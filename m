Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E1A758F1D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGSHgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGSHf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:35:58 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 372BDE43;
        Wed, 19 Jul 2023 00:35:56 -0700 (PDT)
Received: from lexxgentoo.devos.club (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 4FE7D1408B4;
        Wed, 19 Jul 2023 07:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1689752153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TXAZUdyfaHpmcHakUejI+ug2h18/N7wsLTL0rMLkYr4=;
        b=R5ahRwICn17hNaiiH7LHfM1pv3cTmn1Tu1JB6cSVrGMHlkwuQFiOkfZRycTnH+Imj38FTY
        hUBgpMFSH+zIG1nbDSkPFKFpKgaUxwovVEvdUnP7pMjc/1x5+wyyObE9XtkIqxIidlsVoL
        T2eZ2207mMBOPiqKn71X0nJI9XQEnbE=
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Alexey Minnekhanov <alexeymin@postmarketos.org>
Subject: [PATCH] arm64: dts: qcom: sdm630: remove refs to nonexistent clocks
Date:   Wed, 19 Jul 2023 10:35:20 +0300
Message-ID: <20230719073520.2644966-1-alexeymin@postmarketos.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out
interconnect bus clocks") rpmcc-sdm660 no longer provides
RPM_SMD_AGGR2_NOC_CLK and RPM_SMD_AGGR2_NOC_A_CLK clocks.
Remove them to fix various probe failures and get devices
booting again.

Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 038ec7a41412..8bea611b246b 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -638,10 +638,6 @@ anoc2_smmu: iommu@16c0000 {
 			compatible = "qcom,sdm630-smmu-v2", "qcom,smmu-v2";
 			reg = <0x016c0000 0x40000>;
 
-			assigned-clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			assigned-clock-rates = <1000>;
-			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			clock-names = "bus";
 			#global-interrupts = <2>;
 			#iommu-cells = <1>;
 			qcom,bypass-cbndx = /bits/ 8 <6>;
@@ -689,16 +685,12 @@ a2noc: interconnect@1704000 {
 			compatible = "qcom,sdm660-a2noc";
 			reg = <0x01704000 0xc100>;
 			#interconnect-cells = <1>;
-			clock-names = "bus",
-				      "bus_a",
-				      "ipa",
+			clock-names = "ipa",
 				      "ufs_axi",
 				      "aggre2_ufs_axi",
 				      "aggre2_usb3_axi",
 				      "cfg_noc_usb2_axi";
-			clocks = <&rpmcc RPM_SMD_AGGR2_NOC_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_A_CLK>,
-				 <&rpmcc RPM_SMD_IPA_CLK>,
+			clocks = <&rpmcc RPM_SMD_IPA_CLK>,
 				 <&gcc GCC_UFS_AXI_CLK>,
 				 <&gcc GCC_AGGRE2_UFS_AXI_CLK>,
 				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
@@ -1309,20 +1301,16 @@ usb3: usb@a8f8800 {
 				 <&gcc GCC_USB30_MASTER_CLK>,
 				 <&gcc GCC_AGGRE2_USB3_AXI_CLK>,
 				 <&gcc GCC_USB30_SLEEP_CLK>,
-				 <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-				 <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
+				 <&gcc GCC_USB30_MOCK_UTMI_CLK>;
 			clock-names = "cfg_noc",
 				      "core",
 				      "iface",
 				      "sleep",
-				      "mock_utmi",
-				      "bus";
+				      "mock_utmi";
 
 			assigned-clocks = <&gcc GCC_USB30_MOCK_UTMI_CLK>,
-					  <&gcc GCC_USB30_MASTER_CLK>,
-					  <&rpmcc RPM_SMD_AGGR2_NOC_CLK>;
-			assigned-clock-rates = <19200000>, <120000000>,
-					       <19200000>;
+					  <&gcc GCC_USB30_MASTER_CLK>;
+			assigned-clock-rates = <19200000>, <120000000>;
 
 			interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.41.0

