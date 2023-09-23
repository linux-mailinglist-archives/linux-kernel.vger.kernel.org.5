Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D57ABE39
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjIWHCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjIWHCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:02:15 -0400
Received: from out-209.mta1.migadu.com (out-209.mta1.migadu.com [IPv6:2001:41d0:203:375::d1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118691AD
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 00:02:04 -0700 (PDT)
Message-ID: <a357f46d-b314-48ed-8031-5fa08abcba64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695452521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x6TcV6V9rHGnBlnLH/KVXbh8Q0+IoUhYQsffa9u3Igw=;
        b=GzQSE2Xqb/97PEYDsWGWgL/gXqo0bl57SrwGbm0fSI0v+PX3WoEjRs2oks76MmsIYitT+t
        HfQ+eU5Dvv674d+KSpwDq9khkCRReS/bFDGrsc68LCtAaoQoYGSSiNWN07xrw99KbM/eWR
        S3KMKJP7ds0l03B6q5SuchfzD7bcfYY=
Date:   Sat, 23 Sep 2023 15:01:30 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/5] block/null_blk: add queue_rqs() support
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-6-chengming.zhou@linux.dev> <ZQ1WV6PGAxaUVVjV@fedora>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZQ1WV6PGAxaUVVjV@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/22 16:54, Ming Lei wrote:
> On Wed, Sep 13, 2023 at 03:16:16PM +0000, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> Add batched mq_ops.queue_rqs() support in null_blk for testing. The
>> implementation is much easy since null_blk doesn't have commit_rqs().
>>
>> We simply handle each request one by one, if errors are encountered,
>> leave them in the passed in list and return back.
>>
>> There is about 3.6% improvement in IOPS of fio/t/io_uring on null_blk
>> with hw_queue_depth=256 on my test VM, from 1.09M to 1.13M.
> 
> I guess you pass 'shared_tags' to null_blk for the verification?
IIRC it should be "modprobe null_blk hw_queue_depth=256 nr_devices=2 shared_tags=1".

> 
>>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  drivers/block/null_blk/main.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index 968090935eb2..79d6cd3c3d41 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1750,6 +1750,25 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>>  	return null_handle_cmd(cmd, sector, nr_sectors, req_op(rq));
>>  }
>>  
>> +static void null_queue_rqs(struct request **rqlist)
>> +{
>> +	struct request *requeue_list = NULL;
>> +	struct request **requeue_lastp = &requeue_list;
>> +	struct blk_mq_queue_data bd = { };
>> +	blk_status_t ret;
>> +
>> +	do {
>> +		struct request *rq = rq_list_pop(rqlist);
>> +
>> +		bd.rq = rq;
>> +		ret = null_queue_rq(rq->mq_hctx, &bd);
>> +		if (ret != BLK_STS_OK)
>> +			rq_list_add_tail(&requeue_lastp, rq);
>> +	} while (!rq_list_empty(*rqlist));
>> +
>> +	*rqlist = requeue_list;
>> +}
>> +
> 
> null_blk may not be one perfect example for showing queue_rqs()
> which is usually for handling request in batch, but for test or
> demo purpose, it is fine:
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> 

Yes, some other "real" drivers should be better choice that we can
handle more things in batch to improve performance. Maybe ublk driver
can benefit from this too.

Thanks!

