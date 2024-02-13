Return-Path: <linux-kernel+bounces-64564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43701854052
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F398B282E67
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC5B6313C;
	Tue, 13 Feb 2024 23:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR0oY9dH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4E63124;
	Tue, 13 Feb 2024 23:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868088; cv=none; b=g2Zg9cASaPuKPMbIg8l3K0Z6kELiFDYnLTich7KfpQXckCZukWyqc5ZTUqZGOpUffv+Mj+UTdThJ61Ud97RpFqC/xHniqdoWK2zR2llC22ROobVTiwUC9+msT6hIDRpzqBK860ipbkNTkbt60jglXh4OWfxuEjVq8OKKNwZ6rzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868088; c=relaxed/simple;
	bh=iMqHLcS5+XHylKovVfwkIRUUAlQkcvIn3nwvIFAPJfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNTC7nKwASJVMKe4UtkvA+rWc0e54jPje/9k7xhoNduYxDvLHV1AT3Qr8IYmmZ1sWkkverOHgbtqjoQmK9RPGRApkC/MAGWWuPRv9JqK4cH4+e1UfuzPP6HiCyzfTklfn3cg+9IWVedgdm1m8R4CVzVK7ucg2nqeGSqIlbZjJyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR0oY9dH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB7EC433F1;
	Tue, 13 Feb 2024 23:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707868087;
	bh=iMqHLcS5+XHylKovVfwkIRUUAlQkcvIn3nwvIFAPJfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oR0oY9dHytVgT7lURvsy69EYN06W2tEr3VLnVAGwuXR8DoaXRr99PcLqOKPYpzcY3
	 u1hf80bcG4TjH6DwWY6coNcLyIxh+ilnqkkuF7+eJ/Zbs/tBLeWY11mYN4gwb1Ri5t
	 zZxl+wtriekUkZbgSMtfBikOBcPhv+T5wpcvvdm/QnEam1CqhTUKmsstNFeRkYGI/g
	 7x/XTjc9KedwWCT60vXsaL2oLFshbzdJZ+CVyLi7TpEkQgII14rsaXUWQmmJEel/vY
	 /b1Bs7TcSJCqfLOu5Ln9F0mgVJjiAX/ReDVR4bwyCy34Nx8AIBmolRmpeDGJq2JRGA
	 tcpGSeQ0hMjhw==
Received: by mercury (Postfix, from userid 1000)
	id 3E88B1061C38; Wed, 14 Feb 2024 00:48:05 +0100 (CET)
Date: Wed, 14 Feb 2024 00:48:05 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>, 
	Dong Aisheng <aisheng.dong@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/17] ARM: dts: nxp: imx6ul: xnur-gpio -> xnur-gpios
Message-ID: <wowv3yiz2xis3fafel4rkedorrh2n3iamfctyvtuwxrvdxroq2@dojgmuotvzml>
References: <20240213010347.1075251-1-sre@kernel.org>
 <20240213010347.1075251-13-sre@kernel.org>
 <CAOMZO5BUzaqHEvd877te_Tgiaz+QvWrvLC_oKg+mRPzmL26pDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5BUzaqHEvd877te_Tgiaz+QvWrvLC_oKg+mRPzmL26pDw@mail.gmail.com>

Hi,

On Tue, Feb 13, 2024 at 10:53:05AM -0300, Fabio Estevam wrote:
> On Mon, Feb 12, 2024 at 10:03 PM Sebastian Reichel <sre@kernel.org> wrote:
> > Replace all "xnur-gpio" with "xnur-gpios" in the
> > i.MX6UL(L) Touchscreen node.
> 
> Please explain the reason for doing this.

DT binding maintainers asked to use xnur-gpios instead of xnur-gpio
in the DT binding when converting to YAML (the -gpio suffix is
deprecated in favour of -gpios). This updates the DT files to become
compliant. The Linux kernel driver has already been using gpiod API
when it was added to the kernel, so this change is backwards compatible.

I will extend the description from this patch in v3.

-- Sebastian

