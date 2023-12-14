Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD0E812B46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235675AbjLNJMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbjLNJL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:11:59 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92CB10F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:05 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5cbcfdeaff3so78947807b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545125; x=1703149925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9loaHfrne3H3i5jJvNSoB5V0DmyPKqbag1DqqG2m2L0=;
        b=YtIzLFp3ka6zvX5MZ7z4FKYBimoBFHmxXZy3pOlX+O1POaXCRmbbEULAlqRb7nbBaj
         Lg/hPPbQ6jIhVSX73KZ3vcVGdh+8X8iPi7OZB8yHj4WBpbaPnRcxZSUXybzeIqeHLwhX
         eYlrZ1TTw4l/7qqIHSLaZe35om4skdg3lDKt3pJ5IIO0eSZtzaIWZBg05TdGZywqyv9R
         lQwWupBAOrMWfASmtF2HOqyRi4lzdVDAvc1oRZgzwafWS5je8+scRjG9vOydvCIhMkKc
         CO3Jg1+8C4VLL/Wu3+U/ckYevW/D4ttLG++Qy6lzmNuvHe7wqWBaYqVwcNmmt9OA33Ld
         /iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545125; x=1703149925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9loaHfrne3H3i5jJvNSoB5V0DmyPKqbag1DqqG2m2L0=;
        b=pb4jTSi/cyzirH8IjBf6vG0jw6xM1iBnKpjeiWAa74/pPFbDUAibBIrW29GJgD/GKQ
         vy2N074S70iPgvj/L+6tR+6YQmS3ldcy7r6NGAX0P+drP1NspC78SY/4sVKcN6pE+UGO
         WnoyKdXfeTGovz5r0ZThWKJfSxVr5aB1ps0IHRUJ/p1j32RhzrUG3QCesCYZBxu9ibAG
         AFjRvYATZZ5F1ZrFa/nMFUeH56CA5h0vOfhSwRFecgMV5+gfHU/emuu2F6kW+ycs9/Ny
         kOIVvAmo6ljn0wdhObhF/EScB82MLt6YXao47uJuyszcccDLt7Dl4kyOM/50Y0p7c+aW
         xWCw==
X-Gm-Message-State: AOJu0Yy2NT9Gm7LImLi9ly8SsqBlGwGwfVazUZAaAZgZq/YwOwkhgUJh
        tAj2cwLFqgftTj821E6zKQJp
X-Google-Smtp-Source: AGHT+IGFrvj76C9g7DF6q0IKJE1RWepK4pib253K6Tv9NO1veFIB+KJjqnqPmgkzLZ2ovJOm1w1gxQ==
X-Received: by 2002:a05:690c:91:b0:5df:4992:d724 with SMTP id be17-20020a05690c009100b005df4992d724mr7706528ywb.41.1702545124893;
        Thu, 14 Dec 2023 01:12:04 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:12:04 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 08/16] arm64: dts: qcom: sm6115: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:53 +0530
Message-Id: <20231214091101.45713-9-manivannan.sadhasivam@linaro.org>
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

QMP PHY used in SM6115 requires 3 clocks:

* ref - 19.2MHz reference clock from RPM
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

Fixes: 97e563bf5ba1 ("arm64: dts: qcom: sm6115: Add basic soc dtsi")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 839c60351240..40394c412fdf 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1033,8 +1033,12 @@ ufs_mem_phy: phy@4807000 {
 			#size-cells = <2>;
 			ranges;
 
-			clocks = <&gcc GCC_UFS_CLKREF_CLK>, <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
-			clock-names = "ref", "ref_aux";
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_CLKREF_CLK>;
+			clock-names = "ref",
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1

