Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B653B77C964
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjHOIc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjHOIcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:32:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D6C127
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692088279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znLlsPHHnv8BvLsndUsdokUxXtKvPNSjISxIiI4+uhc=;
        b=YIH7Wv4xcjQ3cq98dAyEj/IXzif+Ml3Il8IrkE0UGH6Zt25zBK7rTDnkw76qINLoLaEYwc
        tQD9zuP8jdlz5RILjrWctye8s8prp1TcEf9vXPhENj7QY9my6mrAkPbZFPiFWV1Dn4egbD
        G7M8NqdaIMIuWTXUxTIgc/f34KX3eB8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-zXwMgMGBNT6zQ53C5Ok0sg-1; Tue, 15 Aug 2023 04:31:16 -0400
X-MC-Unique: zXwMgMGBNT6zQ53C5Ok0sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7480D29A9CA9;
        Tue, 15 Aug 2023 08:31:15 +0000 (UTC)
Received: from fedora (unknown [10.72.120.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F795140E950;
        Tue, 15 Aug 2023 08:31:07 +0000 (UTC)
Date:   Tue, 15 Aug 2023 16:31:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, kch@nvidia.com, dhowells@redhat.com,
        damien.lemoal@opensource.wdc.com, bvanassche@acm.org,
        nj.shetty@samsung.com, kbusch@kernel.org,
        zhouchengming@bytedance.com, akinobu.mita@gmail.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] null_blk: fix poll request timeout handling
Message-ID: <ZNs3xtOzH4+blVCF@fedora>
References: <20230815060443.660263-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815060443.660263-1-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 02:04:42PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> When doing io_uring benchmark on /dev/nullb0, it's easy to crash the
> kernel if poll requests timeout triggered, as reported by David. [1]

Just be curious, how is the timeout triggered when running
"./fio/t/io_uring -r20 /dev/nullb0"?

David mentioned that the issue is triggered in 6.5-rc1, maybe one
regression?

> 
> BUG: kernel NULL pointer dereference, address: 0000000000000008
> Workqueue: kblockd blk_mq_timeout_work
> RIP: 0010:null_timeout_rq+0x4e/0x91
> Call Trace:
>  ? __die_body+0x1a/0x5c
>  ? page_fault_oops+0x6f/0x9c
>  ? kernelmode_fixup_or_oops+0xc6/0xd6
>  ? __bad_area_nosemaphore+0x44/0x1eb
>  ? exc_page_fault+0xe2/0xf4
>  ? asm_exc_page_fault+0x22/0x30
>  ? null_timeout_rq+0x4e/0x91
>  blk_mq_handle_expired+0x31/0x4b
>  bt_iter+0x68/0x84
>  ? bt_tags_iter+0x81/0x81
>  __sbitmap_for_each_set.constprop.0+0xb0/0xf2
>  ? __blk_mq_complete_request_remote+0xf/0xf
>  bt_for_each+0x46/0x64
>  ? __blk_mq_complete_request_remote+0xf/0xf
>  ? percpu_ref_get_many+0xc/0x2a
>  blk_mq_queue_tag_busy_iter+0x14d/0x18e
>  blk_mq_timeout_work+0x95/0x127
>  process_one_work+0x185/0x263
>  worker_thread+0x1b5/0x227
>  ? rescuer_thread+0x287/0x287
>  kthread+0xfa/0x102
>  ? kthread_complete_and_exit+0x1b/0x1b
>  ret_from_fork+0x22/0x30
> 
> This is indeed a race problem between null_timeout_rq() and null_poll().
> 
> null_poll()				null_timeout_rq()
>   spin_lock(&nq->poll_lock)
>   list_splice_init(&nq->poll_list, &list)
>   spin_unlock(&nq->poll_lock)
> 
>   while (!list_empty(&list))
>     req = list_first_entry()
>     list_del_init()
>     ...
>     blk_mq_add_to_batch()
>     // req->rq_next = NULL
> 					spin_lock(&nq->poll_lock)
> 
> 					// rq->queuelist->next == NULL
> 					list_del_init(&rq->queuelist)
> 
> 					spin_unlock(&nq->poll_lock)
> 
> What's worse is that we don't call blk_mq_complete_request_remote()
> before blk_mq_add_to_batch(), so these completed requests have wrong
> rq->state == MQ_RQ_IN_FLIGHT. We can easily check this using bpftrace:
> 
> ```
> bpftrace -e 'kretfunc:null_blk:null_poll {
>   $iob=(struct io_comp_batch *)args->iob;
>   @[$iob->req_list->state]=count();
> }'
> 
> @[1]: 51708
> ```
> 
> Fix these problems by setting requests state to MQ_RQ_COMPLETE under
> nq->poll_lock protection, in which null_timeout_rq() can safely detect
> this race and early return.
> 
> [1] https://lore.kernel.org/all/3893581.1691785261@warthog.procyon.org.uk/
> 
> Fixes: 0a593fbbc245 ("null_blk: poll queue support")
> Reported-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  drivers/block/null_blk/main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 864013019d6b..968090935eb2 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1643,9 +1643,12 @@ static int null_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>  	struct nullb_queue *nq = hctx->driver_data;
>  	LIST_HEAD(list);
>  	int nr = 0;
> +	struct request *rq;
>  
>  	spin_lock(&nq->poll_lock);
>  	list_splice_init(&nq->poll_list, &list);
> +	list_for_each_entry(rq, &list, queuelist)
> +		blk_mq_set_request_complete(rq);
>  	spin_unlock(&nq->poll_lock);
>  
>  	while (!list_empty(&list)) {
> @@ -1671,16 +1674,21 @@ static enum blk_eh_timer_return null_timeout_rq(struct request *rq)
>  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
>  	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
>  
> -	pr_info("rq %p timed out\n", rq);
> -
>  	if (hctx->type == HCTX_TYPE_POLL) {
>  		struct nullb_queue *nq = hctx->driver_data;
>  
>  		spin_lock(&nq->poll_lock);
> +		/* The request may have completed meanwhile. */
> +		if (blk_mq_request_completed(rq)) {
> +			spin_unlock(&nq->poll_lock);
> +			return BLK_EH_DONE;
> +		}
>  		list_del_init(&rq->queuelist);
>  		spin_unlock(&nq->poll_lock);
>  	}

I think null_process_cmd() is needed for un-completed request.


Thanks,
Ming

