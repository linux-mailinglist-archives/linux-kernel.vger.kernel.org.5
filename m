Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B32E8812B67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235730AbjLNJMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:12:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbjLNJMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:12:46 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA1E12E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:52 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77f48aef0a5so279010885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545172; x=1703149972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90h9raFSlwYqtZtEwRi3utD1Y8btrpvvb6rt2ijbFWY=;
        b=oBUfICXIt6FQlFyXmmLGXvyZUfztr89Kd74kAKtimFIFE4LLA0VKtz7+1Pl3X6QK9U
         +ioY7JTNSOyL4XYB/ecfoJPKv7cDazqWkqR48Kh8fmiOG2ccX6swHbG2rEA1bxXKXmyH
         Nd2xS4RPD2h5pgvkAlrX8DYZTmwMva4JgtKflvlU9rkr5xjNtkArmt7Fvhz0kjHP2+BO
         qCHtwC+YBeSzO2qow1anvOqXka1LefVbUJps4+H7NB2pbLLI4yrtIFUq5XTmv0H06GuU
         uGagyO+fv4kKI8paCdit2TOp5JttL+u3H01ud5QKX6isBzwJNhXJZSXGIIrz4G6CtYeF
         hA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545172; x=1703149972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90h9raFSlwYqtZtEwRi3utD1Y8btrpvvb6rt2ijbFWY=;
        b=tNclSmjduhrJBYJMB0XEr2tal1FohPjecN5ZFHdRFAWtZLAL1c4nYGbPhAvZc9Jmbc
         0HLzWspbjfqmttTscWFU5UEWNKTPY09lgMxEViCdZPTA12DInDGGGahTWUXItnK2qupG
         mgKeCmtrVV9N/HUbPCZvMj7IzKSJBhAfBXcUjfCpfzR9SUhA82LeW1ivnduYLyup9fQ9
         QDt0QeR7Z+5cxsqpIwBGwY1Q6pb9y4WlMnvpTl7baJ/3y5Z6xUZNlIpf0UA2uL2cKnzr
         jruW1rgJtf8GqFCz9i9c3CLfYQ9qf+x5QhH30HivRodzcEuDF3Iam8MDF/V5VOvNyQ3b
         9cCw==
X-Gm-Message-State: AOJu0Yw3Awe64PWc6Xt5cozFjEikJWnB9cEFYldDdfAuy5XGmpWnb7Nb
        TLqvJGPgwhRMUj2W6K7ongzc
X-Google-Smtp-Source: AGHT+IEGFG/+5WBdW+QF3Y2B4MEmKQm1lHv2/KY/sKl8G6B/VvdbDTPntO5+kmWw7bf4yF46kQC8FA==
X-Received: by 2002:a05:620a:956:b0:77e:fba3:a7af with SMTP id w22-20020a05620a095600b0077efba3a7afmr6304092qkw.141.1702545171754;
        Thu, 14 Dec 2023 01:12:51 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:12:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 16/16] arm64: dts: qcom: sm8550: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:41:01 +0530
Message-Id: <20231214091101.45713-17-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
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

QMP PHY used in SM8550 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from TCSR

Fixes: 35cf1aaab169 ("arm64: dts: qcom: sm8550: Add UFS host controller and phy nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index baa8540868a4..386ffd0d72c4 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1891,9 +1891,12 @@ crypto: crypto@1dfa000 {
 		ufs_mem_phy: phy@1d80000 {
 			compatible = "qcom,sm8550-qmp-ufs-phy";
 			reg = <0x0 0x01d80000 0x0 0x2000>;
-			clocks = <&tcsr TCSR_UFS_CLKREF_EN>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
-			clock-names = "ref", "ref_aux";
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&tcsr TCSR_UFS_CLKREF_EN>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			power-domains = <&gcc UFS_MEM_PHY_GDSC>;
 
-- 
2.25.1

