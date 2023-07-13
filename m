Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F075213D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234072AbjGMM0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjGMMZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:25:59 -0400
Received: from out-10.mta1.migadu.com (out-10.mta1.migadu.com [IPv6:2001:41d0:203:375::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A0219B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:25:57 -0700 (PDT)
Message-ID: <63f93f1c-98da-4c09-b3d8-711f6953d8b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689251155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pT5gzRWG2j71kUTP52MyHpy3Xj9s5R8Kq7vtVkKcyk=;
        b=hqrn3IjuaTPDdopSEj23hT+duceKEWNlGAHhABfOq4cux/X12gVtahhQNXocja/rWaXWeW
        UlTRMR+CUvTsjW3HccYEQcasZGcZpUxnII/KmpuC+QkhwM+z8rXJoEAwi5ShXAJPriXN5w
        bde2Gzy5XxTS5pXXqsflV/5JBZUuqac=
Date:   Thu, 13 Jul 2023 20:25:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, tj@kernel.org, hch@lst.de
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, zhouchengming@bytedance.com
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
 <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/11 03:47, Jens Axboe wrote:
> On 7/10/23 4:55?AM, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The iocost rely on rq start_time_ns and alloc_time_ns to tell
>> saturation state of the block device. Most of the time request is
>> allocated after rq_qos_throttle() and its alloc_time_ns or
>> start_time_ns won't be affected.
>>
>> But for plug batched allocation introduced by the commit 47c122e35d7e
>> ("block: pre-allocate requests if plug is started and is a batch"), we
>> can rq_qos_throttle() after the allocation of the request. This is
>> what the blk_mq_get_cached_request() does.
>>
>> In this case, the cached request alloc_time_ns or start_time_ns is
>> much ahead if blocked in any qos ->throttle().
>>
>> Fix it by setting alloc_time_ns and start_time_ns to now when the
>> allocated request is actually used.
> 
> One of the single most costly things we do in the io path is the crazy
> amount of time stamping that's done or added without attention to what
> else is doing it or where. And this is why we have a ton of them, and
> why the batched time stamping made sense.
> 
> I'd much rather see this just get the saved timestamp updated when
> necessary. If we block, that's certainly one such case.
> 

Ok, this version will only get time stamp once for one request, it's actually
not worse than the current code, which will get start time stamp once for each
request even in the batch allocation.

But yes, maybe we can also set the start time stamp in the batch mode, and only
update the time stamp in the block case, like you said, has better performance.

The first version [1] I posted actually just did this, in which use a nr_flush counter
in plug to indicate that we blocked & flushed plug. Tejun and I think it seems fragile.
So go to this way that only set time stamp once when the request actually used.

[1] https://lore.kernel.org/all/20230601053919.3639954-1-chengming.zhou@linux.dev/

Another way I can think of is to make rq_qos_throttle() return a bool to indicate
if it blocked. Tejun and Jens, how do you think about this way?

Although it's better performance, in case of preemption, the time stamp maybe not accurate.

Thanks.

