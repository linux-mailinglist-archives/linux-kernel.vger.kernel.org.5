Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88D518132F3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573454AbjLNOX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573436AbjLNOX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:23:26 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD2B9A;
        Thu, 14 Dec 2023 06:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1702563812; x=1734099812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mliULnIudaZ8Z9b/YiDFL3xTlsi8t7PxGhTU2deBEsE=;
  b=EDTGYFD240t6vYAyOjJkHAfvM0YGDctoeguWLLiqA5jEyHqJIyJFDPTM
   sg2zoxOtD+Ejge9rNcF79G0/b7W33cm/qjnFdm16FWj5I+z5hY42vIekp
   7NZlmQ3ARR5U45Kc0NlZcTM8BU1V586wHfCWtYJMbUAkQPF80R0Sgwlck
   OAj2a2+kOZnbpOsNkNeU0IM5EyZLrp/2RtYB8z3N/0HOgkM7exVTX0gbb
   lZYbjSS4q1a8a2i2Kx6hmUWv1qnFr41RpT11gn7X+v58WlyE5DidqARW9
   gOXjvS7Z7Jl5FEupAu6Thet+kKpJxfG5NDfETddDDdgAMZGU5RdhA6I5Y
   g==;
X-IronPort-AV: E=Sophos;i="6.04,275,1695679200"; 
   d="scan'208";a="34512084"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Dec 2023 15:23:29 +0100
Received: from steina-w.tq-net.de (steina-w.tq-net.de [10.123.53.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 97268280075;
        Thu, 14 Dec 2023 15:23:29 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 0/4] TQMa8Xx (i.MX8QXP/i.MX8DXP) support
Date:   Thu, 14 Dec 2023 15:23:23 +0100
Message-Id: <20231214142327.1962914-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this series adds initial support for the TQ TQMa8Xx series, namely
TQMa8XQP (imx8qxp based) and TQMa8XDP (imx8dxp based).
The device tree is split into generic mba8xx.dtsi and tqma8xx.dtsi which
can be used for both imx8qxp and imx8dxp based hardware.

Changes in v2:
* Rebased to next-20231214
* Add imx8dxp support patch
* Collected Marco's and Conor's R-b
* Added support for TQMa8XDP as well
* Add PWM polarity to PWM consumer
* Add PWM pinctrl settings
* Rename ethphy node names
* Remove obsolete num-cs property for SPI nodes
* Add gpio-line-names for lsio_gpio3
* Add USB host support (usbotg3)
* Add eMMC pinctrl settings for 100 & 200 MHz
* Merged SPI pinctrl groups (SPI lines + CS)
* Enabled USB3 host related driver in defconfig
* Add TODO entries

Alexander Stein (4):
  arm64: dts: imx: add imx8dxp support
  dt-bindings: arm: add TQMa8Xx boards
  arm64: dts: freescale: add initial device tree for TQMa8Xx
  arm64: defconfig: Enable i.MX8QXP device drivers

 .../devicetree/bindings/arm/fsl.yaml          |  16 +
 arch/arm64/boot/dts/freescale/Makefile        |   2 +
 .../dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts |  16 +
 .../boot/dts/freescale/imx8dxp-tqma8xdp.dtsi  |  24 +
 arch/arm64/boot/dts/freescale/imx8dxp.dtsi    |  24 +
 .../dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts |  16 +
 .../boot/dts/freescale/imx8qxp-tqma8xqp.dtsi  |  14 +
 arch/arm64/boot/dts/freescale/mba8xx.dtsi     | 532 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/tqma8xx.dtsi    | 265 +++++++++
 arch/arm64/configs/defconfig                  |   6 +
 10 files changed, 915 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxp.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/mba8xx.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/tqma8xx.dtsi

-- 
2.34.1

