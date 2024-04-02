Return-Path: <linux-kernel+bounces-128193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6E3895762
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 185B91C222C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2110131748;
	Tue,  2 Apr 2024 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="I8eFhD78"
Received: from mail-177131.yeah.net (mail-177131.yeah.net [123.58.177.131])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757E712C544;
	Tue,  2 Apr 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=123.58.177.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712069103; cv=none; b=Qo8olfDyVa+tmGWj/zst9hOYCbq6t5Bxuoj8EdrHM6+xDk6C2LEIcgAVszyQfU9rrQ2/S3oWtBU1uDpc700EMoZaASMlPqfSVbOkO2leeXDTj27ltqqynRC8DZPVJZVuzENn21RlMXkr/UyybCOOoqfzmiwBjcX8/5KOUFiPfTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712069103; c=relaxed/simple;
	bh=UoAIQh6T2R5yd03vS3etflEo5KsJFR7Ir5HehSGj0qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0kOnoH9UXN6za2tjzjus/yr9ubGTrx+ZMTF6DCJrFNTmf90WEYKdNyl9FVD4R2KPHSzjVWn/ldGLWVULwiqltYEXPl1K79WFwBKKCXXFG7iHE7K1GCJKW0voZkRKOBxMz9sK9kVf9+rYzsL9n3YJXoIERnF9MVoUccWPHmXn3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=I8eFhD78; arc=none smtp.client-ip=123.58.177.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=sNp+AZXGX0bUEOLXo2ZGNsWH+ua3wPGWHS+AYi2Sy94=;
	b=I8eFhD78wX/KsGbMXjYCDiOI/4+iFV21AYAWatCGUUr9GlU1h2acMWQGuPSVc+
	dx/49bGRy+cZNIPU8xEzxUJyuHI1B54xWKQtEVBWlgFH9jKZKfWhBJcVDnNc6yHq
	oHplaASZd4k0BeDzmHPOoPw7UtMFu9iVBlqw2a1m1zi4I=
Received: from dragon (unknown [223.68.79.243])
	by smtp1 (Coremail) with SMTP id ClUQrADnr0IuGQxm_E+mAQ--.45967S3;
	Tue, 02 Apr 2024 22:41:51 +0800 (CST)
Date: Tue, 2 Apr 2024 22:41:50 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Marco Felsch <m.felsch@pengutronix.de>, Marek Vasut <marex@denx.de>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Joao Paulo Goncalves <joao.goncalves@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Matthias Schiffer <matthias.schiffer@tq-group.com>,
	Stefan Wahren <stefan.wahren@chargebyte.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philippe Schenker <philippe.schenker@toradex.com>,
	Josua Mayer <josua@solid-run.com>, Li Yang <leoyang.li@nxp.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
Message-ID: <ZgwZLkpBf11rHNrG@dragon>
References: <20240324214329.29988-1-wafgo01@gmail.com>
 <20240324214329.29988-5-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240324214329.29988-5-wafgo01@gmail.com>
X-CM-TRANSID:ClUQrADnr0IuGQxm_E+mAQ--.45967S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1xGry8Zw1DCFWfuryUWrg_yoW5Jr1fpa
	yrCrZ3GrZ7Gr17Zayaga1kWFyqvws5JFWYkry5ury8tr45Zr9Yqr10krsIgr47Xrn5Aayr
	CF1F9ryxu3WYy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j34SrUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiFRC0ZV6NnBoE+QAAs8

On Sun, Mar 24, 2024 at 10:43:26PM +0100, Wadim Mueller wrote:
> This commit adds device tree support for the NXP S32G3-based
> S32G-VNP-RDB3 Board [1].
> 
> The S32G3 features an 8-core ARM Cortex-A53 based SoC developed by NXP.
> 
> The device tree files are derived from the official NXP downstream
> Linux tree [2].
> 
> This addition encompasses a limited selection of peripherals that
> are upstream-supported. Apart from the ARM System Modules
> (GIC, Generic Timer, etc.), the following IPs have been validated:
> 
>     * UART: fsl-linflexuart
>     * SDHC: fsl-imx-esdhc
> 
> Clock settings for the chip rely on ATF Firmware [3].
> Pin control integration into the device tree is pending and currently
> relies on Firmware/U-Boot settings [4].
> 
> These changes were validated using BSP39 Firmware/U-Boot from NXP [5].
> 
> The modifications enable booting the official Ubuntu 22.04 from NXP on
> the RDB3 with default settings from the SD card and eMMC.
> 
> [1] https://www.nxp.com/design/design-center/designs/s32g3-vehicle-networking-reference-design:S32G-VNP-RDB3
> [2] https://github.com/nxp-auto-linux/linux
> [3] https://github.com/nxp-auto-linux/arm-trusted-firmware
> [4] https://github.com/nxp-auto-linux/u-boot
> [5] https://github.com/nxp-auto-linux/auto_yocto_bsp
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  arch/arm64/boot/dts/freescale/s32g3.dtsi      | 233 ++++++++++++++++++
>  .../boot/dts/freescale/s32g399a-rdb3.dts      |  45 ++++
>  3 files changed, 279 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g3.dtsi
>  create mode 100644 arch/arm64/boot/dts/freescale/s32g399a-rdb3.dts
> 
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> index 2cb0212b63c6..e701008dbc7b 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -252,3 +252,4 @@ dtb-$(CONFIG_ARCH_MXC) += imx8mp-venice-gw74xx-rpidsi.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32g274a-evb.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32g274a-rdb2.dtb
>  dtb-$(CONFIG_ARCH_S32) += s32v234-evb.dtb
> +dtb-$(CONFIG_ARCH_S32) += s32g399a-rdb3.dtb

The list is alphabetically sorted, so it should be added before
s32v234-evb.dtb.  I fixed it up and applied the patch.

Shawn


