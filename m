Return-Path: <linux-kernel+bounces-54716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628ED84B2D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C6AD2839A0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3DC12F361;
	Tue,  6 Feb 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="Kgjqw0ax"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E512EBDD;
	Tue,  6 Feb 2024 10:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707216800; cv=none; b=PLm/D+OYRAVHLwPIPq2G/1AkxFxs8UOlKzWjLZCfDgOxnpOQoxGhdJvho3I2TlpeEcupCNOomZL157Jhcu0Ffwge1vXZo3Fxb+Sh1FU58YgdcjTE3fsqRi2nnAfXoAu2Jq1f0iACR76ISQ9WRbmohrMK0nVhQ6my6Nw+c5dUJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707216800; c=relaxed/simple;
	bh=ssdQYVrN+ea7U0JV9joyXgpHVLYjczVefB/FHwG15Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWhXLaeey6SHXlL13KVUew5wNhnOuZ0NBOwpkRtTyABjqfUgYfbzPX8KVKL87yIIqY3oFBZG5xn7YfJJWUOhE56P7Ox/GP1Rj5HDyDw2Pr6Eo8ZSW++eLY8yGIKssk1XeJjDuUFz14PpXy/MVEPcBjwmc48aJnzQ/LygKkYg+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=Kgjqw0ax; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=8wKomoYeRvkZwd2NriASbbJ3Tx/X28kZxV4Y/FSbGwU=;
	b=Kgjqw0axpcfuMKTen7bWBnWe9PmG8H5KLry9AeWMpNkfZW6VpJXqxD1nVr5ceP
	XJoZnQkWucdYi/I4Mao4okY+LjfCG8UfYxIhrKnpDohAOVkOuPZabAEDSBqZ9OVt
	UmO0TsSCNqYxJL+wTrjbRBdvWgvnqSY1HBpQ+bskUPjfA=
Received: from dragon (unknown [183.213.196.254])
	by smtp2 (Coremail) with SMTP id C1UQrAD3fxxeD8Jl3WICAw--.65526S3;
	Tue, 06 Feb 2024 18:52:15 +0800 (CST)
Date: Tue, 6 Feb 2024 18:52:14 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8qm: add smmu node
Message-ID: <ZcIPXiiyM6080TgD@dragon>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240201-8qm_smmu-v2-3-3d12a80201a3@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201-8qm_smmu-v2-3-3d12a80201a3@nxp.com>
X-CM-TRANSID:C1UQrAD3fxxeD8Jl3WICAw--.65526S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVdb1UUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiDwB8ZVnxccISZwAAs4

On Thu, Feb 01, 2024 at 03:22:43PM -0500, Frank Li wrote:
> Add smmu node for imx8qm.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!


