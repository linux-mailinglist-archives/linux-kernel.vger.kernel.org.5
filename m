Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D669C7F18EB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjKTQnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232576AbjKTQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:43:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BDC124
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:43:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF1EC433C8;
        Mon, 20 Nov 2023 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700498618;
        bh=7w+Gdoob7Qg7v2q89vsu8KyPhB82cWk+lg0XMgtIZKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hI1paVJi/CwUGt3vaH+ZMABSU3IvJHJEhYMCFWR4evYIZ4M21YxT01l1mzPEBHkSt
         ckt/dKlyZT9PHB0pCMIyOX06oSMQlcwl4oOrFJygFxRMTLPzFpwMD2qtfcnAGK5dIN
         /s3GayxO7LhlEbfeudaQlsp5BhWtutkybgk/KkuL9jFpcYea9dBbk/h2axteeVJCEN
         jEEs7Tkq/AA75TPRUeAR+ILmUQVIdn8KfeKRfhoPcUgDo/CdwfRoG5pllkcSh6G3gp
         xVPa909LEHsx//+mAcH2Q+1xdZa4DL0wESC1X65d/QCxDPJ+ACgar8dB33njScZ5ip
         bHxdg2HMxJxUA==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1r57NE-00027b-17;
        Mon, 20 Nov 2023 17:43:48 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 05/11] arm64: dts: qcom: sc7280: fix usb_2 wakeup interrupt types
Date:   Mon, 20 Nov 2023 17:43:25 +0100
Message-ID: <20231120164331.8116-6-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231120164331.8116-1-johan+linaro@kernel.org>
References: <20231120164331.8116-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DP/DM wakeup interrupts are edge triggered and which edge to trigger
on depends on use-case and whether a Low speed or Full/High speed device
is connected.

Note that only triggering on rising edges can be used to detect resume
events but not disconnect events.

Fixes: bb9efa59c665 ("arm64: dts: qcom: sc7280: Add USB related nodes")
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 8b968062a2c4..5ca77acd2a46 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3426,8 +3426,8 @@ usb_2: usb@8cf8800 {
 			assigned-clock-rates = <19200000>, <200000000>;
 
 			interrupts-extended = <&intc GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>,
-					      <&pdc 12 IRQ_TYPE_EDGE_RISING>,
-					      <&pdc 13 IRQ_TYPE_EDGE_RISING>;
+					      <&pdc 12 IRQ_TYPE_EDGE_BOTH>,
+					      <&pdc 13 IRQ_TYPE_EDGE_BOTH>;
 			interrupt-names = "hs_phy_irq",
 					  "dp_hs_phy_irq",
 					  "dm_hs_phy_irq";
-- 
2.41.0

