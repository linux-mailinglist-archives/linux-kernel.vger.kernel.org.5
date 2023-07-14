Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A082753985
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbjGNLb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbjGNLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:31:55 -0400
Received: from out-51.mta0.migadu.com (out-51.mta0.migadu.com [IPv6:2001:41d0:1004:224b::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A767E44
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:31:53 -0700 (PDT)
Message-ID: <5be1cba6-b141-3a05-f801-3af7d2092674@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689334311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzKVNwZNxaI52yuCAvsu56J+T8LUM0KJrHtb7CNMHf4=;
        b=hL0IlyNnmhRFaS86E4RhtXpP13YJlunFBnIf5LEOMoX4TxgzMdChUhaHfqn/yVa5RpAoU6
        J59laa9+loeEh5LOQXrm90ihtcTtDyInNg9QomjcE72a4QTsvzX6uAQr6a6DUsZHrshL+y
        Sv8BwhS80obxrLS8N6sIFwE2/hX2xq0=
Date:   Fri, 14 Jul 2023 19:31:46 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5] blk-mq: fix start_time_ns and alloc_time_ns for
 pre-allocated rq
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, zhouchengming@bytedance.com
References: <20230710105516.2053478-1-chengming.zhou@linux.dev>
 <aa813164-9a6a-53bd-405b-ba4cc1f1b656@kernel.dk>
 <63f93f1c-98da-4c09-b3d8-711f6953d8b7@linux.dev>
 <ZLA7QAfSojxu_FMW@slm.duckdns.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZLA7QAfSojxu_FMW@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/14 01:58, Tejun Heo wrote:
> Hello,
> 
> On Thu, Jul 13, 2023 at 08:25:50PM +0800, Chengming Zhou wrote:
>> Ok, this version will only get time stamp once for one request, it's actually
>> not worse than the current code, which will get start time stamp once for each
>> request even in the batch allocation.
>>
>> But yes, maybe we can also set the start time stamp in the batch mode, and only
>> update the time stamp in the block case, like you said, has better performance.
>>
>> The first version [1] I posted actually just did this, in which use a nr_flush counter
>> in plug to indicate that we blocked & flushed plug. Tejun and I think it seems fragile.
>> So go to this way that only set time stamp once when the request actually used.
>>
>> [1] https://lore.kernel.org/all/20230601053919.3639954-1-chengming.zhou@linux.dev/
>>
>> Another way I can think of is to make rq_qos_throttle() return a bool to indicate
>> if it blocked. Tejun and Jens, how do you think about this way?
>>
>> Although it's better performance, in case of preemption, the time stamp maybe not accurate.
> 
> Trying to manually optimized timestamp reads seems like a bit of fool's
> errand to me. I don't think anyone cares about nanosec accuracy, so there
> are ample opportunities for generically caching timestamp so that we don't
> have to contort code to optimzie timestamp calls.
> 
> It's a bit out of scope for this patchset but I think it might make sense to
> build a timestamp caching infrastructure. The cached timestamp can be
> invalidated on context switches (block layer already hooks into them) and
> issue and other path boundaries (e.g. at the end of plug flush).
> 

Yes, this is a really great idea. It has better performance and is more generic.

Thanks.

