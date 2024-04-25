Return-Path: <linux-kernel+bounces-158076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8578B1B22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57CFB1F21F92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7275A0FE;
	Thu, 25 Apr 2024 06:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="kvIZc6X1"
Received: from mail-177132.yeah.net (mail-177132.yeah.net [123.58.177.132])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663E22EF3;
	Thu, 25 Apr 2024 06:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027041; cv=none; b=Bhi29k7zuoUutVgyWlgFN3F7r7oxUHLidfpR/kkxVtt5js6j6zHuBcsqS9nD+T3Qhpo+xs2p8sC8EtLVhoiq5ypvBG4sIyySgB8tUjthpl6ofUv76MbKZlMthUkNYuhz/+yyNjZZO2IPJa1WUPjNAX8lxyZGhs38YysjaG5iWoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027041; c=relaxed/simple;
	bh=ELfe8WckxF8eVSgyC8i2jrnzs1KvA10s4ckP/UnNsCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd95wXkJjrcFcxXfWlGRftBnQgWvWpeQTKGK1Hg2z8AUtY1rchn6kf4UgCgdQRzI/oZQuTSunuK1+yfkjPl/txdHv5ndE7oLSEWcDpdyUB6BBDYlTjOjGI129JwnIxl10s7oZnBd8JzDmDkPIUTagnPKjfTLmVxB0JQ+2uh2+rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=kvIZc6X1; arc=none smtp.client-ip=123.58.177.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=znCW4xJn3QRey/3PtwEkZuygD9e6UvUN/Gc1h2x4hsE=;
	b=kvIZc6X16kU5qE9Nuaji67kho/47nX8LfmMXf0m+xCMikIJAnqJClKpQwTuH2S
	d6QgxtMeaWpdDwT+/ahxHaFmSNlQoBR9Rz5WkJQ/kNuhh728cefs82EuINbNsYrJ
	UBqC0xmfCv9okKiUBVV+IfS15/wxqi6XnFVpz9g43K6FU=
Received: from dragon (unknown [223.68.79.243])
	by smtp2 (Coremail) with SMTP id C1UQrADHLhiS+SlmRJRzBA--.45238S3;
	Thu, 25 Apr 2024 14:34:59 +0800 (CST)
Date: Thu, 25 Apr 2024 14:34:57 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: soc@kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Antoine Tenart <atenart@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Robert Richter <rric@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"Paul J. Murphy" <paul.j.murphy@intel.com>,
	Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Heiko Stuebner <heiko@sntech.de>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michal Simek <michal.simek@amd.com>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible
 usage
Message-ID: <Zin4+9mv1oIAewHH@dragon>
References: <20240417203853.3212103-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417203853.3212103-1-robh@kernel.org>
X-CM-TRANSID:C1UQrADHLhiS+SlmRJRzBA--.45238S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWUWF45KryrtFW7uw45KFg_yoW8Xr1rp3
	WUuw45Cr18Wr1rCasFgw1IvF90kw4rArW3uF9rGr9xtrn0va4UtF1Svr4fuw4DZ3WrCa1I
	qF4DZryjg3WYqFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UBrWOUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRPLZV6NnF3JSgAAs5

On Wed, Apr 17, 2024 at 03:38:47PM -0500, Rob Herring (Arm) wrote:
> The "arm,armv8-pmuv3" compatible is intended only for s/w models. Primarily,
> it doesn't provide any detail on uarch specific events.
> 
> There's still remaining cases for CPUs without any corresponding PMU
> definition and for big.LITTLE systems which only have a single PMU node
> (there should be one per core type).
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Jisheng Zhang <jszhang@kernel.org>
> Acked-by: Bjorn Andersson <andersson@kernel.org>
> Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Acked-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
> SoC Maintainers, Can you please apply this directly.
> 
> v2:
>  - Drop QCom sdm630 change
> ---
..
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi       | 7 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       | 7 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 5 -----
>  arch/arm64/boot/dts/freescale/imx8dxl.dtsi           | 2 +-

Acked-by: Shawn Guo <shawnguo@kernel.org>


