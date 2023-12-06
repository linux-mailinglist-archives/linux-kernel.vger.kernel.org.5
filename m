Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5BD80715E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378741AbjLFN4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378672AbjLFN4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:56:02 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E543D47
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:56:08 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ce93552cb5so301246b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 05:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701870968; x=1702475768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmeVczC6Kot8sni16e+Ayovssumb8h1f89h2BntZbU8=;
        b=qi+zFd1pKs4/92DpWwD/AyAMTPXgXLHYFxbn4IXjI+2TBbNGiqQEkf5C+6BJQuc1AU
         kTvTJMToI54hNRMOb/0J6uw0jjU28rYmzck9b4wF/xRvAPWAeraO69xJPnolUA+O6Cn9
         C5p8qhPujKhTTv77mVU8JKH4/yrDlA6NnOzJz84Q8JVpxjtrd7aVYO9fpTRIENXmz3vX
         yEnYJwOU2+t+xvblSGALLUX29pG5ZDUdspXxlXcd5gb30mgG34rB/OZf3FHpg7mHfigl
         N5nHcluF3q0upTw9WIkYsNZC94QIA79CaRSsu7ZnX+UzIWH9yEXDb3COjUu4QDX5v/8o
         WtaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701870968; x=1702475768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmeVczC6Kot8sni16e+Ayovssumb8h1f89h2BntZbU8=;
        b=MdQOO90vthmB9nnWHzvIiuxMY+7fII9LYGyd2ML/LGgKJhzul79B+9iRyX7Gjne6B8
         dn0yax2eGZin7XDuvOEdiPnUyHYBk4/4KHGwKj1PELGCITsNwxcLY9Q/xHBvOUKtH7Eh
         Ue+xY/dPe9HnkkAzFO0F23ENjHgtLtTqmGvdKFWS0eejQz506i+KNGqRdqLrAM2AZfjM
         UaVLirDeDKjMI9KrkbthSUuC9bYqBcuXFY4mnXmC5J7lQpLoVJHnVM+4yrFD/s6KaFxK
         jwbAB8I6OGoCWcqA2l7mCIzgbF6BNkLO54VIkh9zqSuXg56gx33oVIw6uZVqS3tmKLRR
         63wA==
X-Gm-Message-State: AOJu0YyDq4fc6DbuloMLd2iauCTz1hEMUtmrmmSVqliitNdP2oGtbB4K
        Z6YamKUzTaDQRinFQkykToBX
X-Google-Smtp-Source: AGHT+IEMtc+F14NCFOrDcgQa9/dMsC3lwjS1LLoH43LSGscYSP/Z2ZlNqN8F20DLDUreWf1jJt7lIg==
X-Received: by 2002:a05:6a20:e124:b0:18f:c3ea:2904 with SMTP id kr36-20020a056a20e12400b0018fc3ea2904mr662700pzb.33.1701870968130;
        Wed, 06 Dec 2023 05:56:08 -0800 (PST)
Received: from localhost.localdomain ([117.202.188.104])
        by smtp.gmail.com with ESMTPSA id n38-20020a056a000d6600b006ce91cdb1c4sm1366056pfv.188.2023.12.06.05.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 05:56:07 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 3/3] arm64: dts: qcom: sa8775p: Add missing space between node name and braces
Date:   Wed,  6 Dec 2023 19:25:40 +0530
Message-Id: <20231206135540.17068-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206135540.17068-1-manivannan.sadhasivam@linaro.org>
References: <20231206135540.17068-1-manivannan.sadhasivam@linaro.org>
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

Add missing space between node name and braces to match the style.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index d73fc3983709..8ba6785038fa 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2409,7 +2409,7 @@ arch_timer: timer {
 			     <GIC_PPI 12 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
-	pcie0: pcie@1c00000{
+	pcie0: pcie@1c00000 {
 		compatible = "qcom,pcie-sa8775p";
 		reg = <0x0 0x01c00000 0x0 0x3000>,
 		      <0x0 0x40000000 0x0 0xf20>,
@@ -2509,7 +2509,7 @@ pcie0_phy: phy@1c04000 {
 		status = "disabled";
 	};
 
-	pcie1: pcie@1c10000{
+	pcie1: pcie@1c10000 {
 		compatible = "qcom,pcie-sa8775p";
 		reg = <0x0 0x01c10000 0x0 0x3000>,
 		      <0x0 0x60000000 0x0 0xf20>,
-- 
2.25.1

