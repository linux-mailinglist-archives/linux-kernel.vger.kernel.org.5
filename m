Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC477881FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbjHYIZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbjHYIZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:25:00 -0400
Received: from out-69.mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD36019AD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:24:57 -0700 (PDT)
Message-ID: <84c857f7-9966-6125-92c4-1b2fa96fb98d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692951895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqbXWkPKTS9wFhIrNSacoOf7UHR08PGSBOsQjqtY1Y4=;
        b=kc4rEmgYNsSGtLStBuapfpyVWmgL1JJ4b2qZV9KujzXqAEEDM0Q9jKo5DBmKXm7rnSoBD7
        bjq3JYuK7DyNtEIC7n8jqbS0F5IUg0y70dKOyaXfC9W6FnOEld/lGSmasId+1JCem3fmAQ
        Vz9Gu+NRDV2e4fNSvRfoO3vCqMlaJZY=
Date:   Fri, 25 Aug 2023 16:24:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/6] blk-mq: optimize the queue_rqs() support
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de,
        ming.lei@redhat.com, kbusch@kernel.org
Cc:     mst@redhat.com, sagi@grimberg.me, damien.lemoal@opensource.wdc.com,
        kch@nvidia.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230824144403.2135739-1-chengming.zhou@linux.dev>
 <e4701e0e-57a3-6ee3-8686-6b1d3750c124@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <e4701e0e-57a3-6ee3-8686-6b1d3750c124@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/25 01:02, Bart Van Assche wrote:
> On 8/24/23 07:43, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> The current queue_rqs() support has limitation that it can't work on
>> shared tags queue, which is resolved by patch 1-3. We move the account
>> of active requests to where we really allocate the driver tag.
>>
>> This is clearer and matched with the unaccount side which now happen
>> when we put the driver tag. And we can remove RQF_MQ_INFLIGHT, which
>> was used to avoid double account problem of flush request.
>>
>> Another problem is that the driver that support queue_rqs() has to
>> set inflight request table by itself, which is resolved in patch 4.
>>
>> The patch 5 fixes a potential race problem which may cause false
>> timeout because of the reorder of rq->state and rq->deadline.
>>
>> The patch 6 add support queue_rqs() for null_blk, which showed a
>> 3.6% IOPS improvement in fio/t/io_uring benchmark on my test VM.
>> And we also use it for testing queue_rqs() on shared tags queue.
> 
> Hi Jens and Christoph,
> 
> This patch series would be simplified significantly if the code for
> fair tag allocation would be removed first
> (https://lore.kernel.org/linux-block/20230103195337.158625-1-bvanassche@acm.org/, January 2023).
> It has been proposed to improve fair tag sharing but the complexity of
> the proposed alternative is scary
> (https://lore.kernel.org/linux-block/20230618160738.54385-1-yukuai1@huaweicloud.com/, June 2023).
>  Does everyone agree with removing the code for fair tag sharing - code
> that significantly hurts performance of UFS devices and code that did
> not exist in the legacy block layer?
> 

Hi Bart, thanks for the references!

I don't know the details of the UFS devices bad performance problem.
But I feel it maybe caused by the too lazy queue idle handling, which
is now only handled in queue timeout work.

Another problem maybe the wakeup batch algorithm, which is too subtle.
And there were some IO hang problems caused by it in the past.

So yes, we should improve it, although I don't have good idea for now,
need to do some tests and analysis.

As for removing all this code, I don't know from my limited knowledge.
It was introduced to improve relative fair tags sharing between queues,
to avoid starvation. And the proposed alternative looks too complex to me.

Thanks.
