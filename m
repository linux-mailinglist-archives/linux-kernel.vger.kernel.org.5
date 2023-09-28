Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2062F7B20C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjI1PQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjI1PQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:16:00 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9921AE;
        Thu, 28 Sep 2023 08:15:53 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38SE0DPd015115;
        Thu, 28 Sep 2023 17:15:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=DVDsnfq
        WMzi6qlYBynRmCr8AXaqPBbzCO9a9d54AX5w=; b=A0MvNWGd4arOF12LqpD2H8P
        gcObAHYXnzOgfPWWGoMANdRrvTMZUdVOKeHNBUcFTnLJaOecqWsh19j2lcISflpm
        tgUIiCi+Pa1I7Cuqpghm2+kMGxs9fekQhO+XSspXClpu/HKh/gJLdqe002ATUuUo
        LiUrZZrklIqzPoNuDMTXd3MtWp1AsP/WoLn5RxDPKdQDqoqPhpyJmXJ5AZvcOwqT
        EBeBeqPrAh5zt9ifMAvyG8GmqcGVUGEjxpyqITVO5GhTDS2lu3hJVdUg6w8d1Rwa
        M0L1omIeK0kyDsW8tZqjagICSVrg18X84HqpSyYOxl3h1TiVjGh4fG0zR5kzYJg=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9nefye3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:15:17 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 917B0100057;
        Thu, 28 Sep 2023 17:15:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58B4E233004;
        Thu, 28 Sep 2023 17:15:16 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 17:15:15 +0200
From:   Christophe Roullier <christophe.roullier@foss.st.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 00/12] Series to deliver Ethernets for STM32MP13
Date:   Thu, 28 Sep 2023 17:15:00 +0200
Message-ID: <20230928151512.322016-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_14,2023-09-28_02,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STM32MP13 is STM32 SOC with 2 GMACs instances
This board have 2 RMII phy:
  -Ethernet1: RMII with crystal
  -Ethernet2: RMII without crystal
Rework dwmac glue to simplify management for next stm32

-V2: Update from remark of Andrew Lunn (split commit into a number of smaller patches)
     Update from Conor Dooley (yaml documentation)
-V3: bad indentation for yaml (sorry)

Christophe Roullier (12):
  dt-bindings: net: add STM32MP13 compatible in documentation for stm32
  dt-bindings: net: add new property st,ext-phyclk in documentation for
    stm32
  dt-bindings: net: add phy-supply property for stm32
  net: ethernet: stmmac: rework glue to simplify management for next
    stm32
  net: ethernet: stmmac: add management of stm32mp13 for stm32
  net: ethernet: stmmac: stm32: update config management for phy wo
    cristal
  net: ethernet: stm32: clean the way to manage wol irqwake
  net: ethernet: stmmac: stm32: support the phy-supply regulator binding
  ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
  ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
  ARM: dts: stm32: add ethernet1 and ethernet2 for STM32MP135F-DK board
  ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support

 .../devicetree/bindings/net/stm32-dwmac.yaml  |  90 ++++++-
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  31 +++
 arch/arm/boot/dts/st/stm32mp133.dtsi          |  30 +++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  48 ++++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 229 +++++++++++++-----
 7 files changed, 425 insertions(+), 75 deletions(-)

-- 
2.25.1

