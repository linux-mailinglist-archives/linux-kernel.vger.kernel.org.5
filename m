Return-Path: <linux-kernel+bounces-53894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D02584A7C7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57661C27A35
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2698A12E1E9;
	Mon,  5 Feb 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tbqV+/Kl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649AA12BEB9;
	Mon,  5 Feb 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707163683; cv=none; b=JK3U/2OEhWdTrBZ+7gr/46OvHa01O8kDyoSVq8E8sSuMD71zvY3CmSSa23d4+sZVCsofbP+35RNzal8mJWjIyjpj1Pyaz5yzIo50K/erfcZk61E8MExEXqcrXIsTbfHLfUW/fINTMNFNYJ92O1HOgVtIDV0YK4gcGbAd2ina3kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707163683; c=relaxed/simple;
	bh=9mUc5HMv0Wr+BUNL3NVu1aqGUHuyRbH/hXmU4xDAaY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6nST+jOMC6Gu9u1A/wEJwt35QP2AOlF8FSnKDO7MEcsrAG1vSUsO0Sgo5YLLkZXzAgxFlLFy+iA4WUVxfxu0QcxakKsFyzWu90km1hSoLImgBMtHmB2BgEDK2Ep+uU5o5nKW5qAJkN0zdXqqgkYnTgpBEUfL8OJRhYJWRCUhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tbqV+/Kl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCA8C433C7;
	Mon,  5 Feb 2024 20:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707163683;
	bh=9mUc5HMv0Wr+BUNL3NVu1aqGUHuyRbH/hXmU4xDAaY0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbqV+/KlI4McHkYW0C3W6AzcRZZQz1NatHHo2z0pW893ORUa4W8hegvsUpeA8IBGv
	 h93y2xQ8DkNuXY9yOenipDw1BE/kRIbSqKSHNf5EZgW5j2yI+U3dYDCV48Pgs96VAM
	 aoCMSIjgEBfJH81rKjANFrUYroQZrg0WbxLAv9AAWOzJ76Bju076Jp2cOGG1hSHh/e
	 3Bh8GrbqNeISPJ/N6W0EPEGIy6vaD6UoKMT86gpWVsy+/GNnvm04762Lo6diheIlI6
	 ESQhJjx7Rm4JG7Zrv9fJrFk+POdoQ8Zh8bPcMdWIwk4iIUNQApVHqRpAsD3fSuYsXQ
	 30HNIDwBEDp7w==
Date: Mon, 5 Feb 2024 20:08:00 +0000
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: claudiu.beznea@tuxon.dev, arnd@arndb.de, manikandan.m@microchip.com,
	rfoss@kernel.org, conor+dt@kernel.org, rdunlap@infradead.org,
	hari.prasathge@microchip.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
	geert+renesas@glider.be, devicetree@vger.kernel.org,
	rientjes@google.com, jonas@kwiboo.se,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	Laurent.pinchart@ideasonboard.com, alexandre.belloni@bootlin.com,
	vbabka@suse.cz, daniel@ffwll.ch, airlied@gmail.com,
	nicolas.ferre@microchip.com, dri-devel@lists.freedesktop.org,
	Jason@zx2c4.com, neil.armstrong@linaro.org,
	linux-kernel@vger.kernel.org, tzimmermann@suse.de,
	andrzej.hajda@intel.com, jernej.skrabec@gmail.com
Subject: Re: [linux][PATCH v2 1/4] dt-bindings: display: bridge: add
 sam9x75-lvds compatible
Message-ID: <170716367908.292710.5272192902501814540.robh@kernel.org>
References: <20240205110609.217022-1-dharma.b@microchip.com>
 <20240205110609.217022-2-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205110609.217022-2-dharma.b@microchip.com>


On Mon, 05 Feb 2024 16:36:06 +0530, Dharma Balasubiramani wrote:
> Add the 'sam9x75-lvds' compatible binding, which describes the Low Voltage
> Differential Signaling (LVDS) Controller found on some Microchip's sam9x7
> series System-on-Chip (SoC) devices. This binding will be used to define
> the properties and configuration for the LVDS Controller in DT.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> ---
> Changelog
> v1 -> v2
> - Remove '|' in description, as there is no formatting to preserve.
> - Remove 'gclk' from clock-names as there is only one clock(pclk).
> - Remove the unused headers and include only used ones.
> - Change the compatible name specific to SoC (sam9x75) instead of entire series.
> - Change file name to match the compatible name.
> ---
>  .../bridge/microchip,sam9x75-lvds.yaml        | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/microchip,sam9x75-lvds.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


