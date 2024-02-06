Return-Path: <linux-kernel+bounces-54701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA0484B296
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8ACA1F2460C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1121292ED;
	Tue,  6 Feb 2024 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="VRZjkAx7"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CD358131;
	Tue,  6 Feb 2024 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215847; cv=none; b=WgnP/KxuVeJ65aLQZuV88+NHCuacEIXsBOqfAtuFLsSFijU5GYaRzunF6NT6mhkVbKp9LQudJqWpcNRlPZZTcv3yhBJ9YWtN2SXR4Pj7IWTow7wpphy/53fmXEagOP9UFkSI5wjImNcdPcL6S9QbLaWSAiU0qkJaMcIKQmV5MoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215847; c=relaxed/simple;
	bh=5qa0BU/BKeOLhsaxnEnmTsnKZiXvwC7zoBs4RRclYWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F+6ojA1AEgwITwuvTy6KRxvsnnwt9CKjyYW9LU39NJO1uqgLNhf2VzhdnhjyJPfVW3zs+UobSlqxsr0z76FZ8heMjzwOAuq+jqJ8R8UeTN4vh4JG1ompS7WYkVDPvQRPBu9TsgyFdJaK3M4RegA0SOqHQYNjMa++sqhWAyLf6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=VRZjkAx7; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=q24x/RFrKCeMLCH08rssYKYmdKI2I63/f28Ucs3/8Sk=;
	b=VRZjkAx7dRfh7UWzGVQzWOM3rp4cy9+xqhAHRvNQR89H715iKPznpbtzs7Zx4P
	mmEFpz6vO/OKXIxiOtzqGx4h+L1sj9FOX8bb057AOBdA3D0KORaXcA2Qhkhi5i8Z
	9CDzntl873fOCGHUrWR+YXtotFvPKFJyr9jliIKclYDt0=
Received: from dragon (unknown [183.213.196.254])
	by smtp1 (Coremail) with SMTP id ClUQrADn6+xzC8JlI3j+Ag--.15990S3;
	Tue, 06 Feb 2024 18:35:33 +0800 (CST)
Date: Tue, 6 Feb 2024 18:35:31 +0800
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
Subject: Re: [PATCH RFC for upstream 4/4] arm64: defconfig: enable i.MX8MP
 ldb bridge
Message-ID: <ZcILc05xove6D92V@dragon>
References: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-0-8ec5b48eec05@phytec.de>
 <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-4-8ec5b48eec05@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126-wip-y-moog-phytec-de-upstream-pollux-lvds-v1-4-8ec5b48eec05@phytec.de>
X-CM-TRANSID:ClUQrADn6+xzC8JlI3j+Ag--.15990S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU4pBTUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwd8ZVnxccILPgABs+

On Fri, Jan 26, 2024 at 09:57:26AM +0100, Yannic Moog wrote:
> Enable the i.MX8MP LDB driver used for display support of the i.MX8MP
> LVDS interface.
> 
> Signed-off-by: Yannic Moog <y.moog@phytec.de>

Applied, thanks!


