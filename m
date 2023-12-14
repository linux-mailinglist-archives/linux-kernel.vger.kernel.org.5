Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB77E812B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbjLNJLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjLNJLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:11:42 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF09118
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:48 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-77f642b9a22so33491085a.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545107; x=1703149907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzU01i6st7Fo+4S1d9zRuY0iUyHKgjsO1CA7YDVBW60=;
        b=hs+3XCUG91TtyWDgWFGL2+8RfdBPJMyG/im0ziLmIXbd6z0agzkLGx1xEwvlGxQwNe
         w87pjLm5uj5eJc6b18TqwuwHgym7Q4syuqtjbKa9M99r3iOMdCjYjq4hUSU10ppHzu8X
         WHZ89/dUhGYxKek/BxJfCgBNjoSuuRAWo+exYo9mNLCnMO3MN58bfFbsaSCk3CT1Nnw+
         bdiOSN/5Dwcwrgn+kR8+O14zbRACh2LsbD9dw8wy11aOk/5V1xYeV1oZsdMpUJIGDuPq
         4Z3PesuUlGG3QWDDt97GzxQjCnYqBh+if1oiBT6LqkeheDbsy8cEOpMq1QaqBGegEEtv
         8zJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545107; x=1703149907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KzU01i6st7Fo+4S1d9zRuY0iUyHKgjsO1CA7YDVBW60=;
        b=NITx+A31FUAWT+9/tWhYwU8/hNR+QR4DEtTghJtLz2mGJZZNvraNABqiEqzHNM2CAG
         CErVTZ61etPxE3tPdcT7LB5qRSX8ZGIDyaShr/BegyIWGdbd+k8TY7Y8Vn0zF/0fXbKr
         92Da3fzwohIgQyBAj4w71Twe/npUuTlzmp+yxQSNfYR+88BXchGlJ76lrYAquatByFbZ
         X3eNE1QBWz76g6J/smJlVMLGPYJtjpf77GnYKpwFhfLw6DVpWuACGOtOqEHEjxFn81tD
         Yu3sojbPpDozNmzI0PFeax61kHXArq8pdHcIvqheTHrsaRg5k25PdOB9u5FIzkOJT9X6
         1Bvw==
X-Gm-Message-State: AOJu0Ywtl/jnPG+m7hLw92kVBcwC7ao22HXVXqra/1y/Dxd+7LyHIaZE
        0ftBZsFo7x7GDw1k8QJ64UpIIsnbiP2SJGLnnw==
X-Google-Smtp-Source: AGHT+IHt2uvwSeovh51fDULXRLbHd6A/TplrDLayAqqLdOB2HDbSO4NgNckuHMbr0eqUuRBeW5jSOg==
X-Received: by 2002:a05:620a:6007:b0:77f:2f54:f990 with SMTP id dw7-20020a05620a600700b0077f2f54f990mr14664887qkb.67.1702545107292;
        Thu, 14 Dec 2023 01:11:47 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:11:46 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 05/16] arm64: dts: qcom: msm8996: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:50 +0530
Message-Id: <20231214091101.45713-6-manivannan.sadhasivam@linaro.org>
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

QMP PHY used in MSM8996 requires 2 clocks:

* ref - 19.2MHz reference clock from RPM
* qref - QREF clock from GCC

Fixes: 27520210e881 ("arm64: dts: qcom: msm8996: Use generic QMP driver for UFS")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 6ba9da9e6a8b..b235f1d651aa 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -2105,8 +2105,8 @@ ufsphy: phy@627000 {
 			#size-cells = <1>;
 			ranges;
 
-			clocks = <&gcc GCC_UFS_CLKREF_CLK>;
-			clock-names = "ref";
+			clocks = <&rpmcc RPM_SMD_LN_BB_CLK>, <&gcc GCC_UFS_CLKREF_CLK>;
+			clock-names = "ref", "qref";
 
 			resets = <&ufshc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1

