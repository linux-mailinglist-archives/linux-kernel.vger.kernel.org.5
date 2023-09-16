Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324877A2F0C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238909AbjIPJeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjIPJde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:33:34 -0400
Received: from out-228.mta0.migadu.com (out-228.mta0.migadu.com [91.218.175.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3439BE3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 02:33:29 -0700 (PDT)
Message-ID: <bcde25fe-0ae2-2297-0ee6-59d7cb1feff7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694856807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZF32vfY+QsmaR5/VYssON92iTEQMNzL9mloi6Y3iFaM=;
        b=uxmBO6nK4ty+VXCIcM5E2NxfFqxxuywvQMv0AyqN5Cozm8WHhyPXlUWAnXOahBAMtTv+60
        6urWdcDzV5h9hexhdy8LPoDblZ0SGihhRiAjGJCkVQ0Gw+5zt1Q5w7aiQ/hedHviKIeVUl
        cJiFvuf+kEyAVEn9ncBX49zJ7rUCCQU=
Date:   Sat, 16 Sep 2023 17:32:58 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/5] blk-mq: account active requests when get driver
 tag
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-2-chengming.zhou@linux.dev> <ZQVz/hFxxaM8Orza@fedora>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZQVz/hFxxaM8Orza@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/16 17:23, Ming Lei wrote:
> On Wed, Sep 13, 2023 at 03:16:12PM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> There is a limit that batched queue_rqs() can't work on shared tags
>> queue, since the account of active requests can't be done there.
>>
>> Now we account the active requests only in blk_mq_get_driver_tag(),
>> which is not the time we get driver tag actually (with none elevator).
>>
>> To support batched queue_rqs() on shared tags queue, we move the
>> account of active requests to where we get the driver tag:
>>
>> 1. none elevator: blk_mq_get_tags() and blk_mq_get_tag()
>> 2. other elevator: __blk_mq_alloc_driver_tag()
>>
>> This is clearer and match with the unaccount side, which just happen
>> when we put the driver tag.
>>
>> The other good point is that we don't need RQF_MQ_INFLIGHT trick
>> anymore, which used to avoid double account of flush request.
>> Now we only account when actually get the driver tag, so all is good.
>> We will remove RQF_MQ_INFLIGHT in the next patch.
> 
> RQF_MQ_INFLIGHT is only set for BLK_MQ_F_TAG_QUEUE_SHARED, so we can
> avoid the extra atomic accounting for !BLK_MQ_F_TAG_QUEUE_SHARED.
> 
> But now your patch switches to account unconditionally by removing
> RQF_MQ_INFLIGHT, not friendly for !BLK_MQ_F_TAG_QUEUE_SHARED.
> 

Hi Ming, blk_mq_add_active_requests() will check hctx->flags before
doing atomic accounting and only account for BLK_MQ_F_TAG_QUEUE_SHARED.

Yes, we don't need any atomic accounting in non-shared queue.

Thanks.
