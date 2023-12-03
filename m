Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17909802540
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 16:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjLCPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 10:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjLCPtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 10:49:20 -0500
X-Greylist: delayed 543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Dec 2023 07:49:26 PST
Received: from mail-m17224.xmail.ntesmail.com (mail-m17224.xmail.ntesmail.com [45.195.17.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58228125
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 07:49:25 -0800 (PST)
Received: from Vostro-3710.lan (unknown [119.122.215.53])
        by mail-m121145.qiye.163.com (Hmail) with ESMTPA id DF26B80003D;
        Sun,  3 Dec 2023 23:40:06 +0800 (CST)
From:   Chukun Pan <amadeus@jmu.edu.cn>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Chukun Pan <amadeus@jmu.edu.cn>
Subject: [PATCH v2 1/1] arm64: dts: qcom: ipq6018: Add QUP5 SPI node
Date:   Sun,  3 Dec 2023 23:40:03 +0800
Message-Id: <20231203154003.532765-1-amadeus@jmu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0kZVkkfSUodHkJMGk9ISFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUpKQlVKSUlVSUpOVU5IWVdZFhoPEhUdFFlBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8c30563ca5b03akuuudf26b80003d
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6Mxw4Ezw0KAkqVjw4NwtK
        CVEKCQFVSlVKTEtKTUpDS0tMQ0hLVTMWGhIXVRoWGh8eDgg7ERYOVR4fDlUYFUVZV1kSC1lBWUpK
        QlVKSUlVSUpOVU5IWVdZCAFZQUlPSEI3Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add node to support the QUP5 SPI controller inside of IPQ6018.
Some routers use this bus to connect SPI TPM chips.

Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
---
Changes in v2:
* No changes, resend due to error link to other threads.

 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index ec0a0ce1849e..2399d16f147e 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -527,6 +527,20 @@ blsp1_spi2: spi@78b6000 {
 			status = "disabled";
 		};
 
+		blsp1_spi5: spi@78b9000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x078b9000 0x0 0x600>;
+			interrupts = <GIC_SPI 299 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			dmas = <&blsp_dma 20>, <&blsp_dma 21>;
+			dma-names = "tx", "rx";
+			status = "disabled";
+		};
+
 		blsp1_i2c2: i2c@78b6000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
 			#address-cells = <1>;
-- 
2.25.1

