Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1F280EDA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 14:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346527AbjLLNbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 08:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbjLLNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 08:31:45 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B32ED
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:31:47 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a00f67f120aso741169866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 05:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702387906; x=1702992706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fzt8RX1Ws07cAJckt2n2AWAh//EFivzd7IWb/0bHK4A=;
        b=l2m4WXGl1jxkqRXU7VZg7Q3r2Wz9H7vGhcwXXDK9Dosq+0TcJB3VcgwOkPdBHByOiD
         rbwnJ5Wr1HhzhudWVIUFX8yY5aoXrzAQAanzBet5LI8KxyJIAkwH8BSEhgZmGMevLUIR
         HFd78EI0aBrwsKl27cBtFsU6P0TrGnG9ahE8iiqmlrInyONcIcX0swmKoszhBVRaiafU
         mzOwcDwQQYaFBuNfd5AEFsEcm/h22fDVl3F8+TU4ETVDrfGFYXoK4ng2DYLZ5EeLqR1r
         z4ZXrbxQJso6ijOedwtN/IaX8e1g/SYM6J6RYaQzjQBY5xbrslbNO4jv/Q+/f22v/Xmt
         mCWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387906; x=1702992706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fzt8RX1Ws07cAJckt2n2AWAh//EFivzd7IWb/0bHK4A=;
        b=J9KvhAaiJZo1ZejxNpmQmElPaOGpILPR34RaW82IfS485e0rdYHp9zupGRUqKrnse9
         Wj1KD8NS5Umum7Uqy4usN4yS8cp6RPjjBMdnaadjA5S98B9Ea+5/peeOWHFBSEzUyUsp
         UDlNb5GCTaTQM6NIpqamymSNMLM84vwHPPjQkHSgkMM545PsdNhdNLgmCD24Wd81ltDd
         ClqodQbNnsD7OInrFgLVwpX6VmtlqtKKLByB0vEr7WnU+W4cDPf8TMmAstT7Hyk0X7Oh
         L/TrPZaVjRQimKnMJI4TOULr8e5F90lAg/pWDFksHTBVeu6EDJK33L9ViV6i0luCeAhE
         vXBw==
X-Gm-Message-State: AOJu0YxXLyuItm5CgT1CN3wnIE7EIw+XTSkKpYgVPY/vgbfBgCD58Wgt
        EYnqXV/6Tr+5SkeGcHaBEgYNoA==
X-Google-Smtp-Source: AGHT+IEP8WCwq/kmQqr/nuMHsHM2LlMha+dw916naYx13uzD1feAB00wBX3EKf6MLb6o6Yv1E7jOtQ==
X-Received: by 2002:a17:906:1053:b0:a19:a19b:560a with SMTP id j19-20020a170906105300b00a19a19b560amr2496624ejj.154.1702387906137;
        Tue, 12 Dec 2023 05:31:46 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id vw12-20020a170907a70c00b00a1c904675cfsm6228811ejc.29.2023.12.12.05.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:31:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sm8650: drop unneeded assigned-clocks from WSA macro
Date:   Tue, 12 Dec 2023 14:31:43 +0100
Message-Id: <20231212133143.100575-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Review of v1 patch resulting in commit 58872a54e4a8 ("arm64: dts: qcom:
sm8650: add ADSP audio codec macros") pointed to remove unneeded
assigned-clock-rates from macro codecs.  One assignment was left in WSA
macro codec, so drop it now as it is redundant: these clocks have fixed
19.2 MHz frequency.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 425e1e50d945..3d55d08649ca 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2773,9 +2773,6 @@ lpass_wsamacro: codec@6b00000 {
 				      "dcodec",
 				      "fsgen";
 
-			assigned-clocks = <&q6prmcc LPASS_CLK_ID_WSA_CORE_TX_MCLK LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
-			assigned-clock-rates = <19200000>;
-
 			#clock-cells = <0>;
 			clock-output-names = "mclk";
 			#sound-dai-cells = <1>;
-- 
2.34.1

