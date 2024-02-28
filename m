Return-Path: <linux-kernel+bounces-85374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F686B513
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F591F22631
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F3B34CDE;
	Wed, 28 Feb 2024 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JEq8YU5Z"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F531E4BF;
	Wed, 28 Feb 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137985; cv=none; b=X/W0HL9WemyaFL64OPuEFpLMWODBEHQSDW5zxBuiky28aLh/sDDn0NwM34I7y8mXpr2sz/GMoHGt3gpi4iVuMQHUKM/OXge2XcsTLX9QbAanTpaQZQGCklNUP2TjzCF4PPsZm0V4zrRMGNSRHk7QV/M05faI7BM1UkhiQ+8He5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137985; c=relaxed/simple;
	bh=WpEvuwbQqpreIe52/sd2Mcz0JuvJUxbOEsWvJ1YBNo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZqcLXDayGp5lTqkIevJwHjElf2xbZAdD5GiySnSXSd6r5a02NMiJ2KBA1C5LcG94/iyHIC8xOKaKiBEHJfE70Y1c4Q4z6VUG6rzSschVkh4AmBWBbPXpuR3tA+o43jnqcty5sGNR/GLFRdzhS2u3hx2vz9DQ1MxL2eP/vtR/14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JEq8YU5Z; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0E5196B3;
	Wed, 28 Feb 2024 17:32:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1709137970;
	bh=WpEvuwbQqpreIe52/sd2Mcz0JuvJUxbOEsWvJ1YBNo8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JEq8YU5ZK2sTFXcAhT5IyohlO9Wh3ZxTIe0h6vv3Y2ZOvuKOyjpE5VsZFfo7l61Gt
	 hhC7uVAA4PKglQqALuCgxG8cVTst1iNOljRBqMHbKxeRCY5r8VZS+hY8YI8i0UHyiB
	 wKblZF2HKE7RJLmyE7jA3Nr4oeTxHvyU7X2xo45U=
Date: Wed, 28 Feb 2024 18:33:04 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
	aford@beaconembedded.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: imx8mp-beacon-kit: Enable HDMI bridge HPD
Message-ID: <20240228163304.GI9863@pendragon.ideasonboard.com>
References: <20240228113737.43434-1-aford173@gmail.com>
 <20240228113737.43434-2-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240228113737.43434-2-aford173@gmail.com>

Hi Adam,

Thank you for the patch.

On Wed, Feb 28, 2024 at 05:37:36AM -0600, Adam Ford wrote:
> The DSI to HDMI bridge supports hot-plut-detect, but the
> driver didn't previously support a shared IRQ GPIO.  With
> the driver updated, the interrupt can be added to the bridge.

You can reflow the commit message to 72 columns.

> Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> diff --git a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> index 8de4dd268908..d854c94ec997 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> @@ -405,6 +405,8 @@ adv_bridge: hdmi@3d {
>  		compatible = "adi,adv7535";
>  		reg = <0x3d>, <0x3c>, <0x3e>, <0x3f>;
>  		reg-names = "main", "cec", "edid", "packet";
> +		interrupt-parent = <&gpio4>;
> +		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
>  		adi,dsi-lanes = <4>;
>  		#sound-dai-cells = <0>;
>  

-- 
Regards,

Laurent Pinchart

