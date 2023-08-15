Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1603B77CAB4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 11:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236168AbjHOJqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 05:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236251AbjHOJqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:46:13 -0400
Received: from out-12.mta1.migadu.com (out-12.mta1.migadu.com [IPv6:2001:41d0:203:375::c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58C2198A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:46:06 -0700 (PDT)
Message-ID: <6726fde4-a766-b61f-dac8-5ec8e3536f0f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692092763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6GubIoUBvX9OOPgXpsNuRTEjW9u/fde6sHXrsSbIhCE=;
        b=n3o9trbri9hpIOfLrql5kcVOa8+G0BQ6JmkjUDqIf1dNsv/Ou8EjgoHHCEMBJa1J+19WkC
        MnjoOQ6vklMHPpvUtvLzk/ymAFuUMrxYSbrjKvqt+kv1lCgu7opfCY6wCjPmbjob+2s1tg
        DVmQGadad9J+HtS9XW1SCMG0ITr0S5A=
Date:   Tue, 15 Aug 2023 17:45:10 +0800
MIME-Version: 1.0
Subject: Re: [PATCH] null_blk: fix poll request timeout handling
Content-Language: en-US
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, kch@nvidia.com, dhowells@redhat.com,
        damien.lemoal@opensource.wdc.com, bvanassche@acm.org,
        nj.shetty@samsung.com, kbusch@kernel.org,
        zhouchengming@bytedance.com, akinobu.mita@gmail.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230815060443.660263-1-chengming.zhou@linux.dev>
 <ZNs3xtOzH4+blVCF@fedora>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <ZNs3xtOzH4+blVCF@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/15 16:31, Ming Lei wrote:
> On Tue, Aug 15, 2023 at 02:04:42PM +0800, chengming.zhou@linux.dev wrote:
>> From: Chengming Zhou <zhouchengming@bytedance.com>
>>
>> When doing io_uring benchmark on /dev/nullb0, it's easy to crash the
>> kernel if poll requests timeout triggered, as reported by David. [1]
> 
> Just be curious, how is the timeout triggered when running
> "./fio/t/io_uring -r20 /dev/nullb0"?

I tried "./fio/t/io_uring -r20 /dev/nullb0" multiple times, sometimes
program exit ok, sometimes it dump many timeout messages and kernel BUG.

I just used David's "./fio/t/io_uring -n4 /dev/nullb0", run a while
then ctrl-C, the program will always dump many timeout messages.

It seems that program exit is not clean, leave some requests in driver
haven't been polled & completed? I don't know.

> 
> David mentioned that the issue is triggered in 6.5-rc1, maybe one
> regression?
> 

I just tested using v6.4.9, found the same timeout and kernel BUG
using "./fio/t/io_uring -n4 /dev/nullb0".

>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000008
>> Workqueue: kblockd blk_mq_timeout_work
>> RIP: 0010:null_timeout_rq+0x4e/0x91
>> Call Trace:
>>  ? __die_body+0x1a/0x5c
>>  ? page_fault_oops+0x6f/0x9c
>>  ? kernelmode_fixup_or_oops+0xc6/0xd6
>>  ? __bad_area_nosemaphore+0x44/0x1eb
>>  ? exc_page_fault+0xe2/0xf4
>>  ? asm_exc_page_fault+0x22/0x30
>>  ? null_timeout_rq+0x4e/0x91
>>  blk_mq_handle_expired+0x31/0x4b
>>  bt_iter+0x68/0x84
>>  ? bt_tags_iter+0x81/0x81
>>  __sbitmap_for_each_set.constprop.0+0xb0/0xf2
>>  ? __blk_mq_complete_request_remote+0xf/0xf
>>  bt_for_each+0x46/0x64
>>  ? __blk_mq_complete_request_remote+0xf/0xf
>>  ? percpu_ref_get_many+0xc/0x2a
>>  blk_mq_queue_tag_busy_iter+0x14d/0x18e
>>  blk_mq_timeout_work+0x95/0x127
>>  process_one_work+0x185/0x263
>>  worker_thread+0x1b5/0x227
>>  ? rescuer_thread+0x287/0x287
>>  kthread+0xfa/0x102
>>  ? kthread_complete_and_exit+0x1b/0x1b
>>  ret_from_fork+0x22/0x30
>>
>> This is indeed a race problem between null_timeout_rq() and null_poll().
>>
>> null_poll()				null_timeout_rq()
>>   spin_lock(&nq->poll_lock)
>>   list_splice_init(&nq->poll_list, &list)
>>   spin_unlock(&nq->poll_lock)
>>
>>   while (!list_empty(&list))
>>     req = list_first_entry()
>>     list_del_init()
>>     ...
>>     blk_mq_add_to_batch()
>>     // req->rq_next = NULL
>> 					spin_lock(&nq->poll_lock)
>>
>> 					// rq->queuelist->next == NULL
>> 					list_del_init(&rq->queuelist)
>>
>> 					spin_unlock(&nq->poll_lock)
>>
>> What's worse is that we don't call blk_mq_complete_request_remote()
>> before blk_mq_add_to_batch(), so these completed requests have wrong
>> rq->state == MQ_RQ_IN_FLIGHT. We can easily check this using bpftrace:
>>
>> ```
>> bpftrace -e 'kretfunc:null_blk:null_poll {
>>   $iob=(struct io_comp_batch *)args->iob;
>>   @[$iob->req_list->state]=count();
>> }'
>>
>> @[1]: 51708
>> ```
>>
>> Fix these problems by setting requests state to MQ_RQ_COMPLETE under
>> nq->poll_lock protection, in which null_timeout_rq() can safely detect
>> this race and early return.
>>
>> [1] https://lore.kernel.org/all/3893581.1691785261@warthog.procyon.org.uk/
>>
>> Fixes: 0a593fbbc245 ("null_blk: poll queue support")
>> Reported-by: David Howells <dhowells@redhat.com>
>> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
>> ---
>>  drivers/block/null_blk/main.c | 12 ++++++++++--
>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
>> index 864013019d6b..968090935eb2 100644
>> --- a/drivers/block/null_blk/main.c
>> +++ b/drivers/block/null_blk/main.c
>> @@ -1643,9 +1643,12 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>>  	struct nullb_queue *nq = hctx->driver_data;
>>  	LIST_HEAD(list);
>>  	int nr = 0;
>> +	struct request *rq;
>>  
>>  	spin_lock(&nq->poll_lock);
>>  	list_splice_init(&nq->poll_list, &list);
>> +	list_for_each_entry(rq, &list, queuelist)
>> +		blk_mq_set_request_complete(rq);
>>  	spin_unlock(&nq->poll_lock);
>>  
>>  	while (!list_empty(&list)) {
>> @@ -1671,16 +1674,21 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
>>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>>  	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
>>  
>> -	pr_info("rq %p timed out\n", rq);
>> -
>>  	if (hctx->type == HCTX_TYPE_POLL) {
>>  		struct nullb_queue *nq = hctx->driver_data;
>>  
>>  		spin_lock(&nq->poll_lock);
>> +		/* The request may have completed meanwhile. */
>> +		if (blk_mq_request_completed(rq)) {
>> +			spin_unlock(&nq->poll_lock);
>> +			return BLK_EH_DONE;
>> +		}
>>  		list_del_init(&rq->queuelist);
>>  		spin_unlock(&nq->poll_lock);
>>  	}
> 
> I think null_process_cmd() is needed for un-completed request.
> 

The end of function will set BLK_STS_TIMEOUT error and complete request
using blk_mq_complete_request(), not sure if null_process_cmd() is
needed in this error case?

Thanks.
