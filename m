Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E6A768BD8
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjGaGTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjGaGTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:19:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649D194;
        Sun, 30 Jul 2023 23:19:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B1AA367373; Mon, 31 Jul 2023 08:19:37 +0200 (CEST)
Date:   Mon, 31 Jul 2023 08:19:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v2 3/4] blk-flush: kill the flush state machine
Message-ID: <20230731061937.GC30409@lst.de>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev> <20230725130102.3030032-4-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725130102.3030032-4-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 09:01:01PM +0800, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Since now we put preflush and postflush requests in separate queues,
> we don't need the flush sequence to record anymore.
> 
> REQ_FSEQ_PREFLUSH: blk_enqueue_preflush()
> REQ_FSEQ_POSTFLUSH: blk_enqueue_postflush()
> REQ_FSEQ_DONE: blk_end_flush()
> 
> In blk_flush_complete(), we have two list to handle: preflush_running
> and postflush_running. We just blk_end_flush() directly for postflush
> requests, but need to move preflush requests to requeue_list to
> dispatch.
> 
> This patch just kill the flush state machine and directly call these
> functions, in preparation for the next patch.

> +static void blk_enqueue_postflush(struct request *rq, struct blk_flush_queue *fq)

Please avoid the overly long here.  Maybe just rename enqueue to queue
here and for the preflush version as we don't really use enqueue in
the flush code anyway.

> +{
> +	unsigned int nr_requeue = 0;
> +	struct list_head *preflush_running;
> +	struct list_head *postflush_running;
> +	struct request *rq, *n;
> +
> +	preflush_running = &fq->preflush_queue[fq->flush_running_idx];
> +	postflush_running = &fq->postflush_queue[fq->flush_running_idx];

I'd initialize these ad declaration time:

	struct list_head *preflush_running =
		&fq->preflush_queue[fq->flush_running_idx];
	struct list_head *postflush_running =
		&fq->postflush_queue[fq->flush_running_idx];
	unsigned int nr_requeue = 0;
	struct request *rq, *n;

> +
> +	list_for_each_entry_safe(rq, n, postflush_running, queuelist) {
> +		blk_end_flush(rq, fq, error);
>  	}

No need for the braces.

