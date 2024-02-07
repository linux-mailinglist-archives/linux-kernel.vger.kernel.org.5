Return-Path: <linux-kernel+bounces-56230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7DF84C7A3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C6B828D046
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD58288A7;
	Wed,  7 Feb 2024 09:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="HFtumaY3"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A5A22F1D
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298556; cv=none; b=Cs8W786+nbh6pil/XkETixl7WSby5RTRqnNy8td/CW4F/KLzBubYiAOLb0vXC02lxPQRx+5B8k0FbsDNVoKadH/6vg8LXigOY1LBRlUHdl0GugOfONguu5rjYlTyTaVag5aTHgF5U+79ebnXHNK7XliDugwNQrvssbNcpAb9HNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298556; c=relaxed/simple;
	bh=kB7zLkCeQL5ry3JwBx2ah2f5NZ2RSTRNuC7Man+rK+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lz1Fy8EZuMLGGaMk/SYA779Lzr4ZVZrGZzUziXlLZ9RHQrOH2S3XIRs2rayzK4wRELeLKk7f9MO86DKhkXp9V4ZJ1awloMZjAv+1m2lqI2ig6/sODJMYcovEGH87qgtP+u1I5tw+47H/p2irR9S5CX8Le0L7EiciurvOZoAhQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=HFtumaY3; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40fc4363a0aso1187925e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1707298552; x=1707903352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDjzhUaPwUcoF6XRC/qZu9PdnocJoXWwT1wu5CmL/Tg=;
        b=HFtumaY3ihL6JlGLSRNJHTvIXnS1Ux2tplTpaaJkQwkpRPXja7LIzwZU5aAT526E49
         J4ZBWda1M33M7B353HujqPHkQIla6OJ+sGxImaONVoNitUpuYOPDeIvhkHDFpmcGW4Ed
         ozuTqVtQl7Z930MMz7H86hdLR4Xyy5OhJkgGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298552; x=1707903352;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDjzhUaPwUcoF6XRC/qZu9PdnocJoXWwT1wu5CmL/Tg=;
        b=qZ1mdAueKu2sEjL51eUwddPrUOqw+W8mAhWM4Ls4J4cXGvizuFejGbPY4hEf7nm9zW
         +Nn75dsEkUEhk5b3gE3rWHdwDXaPhO0SEgN5PMd6JpBLYlYs2o4kz2pS8nL3VdTg1opL
         dszowQOcxmAp5FTg8e89r143OrGar+NxbOP2FdnRANSuLK6z0EJgAPLj4a/9W/3fffbr
         JRzw+G/TGyV93t3f3rzHG8dkX7NoKovPKmf6nvrs4HxClW1V+5MTvoH038UuszJYPo2L
         Q8hy7h68R588L4t+zoCDzbhEXokCJhwn/8l/IPLnXVn77lVt0hNboECN5V6MLs8zOEO/
         aDFg==
X-Forwarded-Encrypted: i=1; AJvYcCUnk7vdbuCE796FwWo2BsahcD9Jj4cZUWcet+kUmQ2ST8g2/Bm6NXlzSHJvaoTSE228u/nKsltizT9P0iqZf88tElXodsij7zWkvrio
X-Gm-Message-State: AOJu0YyGtRtlgR9Ygl8fe0JOSz3TaNZhjZSGRRaEmJS8jfMxn6e0z8cu
	vxRi7mCdVlnrDB6BlQkVocRTbxIJzdCwG0WjvBdombi7WXotb5qEKr8mZL0WNJQ=
X-Google-Smtp-Source: AGHT+IFmvszXu0z+NG8asc6qoDgRJwhmo9boS/08JCn71Imkb7rN964yW8ktjOeqP2m5lmTJlEV6qQ==
X-Received: by 2002:a05:600c:5121:b0:410:5da:14cd with SMTP id o33-20020a05600c512100b0041005da14cdmr1102497wms.2.1707298552028;
        Wed, 07 Feb 2024 01:35:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXjZSpGKSELeP5QwGIlMA3q0Vygn0LDavxNCSSOCwxWLuhaM9X3DKijLGYtIUlVpvywCkpCNdQ9kr1cSgx4MZsy6DZd033WZomlgS8Oi+wIwPjQ93ULkj1jFKLZWOUhxuN+zisdnq+M4syiHMTiI1lXoaKVViCUr7NhRtuboVAIhqsv38tiac2CZaXkY8amqEZ055M43QvshvWTuTk1cgm9TtNgSte0eEVyGLrP5cTnQiRTWnDbtR+78vRGC1ABItWouksknyjGJzMllbdD0nIA37uPFCVkUJGwVUY6vI1H0ngj7/O4VRWmO0CYyUcb9AjFWg7mkH8paMTutBqNIFKIUwqSon9SKh9CNpj/OengY/ktZtB8
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b0040e4733aecbsm1463909wmq.15.2024.02.07.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 01:35:51 -0800 (PST)
Date: Wed, 7 Feb 2024 10:35:49 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: Re: [etnaviv-next v13 7/7] drm/etnaviv: Add support for vivante GPU
 cores attached via PCI(e)
Message-ID: <ZcNO9aZwWzyYs-Rv@phenom.ffwll.local>
Mail-Followup-To: Sui Jingfeng <sui.jingfeng@linux.dev>,
	Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <20240206172759.421737-1-sui.jingfeng@linux.dev>
 <20240206172759.421737-8-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206172759.421737-8-sui.jingfeng@linux.dev>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Wed, Feb 07, 2024 at 01:27:59AM +0800, Sui Jingfeng wrote:
> The component helper functions are the glue, which is used to bind multiple
> GPU cores to a virtual master platform device. Which is fine and works well
> for the SoCs who contains multiple GPU cores.
> 
> The problem is that usperspace programs (such as X server and Mesa) will
> search the PCIe device to use if it is exist. In other words, usperspace
> programs open the PCIe device with higher priority. Creating a virtual
> master platform device for PCI(e) GPUs is unnecessary, as the PCI device
> has been created by the time drm/etnaviv is loaded.
> 
> we create virtual platform devices as a representation for the vivante GPU
> ip core. As all of subcomponent are attached via the PCIe master device,
> we reflect this hardware layout by binding all of the virtual child to the
> the real master.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>

Uh so my understanding is that drivers really shouldn't create platform
devices of their own. For this case here I think the aux-bus framework is
the right thing to use. Alternatively would be some infrastructure where
you feed a DT tree to driver core or pci subsystem and it instantiates it
all for you correctly, and especially with hotunplug all done right since
this is pci now, not actually part of the soc that cannot be hotunplugged.

I think I've seen some other pci devices from arm soc designs that would
benefit from this too, so lifting this logic into a pci function would
make sense imo.

Cheers, Sima
> ---
>  drivers/gpu/drm/etnaviv/Kconfig           |   8 +
>  drivers/gpu/drm/etnaviv/Makefile          |   2 +
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c     |  12 +-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c     |  75 ++++++--
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h     |   4 +
>  drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c | 224 ++++++++++++++++++++++
>  drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h |  18 ++
>  7 files changed, 327 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
>  create mode 100644 drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h
> 
> diff --git a/drivers/gpu/drm/etnaviv/Kconfig b/drivers/gpu/drm/etnaviv/Kconfig
> index faa7fc68b009..38c251585ec1 100644
> --- a/drivers/gpu/drm/etnaviv/Kconfig
> +++ b/drivers/gpu/drm/etnaviv/Kconfig
> @@ -15,6 +15,14 @@ config DRM_ETNAVIV
>  	help
>  	  DRM driver for Vivante GPUs.
>  
> +config DRM_ETNAVIV_PCI_DRIVER
> +	bool "enable ETNAVIV PCI driver support"
> +	depends on DRM_ETNAVIV
> +	depends on PCI
> +	help
> +	  Compile in support for Vivante GPUs attached via PCI(e).
> +	  Say Y if you have such hardwares.
> +
>  config DRM_ETNAVIV_THERMAL
>  	bool "enable ETNAVIV thermal throttling"
>  	depends on DRM_ETNAVIV
> diff --git a/drivers/gpu/drm/etnaviv/Makefile b/drivers/gpu/drm/etnaviv/Makefile
> index 46e5ffad69a6..6829e1ebf2db 100644
> --- a/drivers/gpu/drm/etnaviv/Makefile
> +++ b/drivers/gpu/drm/etnaviv/Makefile
> @@ -16,4 +16,6 @@ etnaviv-y := \
>  	etnaviv_perfmon.o \
>  	etnaviv_sched.o
>  
> +etnaviv-$(CONFIG_DRM_ETNAVIV_PCI_DRIVER) += etnaviv_pci_drv.o
> +
>  obj-$(CONFIG_DRM_ETNAVIV)	+= etnaviv.o
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 5f65f2dead44..48e2402adbe3 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -24,6 +24,7 @@
>  #include "etnaviv_gpu.h"
>  #include "etnaviv_gem.h"
>  #include "etnaviv_mmu.h"
> +#include "etnaviv_pci_drv.h"
>  #include "etnaviv_perfmon.h"
>  
>  /*
> @@ -566,6 +567,10 @@ static int etnaviv_bind(struct device *dev)
>  	if (ret < 0)
>  		goto out_free_priv;
>  
> +	ret = etnaviv_register_irq_handler(dev, priv);
> +	if (ret)
> +		goto out_unbind;
> +
>  	load_gpu(drm);
>  
>  	ret = drm_dev_register(drm, 0);
> @@ -594,7 +599,7 @@ static void etnaviv_unbind(struct device *dev)
>  	etnaviv_private_fini(priv);
>  }
>  
> -static const struct component_master_ops etnaviv_master_ops = {
> +const struct component_master_ops etnaviv_master_ops = {
>  	.bind = etnaviv_bind,
>  	.unbind = etnaviv_unbind,
>  };
> @@ -740,6 +745,10 @@ static int __init etnaviv_init(void)
>  	if (ret != 0)
>  		goto unregister_gpu_driver;
>  
> +	ret = etnaviv_register_pci_driver();
> +	if (ret != 0)
> +		goto unregister_platform_driver;
> +
>  	/*
>  	 * If the DT contains at least one available GPU device, instantiate
>  	 * the DRM platform device.
> @@ -769,6 +778,7 @@ module_init(etnaviv_init);
>  static void __exit etnaviv_exit(void)
>  {
>  	etnaviv_destroy_platform_device(&etnaviv_drm);
> +	etnaviv_unregister_pci_driver();
>  	platform_driver_unregister(&etnaviv_platform_driver);
>  	platform_driver_unregister(&etnaviv_gpu_driver);
>  }
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index 3fd637c17797..221020e98900 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -10,6 +10,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/pci.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> @@ -29,6 +30,7 @@
>  
>  static const struct platform_device_id gpu_ids[] = {
>  	{ .name = "etnaviv-gpu,2d" },
> +	{ .name = "etnaviv-gpu,3d" },
>  	{ },
>  };
>  
> @@ -1555,14 +1557,22 @@ static void dump_mmu_fault(struct etnaviv_gpu *gpu)
>  
>  static irqreturn_t irq_handler(int irq, void *data)
>  {
> -	struct etnaviv_gpu *gpu = data;
> +	struct etnaviv_drm_private *priv = data;
>  	irqreturn_t ret = IRQ_NONE;
> +	int i;
>  
> -	u32 intr = gpu_read(gpu, VIVS_HI_INTR_ACKNOWLEDGE);
> -
> -	if (intr != 0) {
> +	for (i = 0; i < priv->num_gpus; i++) {
> +		struct etnaviv_gpu *gpu = priv->gpu[i];
> +		u32 intr;
>  		int event;
>  
> +		if (!gpu)
> +			continue;
> +
> +		intr = gpu_read(gpu, VIVS_HI_INTR_ACKNOWLEDGE);
> +		if (!intr)
> +			continue;
> +
>  		pm_runtime_mark_last_busy(gpu->dev);
>  
>  		dev_dbg(gpu->dev, "intr 0x%08x\n", intr);
> @@ -1893,10 +1903,44 @@ static const struct of_device_id etnaviv_gpu_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, etnaviv_gpu_match);
>  
> +/*
> + * dev point to the master. For platform device, it is virtual.
> + * For PCI(e) device, it is real.
> + */
> +int etnaviv_register_irq_handler(struct device *dev,
> +				 struct etnaviv_drm_private *priv)
> +{
> +	bool is_pci = dev_is_pci(dev);
> +	int ret = 0;
> +
> +	if (is_pci) {
> +		struct pci_dev *pdev = to_pci_dev(dev);
> +
> +		ret = request_irq(pdev->irq, irq_handler, IRQF_SHARED,
> +				  dev_name(dev), priv);
> +	} else {
> +		int i;
> +
> +		for (i = 0; i < priv->num_gpus; i++) {
> +			struct etnaviv_gpu *gpu = priv->gpu[i];
> +
> +			ret = devm_request_irq(gpu->dev, gpu->irq, irq_handler,
> +					       0, dev_name(dev), priv);
> +			if (ret) {
> +				dev_err(dev, "failed to request IRQ handler: %d\n", ret);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct etnaviv_gpu *gpu;
> +	bool is_pci;
>  	int err;
>  
>  	gpu = devm_kzalloc(dev, sizeof(*gpu), GFP_KERNEL);
> @@ -1912,22 +1956,23 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>  	if (IS_ERR(gpu->mmio))
>  		return PTR_ERR(gpu->mmio);
>  
> +	is_pci = dev->parent ? dev_is_pci(dev->parent) : false;
> +
>  	/* Get Interrupt: */
> -	gpu->irq = platform_get_irq(pdev, 0);
> +	if (is_pci)
> +		gpu->irq = to_pci_dev(dev->parent)->irq;
> +	else
> +		gpu->irq = platform_get_irq(pdev, 0);
> +
>  	if (gpu->irq < 0)
>  		return gpu->irq;
>  
> -	err = devm_request_irq(dev, gpu->irq, irq_handler, 0,
> -			       dev_name(dev), gpu);
> -	if (err) {
> -		dev_err(dev, "failed to request IRQ%u: %d\n", gpu->irq, err);
> -		return err;
> -	}
> -
>  	/* Get Clocks: */
> -	err = etnaviv_gpu_clk_get(gpu);
> -	if (err)
> -		return err;
> +	if (!is_pci) {
> +		err = etnaviv_gpu_clk_get(gpu);
> +		if (err)
> +			return err;
> +	}
>  
>  	/* TODO: figure out max mapped size */
>  	dev_set_drvdata(dev, gpu);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> index 7d5e9158e13c..d354e096652c 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.h
> @@ -208,6 +208,10 @@ static inline u32 gpu_read_power(struct etnaviv_gpu *gpu, u32 reg)
>  int etnaviv_gpu_get_param(struct etnaviv_gpu *gpu, u32 param, u64 *value);
>  
>  int etnaviv_gpu_init(struct etnaviv_gpu *gpu);
> +
> +int etnaviv_register_irq_handler(struct device *dev,
> +				 struct etnaviv_drm_private *priv);
> +
>  bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu);
>  
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
> new file mode 100644
> index 000000000000..ec5039866eda
> --- /dev/null
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_pci_drv.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/component.h>
> +#include <linux/pci.h>
> +
> +#include "etnaviv_drv.h"
> +#include "etnaviv_pci_drv.h"
> +
> +enum etnaviv_pci_gpu_chip_id {
> +	GC_CORE_UNKNOWN = 0,
> +	JM9100 = 1,
> +	JD9230P = 2,
> +	GP102 = 3,
> +	GC1000_IN_LS7A1000 = 4,
> +	GC1000_IN_LS2K1000 = 5,
> +	GC_CORE_PCI_LAST,
> +};
> +
> +struct etnaviv_pci_gpu_data {
> +	enum etnaviv_pci_gpu_chip_id chip_id;
> +	u32 num_core;
> +	u32 num_vram;
> +	u32 vram_bars[2];
> +	u32 mmio_bar;
> +	struct {
> +		u32 id;
> +		u32 offset;
> +		u32 size;
> +		char compatible[20];
> +	} cores[ETNA_MAX_PIPES];
> +
> +	bool has_dedicated_vram;
> +	char market_name[24];
> +};
> +
> +static const struct etnaviv_pci_gpu_data
> +gc_core_plaform_data[GC_CORE_PCI_LAST] = {
> +	{
> +		.chip_id = GC_CORE_UNKNOWN,
> +	},
> +	{
> +		.chip_id = JM9100,
> +		.num_core = 1,
> +		.num_vram = 2,
> +		.vram_bars = {0, 2},
> +		.mmio_bar = 1,
> +		.cores = {{0, 0x00900000, 0x00010000, "etnaviv-gpu,3d"},},
> +		.has_dedicated_vram = true,
> +		.market_name = "JingJia Micro JM9100",
> +	},
> +	{
> +		.chip_id = JD9230P,
> +		.num_core = 2,
> +		.num_vram = 2,
> +		.vram_bars = {0, 2},
> +		.mmio_bar = 1,
> +		.cores = {{0, 0x00900000, 0x00010000, "etnaviv-gpu,3d"},
> +			  {1, 0x00910000, 0x00010000, "etnaviv-gpu,3d"},},
> +		.has_dedicated_vram = true,
> +		.market_name = "JingJia Micro JD9230P",
> +	},
> +	{
> +		.chip_id = GP102,
> +		.num_core = 2,
> +		.num_vram = 1,
> +		.vram_bars = {0,},
> +		.mmio_bar = 2,
> +		.cores = {{0, 0x00040000, 0x00010000, "etnaviv-gpu,3d"},
> +			  {0, 0x000C0000, 0x00010000, "etnaviv-gpu,2d"},},
> +		.has_dedicated_vram = true,
> +		.market_name = "LingJiu GP102",
> +	},
> +	{
> +		.chip_id = GC1000_IN_LS7A1000,
> +		.num_core = 1,
> +		.num_vram = 1,
> +		.vram_bars = {2,},
> +		.mmio_bar = 0,
> +		.cores = {{0, 0, 0x00010000, "etnaviv-gpu,3d"}, {}, {}, {}},
> +		.has_dedicated_vram = true,
> +		.market_name = "GC1000 in LS7A1000",
> +	},
> +	{
> +		.chip_id = GC1000_IN_LS2K1000,
> +		.num_core = 1,
> +		.num_vram = 0,
> +		.mmio_bar = 0,
> +		.cores = {{0, 0, 0x00010000, "etnaviv-gpu,3d"}, {}, {}, {}},
> +		.has_dedicated_vram = false,
> +		.market_name = "GC1000 in LS2K1000",
> +	},
> +};
> +
> +static const struct etnaviv_pci_gpu_data *
> +etnaviv_pci_get_platform_data(const struct pci_device_id *entity)
> +{
> +	enum etnaviv_pci_gpu_chip_id chip_id = entity->driver_data;
> +	static const struct etnaviv_pci_gpu_data *pdata;
> +
> +	pdata = &gc_core_plaform_data[chip_id];
> +	if (!pdata || pdata->chip_id == GC_CORE_UNKNOWN)
> +		return NULL;
> +
> +	return pdata;
> +}
> +
> +extern const struct component_master_ops etnaviv_master_ops;
> +
> +static int etnaviv_pci_probe(struct pci_dev *pdev,
> +			     const struct pci_device_id *ent)
> +{
> +	const struct etnaviv_pci_gpu_data *pdata;
> +	struct device *dev = &pdev->dev;
> +	struct component_match *matches = NULL;
> +	unsigned int i;
> +	unsigned int num_core;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "failed to enable\n");
> +		return ret;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
> +	pdata = etnaviv_pci_get_platform_data(ent);
> +	if (!pdata)
> +		return -ENODEV;
> +
> +	num_core = pdata->num_core;
> +
> +	dev_info(dev, "%s has %u GPU cores\n", pdata->market_name, num_core);
> +
> +	/*
> +	 * Create a virtual platform device for the sub-component,
> +	 * a sub-component is refer to a single vivante GPU core.
> +	 * But it can also be extended to stand for a display controller
> +	 * or any other IP core attached via the same PCIe master.
> +	 */
> +	for (i = 0; i < num_core; i++) {
> +		struct platform_device *virtual_child;
> +		resource_size_t start, offset, size;
> +		struct resource res;
> +
> +		start = pci_resource_start(pdev, pdata->mmio_bar);
> +		offset = pdata->cores[i].offset;
> +		size = pdata->cores[i].size;
> +
> +		memset(&res, 0, sizeof(res));
> +		res.flags = IORESOURCE_MEM;
> +		res.name = "reg";
> +		res.start = start + offset;
> +		res.end = start + offset + size - 1;
> +
> +		ret = etnaviv_create_platform_device(dev,
> +						     pdata->cores[i].compatible,
> +						     pdata->cores[i].id,
> +						     &res,
> +						     (void *)pdata,
> +						     &virtual_child);
> +		if (ret)
> +			return ret;
> +
> +		component_match_add(dev, &matches, component_compare_dev,
> +				    &virtual_child->dev);
> +	}
> +
> +	ret = component_master_add_with_match(dev, &etnaviv_master_ops, matches);
> +
> +	return ret;
> +}
> +
> +static int platform_device_remove_callback(struct device *dev, void *data)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +
> +	etnaviv_destroy_platform_device(&pdev);
> +
> +	return 0;
> +}
> +
> +static void etnaviv_pci_remove(struct pci_dev *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +
> +	component_master_del(dev, &etnaviv_master_ops);
> +
> +	device_for_each_child(dev, NULL, platform_device_remove_callback);
> +
> +	pci_clear_master(pdev);
> +}
> +
> +static const struct pci_device_id etnaviv_pci_id_lists[] = {
> +	{0x0731, 0x9100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, JM9100},
> +	{0x0731, 0x9230, PCI_ANY_ID, PCI_ANY_ID, 0, 0, JD9230P},
> +	{0x0709, 0x0001, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GP102},
> +	{0x0014, 0x7A15, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GC1000_IN_LS7A1000},
> +	{0x0014, 0x7A05, PCI_ANY_ID, PCI_ANY_ID, 0, 0, GC1000_IN_LS2K1000},
> +	{ }
> +};
> +
> +static struct pci_driver etnaviv_pci_driver = {
> +	.name = "etnaviv",
> +	.id_table = etnaviv_pci_id_lists,
> +	.probe = etnaviv_pci_probe,
> +	.remove = etnaviv_pci_remove,
> +};
> +
> +int etnaviv_register_pci_driver(void)
> +{
> +	return pci_register_driver(&etnaviv_pci_driver);
> +}
> +
> +void etnaviv_unregister_pci_driver(void)
> +{
> +	pci_unregister_driver(&etnaviv_pci_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(pci, etnaviv_pci_id_lists);
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h
> new file mode 100644
> index 000000000000..1db559ee5e9b
> --- /dev/null
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_pci_drv.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ETNAVIV_PCI_DRV_H__
> +#define __ETNAVIV_PCI_DRV_H__
> +
> +#ifdef CONFIG_DRM_ETNAVIV_PCI_DRIVER
> +
> +int etnaviv_register_pci_driver(void);
> +void etnaviv_unregister_pci_driver(void);
> +
> +#else
> +
> +static inline int etnaviv_register_pci_driver(void) { return 0; }
> +static inline void etnaviv_unregister_pci_driver(void) { }
> +
> +#endif
> +
> +#endif
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

