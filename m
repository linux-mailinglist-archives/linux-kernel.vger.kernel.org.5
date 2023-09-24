Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29D57ACB64
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjIXSdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIXSdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:33:49 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B85E3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:33:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32172a50356so4787986f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695580422; x=1696185222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2YA6VGuZT/cSJot2FxC+vz9o1Sq5pRaeYXhHT3S/jE=;
        b=Q6SH87Vz7htzAdLWGIa8IpLsiYj9rg1b7ZQVNa6ynwQBWbZJb2Y6TBR2V3YaSY2twK
         aweV5ItOMnHJ9381Zofb4Du3+M3UlH2HYpey8hH4uAv6LVGJArSy3+xF2k8V4ubvfhSS
         kSuzqRtADiNlccBWop6sRpSHhsZQJPCyTTGXVIQMMz13wB0G+dzO+ET0nRCel5syTZt5
         Vf/TkU1eOFSp4uCEszobQ6LbKzWHSdF0dwJQpFj8NL12FKxLTIQ17/g+ehEioirblzqP
         QUHe6ETKjbdO9wwz08lJp2C9MQ+dQdnfZkyNW/lV5uSAYSSAgjgYnL+s+i0ylj3JkrwB
         GehQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695580422; x=1696185222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G2YA6VGuZT/cSJot2FxC+vz9o1Sq5pRaeYXhHT3S/jE=;
        b=Ls9gI680ojqgiCry6OFSeINW0UJEZUM0DfxZviPcGfXdVGETooeK0wrza2ztsjxnLe
         tbo3iH0TfcImyQyXqE+z9KYxoesuwPwEoN+cS93STpu7pYLyCbb1eHn3i3Dr4g5RzJLv
         ZHG3SjxnyywqLHmUC88FZ5j8p+fXF9OsEgSdkErv+xyYoUiA3v0RqfbROsHZ9eJsWyIo
         isdCFm+jkgSajDyyaUkemi9PocTFAjePXMbMocftsV9QiZWxGH3KdMm3jHLEu6Io75Fj
         Yc7vegRhRhq1DNxYBiLwiav2CT0ffaCoX2nxpZ5clz8XtRfUKA6yvRRyZWYwHy3Og2kT
         vz5Q==
X-Gm-Message-State: AOJu0YxjLkO5kUc0fDv25rplJAOXSZIRRnefe3OMVvae5g7eEi4rAxtV
        q5RexnCkb51h7A7ZuaUkYuk4Aw==
X-Google-Smtp-Source: AGHT+IHdN3UgAsFuA4CXCn5ra23ZJBcYiGcG7vszyEbV03U7f23hSKmo+MuXXCn5VJv0gDlZgE0D2Q==
X-Received: by 2002:a5d:5083:0:b0:31f:fb5d:96da with SMTP id a3-20020a5d5083000000b0031ffb5d96damr3652666wrt.64.1695580421752;
        Sun, 24 Sep 2023 11:33:41 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id k10-20020adfd22a000000b0032320a9b010sm1972148wrh.28.2023.09.24.11.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 11:33:41 -0700 (PDT)
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
Subject: [RESEND PATCH 2/2] ARM: dts: qcom: sdx65: fix SDHCI clocks order
Date:   Sun, 24 Sep 2023 20:33:35 +0200
Message-Id: <20230924183335.49961-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230924183335.49961-1-krzysztof.kozlowski@linaro.org>
References: <20230924183335.49961-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bindings expect clocks to be in different order:

  qcom-sdx65-mtp.dtb: mmc@8804000: clock-names:0: 'iface' was expected
  qcom-sdx65-mtp.dtb: mmc@8804000: clock-names:1: 'core' was expected

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx65.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
index 311fd01a4f9e..6d1bf0eeb139 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx65.dtsi
@@ -461,9 +461,9 @@ sdhc_1: mmc@8804000 {
 			interrupts = <GIC_SPI 210 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "hc_irq", "pwr_irq";
-			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
-				 <&gcc GCC_SDCC1_AHB_CLK>;
-			clock-names = "core", "iface";
+			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
+				 <&gcc GCC_SDCC1_APPS_CLK>;
+			clock-names = "iface", "core";
 			status = "disabled";
 		};
 
-- 
2.34.1

