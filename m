Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4F80C77C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 11:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbjLKK6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 05:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjLKK6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 05:58:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D9E9A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 02:58:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9F0C433C7;
        Mon, 11 Dec 2023 10:58:38 +0000 (UTC)
Message-ID: <705ce6b0-e945-404c-8014-38881a01fbca@xs4all.nl>
Date:   Mon, 11 Dec 2023 11:58:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3,03/21] v4l2: verify secure dmabufs are used in secure
 queue
Content-Language: en-US, nl
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, Yong Wu <yong.wu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        "T . J . Mercier" <tjmercier@google.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231206081538.17056-1-yunfei.dong@mediatek.com>
 <20231206081538.17056-4-yunfei.dong@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231206081538.17056-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 09:15, Yunfei Dong wrote:
> From: Jeffrey Kardatzke <jkardatzke@google.com>
> 
> Verfies in the dmabuf implementations that if the secure memory flag is

Verfies -> Verifies

> set for a queue that the dmabuf submitted to the queue is unmappable.
> 
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 6 ++++++
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c     | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index 3d4fd4ef5310..ad58ef8dc231 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -710,6 +710,12 @@ static int vb2_dc_map_dmabuf(void *mem_priv)
>  		return -EINVAL;
>  	}
>  
> +	/* verify the dmabuf is secure if we are in secure mode */
> +	if (buf->vb->vb2_queue->secure_mem && sg_page(sgt->sgl)) {

This needs a bit more explanation. I guess that for secure memory
sg_page returns NULL?

> +		pr_err("secure queue requires secure dma_buf");
> +		return -EINVAL;
> +	}
> +
>  	/* checking if dmabuf is big enough to store contiguous chunk */
>  	contig_size = vb2_dc_get_contiguous_size(sgt);
>  	if (contig_size < buf->size) {
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> index 28f3fdfe23a2..55428c73c380 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> @@ -564,6 +564,12 @@ static int vb2_dma_sg_map_dmabuf(void *mem_priv)
>  		return -EINVAL;
>  	}
>  
> +	/* verify the dmabuf is secure if we are in secure mode */
> +	if (buf->vb->vb2_queue->secure_mem && !sg_dma_secure(sgt->sgl)) {

I can't find the sg_dma_secure function. I suspect this patch series
depends on another series?

> +		pr_err("secure queue requires secure dma_buf");
> +		return -EINVAL;
> +	}
> +
>  	buf->dma_sgt = sgt;
>  	buf->vaddr = NULL;
>  

Regards,

	Hans
