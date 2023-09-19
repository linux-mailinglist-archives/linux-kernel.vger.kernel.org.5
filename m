Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91247A5DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjISJWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjISJWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:22:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0F4E6;
        Tue, 19 Sep 2023 02:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10068C433C8;
        Tue, 19 Sep 2023 09:22:21 +0000 (UTC)
Message-ID: <10de339f-dfeb-449f-be69-629bfae9b966@xs4all.nl>
Date:   Tue, 19 Sep 2023 11:22:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/49] media: videobuf2: Stop spamming kernel log with
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
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-3-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914133323.198857-3-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 15:32, Benjamin Gaignard wrote:
> Only report unbalanced queue counters do avoid spamming kernel log
> with useless information.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 77 +++++++++++--------
>  1 file changed, 43 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index cf3b9f5b69b7..bedd827c0d9a 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -529,24 +529,25 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
>  #ifdef CONFIG_VIDEO_ADV_DEBUG
>  	/*
>  	 * Check that all the calls were balances during the life-time of this

typo: balances -> balanced

> -	 * queue. If not (or if the debug level is 1 or up), then dump the
> -	 * counters to the kernel log.
> +	 * queue. If not then dump the counters to the kernel log.
>  	 */
>  	if (q->num_buffers) {
>  		bool unbalanced = q->cnt_start_streaming != q->cnt_stop_streaming ||
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
> +			pr_info("unbalanced counters for queue %p:\n", q);
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
> @@ -567,29 +568,37 @@ static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
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
> -			pr_info("     get_dmabuf: %u num_users: %u vaddr: %u cookie: %u\n",
> +		if (unbalanced) {
> +			pr_info("unbalanced counters for queue %p:, buffer %d\n",

%p:, buffer %d -> %p, buffer %d:

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
> +			if (vb->cnt_mem_get_userptr != vb->cnt_mem_put_userptr)
> +				pr_info("     get_userptr: %u put_userptr: %u\n",
> +					vb->cnt_mem_get_userptr, vb->cnt_mem_put_userptr);
> +			if (vb->cnt_mem_attach_dmabuf != vb->cnt_mem_detach_dmabuf)
> +				pr_info("     attach_dmabuf: %u detach_dmabuf: %u\n",
> +					vb->cnt_mem_attach_dmabuf, vb->cnt_mem_detach_dmabuf);
> +			if (vb->cnt_mem_map_dmabuf != vb->cnt_mem_unmap_dmabuf)
> +				pr_info("     map_dmabuf: %u unmap_dmabuf: %u\n",
> +					vb->cnt_mem_map_dmabuf, vb->cnt_mem_unmap_dmabuf);
> +			pr_info("     get_dmabuf: %u num_users: %u\n",
>  				vb->cnt_mem_get_dmabuf,
> -				vb->cnt_mem_num_users,
> -				vb->cnt_mem_vaddr,
> -				vb->cnt_mem_cookie);
> +				vb->cnt_mem_num_users);
>  		}
>  	}
>  #endif

Regards,

	Hans
