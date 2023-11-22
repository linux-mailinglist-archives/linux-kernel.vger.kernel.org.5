Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EC77F47A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344119AbjKVNWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344081AbjKVNWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:22:47 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C8C1A8;
        Wed, 22 Nov 2023 05:22:40 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AMD1JP9025028;
        Wed, 22 Nov 2023 14:22:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=+8et82r
        Zp9iBNT80Xn81VQ4KpX7W59VuOEHler+hGgY=; b=hkvQ1PSjvn0BQLyVXHo8g/p
        02LFgdp43zO9tJ74nQwyeDnKp9312KKEc0dUZqOUkAf6RPE5sbizl3OWK/ByLehb
        KhwFMaGTEQFDkFI+B3qYqljTned/UevanF1UP+DMYuXqnPFQ2Ae6aHF137ITZN11
        kPnttt0Hk1U2jlHF7FfV/lh12Z9UxlJbJQS8OjEZlz8SkSIApd07h5oztos6h9W/
        WFfrKDgAuhWlGO04p+mKSoIxwok1eU/PTkp520o29TeGZzOSaCOqWtBDqry2KXxu
        Tw/gdaTaCcBPQBglM7zYEqYRdsmj1FBM8UWc0Ks8DQ/KC3fiZhRILELcIkEFM4w=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uen1pf3m2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 14:22:26 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 390E410004B;
        Wed, 22 Nov 2023 14:22:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2E5EB22A6C3;
        Wed, 22 Nov 2023 14:22:26 +0100 (CET)
Received: from localhost (10.201.21.240) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 22 Nov
 2023 14:22:25 +0100
From:   <gabriel.fernandez@foss.st.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Gabriel Fernandez <gabriel.fernandez@foss.st.com>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/5] Introduce STM32MP257 clock driver
Date:   Wed, 22 Nov 2023 14:21:51 +0100
Message-ID: <20231122132156.158103-1-gabriel.fernandez@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.240]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

This patch-set introduces clock driver for STM32MP257 based on Arm Cortex-35.
It creates also a menuconfig for all STM32MP clock drivers.
The STM32MP1 and STM32MP13 are now in same stm32 directory

v3:
  - fix remark from Rob Herring in YAML documentation
v2:
  - rework reset binding (use ID witch start from 0)
  - rework reset driver to manage STM32MP13 / STM32MP15 / STM32MP25
  - rework YAML documentation

Gabriel Fernandez (5):
  clk: stm32mp1: move stm32mp1 clock driver into stm32 directory
  clk: stm32mp1: use stm32mp13 reset driver
  dt-bindings: stm32: add clocks and reset binding for stm32mp25
    platform
  clk: stm32: introduce clocks for STM32MP257 platform
  arm64: dts: st: add rcc support in stm32mp251

 .../bindings/clock/st,stm32mp25-rcc.yaml      |   76 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |   59 +-
 drivers/clk/Kconfig                           |   11 +-
 drivers/clk/Makefile                          |    1 -
 drivers/clk/stm32/Kconfig                     |   36 +
 drivers/clk/stm32/Makefile                    |    2 +
 drivers/clk/stm32/clk-stm32-core.c            |    5 +-
 drivers/clk/stm32/clk-stm32-core.h            |    5 +-
 drivers/clk/{ => stm32}/clk-stm32mp1.c        |  127 +-
 drivers/clk/stm32/clk-stm32mp13.c             |    9 +-
 drivers/clk/stm32/clk-stm32mp25.c             | 1125 ++++
 drivers/clk/stm32/reset-stm32.c               |   76 +-
 drivers/clk/stm32/reset-stm32.h               |   15 +-
 drivers/clk/stm32/stm32mp25_rcc.h             | 4977 +++++++++++++++++
 include/dt-bindings/clock/st,stm32mp25-rcc.h  |  492 ++
 include/dt-bindings/reset/st,stm32mp25-rcc.h  |  165 +
 16 files changed, 7000 insertions(+), 181 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
 create mode 100644 drivers/clk/stm32/Kconfig
 rename drivers/clk/{ => stm32}/clk-stm32mp1.c (95%)
 create mode 100644 drivers/clk/stm32/clk-stm32mp25.c
 create mode 100644 drivers/clk/stm32/stm32mp25_rcc.h
 create mode 100644 include/dt-bindings/clock/st,stm32mp25-rcc.h
 create mode 100644 include/dt-bindings/reset/st,stm32mp25-rcc.h

-- 
2.25.1

