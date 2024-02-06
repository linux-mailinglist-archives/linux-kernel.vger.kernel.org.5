Return-Path: <linux-kernel+bounces-54700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE984B297
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAACC1F253EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB29612B144;
	Tue,  6 Feb 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="CGQ00tLW"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CAB58233;
	Tue,  6 Feb 2024 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215847; cv=none; b=Vg54tKt+9QrRtC56cyzPyi/0d/GKyjW658eypfW7Ow1HSPeNa4dXYLuPmOb8NN06PEj9uFReMNGoWkLp3WSVr/GPPT05u1qqtXB7wDmbKbbQeS4uTDsqXhee8PYErVENpM1cjPp8R83EpT/mm+C3iBV27jbBAMNehSJfctIuQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215847; c=relaxed/simple;
	bh=w/tN9d7EIu2jSrI12Wh7+oQ5SQST786HYLnVHwynRHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPfnItZZJ7kN1asgAfifq/fYyCGh7lIfHDOrJKLNAPIbGMZE8Sc/sKwil7zvHEZveB5mNaTveSGJ2C4O5Xx6CVJk7haIQwL1MzsoUiudrcMBXuFBlhJP2A/ju/NYDXZBypRhHY+n2d0c+5ttDTbHT0tru1kVE5s5zyJMXagDbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=CGQ00tLW; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=lk+MQ8SH92shgsFG/IxiegRWkPy95NRGePUeiAe3pG4=;
	b=CGQ00tLWEIl2sZMfEeT+KNILvnXGZNjR/rhPP7zZeUTbkP/snD3AUz9z7/sGmA
	bC5rnE5/pF5KAoUdSRj7z0pDGCZ6JAnMpXSGqtWxD5bNdHM0x364H0p7S6qRaDMj
	3pDVfZzmfPar4pwy5kBxhDZwd29G7kdWmHf3bGSQkE7SU=
Received: from dragon (unknown [183.213.196.254])
	by smtp1 (Coremail) with SMTP id ClUQrAB3PCFmC8JlRXf+Ag--.22835S3;
	Tue, 06 Feb 2024 18:35:19 +0800 (CST)
Date: Tue, 6 Feb 2024 18:35:17 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Yannic Moog <y.moog@phytec.de>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Primoz Fiser <primoz.fiser@norik.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	upstream@lists.phytec.de
Subject: Re: [PATCH RFC for upstream 3/4] arm64: dts:
 imx8mp-phyboard-pollux-rdk: add etml panel support
Message-ID: <ZcILZSg7ERGza+1p@dragon>
References: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
 <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-3-8ec5b48eec05@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-3-8ec5b48eec05@phytec.de>
X-CM-TRANSID:ClUQrAB3PCFmC8JlRXf+Ag--.22835S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUxCztUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwd8ZVnxccILPgAAs-

On Fri, Jan 26, 2024 at 09:57:25AM +0100, Yannic Moog wrote:
> The imx8mp-phyboard-pollux has on-board lvds interface connections. An
> edt,etml1010g3dra panel is supported for this interface. Add device tree
> nodes for backlight and panel.
> 
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Applied, thanks!


