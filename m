Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DF87706C3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjHDRJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbjHDRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:09:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06E3849FA;
        Fri,  4 Aug 2023 10:09:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 959AD1007;
        Fri,  4 Aug 2023 10:09:49 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 514423F5A1;
        Fri,  4 Aug 2023 10:09:05 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] sunxi: Orange Pi Zero 3 DT support
Date:   Fri,  4 Aug 2023 18:08:53 +0100
Message-Id: <20230804170856.1237202-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

quick update of the series, mostly cosmetic fixes, except for the
regulator range. For a changelog, see below.

==================
Orange Pi recently released the Orange Pi Zero 3 board, which is some
updated version of their former Zero 2 development board. Some component
changes (Motorcomm PHY instead of Realtek, different PMIC), some board
layout changes, and it ships with up to 4GB of DRAM now. The SoC is now
labelled H618 instead of H616, which apparently is the same, just with
more L2 cache.

Split the existing OPi Zero2 DT, to allow sharing most DT nodes, then
add the binding documentation and DT for the new board.

Linux v6.5-rc boots out of the box (the PMIC driver just made it in),
and most things work: UART, PSCI, GPIO, SPI flash, SD card, USB.
Ethernet is somewhat working: I get an IP address via DHCP, and can
for instance start SSH, but it hangs at some point. I suspect some
PHY setup problem, though others have it working. Help or advice welcome.

Cheers,
Andre

Changelog v1 .. v2:
- rename common .dtsi file to sun50i-h616-orangepi-zero.dtsi
- add required Motorcomm PHY DT property to enable clock
- fix regulator ranges: VDD_CPU and VDD_GPU were swapped
- add comment about broken SD card detect
- reorder PMIC properties to match recommended order

Andre Przywara (3):
  arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
  dt-bindings: arm: sunxi: document Orange Pi Zero 3 board name
  arm64: dts: allwinner: h616: Add OrangePi Zero 3 board support

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-h616-orangepi-zero.dtsi  | 134 ++++++++++++++++++
 .../allwinner/sun50i-h616-orangepi-zero2.dts  | 119 +---------------
 .../allwinner/sun50i-h618-orangepi-zero3.dts  |  94 ++++++++++++
 5 files changed, 235 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zero.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts

-- 
2.25.1

