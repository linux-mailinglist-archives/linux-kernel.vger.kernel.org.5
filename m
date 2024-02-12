Return-Path: <linux-kernel+bounces-62522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 588DC852252
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CE781F229C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165BF4F605;
	Mon, 12 Feb 2024 23:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K82rgZj6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B804EB49;
	Mon, 12 Feb 2024 23:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779460; cv=none; b=lOFUwCQ2nnxBjnnHazKSUdYh6AbST4/aQtZ0kQ8XrkR4YsH351lEsi8zrv6Sp6XvVeyBWT+l4xn1ops0Lg0qEm32g96N0+G9GTdJa2x0SHTe55OVfnZNotYtu+KszTrgwV8nMnmEFIUulhEdVG82FK/ZcJYsGjVvkxYFnlbJhCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779460; c=relaxed/simple;
	bh=pDDsqmdQFRiFzmJFubeCQnwDZA8NVX7LbcVD1ftUghQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+cmhUieUDZHX0r9EB/kTj74qZ701BgFKOWU6a5VjED6aytEvQzGTtp0lfAgMQjUdCjjphwa8IIFh7l12hcoatnaOvRbuTGKXsAVA+H5PWNJaBBopCLlmCK5OSUiW0WqvmR/RMOcEDxPXxA9RpDJUyGLSP3rCbpnPgP2rv7qXyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K82rgZj6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 983BBC433F1;
	Mon, 12 Feb 2024 23:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707779459;
	bh=pDDsqmdQFRiFzmJFubeCQnwDZA8NVX7LbcVD1ftUghQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K82rgZj6YmUtE3BC0zZBZsiXjcvfUmjeXkHAFvDN/Q/JiCsKfWtg8qB0BfnU2Q4bx
	 fc7yCTPogLXyoaGtDmcF/9YzaqxCj4sef6pp4ZoqOUyrtA/dTX1mig5amErUARtvoV
	 757gsAoi0pOGnj9jdutfM6goglMeJjXA2c7SxqrP9WlhOo3STLuYzpU6s1Ob6rn/Yv
	 PfrTPTzZaM2qw5+nR+W9cRu1gHLTjmNTYudaHD9xiPmMm92kFsy8gw1EDk+ghzrbVX
	 x3zuUlG8+uPQ3rudmLzS9242cDEBmapXI8uO8pCNauQv1RUb2jbVquj4sCEdT0oojA
	 l10H6TFt8YzrA==
Received: by mercury (Postfix, from userid 1000)
	id ECE1F106A041; Tue, 13 Feb 2024 00:10:55 +0100 (CET)
Date: Tue, 13 Feb 2024 00:10:55 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	NXP Linux Team <linux-imx@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/14] dt-bindings: lcdif: Do not require
 power-domains for i.MX6ULL
Message-ID: <khwsxrpj5fgxl7ukiur2tdyy7a6d6h6zryc5z2h7o6f7k3b32p@cjqsmdbocfpe>
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-8-sre@kernel.org>
 <a8b55331-a8c3-457e-83e0-2aa361ed23c6@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b55331-a8c3-457e-83e0-2aa361ed23c6@gmx.net>

Hi Stefan,

On Mon, Feb 12, 2024 at 08:20:35PM +0100, Stefan Wahren wrote:
> Am 10.02.24 um 02:18 schrieb Sebastian Reichel:
> > i.MX6UL(L) uses "fsl,imx6sx-lcdif" as fallback compatible string,
> > but has only very lightweight DISPLAY power domain. Its DISPLAY
> > power domain is not supported by the binding / Linux kernel at
> > the moment. Since the current setup is working, let's remove the
> > power-domain from being required for that platform to fix the warning
> > printed by CHECK_DTBS=y.
> i'm not sure this is a good idea. In case i.MX6UL(L) is different from
> i.MX6SX here, then it should have a different compatible.

It already has. The i.MX6UL(L) compatible looks like this:

compatible = "fsl,imx6ul-lcdif", "fsl,imx6sx-lcdif"

So the i.MX6SX one is just a fallback compatible. But the current
requirement for power-domains affects i.MX6UL(L), since it says
the compatible only needs to contain "fsl,imx6sx-lcdif" somewhere
to make power-domains mandatory.

Note, that the kernel driver does not use "fsl,imx6ul-lcdif", so
the hardware itself is indeed compatible.

-- Sebastian

