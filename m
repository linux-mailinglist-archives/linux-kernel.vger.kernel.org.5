Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4A80C3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbjLKI6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjLKI6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:58:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C1ED
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:58:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c256ffdbcso44355345e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 00:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702285115; x=1702889915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SpisxyZzihYTPjv1pLEPT2hNSCW6cuMEDfk4Wh6CC1M=;
        b=KbrmN7txLD2ni/RCZeCED2KnhwXa9IWEWm8Ptj091i32+RWlwEUOpeIbuoZxvLUMrW
         tQkC27erMw66BOEpB01nXKn7EVWr6qs1RUeSn1TjqcXYnTUV5iGrHXPGPwiIz7E7kFYd
         unejKLbt3uPRl/cvR87WxJ983QCPjduIBnynO9VEIBdj6RdaRBIwnlNDz4xIOooxKHGp
         CWVKTmRnm0bRV32iGkjq9q0kNdsfwnlnJA4qDekSZ5kM01j6jJCIO/1a5zmHQUBktBEd
         TjG/dkmViv7kj3hOXRTZKjcRypz5Ne20dyS29dIxzREhAIrlopmeu0z+DXQ26UfkIHrL
         ZmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702285115; x=1702889915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpisxyZzihYTPjv1pLEPT2hNSCW6cuMEDfk4Wh6CC1M=;
        b=bGB7xR9WVxcNwMa0a5vv7bCuXZjobGtCEqIqiR9naXw00JulXn65bzzw0Hd0QQqxN5
         PLco+we/1hzuDjwLb0mHWlCBTghUo7IHGy5wk7zJyy8oqBRWUtXhRPViH8HC5gv14s7J
         XOxNPL75bXNhF41Yp8QP/8KSAy0TsGYRMrfjDnv+jHi+vAhjQ9rgCBAszrroPWu4K+/l
         4l7HRQUWyQwC+eWVRuthNOLFke7dAb3BF297RjL0712PzTbwWQ0cJneiS+sZyihTglm/
         WPEAL0YaGaPYi+bO1hpJd3xlLZtIsRnot3k6Il8SrIKaILQPtAxBDOASCaygO4IUltBL
         t/5Q==
X-Gm-Message-State: AOJu0YyvfiQb1H6nYoaQCUexCH8Dj5RcvKhOmTrL8WCHBOkv7rbFxQwg
        e0AB5utb+tAvOQX6rDWwCqSBuw==
X-Google-Smtp-Source: AGHT+IGV2CHR6ZiBuBPqMgS2ZcQxIppt7M0SysKy6s7Vo9oy6kyPIHprH07uyYWbFvJ0nkZtxIK0UA==
X-Received: by 2002:a05:600c:3ca5:b0:40c:4b3b:f2ac with SMTP id bg37-20020a05600c3ca500b0040c4b3bf2acmr187901wmb.127.1702285114830;
        Mon, 11 Dec 2023 00:58:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm12315067wmb.30.2023.12.11.00.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 00:58:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/3] ARM: dts: qcom: ipq4019: add dedicated SDHCI compatible
Date:   Mon, 11 Dec 2023 09:58:29 +0100
Message-Id: <20231211085830.25380-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
References: <20231211085830.25380-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dedicated compatible for the SDHCI MMC controller, because usage of
generic qcom,sdhci-msm-v4 compatible alone is deprecated.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
index 114c92b4d8d4..e838f2c1678d 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq4019.dtsi
@@ -224,7 +224,7 @@ vqmmc: regulator@1948000 {
 		};
 
 		sdhci: mmc@7824900 {
-			compatible = "qcom,sdhci-msm-v4";
+			compatible = "qcom,ipq4019-sdhci", "qcom,sdhci-msm-v4";
 			reg = <0x7824900 0x11c>, <0x7824000 0x800>;
 			reg-names = "hc", "core";
 			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.34.1

