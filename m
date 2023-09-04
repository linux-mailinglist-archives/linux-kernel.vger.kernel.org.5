Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED271791A68
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349845AbjIDPR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjIDPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:17:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32387CD4;
        Mon,  4 Sep 2023 08:17:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8FFE61843;
        Mon,  4 Sep 2023 15:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9A2C433C7;
        Mon,  4 Sep 2023 15:17:49 +0000 (UTC)
Message-ID: <a9e1f059-4727-fa65-693e-c384890c3f97@xs4all.nl>
Date:   Mon, 4 Sep 2023 17:17:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v6 02/18] media: videobuf2: Stop spamming kernel log with
 all queue counter
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230901124414.48497-1-benjamin.gaignard@collabora.com>
 <20230901124414.48497-3-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230901124414.48497-3-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 14:43, Benjamin Gaignard wrote:
> Only report unbalanced queue counters do avoid spamming kernel log
> with useless information.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 69 +++++++++++--------
>  1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index cf3b9f5b69b7..85e561e46899 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -537,16 +537,18 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  				  q->cnt_prepare_streaming != q->cnt_unprepare_streaming ||
>  				  q->cnt_wait_prepare != q->cnt_wait_finish;
>  
> -		if (unbalanced || debug) {
> -			pr_info("counters for queue %p:%s\n", q,
> -				unbalanced ? " UNBALANCED!" : "");
> -			pr_info("     setup: %u start_streaming: %u stop_streaming: %u\n",
> -				q->cnt_queue_setup, q->cnt_start_streaming,
> -				q->cnt_stop_streaming);
> -			pr_info("     prepare_streaming: %u unprepare_streaming: %u\n",
> -				q->cnt_prepare_streaming, q->cnt_unprepare_streaming);
> -			pr_info("     wait_prepare: %u wait_finish: %u\n",
> -				q->cnt_wait_prepare, q->cnt_wait_finish);
> +		if (unbalanced) {
> +			pr_info("unbalanced counters for queue %p\n", q);

End the pr_info with ':' (i.e. "unbalanced counters for queue %p:\n")

> +			if (q->cnt_start_streaming != q->cnt_stop_streaming)
> +				pr_info("     setup: %u start_streaming: %u stop_streaming: %u\n",
> +					q->cnt_queue_setup, q->cnt_start_streaming,
> +					q->cnt_stop_streaming);
> +			if (q->cnt_prepare_streaming != q->cnt_unprepare_streaming)
> +				pr_info("     prepare_streaming: %u unprepare_streaming: %u\n",
> +					q->cnt_prepare_streaming, q->cnt_unprepare_streaming);
> +			if (q->cnt_wait_prepare != q->cnt_wait_finish)
> +				pr_info("     wait_prepare: %u wait_finish: %u\n",
> +					q->cnt_wait_prepare, q->cnt_wait_finish);
>  		}
>  		q->cnt_queue_setup = 0;
>  		q->cnt_wait_prepare = 0;
> @@ -567,24 +569,35 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  				  vb->cnt_buf_prepare != vb->cnt_buf_finish ||
>  				  vb->cnt_buf_init != vb->cnt_buf_cleanup;
>  
> -		if (unbalanced || debug) {
> -			pr_info("   counters for queue %p, buffer %d:%s\n",
> -				q, buffer, unbalanced ? " UNBALANCED!" : "");
> -			pr_info("     buf_init: %u buf_cleanup: %u buf_prepare: %u buf_finish: %u\n",
> -				vb->cnt_buf_init, vb->cnt_buf_cleanup,
> -				vb->cnt_buf_prepare, vb->cnt_buf_finish);
> -			pr_info("     buf_out_validate: %u buf_queue: %u buf_done: %u buf_request_complete: %u\n",
> -				vb->cnt_buf_out_validate, vb->cnt_buf_queue,
> -				vb->cnt_buf_done, vb->cnt_buf_request_complete);
> -			pr_info("     alloc: %u put: %u prepare: %u finish: %u mmap: %u\n",
> -				vb->cnt_mem_alloc, vb->cnt_mem_put,
> -				vb->cnt_mem_prepare, vb->cnt_mem_finish,
> -				vb->cnt_mem_mmap);
> -			pr_info("     get_userptr: %u put_userptr: %u\n",
> -				vb->cnt_mem_get_userptr, vb->cnt_mem_put_userptr);
> -			pr_info("     attach_dmabuf: %u detach_dmabuf: %u map_dmabuf: %u unmap_dmabuf: %u\n",
> -				vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf,
> -				vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
> +		if (unbalanced) {
> +			pr_info("unbalanced counters for queue %p, buffer %d\n",

End with : here as well.

> +				q, buffer);
> +			if (vb->cnt_buf_init != vb->cnt_buf_cleanup)
> +				pr_info("     buf_init: %u buf_cleanup: %u\n",
> +					vb->cnt_buf_init, vb->cnt_buf_cleanup);
> +			if (vb->cnt_buf_prepare != vb->cnt_buf_finish)
> +				pr_info("     buf_prepare: %u buf_finish: %u\n",
> +					vb->cnt_buf_prepare, vb->cnt_buf_finish);
> +			if (vb->cnt_buf_queue != vb->cnt_buf_done)
> +				pr_info("     buf_out_validate: %u buf_queue: %u buf_done: %u buf_request_complete: %u\n",
> +					vb->cnt_buf_out_validate, vb->cnt_buf_queue,
> +					vb->cnt_buf_done, vb->cnt_buf_request_complete);
> +			if (vb->cnt_mem_alloc != vb->cnt_mem_put)
> +				pr_info("     alloc: %u put: %u\n",
> +					vb->cnt_mem_alloc, vb->cnt_mem_put);
> +			if (vb->cnt_mem_prepare != vb->cnt_mem_finish)
> +				pr_info("     prepare: %u finish: %u\n",
> +					vb->cnt_mem_prepare, vb->cnt_mem_finish);
> +			pr_info("     mmap: %u\n", vb->cnt_mem_mmap);

Drop this, and also drop the cnt_mem_mmap field. I don't think this is
interesting.

> +			if (vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr)
> +				pr_info("     get_userptr: %u put_userptr: %u\n",
> +					vb->cnt_mem_get_userptr, vb->cnt_mem_put_userptr);
> +			if (vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf)
> +				pr_info("     attach_dmabuf: %u detach_dmabuf: %u\n",
> +					vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf);
> +			if (vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf)
> +				pr_info("     map_dmabuf: %u unmap_dmabuf: %u\n",
> +					vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
>  			pr_info("     get_dmabuf: %u num_users: %u vaddr: %u cookie: %u\n",
>  				vb->cnt_mem_get_dmabuf,
>  				vb->cnt_mem_num_users,

Same for cnt_mem_vaddr and cnt_mem_cookie. It's not interesting. But let's keep get_dmabuf and num_users
for now.

Regards,

	Hans
