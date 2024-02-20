Return-Path: <linux-kernel+bounces-73102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9211285BD9F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500B628675D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97FB74E17;
	Tue, 20 Feb 2024 13:48:56 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0ABC6A34F;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436934; cv=none; b=K5PLDmxo2nYCAvig0TSNJWRl2yBUgjMC/6/NdhWhRMPizYTDeQtCrNA4EavqwwVxybZe6t20rP0aReP5Ywe8mEGihGcocXVf5xEfOlWR7TW2l4j89p7ZbOXLm5MrttXEzt8QjIznJG2GRTH1JPt5NbtkuJsBVAkhcJHmXqDurNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436934; c=relaxed/simple;
	bh=vYR8p74SkVXVJ7OHqgJra7pbE2srpH4uLh8O5W7OSOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vfsu/HPCGcSM7gJA9F6DFoeRgBezi6TWNE0Wy8urlyMThDj0PTnC2Cl0X08MGwZbVpXGWJCTrVK1YBwLdE/cp9wzfAR9UqwRR8ryw3uYHDPUOuKu31OdFsORaDDQwSkGhiFdyN2D61Wzp6zUG0sJ2GRaKLTX98eQtuZgNJKpV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUE-0007OI-00; Tue, 20 Feb 2024 14:48:42 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id DD60CC0A1E; Tue, 20 Feb 2024 14:44:23 +0100 (CET)
Date: Tue, 20 Feb 2024 14:44:23 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	=?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v8 00/14] Add support for the Mobileye EyeQ5 SoC
Message-ID: <ZdSst3fM3EOQGH03@alpha.franken.de>
References: <20240216174227.409400-1-gregory.clement@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216174227.409400-1-gregory.clement@bootlin.com>

On Fri, Feb 16, 2024 at 06:42:09PM +0100, Gregory CLEMENT wrote:
> Hello,
> 
> The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
> and features multiple controllers such as the classic UART, I2C, SPI,
> as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
> Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
> Security Module, Functional Safety Hardware, and MJPEG encoder.
> 
> One peculiarity of this SoC is that the physical address of the DDDR
> exceeds 32 bits. Given that the architecture is 64 bits, this is not
> an issue, but it requires some changes in how the mips64 is currently
> managed during boot.
> 
> In this eighth version, I rebased the series onto the one sent by
> Jixuan to unify register numbering macros for uasm. I also addressed
> the comments from Thomas Bogendoerfer, especially regarding the use of
> cache memory to copy the vectors.
> 
> To build and test the kernel, we need to run the following commands:
> 
> make eyeq5_defconfig
> make vmlinuz.itb
> [..] 
> Gregory CLEMENT (12):
>   MIPS: spaces: Define a couple of handy macros
>   MIPS: traps: Give more explanations if ebase doesn't belong to KSEG0
>   MIPS: cps-vec: Use macros for 64bits access
>   dt-bindings: Add vendor prefix for Mobileye Vision Technologies Ltd.
>   dt-bindings: mips: cpus: Sort the entries
>   dt-bindings: mips: cpu: Add I-Class I6500 Multiprocessor Core
>   dt-bindings: mips: Add bindings for Mobileye SoCs
>   MIPS: mobileye: Add EyeQ5 dtsi
>   MIPS: mobileye: Add EPM5 device tree
>   MIPS: Share generic kernel code with other architecture
>   MIPS: Add support for Mobileye EyeQ5
>   MAINTAINERS: Add entry for Mobileye MIPS SoCs
> 
> Jiaxun Yang (2):
>   MIPS: Fix set_uncached_handler for ebase in XKPHYS
>   MIPS: Allows relocation exception vectors everywhere
> 
>  .../devicetree/bindings/mips/cpus.yaml        |  13 +-
>  .../devicetree/bindings/mips/mobileye.yaml    |  32 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |  12 +
>  arch/mips/Kbuild                              |   1 +
>  arch/mips/Kbuild.platforms                    |   1 +
>  arch/mips/Kconfig                             |  57 ++++
>  arch/mips/boot/dts/Makefile                   |   1 +
>  arch/mips/boot/dts/mobileye/Makefile          |   4 +
>  arch/mips/boot/dts/mobileye/eyeq5-epm5.dts    |  23 ++
>  .../boot/dts/mobileye/eyeq5-fixed-clocks.dtsi | 292 ++++++++++++++++++
>  arch/mips/boot/dts/mobileye/eyeq5.dtsi        | 124 ++++++++
>  arch/mips/configs/eyeq5_defconfig             | 108 +++++++
>  arch/mips/generic/Makefile                    |   6 +-
>  arch/mips/include/asm/addrspace.h             |   5 +
>  arch/mips/include/asm/mach-generic/spaces.h   |   4 +
>  arch/mips/include/asm/mips-cm.h               |   1 +
>  arch/mips/include/asm/smp-cps.h               |   9 +-
>  arch/mips/kernel/cps-vec.S                    |  54 +---
>  arch/mips/kernel/smp-cps.c                    | 141 +++++++--
>  arch/mips/kernel/traps.c                      |   7 +-
>  arch/mips/mobileye/Makefile                   |   1 +
>  arch/mips/mobileye/Platform                   |  16 +
>  arch/mips/mobileye/board-epm5.its.S           |  24 ++
>  arch/mips/mobileye/vmlinux.its.S              |  32 ++
>  25 files changed, 890 insertions(+), 80 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mips/mobileye.yaml
>  create mode 100644 arch/mips/boot/dts/mobileye/Makefile
>  create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-epm5.dts
>  create mode 100644 arch/mips/boot/dts/mobileye/eyeq5-fixed-clocks.dtsi
>  create mode 100644 arch/mips/boot/dts/mobileye/eyeq5.dtsi
>  create mode 100644 arch/mips/configs/eyeq5_defconfig
>  create mode 100644 arch/mips/mobileye/Makefile
>  create mode 100644 arch/mips/mobileye/Platform
>  create mode 100644 arch/mips/mobileye/board-epm5.its.S
>  create mode 100644 arch/mips/mobileye/vmlinux.its.S

series applied to mips-next.

I've fixed generic|ingenic|realtek builds by adding select MACH_GENERIC_CORE
in arch/mips/Kconfig.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

