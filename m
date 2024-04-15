Return-Path: <linux-kernel+bounces-144808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C148A4B01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98067284582
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DA63BBF0;
	Mon, 15 Apr 2024 08:57:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01D63BB25;
	Mon, 15 Apr 2024 08:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171476; cv=none; b=pt8A/MTvPtZ+oB70UEOA4vM0Xw0Lx9I257V3H3VdYXl+a1JFo1485+pX/eNyUF31ghFCuSw74PjYAIaoOV4OLt/BCv8XCyn6Gskmt/WjI0WVmUOa+Mxen062I678vDgfLLEeB+mbdvc3+/fI2oxsUrttN21rCSexyH1WZlVHYY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171476; c=relaxed/simple;
	bh=y17O9lADy1koeCNGu1Oe7+FyvbVjW2CQKFJ5vnc/bJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ny2kBMLj5rh7luH0Vl2mG1y2ZAPnkk0MLgXY8BDkVedg/WnVs8m78aBFzqovagbYpc6AZE1c8HsdbOgUlPvv2lt4NoCUbt9XaaGKFbbroH1Xr6s/Gwb5W21Tae2wzCbFjV2Kj2SHQY/Mdw/3A52pNimag8gkAWE//t88PCjXbBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D38C2F;
	Mon, 15 Apr 2024 01:58:22 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E68D3F64C;
	Mon, 15 Apr 2024 01:57:48 -0700 (PDT)
Date: Mon, 15 Apr 2024 09:57:45 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Rob Herring <robh@kernel.org>
Cc: soc@kernel.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Antoine Tenart <atenart@kernel.org>,
	Khuong Dinh <khuong@os.amperecomputing.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
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
	Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
	Michal Simek <michal.simek@amd.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-realtek-soc@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
Message-ID: <ZhzsCYu4PEYaQFaF@bogus>
References: <20240412222857.3873079-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412222857.3873079-1-robh@kernel.org>

On Fri, Apr 12, 2024 at 05:28:51PM -0500, Rob Herring wrote:
> The "arm,armv8-pmuv3" compatible is intended only for s/w models. Primarily,
> it doesn't provide any detail on uarch specific events.
> 
> There's still remaining cases for CPUs without any corresponding PMU
> definition and for big.LITTLE systems which only have a single PMU node
> (there should be one per core type).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> SoC Maintainers, Can you please apply this directly.
> ---
>  arch/arm/boot/dts/broadcom/bcm2711.dtsi              | 4 ++--
>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi    | 2 +-
>  arch/arm64/boot/dts/amazon/alpine-v2.dtsi            | 2 +-
>  arch/arm64/boot/dts/apm/apm-storm.dtsi               | 2 +-
>  arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts | 2 +-
>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi     | 2 +-
>  arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi  | 2 +-
>  arch/arm64/boot/dts/cavium/thunder-88xx.dtsi         | 2 +-
>  arch/arm64/boot/dts/cavium/thunder2-99xx.dtsi        | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi       | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi       | 2 +-
>  arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi       | 7 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi       | 7 +++++++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi       | 5 -----
>  arch/arm64/boot/dts/freescale/imx8dxl.dtsi           | 2 +-
>  arch/arm64/boot/dts/intel/keembay-soc.dtsi           | 2 +-
>  arch/arm64/boot/dts/intel/socfpga_agilex.dtsi        | 2 +-
>  arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi        | 2 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi         | 2 +-
>  arch/arm64/boot/dts/mediatek/mt8516.dtsi             | 2 +-
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi             | 2 +-
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi                | 2 +-
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi                | 2 +-
>  arch/arm64/boot/dts/qcom/sdm630.dtsi                 | 2 +-
>  arch/arm64/boot/dts/qcom/sdx75.dtsi                  | 2 +-
>  arch/arm64/boot/dts/realtek/rtd16xx.dtsi             | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3368.dtsi             | 2 +-
>  arch/arm64/boot/dts/sprd/sc9860.dtsi                 | 2 +-
>  arch/arm64/boot/dts/sprd/sc9863a.dtsi                | 2 +-
>  arch/arm64/boot/dts/synaptics/berlin4ct.dtsi         | 2 +-
>  arch/arm64/boot/dts/tesla/fsd.dtsi                   | 2 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi               | 2 +-
>  32 files changed, 44 insertions(+), 35 deletions(-)
>

[...]

> diff --git a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> index 8db4243a4947..9115c99d0dc0 100644
> --- a/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> +++ b/arch/arm64/boot/dts/arm/vexpress-v2f-1xv7-ca53x2.dts
> @@ -102,7 +102,7 @@ timer {
>  	};
>
>  	pmu {
> -		compatible = "arm,armv8-pmuv3";
> +		compatible = "arm,cortex-a53-pmu";
>  		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
>  	};

(For vexpress related change)

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep

