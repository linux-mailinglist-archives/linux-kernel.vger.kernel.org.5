Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63688768BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGaGQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGaGQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:16:17 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEF51713;
        Sun, 30 Jul 2023 23:15:57 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 736AE67373; Mon, 31 Jul 2023 08:15:21 +0200 (CEST)
Date:   Mon, 31 Jul 2023 08:15:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH v2 2/4] blk-flush: split queues for preflush and
 postflush requests
Message-ID: <20230731061521.GB30409@lst.de>
References: <20230725130102.3030032-1-chengming.zhou@linux.dev> <20230725130102.3030032-3-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725130102.3030032-3-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -	list_for_each_entry_safe(rq, n, running, queuelist) {
> +	list_for_each_entry_safe(rq, n, preflush_running, queuelist) {
> +		unsigned int seq = blk_flush_cur_seq(rq);
> +
> +		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);
> +		blk_flush_complete_seq(rq, fq, seq, error);
> +	}
> +
> +	list_for_each_entry_safe(rq, n, postflush_running, queuelist) {
>  		unsigned int seq = blk_flush_cur_seq(rq);
>  
>  		BUG_ON(seq != REQ_FSEQ_PREFLUSH && seq != REQ_FSEQ_POSTFLUSH);

Shouldn't the BUG_ON be split into one that only checks for PREFLUSH and
one only for POSTFLUSH?

> +	if (fq->flush_pending_idx != fq->flush_running_idx)
> +		return;
> +
> +	if (!list_empty(preflush_pending))
> +		first_rq = list_first_entry(preflush_pending, struct request, queuelist);
> +	else if (!list_empty(postflush_pending))
> +		first_rq = list_first_entry(postflush_pending, struct request, queuelist);
> +	else
>  		return;

Hmm, I don't think both lists can be empty here?

I'd simplify this and avoid the overly long lines as:

	first_rq = list_first_entry_or_null(preflush_pending, struct request,
					    queuelist);
	if (!first_rq)
		first_rq = list_first_entry_or_null(postflush_pending,
						    struct request, queuelist);

