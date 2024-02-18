Return-Path: <linux-kernel+bounces-70614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A598599D6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F07F01C20C23
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8F86EB6F;
	Sun, 18 Feb 2024 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aRpnIvVp"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479021DFD6;
	Sun, 18 Feb 2024 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708297055; cv=none; b=qklwzGlyyyMAm0H13L2Dp2ODL9o2pFPVAoqQDvlcG2pQNUWVEtHxq8zo0fGKdFqKcDSsExp6UWxknIOAhdXElCkIwB5TF080yZdMXOFfzomw6odmVKgwiHD+0iXyajV22VV5mGEGfzKXWvzxusHMwRk0nfqsDzzcif8p7dWv/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708297055; c=relaxed/simple;
	bh=5I5rcGzvvfKkYVxYcEj6Zhf7emlThUYxDOK9gE8vMP4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lPQ0AdPRUiLOl3wBhF6LZOhox3rdoV86M9H3PU3Frq6k+ZXmIU5s1WC7Pc2XPQLkSt0E+vxg5v7TLbSXidnwdPd+qKmNJQkldlOz3ZzYKm3m8/1aQHomouL1l6Rh+EhglUsVbwNgwR2GBWMSeQBK5kI7rPvO1CB2hOuhQbK2OPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aRpnIvVp; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4725EC0003;
	Sun, 18 Feb 2024 22:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708297044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+pq9/TozG0Ax/9t8pkN6j57YfUyG6l7IZWL75JNMOW8=;
	b=aRpnIvVpZuOrja+9vi61c+YPFQpEeNKl08VTLi1/D9Yp67pX0qu+9cLwGoH2StmVH7M7dw
	PY3u/RGrT9J+SIRvSvlo7/SrMU+WjdrQE4GO4HCZdhobF40THyc2kvK5EvwavdKFXuHq4W
	I9TkNLztch13vUOicb52krzpUuFvlggx7LJ8JLXmmK7E+DagQFja2qG9abHUJE5eQ5oNJ9
	V+9WBz2U6tO6axVoVC/nBR/Nq2xHQCt+sNYYl/WK/VVZmAZcPhms4GaG0f5MD4aaASFF1e
	HX7Toqqv+lX88OtgP7ycJtIH4r9CdOkdDQ/wN6AIbx8yt9MXcu9R9cZUwAyPfw==
Date: Sun, 18 Feb 2024 23:57:19 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	=?utf-8?Q?Przemys=C5=82aw?= Gaj <pgaj@cadence.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH 1/3] dt-bindings: i3c: drop "master" node name
 suffix
Message-ID: <170829700336.822203.177392854952786485.b4-ty@bootlin.com>
References: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117075618.81932-1-krzysztof.kozlowski@linaro.org>
X-GND-Sasl: alexandre.belloni@bootlin.com

On Wed, 17 Jan 2024 08:56:16 +0100, Krzysztof Kozlowski wrote:
> Drop the requirement of "-master" suffix in node names because:
> 1. "Master" word is discouraged and MIPI Alliance renamed it to
>    "Controller".
> 2. Some devices can operate in Controller (Master) or Target mode, thus
>    the name is not accurate in such cases.
> 3. Other buses, like I2C controllers, use simple "i2c".
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: i3c: drop "master" node name suffix
      https://git.kernel.org/abelloni/c/c53611f2e27a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

