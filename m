Return-Path: <linux-kernel+bounces-108906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBEC58811BB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470841F24356
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C9F3FE3D;
	Wed, 20 Mar 2024 12:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUlEARJr"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358D92E821;
	Wed, 20 Mar 2024 12:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710938160; cv=none; b=JJxOOyfy8dk0KGdoWneFPjAON+QALaq92IUlqiBtjmLuxx7B1xMA+6+vz6A3e1l8RO/mt5bWzXrqt+y0IHr/VdDj/y6qvnFAMHX6Etolw9xHIcHCofBYiAlq0SzwvIIKuP2XJL6UFUKdeiCEVYU2hDmXGLrenG5LVYvD5i64uHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710938160; c=relaxed/simple;
	bh=xhP26pSgEUFLaf6nmg+YHggFajvAX/TZ2zrW7LxTpNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE3LQ3Qa2RqL2wCCLYrEVY86satzJTyAs/Br6U2ycqqE0pOAXTNLLlJstdIeMFGDJiT4ySKVo2aSJPhAyixguDKvZSZ+Ohc86H5PFxgMrvynLghv6TUR07dQGIwRWnjo8OFUUQFpAlrYI5/BLh9PFyqDzy9r4Qkys9dqqKDg5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUlEARJr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c66b093b86so692293a12.0;
        Wed, 20 Mar 2024 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710938158; x=1711542958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkgG1cL/5B4fNhZbtl14ktJjjgymucoxHqvalG67OVc=;
        b=IUlEARJrFwLyQ9shcdmhqPF8hRxhnXrTPOwSsVTzT5x/pJbRP+4dI8LxrdnhdIiDKr
         hnZM8L2QWTHSHjPQbWpCoA/xLNPiSiSlfjZKZQIfgE6qR56/Ba/fifwFGYsZ2Z5Ajl/L
         IlWveAXs5tsQeTN6ZqauhdTkRtD5GqC9sO02xCQTtinNhEQK0UJ9sLwT5qzYwj11YIIQ
         WFjSvQqPe5VirW8N4dJRo5GF/834Cro9PZJ19FqpmkMjLNIcAplTxgXbP5pWHPwAfi4F
         KpF/Pyd1Fm5IC6rYIMnTwDemf6eeoPrFQcc8lbgCR/ncsD8APzZ/mL4hnwMVBUXWB5ro
         Xn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710938158; x=1711542958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkgG1cL/5B4fNhZbtl14ktJjjgymucoxHqvalG67OVc=;
        b=aK9VURkyEp2z84LBbXcSHUgEdRGDIE4XjDU83o1eC/ZraVT2dHZh1kvwEJuuB7s01D
         cTqggH+0wFIYrxI6+lLK6xNZPMOPvBMkr2awAWEHr+o2RJB/68t9DE6O6M7qVnEub+Gv
         9ZXae9k3yCQUiV+HlbOhvBJYUG6leqecZWP007g0G9PAVXEA+M9F+QKMm9blNC3ABZtq
         CC4QsRGSARVVcbwXDXWIJumjOQZ3JMhMNesirMyF5XFmbLiXO+D0rdoplh8wt4nLPqrK
         kFMFlTMEHHLkAHdYzp+EbxcOpDuBdZUWBTqM3KN6+k/0gG9ni0dcj+vrvbWl5cNgFEWi
         NVbg==
X-Forwarded-Encrypted: i=1; AJvYcCVleVyvqJpvkR6Fq7WTeqSKLpk9C+4weHVPyM0eD4x/GtZgQe78zW/GNiNvNVFDOlNFO6uFUDjlGWD47n0YaDsxUBIS3JbXrgoT7GoSGQn2TIMyHZD1fAxtnAZ4SBXChxrK22oVuEA1kA==
X-Gm-Message-State: AOJu0YyUEXRjlGCjoaW03rB7w6Fj2iKiKDWNC3g2E+kld1TqNo1uInxB
	le0e718kZRtZC5bFBBPz60tN471HFo2zC0BmM7+RhnzrnFAiaEzdI5JwnYfHhfbk8acNn0+SGL0
	V/dorEozc0kAZQ1eicGW2K8+n5C4=
X-Google-Smtp-Source: AGHT+IHluuILnheUcmIRRFLg/VWXy6bNItVeObCj2+bK0X6rHBxK/wswlqQZqNhDlGb2BsxHpXvCykbTtvDgNnW+2Hg=
X-Received: by 2002:a17:90b:30d1:b0:29f:6971:b89 with SMTP id
 hi17-20020a17090b30d100b0029f69710b89mr7534391pjb.3.1710938158173; Wed, 20
 Mar 2024 05:35:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129093113.255161-1-paul.elder@ideasonboard.com> <20231129093113.255161-2-paul.elder@ideasonboard.com>
In-Reply-To: <20231129093113.255161-2-paul.elder@ideasonboard.com>
From: Adam Ford <aford173@gmail.com>
Date: Wed, 20 Mar 2024 07:35:46 -0500
Message-ID: <CAHCN7xLOu5qfxNihEYuSXxuxxH=S_+7nDkX1H=ziDW3QvaErQA@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Add DT nodes for the two ISPs
To: Paul Elder <paul.elder@ideasonboard.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	kieran.bingham@ideasonboard.com, tomi.valkeinen@ideasonboard.com, 
	umang.jain@ideasonboard.com, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	NXP Linux Team <linux-imx@nxp.com>, Marek Vasut <marex@denx.de>, 
	Alexander Stein <alexander.stein@ew.tq-group.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Frank Li <Frank.Li@nxp.com>, 
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 3:31=E2=80=AFAM Paul Elder <paul.elder@ideasonboard=
com> wrote:
>
> The ISP supports both CSI and parallel interfaces, where port 0
> corresponds to the former and port 1 corresponds to the latter. Since
> the i.MX8MP's ISPs are connected by the parallel interface to the CSI
> receiver, set them both to port 1.
>
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>

Paul, are you able to resend this now that the driver part has been
merged into the main branch?

If you can't, I can resend it on your behalf.

thanks,

adam

> ---
>  arch/arm64/boot/dts/freescale/imx8mp.dtsi | 50 +++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mp.dtsi
> index c9a610ba4836..25579d4c58f2 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
> @@ -1604,6 +1604,56 @@ isi_in_1: endpoint {
>                                 };
>                         };
>
> +                       isp_0: isp@32e10000 {
> +                               compatible =3D "fsl,imx8mp-isp";
> +                               reg =3D <0x32e10000 0x10000>;
> +                               interrupts =3D <GIC_SPI 74 IRQ_TYPE_LEVEL=
_HIGH>;
> +                               clocks =3D <&clk IMX8MP_CLK_MEDIA_ISP_ROO=
T>,
> +                                        <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>=
,
> +                                        <&clk IMX8MP_CLK_MEDIA_APB_ROOT>=
;
> +                               clock-names =3D "isp", "aclk", "hclk";
> +                               assigned-clocks =3D <&clk IMX8MP_CLK_MEDI=
A_ISP>;
> +                               assigned-clock-parents =3D <&clk IMX8MP_S=
YS_PLL2_500M>;
> +                               assigned-clock-rates =3D <500000000>;
> +                               power-domains =3D <&media_blk_ctrl IMX8MP=
_MEDIABLK_PD_ISP>;
> +                               fsl,blk-ctrl =3D <&media_blk_ctrl 0>;
> +                               status =3D "disabled";
> +
> +                               ports {
> +                                       #address-cells =3D <1>;
> +                                       #size-cells =3D <0>;
> +
> +                                       port@1 {
> +                                               reg =3D <1>;
> +                                       };
> +                               };
> +                       };
> +
> +                       isp_1: isp@32e20000 {
> +                               compatible =3D "fsl,imx8mp-isp";
> +                               reg =3D <0x32e20000 0x10000>;
> +                               interrupts =3D <GIC_SPI 75 IRQ_TYPE_LEVEL=
_HIGH>;
> +                               clocks =3D <&clk IMX8MP_CLK_MEDIA_ISP_ROO=
T>,
> +                                        <&clk IMX8MP_CLK_MEDIA_AXI_ROOT>=
,
> +                                        <&clk IMX8MP_CLK_MEDIA_APB_ROOT>=
;
> +                               clock-names =3D "isp", "aclk", "hclk";
> +                               assigned-clocks =3D <&clk IMX8MP_CLK_MEDI=
A_ISP>;
> +                               assigned-clock-parents =3D <&clk IMX8MP_S=
YS_PLL2_500M>;
> +                               assigned-clock-rates =3D <500000000>;
> +                               power-domains =3D <&media_blk_ctrl IMX8MP=
_MEDIABLK_PD_ISP>;
> +                               fsl,blk-ctrl =3D <&media_blk_ctrl 1>;
> +                               status =3D "disabled";
> +
> +                               ports {
> +                                       #address-cells =3D <1>;
> +                                       #size-cells =3D <0>;
> +
> +                                       port@1 {
> +                                               reg =3D <1>;
> +                                       };
> +                               };
> +                       };
> +
>                         dewarp: dwe@32e30000 {
>                                 compatible =3D "nxp,imx8mp-dw100";
>                                 reg =3D <0x32e30000 0x10000>;
> --
> 2.39.2
>

