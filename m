Return-Path: <linux-kernel+bounces-166670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CA98B9DF1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2429D1F220B6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A615D5A2;
	Thu,  2 May 2024 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jnSMlcIt"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688EB15AD83;
	Thu,  2 May 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665404; cv=none; b=Ns2lgxbup6hbDTChIq1F0ZdaG4XM645J2shuXyTyKWMCAv7RAp0Bfv92XNhiDwlSHirQtr0VUsUi8EfK1XKn4mqXTLYT3x3mYbn3EaJSYwD9U3+0YXG9xpmwUrW3KMNIiDCk9VZu7E5AjTn44VRmI/8n7kT/FSa1hnP1rLbTT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665404; c=relaxed/simple;
	bh=BNZ7VCPqIKavIbCVEnhdxfAfj5DbuGh10cv43Ssn2rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrRHzJT/X76aUQpRYF4XxAzkHipgHaFBIcLANaoPypVlCMnPeBX0qiHF7udUUIqGWwbydDqvjmULwx6SRXpzeavzZWXWf0jeT1DyuNDqlXl/soLZELiKy4hD8EVOL8oN3Uy3OvPGzmhwy74bgRMkGwPOUgvSpt1E9k9Ph7FnFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=jnSMlcIt; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 42DA73A3;
	Thu,  2 May 2024 17:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714665335;
	bh=BNZ7VCPqIKavIbCVEnhdxfAfj5DbuGh10cv43Ssn2rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnSMlcIt5GY6y0QCKlRnRwjUxUy+OXFL3lb5q3xwriAfQ1XM0hdrEX26Y4xSBi+FQ
	 L72jIK7nkXz0HCAPtF7Rb+x1zFTG1EtF9j5ah2S9T6RX9KlYqUZEC3ZvnbPkm3ehC2
	 r8UxJmawbCOQ9y1KOJ8vd01dLIWBulksmipSllag=
Date: Thu, 2 May 2024 18:56:26 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Julien Massot <julien.massot@collabora.com>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jacopo Mondi <jacopo+renesas@jmondi.org>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Yong Zhi <yong.zhi@intel.com>, Bingbu Cao <bingbu.cao@intel.com>,
	Dan Scally <djrscally@gmail.com>,
	Tianshu Qiu <tian.shu.qiu@intel.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Ripard <mripard@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Robert Foss <rfoss@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Dafna Hirschfeld <dafna@fastmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yong Deng <yong.deng@magewell.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Benoit Parrot <bparrot@ti.com>, Jai Luthra <j-luthra@ti.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-sunxi@lists.linux.dev, linux-staging@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/2] Introduce v4l2_async_nf_unregister_cleanup
Message-ID: <20240502155626.GD15807@pendragon.ideasonboard.com>
References: <20240502-master-v1-0-8bd109c6a3ba@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240502-master-v1-0-8bd109c6a3ba@collabora.com>

Hi Julien,

On Thu, May 02, 2024 at 05:22:20PM +0200, Julien Massot wrote:
> Many drivers has
>   v4l2_async_nf_unregister(&notifier);
>   v4l2_async_nf_cleanup(&notifier);
> 
> Introduce a helper function to call both functions in one line.

Does this really go in the right direction ? For other objects (video
devices, media devices, ...), the unregistration should be done at
remove() time, and the cleanup at .release() time (the operation called
when the last reference to the object is released). This is needed to
ensure proper lifetime management of the objects, and avoid a
use-after-free for objects that can be reached from userspace.

It could be argued that the notifier isn't exposed to userspace, but can
we guarantee that no driver will have a need to access the notifier in a
code path triggered by a userspace operation ? I think it would be safer
to adopt the same split for the nofifier unregistration and cleanup. In
my opinion using the same rule across different APIs also make it easier
for driver authors and for reviewers to get it right.

As shown by your series, lots of drivers call v4l2_async_nf_cleanup()
and .remove() time instead of .release(). That's because most drivers
get lifetime management wrong and don't even implement .release().
That's something Sakari is addressing with ongoing work. This patch
series seems to go in the opposite direction.

> ---
> Julien Massot (2):
>       media: v4l: async: Add v4l2_async_nf_unregister_cleanup
>       media: convert all drivers to use v4l2_async_nf_unregister_cleanup
> 
>  drivers/media/i2c/ds90ub913.c                           | 10 ++--------
>  drivers/media/i2c/ds90ub953.c                           | 10 ++--------
>  drivers/media/i2c/ds90ub960.c                           | 10 ++--------
>  drivers/media/i2c/max9286.c                             |  3 +--
>  drivers/media/i2c/st-mipid02.c                          |  6 ++----
>  drivers/media/i2c/tc358746.c                            |  3 +--
>  drivers/media/pci/intel/ipu3/ipu3-cio2.c                |  6 ++----
>  drivers/media/pci/intel/ipu6/ipu6-isys.c                |  8 +-------
>  drivers/media/pci/intel/ivsc/mei_csi.c                  |  6 ++----
>  drivers/media/platform/atmel/atmel-isi.c                |  3 +--
>  drivers/media/platform/cadence/cdns-csi2rx.c            |  6 ++----
>  drivers/media/platform/intel/pxa_camera.c               |  3 +--
>  drivers/media/platform/marvell/mcam-core.c              |  6 ++----
>  drivers/media/platform/microchip/microchip-csi2dc.c     |  3 +--
>  drivers/media/platform/microchip/microchip-isc-base.c   |  6 ++----
>  drivers/media/platform/nxp/imx-mipi-csis.c              |  6 ++----
>  drivers/media/platform/nxp/imx7-media-csi.c             |  3 +--
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c     |  3 +--
>  drivers/media/platform/nxp/imx8mq-mipi-csi2.c           |  6 ++----
>  drivers/media/platform/qcom/camss/camss.c               |  3 +--
>  drivers/media/platform/renesas/rcar-csi2.c              |  6 ++----
>  drivers/media/platform/renesas/rcar-isp.c               |  6 ++----
>  drivers/media/platform/renesas/rcar-vin/rcar-core.c     |  9 +++------
>  drivers/media/platform/renesas/rcar_drif.c              |  3 +--
>  drivers/media/platform/renesas/renesas-ceu.c            |  4 +---
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-core.c   |  3 +--
>  drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c   |  6 ++----
>  drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c     |  3 +--
>  drivers/media/platform/samsung/exynos4-is/media-dev.c   |  3 +--
>  drivers/media/platform/st/stm32/stm32-dcmi.c            |  3 +--
>  .../media/platform/st/stm32/stm32-dcmipp/dcmipp-core.c  |  3 +--
>  drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c      |  3 +--
>  .../media/platform/sunxi/sun6i-csi/sun6i_csi_bridge.c   |  3 +--
>  .../platform/sunxi/sun6i-mipi-csi2/sun6i_mipi_csi2.c    |  3 +--
>  .../sunxi/sun8i-a83t-mipi-csi2/sun8i_a83t_mipi_csi2.c   |  3 +--
>  drivers/media/platform/ti/am437x/am437x-vpfe.c          |  3 +--
>  drivers/media/platform/ti/cal/cal.c                     |  8 +-------
>  drivers/media/platform/ti/davinci/vpif_capture.c        |  3 +--
>  drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 10 ++--------
>  drivers/media/platform/ti/omap3isp/isp.c                |  3 +--
>  drivers/media/platform/video-mux.c                      |  3 +--
>  drivers/media/platform/xilinx/xilinx-vipp.c             |  3 +--
>  drivers/staging/media/deprecated/atmel/atmel-isc-base.c |  6 ++----
>  drivers/staging/media/sunxi/sun6i-isp/sun6i_isp_proc.c  |  3 +--
>  drivers/staging/media/tegra-video/vi.c                  |  3 +--
>  include/media/v4l2-async.h                              | 17 +++++++++++++++++
>  46 files changed, 80 insertions(+), 153 deletions(-)
> ---
> base-commit: 843a9f4a7a85988f2f3af98adf21797c2fd05ab1
> change-id: 20240502-master-5deee133b4f5

-- 
Regards,

Laurent Pinchart

