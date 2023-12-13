Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4425B811B14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441921AbjLMRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235563AbjLMRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:31:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042E4111
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:31:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907C8C433C9;
        Wed, 13 Dec 2023 17:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702488711;
        bh=pvfAZ2jWOf3ivNxGlbKupApmdVeEyh6B35IYVxGAQVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyRL7vxRdK3m9bfIoxioogLX62bouo1KuletWAv2bRccseP4Cpu3BuhdYCqWnelFY
         l2pUeV+hqoOMm9OEokUCFUWDmJEvRs+8mAsdoUfPVEjkX2GifjrxfgkE9EC4J6m3kf
         keNGhxSAiVbsszucmnUeg5Yoonn+Ait6UFO/2vefRSsnEOq7kUmcv2YFs0ApPY98+E
         1gSWY53DiUHMQDVRWxR6S188uMOF+cBm6G5xMvxBjJpKxP1u82UWCK+9MItv+7oV1d
         eQuz4dE4x+ItycgyHd89GIOpvOMCCShbBJlN4KLe9i4N+QXojIdNESHmLdIQNS7IsU
         RrUtvtIjYZnyg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1rDT5J-0007fD-0d;
        Wed, 13 Dec 2023 18:31:49 +0100
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
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 3/3] ARM: dts: qcom: sdx55: fix USB SS wakeup
Date:   Wed, 13 Dec 2023 18:31:31 +0100
Message-ID: <20231213173131.29436-4-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231213173131.29436-1-johan+linaro@kernel.org>
References: <20231213173131.29436-1-johan+linaro@kernel.org>
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

The USB SS PHY interrupt needs to be provided by the PDC interrupt
controller in order to be able to wake the system up from low-power
states.

Fixes: fea4b41022f3 ("ARM: dts: qcom: sdx55: Add USB3 and PHY support")
Cc: stable@vger.kernel.org	# 5.12
Cc: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 49910279cb71..5b69219170a8 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -586,7 +586,7 @@ usb: usb@a6f8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
-					      <&intc GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>,
+					      <&pdc 51 IRQ_TYPE_LEVEL_HIGH>,
 					      <&pdc 11 IRQ_TYPE_EDGE_BOTH>,
 					      <&pdc 10 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq", "ss_phy_irq",
-- 
2.41.0

