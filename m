Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7EB80D3A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344555AbjLKRYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343918AbjLKRYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:24:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F1694
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:24:22 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6cec976b197so2435869b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702315462; x=1702920262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OIO4WNjR5xVb+yTIblaWghN44VQDB2yiwlWnOskO7lQ=;
        b=X/HElSpsabf/JSNO5yuoYy7tmRFjNqnSfKB8lq23BvtLoaEbQ/DnSu50VHbA6BR06L
         zs4lopBJYqqozWHk4ZG7iIlZrboP4B/mbUauspaHlcXlE+edktmPncm1OwbnRIIeoAsB
         diaiK3kW3ZaDM8K5hpS1RA3CGqLVhPN4IIkSUQIGc0OrEmvHqe5trqyaCcRu7L1f+/5l
         IngXVePIRNX/D6PflAUXWB/KYxx0aHl4MH3j0D0LvyQQOF547Bdv24qJ+xepqhgQJTQy
         t7uk1+1HopMXTp5RN36HOFsjz/cPsOVtUsh1YpjagZsaDtsvuqVbuClbln1kfwPDVgLC
         FVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315462; x=1702920262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OIO4WNjR5xVb+yTIblaWghN44VQDB2yiwlWnOskO7lQ=;
        b=k6ekdBQamluZQdqamTo71eDwHQZSanVXhAngMrtckrNygrr8slgZXql/59sltIPuky
         HhymQTDsYNSxKvqDi6T5MGPPlj+11jkQEQ8X8EC0m0uNA2NHjJv98LYZcnoTxmoS9LXo
         DxiwQqzAzZ4nJR+n9HnvkIPW0yxMlYxrI/KU2foQUqUH8vbuvsG37+HGUTaquRIWyCIo
         RJ0rKkRdyz24lb1+DIsciDRkwKK5zshY7ALKUIH1JcPUwSZ0+btv80O6si2DV7YtboFd
         6jWPiuvVhUoD8jOeTHgHmizJ+hw0/wKFKm05sdYCym4Faxq+t2mISl9w8LYH1nkYVRiH
         AWww==
X-Gm-Message-State: AOJu0YxG3yWcaqWSaLq0ZiJwUXBF9u+ig2rkLq+OspUGlj9DetW3KS3J
        4QYNNvFaTjuRjjDlYz57KWiu
X-Google-Smtp-Source: AGHT+IF/o7tMygudcvDEgvWVGduVd5AMvlcE/EGogBR8ckxyLh/FBo/ByXUkDPmqNZldCt3kozHQaA==
X-Received: by 2002:a05:6a00:1b57:b0:6ce:f78d:b376 with SMTP id o23-20020a056a001b5700b006cef78db376mr1612136pfv.7.1702315462108;
        Mon, 11 Dec 2023 09:24:22 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:103d:670f:7d18:86fe:2cd9:84f3])
        by smtp.gmail.com with ESMTPSA id r21-20020aa78b95000000b006cef5c09ca3sm4495255pfd.147.2023.12.11.09.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:24:21 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] ARM: dts: qcom-sdx55: Fix the base address of PCIe PHY
Date:   Mon, 11 Dec 2023 22:54:11 +0530
Message-Id: <20231211172411.141289-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While convering the binding to new format, serdes address specified in the
old binding was used as the base address. This causes a boot hang as the
driver tries to access memory region outside of the specified address. Fix
it!

Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: stable@vger.kernel.org # 6.6
Fixes: bb56cff4ac03 ("ARM: dts: qcom-sdx55: switch PCIe QMP PHY to new style of bindings")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 2aa5089a8513..a88f186fcf03 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -436,9 +436,9 @@ pcie_ep: pcie-ep@1c00000 {
 			status = "disabled";
 		};
 
-		pcie_phy: phy@1c07000 {
+		pcie_phy: phy@1c06000 {
 			compatible = "qcom,sdx55-qmp-pcie-phy";
-			reg = <0x01c07000 0x2000>;
+			reg = <0x01c06000 0x2000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
-- 
2.25.1

