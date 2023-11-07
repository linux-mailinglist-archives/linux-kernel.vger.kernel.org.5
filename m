Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4487E3635
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjKGIE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjKGIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:04:26 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E004311D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:04:23 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso10696459a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 00:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699344262; x=1699949062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Np5GiWxnhnJTIZmvQ42ZbLK3zb8qYqvzz1ywPLj5Fog=;
        b=QWY6apEL0iQsHJcGG64hBAJO3Oxo08r1ByNohT6zUW3ZH/OvvlKokal8FgoJsNm+cH
         yDraLGwI02O6OuZNYSzj6QV/+VVtbfAV/WkBFdFMbOkU899WtdTT84ffu1WkW/uRpyuI
         lrZF/bucgfSnTrGvFXxrZzhD3oisxdjsp6r8vR5386xw4/EoaGGQE7e3GJ/BjOBarhEP
         05ZG/UL9rJNnBfk971JME+6cUbNqJsFJmHWHBdhFIoxk2BmV/enrUqT3PmlvQ3GMqhI0
         qd0hh9hb+z8OoLg1MBrCza+hPZvZfw3jhj+56JHW1mmPMyz/r11DrDfYeV0Ia9sIZwIU
         QG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344262; x=1699949062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Np5GiWxnhnJTIZmvQ42ZbLK3zb8qYqvzz1ywPLj5Fog=;
        b=hsx6iu7A/nu6BFqgfih7SqxT/dtHJ4YnRDdpNTB1okZoq2t1Bvi/uC2k8MCU2g8GJd
         uPWqSgYfYVl4NWnlnrOTMSCzZ9pL1tK+kGLIZu2s07zDvAEzwPiQmcUg8+UWpiJri9H8
         AoxEidF0fUr1t4sxYJpqXbpvLfKsw6/Tqwc/TKwy57iuaFWw9cWt/caGG6Hl6QgLcESA
         F3mqqnQdxIhqPV42XxTifz6qYVX3YFmfe9fMvS09cyivsI04k2M3zZGVL+f9uftBIM3g
         TT10QiF9EhQaZf5c7LxVqZOkF6OaLnPEf7msIi0CxjGWZBCQMky0qI9Ypk5TpdrWw6ve
         8ZdA==
X-Gm-Message-State: AOJu0Yzx1SOeRjs/l6I3lv2jveuPaV6oVnUDYXHcm+4hUuE1ZhfE9dRl
        sr2nAcDhb+l2RosjbcAG4eaQ+JVfwN0MOL54b18=
X-Google-Smtp-Source: AGHT+IESPzRu8d3bmRhFVHYtA270mHLRaGxGZUe/OXqIPmru/RxNuH764q2aVss8Ii+r/uaIQ6HgCw==
X-Received: by 2002:a50:8701:0:b0:544:978f:bdd9 with SMTP id i1-20020a508701000000b00544978fbdd9mr1598889edb.12.1699344262487;
        Tue, 07 Nov 2023 00:04:22 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id r15-20020a50aacf000000b00544f8271b5fsm83449edc.8.2023.11.07.00.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:04:22 -0800 (PST)
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
Subject: [PATCH 2/2] arm64: dts: qcom: qdu1000-idp: drop unused LLCC multi-ch-bit-off
Date:   Tue,  7 Nov 2023 09:04:17 +0100
Message-Id: <20231107080417.16700-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107080417.16700-1-krzysztof.kozlowski@linaro.org>
References: <20231107080417.16700-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no "multi-ch-bit-off" property in LLCC, according to bindings
and Linux driver:

  qdu1000-idp.dtb: system-cache-controller@19200000: 'multi-ch-bit-off' does not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 618a101eb53a..89eff977d40e 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1450,7 +1450,6 @@ system-cache-controller@19200000 {
 			reg-names = "llcc0_base",
 				    "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
-			multi-ch-bit-off = <24 2>;
 		};
 	};
 
-- 
2.34.1

