Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B1776FFA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjHDLsQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 07:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjHDLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 07:48:13 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0622C126;
        Fri,  4 Aug 2023 04:48:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62E041007;
        Fri,  4 Aug 2023 04:48:53 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E5C23F5A1;
        Fri,  4 Aug 2023 04:48:09 -0700 (PDT)
Date:   Fri, 4 Aug 2023 12:48:06 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
Subject: Re: [PATCH 0/3] sunxi: Orange Pi Zero 3 DT support
Message-ID: <20230804124806.2a9b2c40@donnerap.manchester.arm.com>
In-Reply-To: <3751904.kQq0lBPeGt@jernej-laptop>
References: <20230731011725.7228-1-andre.przywara@arm.com>
        <3751904.kQq0lBPeGt@jernej-laptop>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2023 23:07:55 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi Jernej,

> Dne ponedeljek, 31. julij 2023 ob 03:17:22 CEST je Andre Przywara napisal(a):
> > Hi,
> > 
> > Orange Pi recently released the Orange Pi Zero 3 board, which is some
> > updated version of their former Zero 2 development board. Some component
> > changes (Motorcomm PHY instead of Realtek, different PMIC), some board
> > layout changes, and it ships with up to 4GB of DRAM now. The SoC is now
> > labelled H618 instead of H616, which apparently is the same, just with
> > more L2 cache.
> > 
> > Split the existing OPi Zero2 DT, to allow sharing most DT nodes, then
> > add the binding documentation and DT for the new board.
> > 
> > Linux v6.5-rc boots out of the box (the PMIC driver just made it in),
> > and most things work: UART, PSCI, GPIO, SPI flash, SD card, USB.
> > Ethernet is almost working, I get an IP address via DHCP, but no further
> > packets come through. Might be either a problem with the new Motorcomm
> > PHY driver, or some missing delay settings, I have to investigate, any
> > help or advice welcome.  
> 
> When I worked with Motorcomm PHYs, I had to add 
> 
> motorcomm,clk-out-frequency-hz = <125000000>;

Ah, good point. Looking at the Linux driver code, that seems almost
mandatory, otherwise the PHY clock is not activated(?).
So that helped, I managed to SSH into my laptop, but it still hangs then.

Just for the sake of completeness, I also tried the other properties that
other boards use: As expected, motorcomm,keep-pll-enabled didn't help, as
the clock line just goes to the MAC pin, and is not used otherwise.
And also motorcomm,auto-sleep-disabled didn't improve stability. At least
not with the current settings, maybe it's needed later on.

> and usual reset gpio related properties. Have you tried that? In any case, 
> it's not 100% reliable, but I don't know why.

The reset pin is hardwired via a simple RC circuit, so there is no GPIO,
and thus the delay parameters don't do anything, I suppose.

But as it's better now with the clk-out property, so I will definitely add
that.
Reports from others (Piotr) seem to suggest that Ethernet is working for
them, so I need to compare notes.

Thanks,
Andre

> 
> Best regards,
> Jernej
> 
> > Also let me know if the DT split is a good idea or not, happy to roll
> > that back if requested.
> > 
> > Cheers,
> > Andre
> > 
> > Andre Przywara (3):
> >   arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
> >   dt-bindings: arm: sunxi: document Orange Pi Zero 3 board name
> >   arm64: dts: allwinner: h616: Add OrangePi Zero 3 board support
> > 
> >  .../devicetree/bindings/arm/sunxi.yaml        |   5 +
> >  arch/arm64/boot/dts/allwinner/Makefile        |   1 +
> >  .../allwinner/sun50i-h616-orangepi-zero2.dts  | 119 +---------------
> >  .../allwinner/sun50i-h616-orangepi-zerox.dtsi | 131 ++++++++++++++++++
> >  .../allwinner/sun50i-h618-orangepi-zero3.dts  |  86 ++++++++++++
> >  5 files changed, 224 insertions(+), 118 deletions(-)
> >  create mode 100644
> > arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi create mode
> > 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts  
> 
> 
> 
> 
> 

