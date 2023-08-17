Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1942077FAC4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353215AbjHQPay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353244AbjHQPaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:30:20 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [91.218.175.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2317D19AE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:30:18 -0700 (PDT)
Message-ID: <317715dc-f6e4-1847-5b78-b2d8184b446a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692286216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJM4Hdms6SRtkTPMdaK0rVnNa8K7qD60i1kkq/z/JZE=;
        b=p4dgNVuyKQlmB33x/50qtlSqE3/3/CevI0ifBM5IQvX1C/7yA73d/Xri0b6QgxeX4PQBd2
        BjMahVhit6WQ4pV8S0Bal9utS+qfRhZf+z1SRDoDO3kvE5uOaITm6yy3uoZQmZ9D1TEgIs
        RHkCkj96v+cfKGcYJc1ipVNCHQqYCAs=
Date:   Thu, 17 Aug 2023 23:29:37 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2] blk-mq: release scheduler resource when request
 complete
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, cel@kernel.org,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>,
        chengming.zhou@linux.dev
References: <202308172100.8ce4b853-oliver.sang@intel.com>
 <af61c72c-b3ec-ce7a-4f41-bce9a9844baf@acm.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <af61c72c-b3ec-ce7a-4f41-bce9a9844baf@acm.org>
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

On 2023/8/17 22:50, Bart Van Assche wrote:
> On 8/17/23 07:41, kernel test robot wrote:
>> [  222.622837][ T2216] statistics for priority 1: i 276 m 0 d 276 c 278
>> [ 222.629307][ T2216] WARNING: CPU: 0 PID: 2216 at block/mq-deadline.c:680 dd_exit_sched (block/mq-deadline.c:680 (discriminator 3))
> 
> The above information shows that dd_inserted_request() has been called
> 276 times and also that dd_finish_request() has been called 278 times.

Thanks much for your help.

This patch indeed introduced a regression, postflush requests will be completed
twice, so here dd_finish_request() is more than dd_inserted_request().

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a8c63bef8ff1..7cd47ffc04ce 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -686,8 +686,10 @@ static void blk_mq_finish_request(struct request *rq)
 {
        struct request_queue *q = rq->q;

-       if (rq->rq_flags & RQF_USE_SCHED)
+       if (rq->rq_flags & RQF_USE_SCHED) {
                q->elevator->type->ops.finish_request(rq);
+               rq->rq_flags &= ~RQF_USE_SCHED;
+       }
 }


Clear RQF_USE_SCHED flag here should fix this problem, which should be ok
since finish_request() is the last callback, this flag isn't needed anymore.

Jens, should I send this diff as another patch or resend updated v3?

Thanks.

> Calling dd_finish_request() more than once per request breaks the code
> for priority handling since that code checks how many requests are
> pending per priority level by subtracting the number of completion calls
> from the number of insertion calls (see also dd_queued()). I think the
> above output indicates that this patch introduced a regression.
> 
> Bart.
> 
