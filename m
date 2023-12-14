Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241B681299C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 08:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443360AbjLNHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 02:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbjLNHnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 02:43:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296BDB9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 23:43:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7EAEC433C7;
        Thu, 14 Dec 2023 07:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702539819;
        bh=Yl2x7eLhM78aBJkayHAzBhB3fDnzcX22imLrs5W4058=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SsqxBolGwNn2WnFESjwwmEsD54cH3Z9K77vTR8cTgI2DXnvMZ1nALvvOulJJJtnNe
         ikisnu2cwX6pz4NPDFO8vXhVYy0ilA52gzBMjmB+fwLq89tvqfZPARYPxzdKU5c4Km
         SjjmWGErk0sq4lAGnMSphoGYi3pPcYMRyXFnhVNYffJzKavKW48yMlVVHVg0Dt+pPF
         apzjFgtMtMTYHfNy6vl3YC1zFif9FhfJreUf95DCvX7sff2JNHXRM6WkwYEPWBg23o
         ffKecZ70VB9xsgpSzvDf4MeF4MXiGZidX4d/Hei6+UQt3+rTPfhLyqjBQiu8Qh4Aku
         hMh3I0+qGy6eg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rDgNf-0002s6-0Y;
        Thu, 14 Dec 2023 08:43:39 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 1/3] arm64: dts: qcom: sdm670: fix USB DP/DM HS PHY interrupts
Date:   Thu, 14 Dec 2023 08:43:17 +0100
Message-ID: <20231214074319.11023-2-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231214074319.11023-1-johan+linaro@kernel.org>
References: <20231214074319.11023-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB DP/DM HS PHY interrupts need to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states and to be able to detect disconnect events, which requires
triggering on falling edges.

A recent commit updated the trigger type but failed to change the
interrupt provider as required. This leads to the current Linux driver
failing to probe instead of printing an error during suspend and USB
wakeup not working as intended.

Fixes: de3b3de30999 ("arm64: dts: qcom: sdm670: fix USB wakeup interrupt types")
Fixes: 07c8ded6e373 ("arm64: dts: qcom: add sdm670 and pixel 3a device trees")
Cc: stable@vger.kernel.org      # 6.2
Cc: Richard Acayan <mailingradian@gmail.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index c873560ae9d5..fe4067c012a0 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1295,10 +1295,10 @@ usb_1: usb@a6f8800 {
 					  <&gcc GCC_USB30_PRIM_MASTER_CLK>;
 			assigned-clock-rates = <19200000>, <150000000>;
 
-			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 488 IRQ_TYPE_EDGE_BOTH>,
-				     <GIC_SPI 489 IRQ_TYPE_EDGE_BOTH>;
+			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					      <&intc GIC_SPI 486 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 8 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 9 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
 					  "dm_hs_phy_irq", "dp_hs_phy_irq";
 
-- 
2.41.0

