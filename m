Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A660D7AAD41
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbjIVIz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjIVIzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2501CA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695372903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tPTCtaqbKGccEC5PGZGu8j88Z3LYbxZf/KUwfbQeLNQ=;
        b=SSuZITQSZUPmG3VhYHhl8YmB8HzHnq/Fn1eiB9YcrUPJfXLAv1N5V6xQrPYrOJvVYdmkf1
        Uc+8WW2jBYg946BrYjbgygB7+sY5mG/p9O4BbOJl16vn6mGFTzXhKqDWqCU5CVBaMZrPak
        53Fk3+dBcyxphQUy3y0lXRKtjj3S7NY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-2yX3J01LMWyZbpO3NlUveA-1; Fri, 22 Sep 2023 04:54:58 -0400
X-MC-Unique: 2yX3J01LMWyZbpO3NlUveA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09411185A797;
        Fri, 22 Sep 2023 08:54:58 +0000 (UTC)
Received: from fedora (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9391140C6EBF;
        Fri, 22 Sep 2023 08:54:52 +0000 (UTC)
Date:   Fri, 22 Sep 2023 16:54:47 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, hch@lst.de, bvanassche@acm.org, kbusch@kernel.org,
        mst@redhat.com, damien.lemoal@opensource.wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH v2 5/5] block/null_blk: add queue_rqs() support
Message-ID: <ZQ1WV6PGAxaUVVjV@fedora>
References: <20230913151616.3164338-1-chengming.zhou@linux.dev>
 <20230913151616.3164338-6-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913151616.3164338-6-chengming.zhou@linux.dev>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 03:16:16PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> Add batched mq_ops.queue_rqs() support in null_blk for testing. The
> implementation is much easy since null_blk doesn't have commit_rqs().
> 
> We simply handle each request one by one, if errors are encountered,
> leave them in the passed in list and return back.
> 
> There is about 3.6% improvement in IOPS of fio/t/io_uring on null_blk
> with hw_queue_depth=256 on my test VM, from 1.09M to 1.13M.

I guess you pass 'shared_tags' to null_blk for the verification?

> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  drivers/block/null_blk/main.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 968090935eb2..79d6cd3c3d41 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1750,6 +1750,25 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return null_handle_cmd(cmd, sector, nr_sectors, req_op(rq));
>  }
>  
> +static void null_queue_rqs(struct request **rqlist)
> +{
> +	struct request *requeue_list = NULL;
> +	struct request **requeue_lastp = &requeue_list;
> +	struct blk_mq_queue_data bd = { };
> +	blk_status_t ret;
> +
> +	do {
> +		struct request *rq = rq_list_pop(rqlist);
> +
> +		bd.rq = rq;
> +		ret = null_queue_rq(rq->mq_hctx, &bd);
> +		if (ret != BLK_STS_OK)
> +			rq_list_add_tail(&requeue_lastp, rq);
> +	} while (!rq_list_empty(*rqlist));
> +
> +	*rqlist = requeue_list;
> +}
> +

null_blk may not be one perfect example for showing queue_rqs()
which is usually for handling request in batch, but for test or
demo purpose, it is fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks
Ming

