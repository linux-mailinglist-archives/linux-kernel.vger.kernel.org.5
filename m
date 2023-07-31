Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBEBC768981
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 03:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGaBS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 21:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjGaBSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 21:18:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 218FD1A2;
        Sun, 30 Jul 2023 18:18:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECB4B1650;
        Sun, 30 Jul 2023 18:19:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D92FC3F5A1;
        Sun, 30 Jul 2023 18:18:19 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Icenowy Zheng <uwu@icenowy.me>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] sunxi: Orange Pi Zero 3 DT support
Date:   Mon, 31 Jul 2023 02:17:22 +0100
Message-Id: <20230731011725.7228-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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
Ethernet is almost working, I get an IP address via DHCP, but no further
packets come through. Might be either a problem with the new Motorcomm
PHY driver, or some missing delay settings, I have to investigate, any
help or advice welcome.
Also let me know if the DT split is a good idea or not, happy to roll
that back if requested.

Cheers,
Andre

Andre Przywara (3):
  arm64: dts: allwinner: h616: Split Orange Pi Zero 2 DT
  dt-bindings: arm: sunxi: document Orange Pi Zero 3 board name
  arm64: dts: allwinner: h616: Add OrangePi Zero 3 board support

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm64/boot/dts/allwinner/Makefile        |   1 +
 .../allwinner/sun50i-h616-orangepi-zero2.dts  | 119 +---------------
 .../allwinner/sun50i-h616-orangepi-zerox.dtsi | 131 ++++++++++++++++++
 .../allwinner/sun50i-h618-orangepi-zero3.dts  |  86 ++++++++++++
 5 files changed, 224 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h616-orangepi-zerox.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h618-orangepi-zero3.dts

-- 
2.35.8

