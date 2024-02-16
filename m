Return-Path: <linux-kernel+bounces-69012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B62685836A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E4571C21A45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5BF131726;
	Fri, 16 Feb 2024 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Zd8OtdDE"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28EE130AD8
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708103090; cv=none; b=DccVg0LVOb4wljOQajoTsBygMjNczQoaMUvJsHrqVgoHv1R0tnM3ZvMlX2wu0iw4okFHIJiRa6u5hjl+JdkRS8Vzq1MlS/qMVb75sAfK0WYqyZ+aF4WAIPvYhdTdHJydym/04Gr6jNAsOAwElRYYBsP05BsE7I3JuVyswEYsnzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708103090; c=relaxed/simple;
	bh=+v//8WVn3MVA+fRB3iK8/p8gHK/v/DBelqoowUcll7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRf5TDsmVDzRJ+zn0CAr3rUgqGnmPjPU/juLw6BaZ/2OY5VMQON2lbYtqF+wOKgotqHuwOOIMHrobUvlO2J2fX9vAm/dtYmcmnQy745DULk0gspGE8NOqodPG9RhYKc1GUul8WcrYunQ1yZ71OHCuD5XrzseQgOsX4n1udXoFMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=Zd8OtdDE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-411baa02bc3so3037455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1708103087; x=1708707887; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivwhLebdUuD1A5Otgnd7/ZhxAtbeQ+cN+CSubuJmL3g=;
        b=Zd8OtdDEC2a5xM47t94P4YiCouctBdD3MN35OYgBXXL6bGDuH03bR6BGcz2vsrPAVF
         x3/Ow6ua3aZusYMjoXz+BqUUl2VPye+ifZI2pZ1aIJn5nt4Dlc5sdQGOxLKC3iDgp0s+
         hJKbo0W9zItAkyUvnJVLnY7/W3vlNDJc2r3U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708103087; x=1708707887;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivwhLebdUuD1A5Otgnd7/ZhxAtbeQ+cN+CSubuJmL3g=;
        b=wKHIjxV1OkIdtxlyFEaSyjmLy+S7KYqFK0UKgZU3ykgjoOJz2fuu2T21t8Ynohy/PT
         cTMqkUWRqghKcaEq8YgK9YE8GzegLzsgAcjKIlm7un0NB6QKR+YJ5O0jiKuUimWrfzZT
         1IYVQOeT/HkW59qUWci9YGb6ycKkL+Cxs4GMxA/iEM2yBfHCyDo821mMrFEhAhDBxtAA
         LGfAY3fLumAMza9Ic9TYmP4EWcovIexLto5q1jKjaphUGVI+U81kTAXqMB5M0P61qfgS
         K9MYOJK7WhH1nC2FroWLgdh8Ejeb1MpIgqo3ukO/y5JK1TSjSHM8rpkrJBrzop4VT84q
         9xIA==
X-Forwarded-Encrypted: i=1; AJvYcCWkGWSoPJfhMT1qHH+TazEOrQEFOVHAsNI2KMnH4W7YiQY0oYWYdd4YjL2505HS3uFVpw1vV2BVlXo+n1Qr91Jn+F+J+fmBN9e041HI
X-Gm-Message-State: AOJu0YwNTH62jbePql00W9s69ScUGileROCZ9+UdCeHy4MxfiF0gdIm2
	4Ycx09bY0NmEIVxMVSnAFaoZhF8z0VHFpHqA6xYLV9oe99XijqoOTpwMRhoNkkg=
X-Google-Smtp-Source: AGHT+IGxIbJQdotpNxoYDDuZqhrA0VU+pE2iwUZz2LV9N47mgjCflPHbe0NI9pdRvHAvhxRb9JEmlQ==
X-Received: by 2002:a05:600c:4446:b0:412:cd2:2ce6 with SMTP id v6-20020a05600c444600b004120cd22ce6mr1930753wmn.3.1708103086789;
        Fri, 16 Feb 2024 09:04:46 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id k10-20020a7bc40a000000b004101f27737asm2849571wmi.29.2024.02.16.09.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 09:04:45 -0800 (PST)
Date: Fri, 16 Feb 2024 18:04:43 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Hsiao Chien Sung <shawn.sung@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
	Sean Paul <seanpaul@chromium.org>, Fei Shao <fshao@chromium.org>,
	Jason Chen <jason-ch.chen@mediatek.corp-partner.google.com>,
	"Nancy . Lin" <nancy.lin@mediatek.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/13] drm/mediatek: Support CRC in display driver
Message-ID: <Zc-Vq2MeG9X37JJe@phenom.ffwll.local>
Mail-Followup-To: Hsiao Chien Sung <shawn.sung@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Bibby Hsieh <bibby.hsieh@mediatek.com>, CK Hu <ck.hu@mediatek.com>,
	Sean Paul <seanpaul@chromium.org>, Fei Shao <fshao@chromium.org>,
	Jason Chen <jason-ch.chen@mediatek.corp-partner.google.com>,
	"Nancy . Lin" <nancy.lin@mediatek.com>,
	dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
 <20240215101119.12629-11-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215101119.12629-11-shawn.sung@mediatek.com>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Thu, Feb 15, 2024 at 06:11:16PM +0800, Hsiao Chien Sung wrote:
> Register CRC related function pointers to support
> CRC retrieval.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 239 ++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |  39 ++++
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   3 +
>  3 files changed, 281 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 14cf75fa217f9..6cb1ed419dee7 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -68,6 +68,9 @@ struct mtk_drm_crtc {
>  	/* lock for display hardware access */
>  	struct mutex			hw_lock;
>  	bool				config_updating;
> +
> +	struct mtk_ddp_comp		*crc_provider;
> +	unsigned int			frames;
>  };
>  
>  struct mtk_crtc_state {
> @@ -635,6 +638,14 @@ static void mtk_crtc_ddp_irq(void *data)
>  	struct drm_crtc *crtc = data;
>  	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
>  	struct mtk_drm_private *priv = crtc->dev->dev_private;
> +	struct mtk_ddp_comp *comp = mtk_crtc->crc_provider;
> +
> +	/*
> +	 * crc providers should make sure the crc is always correct
> +	 * by resetting it in .crc_read()
> +	 */
> +	if (crtc->crc.opened)
> +		comp->funcs->crc_read(comp->dev);
>  
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>  	if (!priv->data->shadow_register && !mtk_crtc->cmdq_client.chan)
> @@ -646,6 +657,24 @@ static void mtk_crtc_ddp_irq(void *data)
>  	if (!priv->data->shadow_register)
>  		mtk_crtc_ddp_config(crtc, NULL);
>  #endif
> +
> +	/*
> +	 * drm_crtc_add_crc_entry() could take more than 50ms to finish
> +	 * put it at the end of the isr
> +	 */

Uh this looks really scary, especially since you put this before the call
to drm_crtc_handle_vblank in the function below, which really shouldn't be
unecessarily delayed (because that's the one that takes the vblank
timestamp).

This sounds like the perfect application for a vblank worker though, so
you please look into drm_vblank_work.h. And if that is not useable due to
hardware constraint, then please explain in a comment here and in the
commit message why you cannot use that and have to roll your own. vblank
work really should be your first choice here, because:
- it's designed for expensive vblank work
- it gives you all the flush/cancel_sync functions you need for disabling
  crc again, and in a race-free implementation. Much better to use common
  code than to reinvent synchronization wheels in drivers :-)

> +	if (crtc->crc.opened) {

Because this is probably not race-free, so we need something solid here.

Cheers, Sima


> +		/*
> +		 * skip the first crc because the first frame is configured by
> +		 * mtk_crtc_ddp_hw_init() when atomic enable
> +		 */
> +		if (++mtk_crtc->frames > 1) {
> +			drm_crtc_add_crc_entry(crtc, true,
> +					       drm_crtc_vblank_count(crtc),
> +					       comp->funcs->crc_entry(comp->dev));
> +		}
> +	} else {
> +		mtk_crtc->frames = 0;
> +	}
>  	mtk_drm_finish_page_flip(mtk_crtc);
>  }
>  
> @@ -704,6 +733,40 @@ static void mtk_drm_crtc_update_output(struct drm_crtc *crtc,
>  	}
>  }
>  
> +static int mtk_drm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src)
> +{
> +	if (src && strcmp(src, "auto") != 0) {
> +		DRM_ERROR("%s(crtc-%d): unknown source '%s'\n",
> +			  __func__, drm_crtc_index(crtc), src);
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int mtk_drm_crtc_verify_crc_source(struct drm_crtc *crtc,
> +					  const char *src,
> +					  size_t *cnt)
> +{
> +	struct mtk_drm_crtc *mtk_crtc = to_mtk_crtc(crtc);
> +	struct mtk_ddp_comp *comp = mtk_crtc->crc_provider;
> +
> +	if (!comp) {
> +		DRM_ERROR("%s(crtc-%d): no crc provider\n",
> +			  __func__, drm_crtc_index(crtc));
> +		return -ENOENT;
> +	}
> +
> +	if (src && strcmp(src, "auto") != 0) {
> +		DRM_ERROR("%s(crtc-%d): unknown source '%s'\n",
> +			  __func__, drm_crtc_index(crtc), src);
> +		return -EINVAL;
> +	}
> +
> +	*cnt = comp->funcs->crc_cnt(comp->dev);
> +
> +	return 0;
> +}
> +
>  int mtk_drm_crtc_plane_check(struct drm_crtc *crtc, struct drm_plane *plane,
>  			     struct mtk_plane_state *state)
>  {
> @@ -841,6 +904,8 @@ static const struct drm_crtc_funcs mtk_crtc_funcs = {
>  	.atomic_destroy_state	= mtk_drm_crtc_destroy_state,
>  	.enable_vblank		= mtk_drm_crtc_enable_vblank,
>  	.disable_vblank		= mtk_drm_crtc_disable_vblank,
> +	.set_crc_source		= mtk_drm_crtc_set_crc_source,
> +	.verify_crc_source	= mtk_drm_crtc_verify_crc_source,
>  };
>  
>  static const struct drm_crtc_helper_funcs mtk_crtc_helper_funcs = {
> @@ -1033,6 +1098,11 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  
>  			if (comp->funcs->ctm_set)
>  				has_ctm = true;
> +
> +			if (comp->funcs->crc_cnt &&
> +			    comp->funcs->crc_entry &&
> +			    comp->funcs->crc_read)
> +				mtk_crtc->crc_provider = comp;
>  		}
>  
>  		mtk_ddp_comp_register_vblank_cb(comp, mtk_crtc_ddp_irq,
> @@ -1137,3 +1207,172 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  
>  	return 0;
>  }
> +
> +void mtk_drm_crc_init(struct mtk_drm_crc *crc,
> +		      const u32 *crc_offset_table, size_t crc_count,
> +		      u32 reset_offset, u32 reset_mask)
> +{
> +	crc->ofs = crc_offset_table;
> +	crc->cnt = crc_count;
> +	crc->rst_ofs = reset_offset;
> +	crc->rst_msk = reset_mask;
> +	crc->va = kcalloc(crc->cnt, sizeof(*crc->va), GFP_KERNEL);
> +	if (!crc->va) {
> +		DRM_ERROR("failed to allocate memory for crc\n");
> +		crc->cnt = 0;
> +	}
> +}
> +
> +void mtk_drm_crc_read(struct mtk_drm_crc *crc, void __iomem *reg)
> +{
> +	if (!crc->cnt || !crc->ofs || !crc->va)
> +		return;
> +
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	/* sync to see the most up-to-date copy of the DMA buffer */
> +	dma_sync_single_for_cpu(crc->cmdq_client.chan->mbox->dev,
> +				crc->pa, crc->cnt * sizeof(*crc->va),
> +				DMA_FROM_DEVICE);
> +#else
> +	/* read crc with cpu for the platforms without cmdq */
> +	{
> +		u32 n;
> +
> +		for (n = 0; n < crc->cnt; n++)
> +			crc->va[n] = readl(reg + crc->ofs[n]);
> +
> +		n = readl(reg + crc->rst_ofs);
> +
> +		/* pull reset bit */
> +		n |= crc->rst_msk;
> +		writel(n, reg + crc->rst_ofs);
> +
> +		/* release reset bit */
> +		n &= ~crc->rst_msk;
> +		writel(n, reg + crc->rst_ofs);
> +	}
> +#endif
> +}
> +
> +void mtk_drm_crc_destroy(struct mtk_drm_crc *crc)
> +{
> +	if (!crc->cnt)
> +		return;
> +
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	if (crc->pa) {
> +		dma_unmap_single(crc->cmdq_client.chan->mbox->dev,
> +				 crc->pa, crc->cnt * sizeof(*crc->va),
> +				 DMA_TO_DEVICE);
> +		crc->pa = 0;
> +	}
> +	if (crc->cmdq_client.chan) {
> +		mtk_drm_cmdq_pkt_destroy(&crc->cmdq_handle);
> +		mbox_free_channel(crc->cmdq_client.chan);
> +		crc->cmdq_client.chan = NULL;
> +	}
> +#endif
> +	kfree(crc->va);
> +	crc->va = NULL;
> +	crc->cnt = 0;
> +}
> +
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +void mtk_drm_crc_cmdq_create(struct device *dev, struct mtk_drm_crc *crc)
> +{
> +	int i;
> +
> +	if (!crc->cnt) {
> +		dev_warn(dev, "%s: not support\n", __func__);
> +		goto cleanup;
> +	}
> +
> +	if (!crc->ofs) {
> +		dev_warn(dev, "%s: not defined\n", __func__);
> +		goto cleanup;
> +	}
> +
> +	crc->cmdq_client.client.dev = dev;
> +	crc->cmdq_client.client.tx_block = false;
> +	crc->cmdq_client.client.knows_txdone = true;
> +	crc->cmdq_client.client.rx_callback = NULL;
> +	crc->cmdq_client.chan = mbox_request_channel(&crc->cmdq_client.client, 0);
> +	if (IS_ERR(crc->cmdq_client.chan)) {
> +		dev_warn(dev, "%s: failed to create mailbox client\n", __func__);
> +		crc->cmdq_client.chan = NULL;
> +		goto cleanup;
> +	}
> +
> +	if (mtk_drm_cmdq_pkt_create(&crc->cmdq_client, &crc->cmdq_handle, PAGE_SIZE)) {
> +		dev_warn(dev, "%s: failed to create cmdq packet\n", __func__);
> +		goto cleanup;
> +	}
> +
> +	if (!crc->va) {
> +		dev_warn(dev, "%s: no memory\n", __func__);
> +		goto cleanup;
> +	}
> +
> +	/* map the entry to get a dma address for cmdq to store the crc */
> +	crc->pa = dma_map_single(crc->cmdq_client.chan->mbox->dev,
> +				 crc->va, crc->cnt * sizeof(*crc->va),
> +				 DMA_FROM_DEVICE);
> +
> +	if (dma_mapping_error(crc->cmdq_client.chan->mbox->dev, crc->pa)) {
> +		dev_err(dev, "%s: failed to map dma\n", __func__);
> +		goto cleanup;
> +	}
> +
> +	if (crc->cmdq_event)
> +		cmdq_pkt_wfe(&crc->cmdq_handle, crc->cmdq_event, true);
> +
> +	for (i = 0; i < crc->cnt; i++) {
> +		/* put crc to spr1 register */
> +		cmdq_pkt_read_s(&crc->cmdq_handle, crc->cmdq_reg->subsys,
> +				crc->cmdq_reg->offset + crc->ofs[i],
> +				CMDQ_THR_SPR_IDX1);
> +
> +		/* copy spr1 register to physical address of the crc */
> +		cmdq_pkt_assign(&crc->cmdq_handle, CMDQ_THR_SPR_IDX0,
> +				CMDQ_ADDR_HIGH(crc->pa + i * sizeof(*crc->va)));
> +		cmdq_pkt_write_s(&crc->cmdq_handle, CMDQ_THR_SPR_IDX0,
> +				 CMDQ_ADDR_LOW(crc->pa + i * sizeof(*crc->va)),
> +				 CMDQ_THR_SPR_IDX1);
> +	}
> +	/* reset crc */
> +	mtk_ddp_write_mask(&crc->cmdq_handle, ~0, crc->cmdq_reg, 0,
> +			   crc->rst_ofs, crc->rst_msk);
> +
> +	/* clear reset bit */
> +	mtk_ddp_write_mask(&crc->cmdq_handle, 0, crc->cmdq_reg, 0,
> +			   crc->rst_ofs, crc->rst_msk);
> +
> +	/* jump to head of the cmdq packet */
> +	cmdq_pkt_jump(&crc->cmdq_handle, crc->cmdq_handle.pa_base);
> +
> +	return;
> +cleanup:
> +	mtk_drm_crc_destroy(crc);
> +}
> +
> +void mtk_drm_crc_cmdq_start(struct mtk_drm_crc *crc)
> +{
> +	if (!crc->cmdq_client.chan)
> +		return;
> +
> +	dma_sync_single_for_device(crc->cmdq_client.chan->mbox->dev,
> +				   crc->cmdq_handle.pa_base,
> +				   crc->cmdq_handle.cmd_buf_size,
> +				   DMA_TO_DEVICE);
> +	mbox_send_message(crc->cmdq_client.chan, &crc->cmdq_handle);
> +	mbox_client_txdone(crc->cmdq_client.chan, 0);
> +}
> +
> +void mtk_drm_crc_cmdq_stop(struct mtk_drm_crc *crc)
> +{
> +	if (!crc->cmdq_client.chan)
> +		return;
> +
> +	mbox_flush(crc->cmdq_client.chan, 2000);
> +}
> +#endif
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> index 3c224595fa714..0683ec4bc26f6 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> @@ -15,6 +15,45 @@
>  #define MTK_MAX_BPC	10
>  #define MTK_MIN_BPC	3
>  
> +/**
> + * struct mtk_drm_crc - crc related information
> + * @ofs: register offset of crc
> + * @rst_ofs: register offset of crc reset
> + * @rst_msk: register mask of crc reset
> + * @cnt: count of crc
> + * @va: pointer to the start of crc array
> + * @pa: physical address of the crc for gce to access
> + * @cmdq_event: the event to trigger the cmdq
> + * @cmdq_reg: address of the register that cmdq is going to access
> + * @cmdq_client: handler to control cmdq (mbox channel, thread ...etc.)
> + * @cmdq_handle: cmdq packet to store the commands
> + */
> +struct mtk_drm_crc {
> +	const u32 *ofs;
> +	u32 rst_ofs;
> +	u32 rst_msk;
> +	size_t cnt;
> +	u32 *va;
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +	dma_addr_t pa;
> +	u32 cmdq_event;
> +	struct cmdq_client_reg *cmdq_reg;
> +	struct cmdq_client cmdq_client;
> +	struct cmdq_pkt cmdq_handle;
> +#endif
> +};
> +
> +void mtk_drm_crc_init(struct mtk_drm_crc *crc,
> +		      const u32 *crc_offset_table, size_t crc_count,
> +		      u32 reset_offset, u32 reset_mask);
> +void mtk_drm_crc_read(struct mtk_drm_crc *crc, void __iomem *reg);
> +void mtk_drm_crc_destroy(struct mtk_drm_crc *crc);
> +#if IS_REACHABLE(CONFIG_MTK_CMDQ)
> +void mtk_drm_crc_cmdq_create(struct device *dev, struct mtk_drm_crc *crc);
> +void mtk_drm_crc_cmdq_start(struct mtk_drm_crc *crc);
> +void mtk_drm_crc_cmdq_stop(struct mtk_drm_crc *crc);
> +#endif
> +
>  void mtk_drm_crtc_commit(struct drm_crtc *crtc);
>  int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  			const unsigned int *path,
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> index 215b7234ff13c..231017470607e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h
> @@ -87,6 +87,9 @@ struct mtk_ddp_comp_funcs {
>  	void (*remove)(struct device *dev, struct mtk_mutex *mutex);
>  	unsigned int (*encoder_index)(struct device *dev);
>  	enum drm_mode_status (*mode_valid)(struct device *dev, const struct drm_display_mode *mode);
> +	size_t (*crc_cnt)(struct device *dev);
> +	u32 *(*crc_entry)(struct device *dev);
> +	void (*crc_read)(struct device *dev);
>  };
>  
>  struct mtk_ddp_comp {
> -- 
> 2.18.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

