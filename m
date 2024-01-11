Return-Path: <linux-kernel+bounces-23185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B637482A8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BEF281CD6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B697DDC3;
	Thu, 11 Jan 2024 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MkyY8POS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83560D512;
	Thu, 11 Jan 2024 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C211AC85;
	Thu, 11 Jan 2024 09:07:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1704960445;
	bh=qmei24w/G2Gd38IxUj6H/ANIvTM67mnsZB7V0/RAtLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkyY8POSVX7UaEBiHxkzQk/CvAeTddOKPInEUe2lqAC8sd8iiVp8EOWmbT4xVvwCs
	 SUYCwgl6oQwd37DkkC+LE+zrlPX+IqygjAq3WeNY+PM+neqWudwbyBDpAf/NXP2FIW
	 EJykbF8O+CempNUHb0/63gw0Bb3QMjQqUNhQst/s=
Date: Thu, 11 Jan 2024 10:08:37 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Andy Hsieh <andy.hsieh@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Florian Sylvestre <fsylvestre@baylibre.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
	Louis Kuo <louis.kuo@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Paul Elder <paul.elder@ideasonboard.com>,
	Phi-bang Nguyen <pnguyen@baylibre.com>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 0/5] Add Mediatek ISP3.0
Message-ID: <20240111080837.GA30988@pendragon.ideasonboard.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240110141443.364655-1-jstephan@baylibre.com>

Hi Julien,

Thank you for the patches.

On Wed, Jan 10, 2024 at 03:14:37PM +0100, Julien Stephan wrote:
> This series adds the support of the Mediatek ISP3.0 found on some
> Mediatek SoCs such as the mt8365. The driver is divided into 2 parts:
> 
> * SENINF: the sensor interface
> * CAMSV: this driver provides a path to bypass the SoC ISP so that image
>   data coming from the SENINF can go directly into memory without any
>   image processing. This allows the use of an external ISP or camera
>   sensor directly.

I'm afraid this doesn't compile based on the latest media tree's master
branch, scheduled for v6.8-rc1. I've pushed the following fixes to [1]:

0d2e75fb8909 media: mediatek: isp_30: Update to new subdev state API
05dc498f151a media: mediatek: isp_30: Update to new subdev state API

You can squash those in v5 when you will rebase on v6.8-rc1.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pinchartl/linux.git/log/?h=mtk/v6.8/pumpkin/camera

> The SENINF driver is based on previous work done by Louis Kuo available
> as an RFC here: https://lore.kernel.org/all/20200708104023.3225-1-louis.kuo@mediatek.com/
> 
> This series depends on the following series for the phy [1]
> 
> Changes in v4:
> - fix suspend/resume deadlock
> - fix various locking issues reported by Laurent Pinchart on v3
> - run LOCKDEP
> - add missing include reported by kernel-test-robot for non mediatek arch and COMPILE_TEST=y
> - use atomic poll inside mtk_camsv30_setup
> - drop second lane support as it was not used 
> - remove useless members in structs
> - fix media entity initialization
> - initialize correct pad for camsv video device
> - add isp support in mt8365.dtsi
> - rebase on 6.7
> 
> Changes in v3:
> - fix a lot of formatting issues/coding style issues found in camsv/seninf reported by Angelo on v2
> - fix camsv/seninf binding file error reported by Rob
> 
> Changes in v2:
> - renamed clock `cam_seninf` to `camsys`
> - renamed clock `top_mux_seninf` to `top_mux`
> - moved phy properties from port nodes to top level
> - remove patternProperties
> - specify power management dependency in the cover letter description to fix
>   missing include in dt-binding example
> - change '$ref' properties on some endpoint nodes from
>   '$ref: video-interfaces.yaml#' to '$ref: /schemas/graph.yaml#/$defs/endpoint-base'
>  where applicable
> 
> Best
> Julien Stephan
> 
> [1] : https://lore.kernel.org/all/20230620121928.1231745-1-jstephan@baylibre.com/
> 
> 
> 
> Louis Kuo (2):
>   dt-bindings: media: add mediatek ISP3.0 sensor interface
>   media: platform: mediatek: isp_30: add mediatek ISP3.0 sensor
>     interface
> 
> Phi-bang Nguyen (2):
>   dt-bindings: media: add mediatek ISP3.0 camsv
>   media: platform: mediatek: isp_30: add mediatek ISP3.0 camsv
> 
>  .../bindings/media/mediatek,mt8365-camsv.yaml |  109 ++
>  .../media/mediatek,mt8365-seninf.yaml         |  259 +++
>  MAINTAINERS                                   |   10 +
>  arch/arm64/boot/dts/mediatek/mt8365.dtsi      |  128 ++
>  drivers/media/platform/mediatek/Kconfig       |    1 +
>  drivers/media/platform/mediatek/Makefile      |    1 +
>  drivers/media/platform/mediatek/isp/Kconfig   |    2 +
>  drivers/media/platform/mediatek/isp/Makefile  |    3 +
>  .../platform/mediatek/isp/isp_30/Kconfig      |   35 +
>  .../platform/mediatek/isp/isp_30/Makefile     |    4 +
>  .../mediatek/isp/isp_30/camsv/Makefile        |    7 +
>  .../mediatek/isp/isp_30/camsv/mtk_camsv.c     |  328 ++++
>  .../mediatek/isp/isp_30/camsv/mtk_camsv.h     |  199 +++
>  .../isp/isp_30/camsv/mtk_camsv30_hw.c         |  427 +++++
>  .../isp/isp_30/camsv/mtk_camsv30_regs.h       |   60 +
>  .../isp/isp_30/camsv/mtk_camsv_video.c        |  774 +++++++++
>  .../mediatek/isp/isp_30/seninf/Makefile       |    5 +
>  .../mediatek/isp/isp_30/seninf/mtk_seninf.c   | 1488 +++++++++++++++++
>  .../isp/isp_30/seninf/mtk_seninf_reg.h        |  112 ++
>  19 files changed, 3952 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-camsv.yaml
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8365-seninf.yaml
>  create mode 100644 drivers/media/platform/mediatek/isp/Kconfig
>  create mode 100644 drivers/media/platform/mediatek/isp/Makefile
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Kconfig
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/Makefile
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/Makefile
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.c
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv.h
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_hw.c
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv30_regs.h
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/camsv/mtk_camsv_video.c
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/Makefile
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf.c
>  create mode 100644 drivers/media/platform/mediatek/isp/isp_30/seninf/mtk_seninf_reg.h

-- 
Regards,

Laurent Pinchart

