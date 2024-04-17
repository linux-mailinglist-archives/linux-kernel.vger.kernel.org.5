Return-Path: <linux-kernel+bounces-148677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00DE8A85F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90489B21E61
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E5A82D70;
	Wed, 17 Apr 2024 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyKBXKiD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E6822334
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364351; cv=none; b=BqnL/h9T2plyxEDPAxYVwShukGTgilZ+kkPlukUXhVfrkrNHHH06u98cf7o5yLdRJmN39brhSvWt7fmofPyRCYEpS2ml2zAN5PdnfACMHXAgoBjiB18a6YwpK6DPdN6IU9ek4gwBS0eI9kqfD2HSW/5RZzpWmKiXrcqPBXx0YoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364351; c=relaxed/simple;
	bh=PUu4gP0r1lpuHkPJAID3jYnRx76OcmdFV7y6UFy/ZNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5yyalQwoASEpI1jJumpzd/COAqhlk3vr4tng1KGc8vRz/ddzYqzUmN1MVYA2SvnQce8vcu+VShdL21pDP91ozgfNmYd76CoJbYWxeO94WhO9S7w4HeU020zAr95xvtgZUQB5gKpHK9FLB8EHKWnwK4xchGorzlH0kDXdglOSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyKBXKiD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C45C3277B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713364351;
	bh=PUu4gP0r1lpuHkPJAID3jYnRx76OcmdFV7y6UFy/ZNk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GyKBXKiDWxfgonQhzj2Tl1sH0ijTSbrPGzjsZIV7JRylBub6lMirjNINfaT+P1eem
	 gB4oZj/STbHg0jmnuCxJ8dPQ6jctp0Hj4fw6QK047URVRvEDgOCqWf6+UM02LF0KSC
	 FNWVVTx7O9AiCM5tk3no3C1CBfUV4UXDyZxKeykYlwxV5A1tmjW8NN5aEKPHDkch10
	 aDmbtx8G2QBUj1RBFE79T9NaWsUMhh4pVHR8GGjddStCyz7Ts1HvawycohO/EDEGMx
	 /cYlZnWpWlJ+/2Fo4aEV4Wh0p2Aq5gDJUez1c6fMy0JwZGiZvgcHOe5KaHYK4yMo42
	 wjsuvCcsFASiw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-516d6c1e238so6765375e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 07:32:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXHPeeM9pSKmPhqOcuidagB2PYvS1HGY4Nw1gEcFNOU19L3JGYAgCEPkzXq2kaercV/2WY2seuD9xi5SgWjt0SWceOx2kKDd5d5RsVC
X-Gm-Message-State: AOJu0YzntNYFq4fNwIAyPCDPoF2HjLHaE//UKmi1gEMT3FdFOZI5tI1A
	+XhgJVpN4TAHiB6etF01gPpShcuyFuivuikQ0hC7/Y1IEb1Bd2idNwFu0U7xj8LZCQeFuSPn6vW
	mYbnT0zt1n+MrnYlJNCCkBJ6nL1M=
X-Google-Smtp-Source: AGHT+IFzFfbXq8MVPjrUIpo4Y31mC4JkVNmMrM52bUgoBrPi0c/4B64eThupWdMLRm1alQlvRPxjLXAZ3C9Qu2A+pbI=
X-Received: by 2002:a19:f015:0:b0:518:c564:1089 with SMTP id
 p21-20020a19f015000000b00518c5641089mr6513183lfc.52.1713364350001; Wed, 17
 Apr 2024 07:32:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ea330927-2a8d-4026-a6f1-d418a916d19c@broadcom.com>
In-Reply-To: <ea330927-2a8d-4026-a6f1-d418a916d19c@broadcom.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 17 Apr 2024 23:31:53 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQJcFifScm_N40B+uHXB7o=EYyERQVRQ4=f2f0JTEM3+g@mail.gmail.com>
Message-ID: <CAK7LNAQJcFifScm_N40B+uHXB7o=EYyERQVRQ4=f2f0JTEM3+g@mail.gmail.com>
Subject: Re: Issue with "kbuild: create a list of all built DTB files"
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 2:22=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> Hi Masahiro,
>
> Sorry about the late report, commit
> 24507871c3c6ae4f6b460b016da7ff434cd34149 ("kbuild: create a list of all
> built DTB files") is breaking the build when we are doing a rsync of the
> Linux sources into a build directory, which is how buildroot works when
> doing a source directory override.
>
> This does not happen when doing a build from the git directory
> containing the sources, and I cannot find a missing $(obj) reference, so
> I am left wondering what I am missing here. The build error looks like th=
is:
>
> cat: arch/arm64/boot/dts/actions/dtbs-list: No such file or directory
> host-make[3]: *** [scripts/Makefile.build:423:
> arch/arm64/boot/dts/dtbs-list] Error 1
> host-make[3]: *** Deleting file 'arch/arm64/boot/dts/dtbs-list'
> host-make[2]: *** [Makefile:1394: dtbs] Error 2
> host-make[2]: *** Waiting for unfinished jobs....
>
> running with verbose, we can see the rule not generating an empty file
> at all:
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Dscripts/dtc
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Dscripts
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts need-dtbslist=3D1
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Dscripts/genksyms \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/actions \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/allwinner \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/altera \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/amazon \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/tools kapi
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/amd \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/amlogic \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/apm \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/apple \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/arm \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/bitmain \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/broadcom \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/cavium \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/exynos \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/freescale \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/hisilicon \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/intel \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/lg \
> need-builtin=3D \
> need-modorder=3D \
>
> # GEN     arch/arm64/include/generated/asm/cpucap-defs.h
>    mkdir -p arch/arm64/include/generated/asm/; awk -f
> arch/arm64/tools/gen-cpucaps.awk arch/arm64/tools/cpucaps >
> arch/arm64/include/generated/asm/cpucap-defs.h
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/marvell \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/mediatek \
> need-builtin=3D \
> need-modorder=3D \
>
> # GEN     arch/arm64/include/generated/asm/sysreg-defs.h
>    mkdir -p arch/arm64/include/generated/asm/; awk -f
> arch/arm64/tools/gen-sysreg.awk arch/arm64/tools/sysreg >
> arch/arm64/include/generated/asm/sysreg-defs.h
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/microchip \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/broadcom/bcmbca \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/nuvoton \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/broadcom/northstar2 \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/exynos/google \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/nvidia \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/broadcom/stingray \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/qcom \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/realtek \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/renesas \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/rockchip \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/socionext \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/sprd \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/st \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/synaptics \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/tesla \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/ti \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/toshiba \
> need-builtin=3D \
> need-modorder=3D \
>
> /home/fainelli/work/buildroot/output/arm64/host/bin/host-make -f
> ./scripts/Makefile.build obj=3Darch/arm64/boot/dts/xilinx \
> need-builtin=3D \
> need-modorder=3D \
>
> # cmd_gen_order arch/arm64/boot/dts/dtbs-list
>    {   cat arch/arm64/boot/dts/actions/dtbs-list;   cat
> arch/arm64/boot/dts/allwinner/dtbs-list;   cat
> arch/arm64/boot/dts/altera/dtbs-list;   cat
> arch/arm64/boot/dts/amazon/dtbs-list;   cat
> arch/arm64/boot/dts/amd/dtbs-list;   cat
> arch/arm64/boot/dts/amlogic/dtbs-list;   cat
> arch/arm64/boot/dts/apm/dtbs-list;   cat
> arch/arm64/boot/dts/apple/dtbs-list;   cat
> arch/arm64/boot/dts/arm/dtbs-list;   cat
> arch/arm64/boot/dts/bitmain/dtbs-list;   cat
> arch/arm64/boot/dts/broadcom/dtbs-list;   cat
> arch/arm64/boot/dts/cavium/dtbs-list;   cat
> arch/arm64/boot/dts/exynos/dtbs-list;   cat
> arch/arm64/boot/dts/freescale/dtbs-list;   cat
> arch/arm64/boot/dts/hisilicon/dtbs-list;   cat
> arch/arm64/boot/dts/intel/dtbs-list;   cat
> arch/arm64/boot/dts/lg/dtbs-list;   cat
> arch/arm64/boot/dts/marvell/dtbs-list;   cat
> arch/arm64/boot/dts/mediatek/dtbs-list;   cat
> arch/arm64/boot/dts/microchip/dtbs-list;   cat
> arch/arm64/boot/dts/nuvoton/dtbs-list;   cat
> arch/arm64/boot/dts/nvidia/dtbs-list;   cat
> arch/arm64/boot/dts/qcom/dtbs-list;   cat
> arch/arm64/boot/dts/realtek/dtbs-list;   cat
> arch/arm64/boot/dts/renesas/dtbs-list;   cat
> arch/arm64/boot/dts/rockchip/dtbs-list;   cat
> arch/arm64/boot/dts/socionext/dtbs-list;   cat
> arch/arm64/boot/dts/sprd/dtbs-list;   cat
> arch/arm64/boot/dts/st/dtbs-list;   cat
> arch/arm64/boot/dts/synaptics/dtbs-list;   cat
> arch/arm64/boot/dts/tesla/dtbs-list;   cat
> arch/arm64/boot/dts/ti/dtbs-list;   cat
> arch/arm64/boot/dts/toshiba/dtbs-list;   cat
> arch/arm64/boot/dts/xilinx/dtbs-list; :; } > arch/arm64/boot/dts/dtbs-lis=
t
> cat: arch/arm64/boot/dts/actions/dtbs-list: No such file or directory
> host-make[3]: *** [scripts/Makefile.build:423:
> arch/arm64/boot/dts/dtbs-list] Error 1
> host-make[3]: *** Deleting file 'arch/arm64/boot/dts/dtbs-list'
> host-make[2]: *** [Makefile:1394: dtbs] Error 2
> host-make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [package/pkg-generic.mk:293:
> /home/fainelli/work/buildroot/output/arm64/build/linux-custom/.stamp_buil=
t]
> Error 2
> make: *** [Makefile:27: _all] Error 2
>
> Buildroot builds its own GNU Make version 4.4.1.
>
> Any clues what might be going on? My defconfig is such that only
> CONFIG_ARCH_BRCMSTB is enabled, and there are essentially no .dtbs file
> that will be generated.



How to reproduce this in buildroot?



--=20
Best Regards
Masahiro Yamada

