Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FE97E4CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 00:22:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbjKGXWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 18:22:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343599AbjKGXWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 18:22:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1561D79;
        Tue,  7 Nov 2023 15:22:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1E8CC433C9;
        Tue,  7 Nov 2023 23:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399360;
        bh=0QmTRPmgmn8UfXnnBetJxKx9fT3u6QCiV/IBazpqvW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=inf+WCrdnatV+R5sI51JnfYYypM9HjsztiGaB/VbGR6fLpsv1ELFoefQ1xZA0Ueqk
         f88yl+AEw3lK+mAD/ooYMF7aV50iA0Dpk/s5EQzr2PWhd9/JEhpqLZJF44/52V6LWY
         o+3UnJPD0aKKfMXDufNRZvhz34HdnyYMj1zXuc00V6OJcGB4ItJYnSEe0Ku1pF1vAU
         qXbU8HjYvplp2DmqapDVH/pCT69YMb4qEV/GN35tSgKPZQ4Su8B6dPQRl7WLDv0OzT
         4OxwuKpatJY1UHNmBwuBznYPd/oGSTREA0IEGve8/fTCTvzrVZt9EdiV9KtnAjjzhD
         k4TatgAdUQbhA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Sasha Levin <sashal@kernel.org>, agross@kernel.org,
        andersson@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        abel.vesa@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/18] dt-bindings: phy: qcom,snps-eusb2-repeater: Add magic tuning overrides
Date:   Tue,  7 Nov 2023 18:21:58 -0500
Message-ID: <20231107232231.3775605-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232231.3775605-1-sashal@kernel.org>
References: <20231107232231.3775605-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit c20b59b2996c89c4f072c3312e6210528a298330 ]

The EUSB2 repeater requires some alterations to its init sequence,
depending on board design.

Add support for making the necessary changes to that sequence to make USB
functional on SM8550-based Xperia 1 V.

They all have lackluster description due to lack of information.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20230830-topic-eusb2_override-v2-1-7d8c893d93f6@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../phy/qcom,snps-eusb2-repeater.yaml         | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
index 029569d5fcf35..24c733c10e0e9 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -32,6 +32,27 @@ properties:
 
   vdd3-supply: true
 
+  qcom,tune-usb2-disc-thres:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: High-Speed disconnect threshold
+    minimum: 0
+    maximum: 7
+    default: 0
+
+  qcom,tune-usb2-amplitude:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: High-Speed trasmit amplitude
+    minimum: 0
+    maximum: 15
+    default: 8
+
+  qcom,tune-usb2-preem:
+    $ref: /schemas/types.yaml#/definitions/uint8
+    description: High-Speed TX pre-emphasis tuning
+    minimum: 0
+    maximum: 7
+    default: 5
+
 required:
   - compatible
   - reg
-- 
2.42.0

