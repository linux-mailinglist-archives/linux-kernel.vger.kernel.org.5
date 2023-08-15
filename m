Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A684977CDF4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 16:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbjHOOTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 10:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237567AbjHOOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 10:19:15 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9AB1989;
        Tue, 15 Aug 2023 07:19:14 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c1d03e124so672995166b.2;
        Tue, 15 Aug 2023 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692109153; x=1692713953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbxPwjT8x5u7zIuMPUNe2aimwgkFJxO3k4uTJwZgBjA=;
        b=se7QNAkYDV3GPEvxCiDX9Sm/lAe9TdH6WKOs3qyrrb1AxdQT3b7u/m09csKrM9NdUz
         Mq0AVfCIq66b8LT9GL/mOjB3Teiy+3w6t0xSH5Wq2QPkzapvfHm/7qSSwLhxd4Q6nvZx
         lwchPsDcau6ti05T0ngTGEcn2uCTYhDs6AuHTFn9i/x7UR3QsuNvvr/0kG0zcwS2HIE2
         rbOQ6glEl7DUq1OmRxaEhNFAQ5XK+hu1O5J+52NhoLzNrtLUuI6dAEStfSBxYAfM1ctp
         gUttARpaatspb9JZMoig+L8SBkYRS5br90Pu/C84GuwKodyEehjUe+TTITZwFuVHE8H/
         0ufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692109153; x=1692713953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gbxPwjT8x5u7zIuMPUNe2aimwgkFJxO3k4uTJwZgBjA=;
        b=i9kL1B2aB+WmbNKopakrOIKEgeGAtsOv+6m4oIWDi8oGlfS0QBT3OsVVU1liJOgI82
         IcdX+aGZ9haoglKZWdclUcPrLFNqj8veDrG2YiuwH4HQvbyNG+Jm/6SKW3vATkD4kOF/
         AJWTLC6Zb4Ld00PKGFscjan5cjN8RYsrMZDah3/kd4BCRj6UHATlCAoS7+WN1LvOcGZV
         WnfJlQBmP6F4jVgw2KArpyOb4/lLSQ8xQlH5ZvDUaMYczLe6PH7JWLBwOeXvJRz9c5SN
         yWihBcAJMBpzfzBPNaPkYNq2Esq2vQnHvL9wgI2Wiq8dQnnDyIvbi34GAIxiLYdxazux
         z8BQ==
X-Gm-Message-State: AOJu0Yyc29TFYlu7Jyu+IzRJG/2oCCnoe34K8SuDfBWL8BOdTFBWC+nJ
        JDygL0eCPdt0KzZcxF1/wTt3rG/UNnMScg==
X-Google-Smtp-Source: AGHT+IGWYtMxgvkHLBbgNs8+ORFbo/eGF2AelkQWKbuBVYLgTfDFpye106F2LaKPNb0Po11Qh0FCaA==
X-Received: by 2002:a17:907:2cd4:b0:991:c842:2ca2 with SMTP id hg20-20020a1709072cd400b00991c8422ca2mr9359758ejc.15.1692109152778;
        Tue, 15 Aug 2023 07:19:12 -0700 (PDT)
Received: from fedora.. (dh207-96-14.xnet.hr. [88.207.96.14])
        by smtp.googlemail.com with ESMTPSA id j15-20020a170906278f00b009926928d486sm7078743ejc.35.2023.08.15.07.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 07:19:12 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: ipq5018: add WDT
Date:   Tue, 15 Aug 2023 16:17:51 +0200
Message-ID: <20230815141908.1084893-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815141908.1084893-1-robimarko@gmail.com>
References: <20230815141908.1084893-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required DT node for WDT operation.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 3285c86824cf..168322bfb11c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -182,6 +182,13 @@ v2m1: v2m@1000 {
 			};
 		};
 
+		watchdog: watchdog@b017000 {
+			compatible = "qcom,apss-wdt-ipq5018", "qcom,kpss-wdt";
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			reg = <0x0b017000 0x40>;
+			clocks = <&sleep_clk>;
+		};
+
 		timer@b120000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0b120000 0x1000>;
-- 
2.41.0

