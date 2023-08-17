Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305F077FCDA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353903AbjHQRSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 13:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353922AbjHQRSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 13:18:09 -0400
Received: from out-31.mta1.migadu.com (out-31.mta1.migadu.com [IPv6:2001:41d0:203:375::1f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654ED10C8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 10:18:07 -0700 (PDT)
Message-ID: <d16edaf8-1eef-f099-eb15-7599906d1492@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692292685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oP35WFkAGM1mqUKfAAOZno6K6eolQgOYmd9Fifhu4bc=;
        b=nQo8ZaFh4yp+bsrYRq0hie4ebKHaQlZGU0ayDy4fw+UT2srPnsKGHaDOxfutrxnFSty3xy
        owB27Rv6A0jVF2M8vERdix/hdktvDxtiYnQsOySRG8TRjycni0KqVonZceBF5+CL8Cc8U1
        b1FIdi7T6aopaNAnKoLgJqqxdTDkLxw=
Date:   Fri, 18 Aug 2023 01:17:38 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, cel@kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <202308172100.8ce4b853-oliver.sang@intel.com>
 <af61c72c-b3ec-ce7a-4f41-bce9a9844baf@acm.org>
 <317715dc-f6e4-1847-5b78-b2d8184b446a@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <317715dc-f6e4-1847-5b78-b2d8184b446a@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/17 23:29, Chengming Zhou wrote:
> On 2023/8/17 22:50, Bart Van Assche wrote:
>> On 8/17/23 07:41, kernel test robot wrote:
>>> [  222.622837][ T2216] statistics for priority 1: i 276 m 0 d 276 c 278
>>> [ 222.629307][ T2216] WARNING: CPU: 0 PID: 2216 at block/mq-deadline.c:680 dd_exit_sched (block/mq-deadline.c:680 (discriminator 3))
>>
>> The above information shows that dd_inserted_request() has been called
>> 276 times and also that dd_finish_request() has been called 278 times.
> 
> Thanks much for your help.
> 
> This patch indeed introduced a regression, postflush requests will be completed
> twice, so here dd_finish_request() is more than dd_inserted_request().
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index a8c63bef8ff1..7cd47ffc04ce 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -686,8 +686,10 @@ static void blk_mq_finish_request(struct request *rq)
>  {
>         struct request_queue *q = rq->q;
> 
> -       if (rq->rq_flags & RQF_USE_SCHED)
> +       if (rq->rq_flags & RQF_USE_SCHED) {
>                 q->elevator->type->ops.finish_request(rq);
> +               rq->rq_flags &= ~RQF_USE_SCHED;
> +       }
>  }
> 

I just tried to run LKP and xfstests, firstly failed to run LKP on my server
which seems to miss some dependencies. Then I ran xfstests successfully.

But xfstests generic/704 always pass and no WARN in dmesg. (I don't know why,
maybe my server settings are some different from the test robot.)

So I try to reproduce it manually. Steps:

```
echo mq-deadline > /sys/block/sdb/queue/scheduler

mkfs.ext4 /dev/sdb
mount /dev/sdb /fs/sdb
cd /fs/sdb
stress-ng --symlink 4 --timeout 60

echo none > /sys/block/sdb/queue/scheduler
```

This way the WARNING in mq-deadline can be reproduced easily.

Then retest with the diff, mq-deadline WARNING still happened... So there
are still other requests which have RQF_USE_SCHED flag completed without
being inserted into elevator.

Will use some tracing and look again.

Thanks.

> 
> Clear RQF_USE_SCHED flag here should fix this problem, which should be ok
> since finish_request() is the last callback, this flag isn't needed anymore.
> 
> Jens, should I send this diff as another patch or resend updated v3?
> 
> Thanks.
> 
>> Calling dd_finish_request() more than once per request breaks the code
>> for priority handling since that code checks how many requests are
>> pending per priority level by subtracting the number of completion calls
>> from the number of insertion calls (see also dd_queued()). I think the
>> above output indicates that this patch introduced a regression.
>>
>> Bart.
>>
