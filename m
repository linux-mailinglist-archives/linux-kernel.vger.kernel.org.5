Return-Path: <linux-kernel+bounces-139409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2988A02F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39AF91F21543
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA1F19069C;
	Wed, 10 Apr 2024 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PqolnPgC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C64A190691
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712787089; cv=none; b=RUhBN3mQ4U4F+2nxYiUjOKNxqZGZJkps4x9KPsRsw9hv22Ruafu4IuBGBYpaqlOE5RsDF0qml47t9QzY4QKkkAOLnlSYlC23D4g43Xm+5884PRnGd+Vi6YN9h8U5xXnHM+5bcJKMTuXQXCly5a6+HGGTVVtC+VOf+AzAGhSwRfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712787089; c=relaxed/simple;
	bh=rk3Y/hV4O3MGFGXpBEK2ctrlDUHH3NOCfzel06outQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQ4h7cqFvR5Mbc0W3K+9QGCiWA/zWO4TB/4YGPT/GX1sVJFWTtEUnE4huv0BYzN5UHPv/o5x4Y4q0cSgwJi1Z2wbA5oeEenAU6ZVGk6fTKJAqpxp2470wZ+VALSvBN7hd7s2Y/YgQkcxlJvo8ttSSa9+ycTjDe8Y/syW2oiTgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PqolnPgC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712787086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/9ZaDdsvv6WC5wTEQulDSBBsBWUVx4JFTYwinWsVjD0=;
	b=PqolnPgC4D+X5xrQibxf9IDcppdeOc7YOLhdX6F5Q93RS1NdIs58BjhlKQyiNzuRzCkOnp
	XHDV2C7NORvgp+DtHKlD1zyztpYgrLnpNOFpzi8ZD2EAuSOei7TxwyQCim1q/+Um2B0lBj
	EXz7jSUevaCWI6dAPigGCMjG/kmEups=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-MWQDbPZmMoCvYFopXFnvFw-1; Wed, 10 Apr 2024 18:11:24 -0400
X-MC-Unique: MWQDbPZmMoCvYFopXFnvFw-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36a179df9fdso49154275ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:11:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712787084; x=1713391884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/9ZaDdsvv6WC5wTEQulDSBBsBWUVx4JFTYwinWsVjD0=;
        b=KSAqQCK/CR/70pJgVQV//4TE9UxEDGedZefJa8CBDqTQHDq8ul4kJA8dzNpopp83QV
         JS9sqLN0ev4TKOt/MT/xI57Y7dnToFVQGVc0c3t/9Q4ToXeYxD3cmzC+E3Uavv2e0FrI
         BJdFzT4PYBYD78H+AfM4vM9ZRNntxqzuYwtZkLz0HWFMl3OYCZsGm13DzXIZrHlRB6kC
         zKil1vW/ppQYMxvinyAyRxSMk+Y/6uN+ZvH5Dkhciw5GoAX3UCHKs4mbosTa5CG+V6tJ
         80v6BVk4obPiXv5QOVnM8nGbWGB9gkxEIy4DcLSrsiylxvNKmj8hQD72AI0i6aZ9kyOR
         wD8w==
X-Forwarded-Encrypted: i=1; AJvYcCWyxe59YARio31nl6M7zxssqaXxBeqm3ADbGFnrMs1Te6sQcTPKpBM/oWtEyK6DzT57oEAD5yJMpuQXwNVVHz5DjUCqAQJalp8Qrhpt
X-Gm-Message-State: AOJu0Yx14Xo+onI8SLAVDSEkvscrZfKpFb+tgfAn+G+XRDVaN9eZJJ1e
	vh0qGFwm6Sswxpfj9lbOcalCqs2qsgi8hoXSLA36j/yGNuFIJwT6kCCF3MvX/vBWyjYkxfYT+sw
	o9JRc4bJxHEaTHzDcRzIp539DcFJ6g+Sh6De6M1YBsqFdXDX/evrBHYmQOgpfFg==
X-Received: by 2002:a05:6e02:2184:b0:369:f74f:bbe8 with SMTP id j4-20020a056e02218400b00369f74fbbe8mr4414896ila.14.1712787083837;
        Wed, 10 Apr 2024 15:11:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5CdIhx3hEVeM8v+W7ezlD4mg6TH6+8ByQq5pRvr8stk4BYb74HRPa8nDJXZLAMSTxH4SmhA==
X-Received: by 2002:a05:6e02:2184:b0:369:f74f:bbe8 with SMTP id j4-20020a056e02218400b00369f74fbbe8mr4414872ila.14.1712787083369;
        Wed, 10 Apr 2024 15:11:23 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id t184-20020a632dc1000000b005f410b67e60sm37103pgt.22.2024.04.10.15.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 15:11:22 -0700 (PDT)
Date: Wed, 10 Apr 2024 17:11:19 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Drop msm_read/writel
Message-ID: <s5i4sgt7xbtjkfa6d7whjmuwdpe643uvgdefq7lhsu2wrchfin@eb6csf2mh4g6>
References: <20240410-topic-msm_rw-v1-1-e1fede9ffaba@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410-topic-msm_rw-v1-1-e1fede9ffaba@linaro.org>

On Wed, Apr 10, 2024 at 11:52:52PM +0200, Konrad Dybcio wrote:
> Totally useless.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

A few more words in the description mentioning this just wraps readl/writel
with no, but that's a minor nit and is easy to find when you finally see
the removal in the end of the diff.

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>

> ---
> only compile-tested
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c       |  2 +-
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.h       | 12 ++++++------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |  4 ++--
>  drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  4 ++--
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h    |  4 ++--
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h    |  4 ++--
>  drivers/gpu/drm/msm/dsi/dsi_host.c          | 10 +++++-----
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h       |  8 ++++----
>  drivers/gpu/drm/msm/hdmi/hdmi.h             | 10 +++++-----
>  drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c    |  6 +++---
>  drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c    |  4 ++--
>  drivers/gpu/drm/msm/msm_drv.h               |  7 ++-----
>  drivers/gpu/drm/msm/msm_gpu.h               | 12 ++++++------
>  13 files changed, 42 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> index 8bea8ef26f77..0e3dfd4c2bc8 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
> @@ -507,7 +507,7 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
>  
>  static inline void pdc_write(void __iomem *ptr, u32 offset, u32 value)
>  {
> -	msm_writel(value, ptr + (offset << 2));
> +	writel(value, ptr + (offset << 2));
>  }
>  
>  static void __iomem *a6xx_gmu_get_mmio(struct platform_device *pdev,
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> index 592b296aab22..94b6c5cab6f4 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
> @@ -103,12 +103,12 @@ struct a6xx_gmu {
>  
>  static inline u32 gmu_read(struct a6xx_gmu *gmu, u32 offset)
>  {
> -	return msm_readl(gmu->mmio + (offset << 2));
> +	return readl(gmu->mmio + (offset << 2));
>  }
>  
>  static inline void gmu_write(struct a6xx_gmu *gmu, u32 offset, u32 value)
>  {
> -	msm_writel(value, gmu->mmio + (offset << 2));
> +	writel(value, gmu->mmio + (offset << 2));
>  }
>  
>  static inline void
> @@ -131,8 +131,8 @@ static inline u64 gmu_read64(struct a6xx_gmu *gmu, u32 lo, u32 hi)
>  {
>  	u64 val;
>  
> -	val = (u64) msm_readl(gmu->mmio + (lo << 2));
> -	val |= ((u64) msm_readl(gmu->mmio + (hi << 2)) << 32);
> +	val = (u64) readl(gmu->mmio + (lo << 2));
> +	val |= ((u64) readl(gmu->mmio + (hi << 2)) << 32);
>  
>  	return val;
>  }
> @@ -143,12 +143,12 @@ static inline u64 gmu_read64(struct a6xx_gmu *gmu, u32 lo, u32 hi)
>  
>  static inline u32 gmu_read_rscc(struct a6xx_gmu *gmu, u32 offset)
>  {
> -	return msm_readl(gmu->rscc + (offset << 2));
> +	return readl(gmu->rscc + (offset << 2));
>  }
>  
>  static inline void gmu_write_rscc(struct a6xx_gmu *gmu, u32 offset, u32 value)
>  {
> -	msm_writel(value, gmu->rscc + (offset << 2));
> +	writel(value, gmu->rscc + (offset << 2));
>  }
>  
>  #define gmu_poll_timeout_rscc(gmu, addr, val, cond, interval, timeout) \
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> index 34822b080759..8917032b7515 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
> @@ -69,12 +69,12 @@ static inline void a6xx_llc_rmw(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 mask, u3
>  
>  static inline u32 a6xx_llc_read(struct a6xx_gpu *a6xx_gpu, u32 reg)
>  {
> -	return msm_readl(a6xx_gpu->llc_mmio + (reg << 2));
> +	return readl(a6xx_gpu->llc_mmio + (reg << 2));
>  }
>  
>  static inline void a6xx_llc_write(struct a6xx_gpu *a6xx_gpu, u32 reg, u32 value)
>  {
> -	msm_writel(value, a6xx_gpu->llc_mmio + (reg << 2));
> +	writel(value, a6xx_gpu->llc_mmio + (reg << 2));
>  }
>  
>  #define shadowptr(_a6xx_gpu, _ring) ((_a6xx_gpu)->shadow_iova + \
> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> index a847a0f7a73c..83d7ee01c944 100644
> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
> @@ -192,10 +192,10 @@ static int debugbus_read(struct msm_gpu *gpu, u32 block, u32 offset,
>  }
>  
>  #define cxdbg_write(ptr, offset, val) \
> -	msm_writel((val), (ptr) + ((offset) << 2))
> +	writel((val), (ptr) + ((offset) << 2))
>  
>  #define cxdbg_read(ptr, offset) \
> -	msm_readl((ptr) + ((offset) << 2))
> +	readl((ptr) + ((offset) << 2))
>  
>  /* read a value from the CX debug bus */
>  static int cx_debugbus_read(void __iomem *cxdbg, u32 block, u32 offset,
> diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
> index 01179e764a29..94b1ba92785f 100644
> --- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
> +++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.h
> @@ -44,12 +44,12 @@ struct mdp4_kms {
>  
>  static inline void mdp4_write(struct mdp4_kms *mdp4_kms, u32 reg, u32 data)
>  {
> -	msm_writel(data, mdp4_kms->mmio + reg);
> +	writel(data, mdp4_kms->mmio + reg);
>  }
>  
>  static inline u32 mdp4_read(struct mdp4_kms *mdp4_kms, u32 reg)
>  {
> -	return msm_readl(mdp4_kms->mmio + reg);
> +	return readl(mdp4_kms->mmio + reg);
>  }
>  
>  static inline uint32_t pipe2flush(enum mdp4_pipe pipe)
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
> index fac9f05aa639..36b6842dfc9c 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.h
> @@ -171,13 +171,13 @@ struct mdp5_encoder {
>  static inline void mdp5_write(struct mdp5_kms *mdp5_kms, u32 reg, u32 data)
>  {
>  	WARN_ON(mdp5_kms->enable_count <= 0);
> -	msm_writel(data, mdp5_kms->mmio + reg);
> +	writel(data, mdp5_kms->mmio + reg);
>  }
>  
>  static inline u32 mdp5_read(struct mdp5_kms *mdp5_kms, u32 reg)
>  {
>  	WARN_ON(mdp5_kms->enable_count <= 0);
> -	return msm_readl(mdp5_kms->mmio + reg);
> +	return readl(mdp5_kms->mmio + reg);
>  }
>  
>  static inline const char *stage2name(enum mdp_mixer_stage_id stage)
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 9d86a6aca6f2..77bd5ff330d7 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -55,7 +55,7 @@ static int dsi_get_version(const void __iomem *base, u32 *major, u32 *minor)
>  	 * scratch register which we never touch)
>  	 */
>  
> -	ver = msm_readl(base + REG_DSI_VERSION);
> +	ver = readl(base + REG_DSI_VERSION);
>  	if (ver) {
>  		/* older dsi host, there is no register shift */
>  		ver = FIELD(ver, DSI_VERSION_MAJOR);
> @@ -73,12 +73,12 @@ static int dsi_get_version(const void __iomem *base, u32 *major, u32 *minor)
>  		 * registers are shifted down, read DSI_VERSION again with
>  		 * the shifted offset
>  		 */
> -		ver = msm_readl(base + DSI_6G_REG_SHIFT + REG_DSI_VERSION);
> +		ver = readl(base + DSI_6G_REG_SHIFT + REG_DSI_VERSION);
>  		ver = FIELD(ver, DSI_VERSION_MAJOR);
>  		if (ver == MSM_DSI_VER_MAJOR_6G) {
>  			/* 6G version */
>  			*major = ver;
> -			*minor = msm_readl(base + REG_DSI_6G_HW_VERSION);
> +			*minor = readl(base + REG_DSI_6G_HW_VERSION);
>  			return 0;
>  		} else {
>  			return -EINVAL;
> @@ -186,11 +186,11 @@ struct msm_dsi_host {
>  
>  static inline u32 dsi_read(struct msm_dsi_host *msm_host, u32 reg)
>  {
> -	return msm_readl(msm_host->ctrl_base + reg);
> +	return readl(msm_host->ctrl_base + reg);
>  }
>  static inline void dsi_write(struct msm_dsi_host *msm_host, u32 reg, u32 data)
>  {
> -	msm_writel(data, msm_host->ctrl_base + reg);
> +	writel(data, msm_host->ctrl_base + reg);
>  }
>  
>  static const struct msm_dsi_cfg_handler *dsi_get_config(
> diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> index e4275d3ad581..5a5dc3faa971 100644
> --- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> +++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
> @@ -12,10 +12,10 @@
>  
>  #include "dsi.h"
>  
> -#define dsi_phy_read(offset) msm_readl((offset))
> -#define dsi_phy_write(offset, data) msm_writel((data), (offset))
> -#define dsi_phy_write_udelay(offset, data, delay_us) { msm_writel((data), (offset)); udelay(delay_us); }
> -#define dsi_phy_write_ndelay(offset, data, delay_ns) { msm_writel((data), (offset)); ndelay(delay_ns); }
> +#define dsi_phy_read(offset) readl((offset))
> +#define dsi_phy_write(offset, data) writel((data), (offset))
> +#define dsi_phy_write_udelay(offset, data, delay_us) { writel((data), (offset)); udelay(delay_us); }
> +#define dsi_phy_write_ndelay(offset, data, delay_ns) { writel((data), (offset)); ndelay(delay_ns); }
>  
>  struct msm_dsi_phy_ops {
>  	int (*pll_init)(struct msm_dsi_phy *phy);
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
> index ec5786440391..4586baf36415 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi.h
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
> @@ -115,17 +115,17 @@ void msm_hdmi_set_mode(struct hdmi *hdmi, bool power_on);
>  
>  static inline void hdmi_write(struct hdmi *hdmi, u32 reg, u32 data)
>  {
> -	msm_writel(data, hdmi->mmio + reg);
> +	writel(data, hdmi->mmio + reg);
>  }
>  
>  static inline u32 hdmi_read(struct hdmi *hdmi, u32 reg)
>  {
> -	return msm_readl(hdmi->mmio + reg);
> +	return readl(hdmi->mmio + reg);
>  }
>  
>  static inline u32 hdmi_qfprom_read(struct hdmi *hdmi, u32 reg)
>  {
> -	return msm_readl(hdmi->qfprom_mmio + reg);
> +	return readl(hdmi->qfprom_mmio + reg);
>  }
>  
>  /*
> @@ -166,12 +166,12 @@ struct hdmi_phy {
>  
>  static inline void hdmi_phy_write(struct hdmi_phy *phy, u32 reg, u32 data)
>  {
> -	msm_writel(data, phy->mmio + reg);
> +	writel(data, phy->mmio + reg);
>  }
>  
>  static inline u32 hdmi_phy_read(struct hdmi_phy *phy, u32 reg)
>  {
> -	return msm_readl(phy->mmio + reg);
> +	return readl(phy->mmio + reg);
>  }
>  
>  int msm_hdmi_phy_resource_enable(struct hdmi_phy *phy);
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
> index 4dd055416620..8c8d80b59573 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
> @@ -86,18 +86,18 @@ static inline struct hdmi_phy *pll_get_phy(struct hdmi_pll_8996 *pll)
>  static inline void hdmi_pll_write(struct hdmi_pll_8996 *pll, int offset,
>  				  u32 data)
>  {
> -	msm_writel(data, pll->mmio_qserdes_com + offset);
> +	writel(data, pll->mmio_qserdes_com + offset);
>  }
>  
>  static inline u32 hdmi_pll_read(struct hdmi_pll_8996 *pll, int offset)
>  {
> -	return msm_readl(pll->mmio_qserdes_com + offset);
> +	return readl(pll->mmio_qserdes_com + offset);
>  }
>  
>  static inline void hdmi_tx_chan_write(struct hdmi_pll_8996 *pll, int channel,
>  				      int offset, int data)
>  {
> -	 msm_writel(data, pll->mmio_qserdes_tx[channel] + offset);
> +	 writel(data, pll->mmio_qserdes_tx[channel] + offset);
>  }
>  
>  static inline u32 pll_get_cpctrl(u64 frac_start, unsigned long ref_clk,
> diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c b/drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c
> index cb35a297afbd..83c8781fcc3f 100644
> --- a/drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c
> +++ b/drivers/gpu/drm/msm/hdmi/hdmi_pll_8960.c
> @@ -236,12 +236,12 @@ static const struct pll_rate freqtbl[] = {
>  
>  static inline void pll_write(struct hdmi_pll_8960 *pll, u32 reg, u32 data)
>  {
> -	msm_writel(data, pll->mmio + reg);
> +	writel(data, pll->mmio + reg);
>  }
>  
>  static inline u32 pll_read(struct hdmi_pll_8960 *pll, u32 reg)
>  {
> -	return msm_readl(pll->mmio + reg);
> +	return readl(pll->mmio + reg);
>  }
>  
>  static inline struct hdmi_phy *pll_get_phy(struct hdmi_pll_8960 *pll)
> diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
> index 65f213660452..0659459c0b15 100644
> --- a/drivers/gpu/drm/msm/msm_drv.h
> +++ b/drivers/gpu/drm/msm/msm_drv.h
> @@ -488,15 +488,12 @@ void __iomem *msm_ioremap_mdss(struct platform_device *mdss_pdev,
>  
>  struct icc_path *msm_icc_get(struct device *dev, const char *name);
>  
> -#define msm_writel(data, addr) writel((data), (addr))
> -#define msm_readl(addr) readl((addr))
> -
>  static inline void msm_rmw(void __iomem *addr, u32 mask, u32 or)
>  {
> -	u32 val = msm_readl(addr);
> +	u32 val = readl(addr);
>  
>  	val &= ~mask;
> -	msm_writel(val | or, addr);
> +	writel(val | or, addr);
>  }
>  
>  /**
> diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> index 2bfcb222e353..a0c1bd6d1d5b 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.h
> +++ b/drivers/gpu/drm/msm/msm_gpu.h
> @@ -555,12 +555,12 @@ struct msm_gpu_state {
>  
>  static inline void gpu_write(struct msm_gpu *gpu, u32 reg, u32 data)
>  {
> -	msm_writel(data, gpu->mmio + (reg << 2));
> +	writel(data, gpu->mmio + (reg << 2));
>  }
>  
>  static inline u32 gpu_read(struct msm_gpu *gpu, u32 reg)
>  {
> -	return msm_readl(gpu->mmio + (reg << 2));
> +	return readl(gpu->mmio + (reg << 2));
>  }
>  
>  static inline void gpu_rmw(struct msm_gpu *gpu, u32 reg, u32 mask, u32 or)
> @@ -586,8 +586,8 @@ static inline u64 gpu_read64(struct msm_gpu *gpu, u32 reg)
>  	 * when the lo is read, so make sure to read the lo first to trigger
>  	 * that
>  	 */
> -	val = (u64) msm_readl(gpu->mmio + (reg << 2));
> -	val |= ((u64) msm_readl(gpu->mmio + ((reg + 1) << 2)) << 32);
> +	val = (u64) readl(gpu->mmio + (reg << 2));
> +	val |= ((u64) readl(gpu->mmio + ((reg + 1) << 2)) << 32);
>  
>  	return val;
>  }
> @@ -595,8 +595,8 @@ static inline u64 gpu_read64(struct msm_gpu *gpu, u32 reg)
>  static inline void gpu_write64(struct msm_gpu *gpu, u32 reg, u64 val)
>  {
>  	/* Why not a writeq here? Read the screed above */
> -	msm_writel(lower_32_bits(val), gpu->mmio + (reg << 2));
> -	msm_writel(upper_32_bits(val), gpu->mmio + ((reg + 1) << 2));
> +	writel(lower_32_bits(val), gpu->mmio + (reg << 2));
> +	writel(upper_32_bits(val), gpu->mmio + ((reg + 1) << 2));
>  }
>  
>  int msm_gpu_pm_suspend(struct msm_gpu *gpu);
> 
> ---
> base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430
> change-id: 20240410-topic-msm_rw-cdc1d85b2ece
> 
> Best regards,
> -- 
> Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> 


