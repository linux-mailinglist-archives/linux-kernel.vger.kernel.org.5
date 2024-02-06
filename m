Return-Path: <linux-kernel+bounces-55155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C6A84B8BD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C891AB2F7EC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEB9133285;
	Tue,  6 Feb 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ct0eOsHG"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCD5A59
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231337; cv=none; b=d/syL++i2+0Yfdie09vgAe8A55/hoPfFo2tu04LkRuqPjm+zdkzFAQ9hBGmX4mbekTZCcUT47R41s+bTW7+Oq8qJrZcfIUH/mdsiu1dsJj5TicXn9yeIelpvmmcdwV1+kN5LKba8WGaUW/3UJh/pd0nahO5BVFABzwPWbeAQb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231337; c=relaxed/simple;
	bh=hWqaNHhbONtfYESP/Hc46X8ElAU7zgcs3+Vp4Q0jF8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vg/jTKyFmlq2oqHEDrVRkWiHunfe1c2TmdTg8uvZqHPCuPAVB3NvPFm3/e+vUpVws8CUWfcthlz6zlDzLsZnTuNgD17HDh7qyoVznVPYUI3pxf5rQxT1Mw7Hb++ycAijvyyQYp8Y3f7F39CnZizUEORsaPEy61zt0C/3j2o/x/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ct0eOsHG; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-604819d544cso4654987b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707231334; x=1707836134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SWfppdoG5bpokcGbIWQoQ+cvHlccFq4ffx5trjHwiI=;
        b=Ct0eOsHGlh4uPoKbxzR+Ze4Ksh/njy4Q59juST3hudIPFI4D0v2chj3jmYhjroI9Jh
         9/RUdPr4TKRBzcPGG620bb9Grjfb5go1A8bSYjMSeLOcD8WtX8960CDTyj9F05vsO7L6
         I8JP2WC8kEYxPpc/V+yPfS952+6vjFckTjpckYv5o9Ooc1w1S/iDq43rJgoQPBDSPSTf
         GCz7OBuVLgGO7Bi66D5Wfbvfi7bCfp6vJTjgBXeb3pwnCSJWY1lSIHPDX6EdEwPr71aj
         MTjeuhcM+vTnGn/HZweakI1QVnctAiz4G3x4I7MoOo2n/pwYATAGLf1+P/tTnDUYfPyG
         eCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707231334; x=1707836134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SWfppdoG5bpokcGbIWQoQ+cvHlccFq4ffx5trjHwiI=;
        b=g3kJ0lrSkf470kP6UWhpdBSX8wVbwgrMINmVy3pGNFeDq3hUj300gubpm+2RUZW27P
         qXKHHa5dHqiVCCb2JO7AX8fWobw6wiBIxvzZsiMQ9YuiesXXRpY1T454US7e/v+Y6FqL
         lAzpp4MPIiBCzuBfT+8HMWFVpWjCvrUIckbFVtpvDHv/1Vv8KD9wzCfwqPK/Jlr4kUJj
         1+4vWNC5J8l8b94tGwkYj80w0DPU+3HE/I72ea3//QiMuQiCpddM6VGfDKE5dHY6OZ3z
         yBIgCye4fW4Hjg+lnM+qJEJeVykyWqN4mgDomFvAjNkq60qVgxRI19Sk6Z3b9sMeeOA0
         JmUA==
X-Gm-Message-State: AOJu0YxNnIYeFdkT48hvCj6Wbz9bWjMi1jAkeJZOmD5k/f34iXdKVbm2
	dLf8iSRVMANKfmf/+LKnNnvv6UBi4RI5sKWG0+ik4+E3LVuKQAJIXwFSEkaHsKstw38H4OWwbEZ
	TG9h3l/yUUTKUBuN2eJk2Iz9KpIq+6rZ4QecR9Q==
X-Google-Smtp-Source: AGHT+IEt5+GlyLWn7cfMD/ub2E/OPVwaCtLuF3gNNCnrz9pftZjKz6I+EFztBnowzrCHYBptts089/ymh0TVaP8oi0k=
X-Received: by 2002:a81:be0c:0:b0:5e9:5538:d930 with SMTP id
 i12-20020a81be0c000000b005e95538d930mr1716017ywn.47.1707231334348; Tue, 06
 Feb 2024 06:55:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203165307.7806-1-aford173@gmail.com>
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 6 Feb 2024 15:54:58 +0100
Message-ID: <CAPDyKFpe-+ttcciPsQiSYUh4ptZ+5RGc3S=K3xVwpaTuCA_FeA@mail.gmail.com>
Subject: Re: [PATCH V8 00/12] soc: imx8mp: Add support for HDMI
To: Adam Ford <aford173@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Sat, 3 Feb 2024 at 17:53, Adam Ford <aford173@gmail.com> wrote:
>
> The i.MX8M Plus has an HDMI controller, but it depends on two
> other systems, the Parallel Video Interface (PVI) and the
> HDMI PHY from Samsung. The LCDIF controller generates the display
> and routes it to the PVI which converts passes the parallel video
> to the HDMI bridge.  The HDMI system has a corresponding power
> domain controller whose driver was partially written, but the
> device tree for it was never applied, so some changes to the
> power domain should be harmless because they've not really been
> used yet.
>
> This series is adapted from multiple series from Lucas Stach with
> edits and suggestions from feedback from various series, but it
> since it's difficult to use and test them independently,
> I merged them into on unified series.  The version history is a
> bit ambiguous since different components were submitted at different
> times and had different amount of retries.  In an effort to merge them
> I used the highest version attempt.
>
> Adam Ford (3):
>   dt-bindings: soc: imx: add missing clock and power-domains to
>     imx8mp-hdmi-blk-ctrl
>   pmdomain: imx8mp-blk-ctrl: imx8mp_blk: Add fdcc clock to hdmimix
>     domain
>   arm64: defconfig: Enable DRM_IMX8MP_DW_HDMI_BRIDGE as module
>
> Lucas Stach (9):
>   dt-bindings: phy: add binding for the i.MX8MP HDMI PHY
>   phy: freescale: add Samsung HDMI PHY
>   arm64: dts: imx8mp: add HDMI power-domains
>   arm64: dts: imx8mp: add HDMI irqsteer
>   dt-bindings: display: imx: add binding for i.MX8MP HDMI PVI
>   drm/bridge: imx: add driver for HDMI TX Parallel Video Interface
>   dt-bindings: display: imx: add binding for i.MX8MP HDMI TX
>   drm/bridge: imx: add bridge wrapper driver for i.MX8MP DWC HDMI
>   arm64: dts: imx8mp: add HDMI display pipeline
>
>  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    |  102 ++
>  .../display/imx/fsl,imx8mp-hdmi-pvi.yaml      |   84 ++
>  .../bindings/phy/fsl,imx8mp-hdmi-phy.yaml     |   62 +
>  .../soc/imx/fsl,imx8mp-hdmi-blk-ctrl.yaml     |   22 +-
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi     |  145 +++
>  arch/arm64/configs/defconfig                  |    1 +
>  drivers/gpu/drm/bridge/imx/Kconfig            |   18 +
>  drivers/gpu/drm/bridge/imx/Makefile           |    2 +
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c  |  207 ++++
>  drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c   |  154 +++
>  drivers/phy/freescale/Kconfig                 |    6 +
>  drivers/phy/freescale/Makefile                |    1 +
>  drivers/phy/freescale/phy-fsl-samsung-hdmi.c  | 1075 +++++++++++++++++
>  drivers/pmdomain/imx/imx8mp-blk-ctrl.c        |   10 +-
>  14 files changed, 1876 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/fsl,imx8mp-hdmi-tx.yaml
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pvi.yaml
>  create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8mp-hdmi-phy.yaml
>  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-pvi.c
>  create mode 100644 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
>  create mode 100644 drivers/phy/freescale/phy-fsl-samsung-hdmi.c
>

Patch 3 and patch 4, applied for next to my pmdomain tree. Patch 3 (DT
doc) is also available at the immutable "dt" branch, allowing it to be
pulled into the soc maintainer's tree too.

Kind regards
Uffe

