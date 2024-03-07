Return-Path: <linux-kernel+bounces-96324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A1F875A43
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 23:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 216CB1F22993
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F19113F44E;
	Thu,  7 Mar 2024 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSNxfRjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DFB130AD0;
	Thu,  7 Mar 2024 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709850475; cv=none; b=knvre2Bo6j+f7plpTTVeDG8hNlYnb9ee+XwOuiBAGNb9enfQKvw+6Cr84qDw7v185BaS8vdAUnn3BclDjG8q5LwXdVWFYt+FT+sIVcp4TpRHr6H5irqhQ258MsllWbRjHInWOT68JN2Y0BC/DUGu2Hw8KvJF8wcz+vtvE1Sh6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709850475; c=relaxed/simple;
	bh=TCHmyo/bk6a8X8eBuNw2MkbEMUjei5hv7GdhoF+s4Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1x+B6SJUBWIrcEJyJ74U2ew6v+GL7g+mE6mMPOZdjRfN7cnd6Sn7Mc+Z2neFBpzMCrEqEL4KJ68hbRhpL6hFDzaAoyMmnkM+rGTtPuu7Pzjsjw7+es6ZuwAf5o4X4a4YISHnpeQ5wmwlvrLUeRY1VLq4e5sFjrppBtLriSiiN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSNxfRjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08D0C433C7;
	Thu,  7 Mar 2024 22:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709850475;
	bh=TCHmyo/bk6a8X8eBuNw2MkbEMUjei5hv7GdhoF+s4Ak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eSNxfRjk8zBKEAvcfJaE0wFM/gYfJ7t0t63TLcheiCC6X8Nn2qCU59Y8A/gpKbJs4
	 oWuBNb+HW12wRvjIg14QG9ZpgQU44iZemrTR6x3rsAWZSM5sQzQG4srV9gXHaLFm7q
	 jo5vANtwdZMiyXVSk6+FWQnGyLF+x6ti3hadlzuQMjIgqAkMTyGbPY7ucY/kpF0gzo
	 sq2bqAKY2QpMXR9Ew7ASlVmTwpN5R4Iipu0CkhsAHgzNwjazd5PZQ2/SzgOrFgSNy7
	 2kVJXOjpCqtcneSXXPv57Kl46Apm7q4YqkScdIJHaT72fIY0ayrPwvDCKa1L7evfpQ
	 QD3OM65lQdynw==
Date: Thu, 7 Mar 2024 16:27:51 -0600
From: Rob Herring <robh@kernel.org>
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>, willl will <will@willwhang.com>,
	linux-media@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	NXP Linux Team <linux-imx@nxp.com>, linux-kernel@vger.kernel.org,
	Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Fabio Estevam <festevam@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	devicetree@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: Add bindings for IMX283
Message-ID: <170985047110.3271777.11909782717247378150.robh@kernel.org>
References: <20240307214048.858318-1-umang.jain@ideasonboard.com>
 <20240307214048.858318-2-umang.jain@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307214048.858318-2-umang.jain@ideasonboard.com>


On Fri, 08 Mar 2024 03:10:42 +0530, Umang Jain wrote:
> - Add dt-bindings documentation for Sony IMX283 sensor driver
> - Add MAINTAINERS entry for Sony IMX283 binding documentation
> 
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  .../bindings/media/i2c/sony,imx283.yaml       | 107 ++++++++++++++++++
>  MAINTAINERS                                   |   8 ++
>  2 files changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/sony,imx283.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


