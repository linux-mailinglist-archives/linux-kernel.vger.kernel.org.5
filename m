Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A7C7E3633
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjKGIE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKGIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:04:26 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A15114
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 00:04:22 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso9172002a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 00:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699344261; x=1699949061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FB2VcHLhZHHgGwi+MjMB7tS8or/xAoujhJnXOAckqMM=;
        b=Qj8lAp25lG2Fgruy+JQzNjY1Rw/Aw1lgJVFC9UAYSuW2JGm0ONQskmFDg3qirVJwQF
         dN5IyV8IJXkWrB/wJkn0JWydMx9uR93wsE4hXmqAkgmmmgBpBcySZWVOccg6DWYgXBCv
         g0h3He2wU8MZqWV6XICIpHDftCf85oYSTCaZqL6nmLS6tRxENidR73DOca0oMGOUmQD2
         o2aM0ixzzWMqpLUxGockJfVx3Fj7vgDfY5XTmCnwzROoxTWdrvzqDiSEw2OSl3Bizk2l
         1eu5mlKSEibuAVIjLUiUcQ6+xR3hwHqVQbmmttG2Xjrw4oEBLM5iZlvt2W2a7kdPwTGb
         O0lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699344261; x=1699949061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FB2VcHLhZHHgGwi+MjMB7tS8or/xAoujhJnXOAckqMM=;
        b=A4gt12AC+VNV/jj14D9wKiZr+GhRwHcbnVWtATw+q8WmRbaUnvQ6NbdeSA8YC9JYgf
         VC4Uj8btHK4KNwRmHfo2F5tVYJ5UPQnUMR1ESHwr4QduiRa9HbM1weHhhuH8W99Var7E
         SDM3YgdRkhHEy+zjDVm/tNIgxjbrCXKbZZNK8scV3jH4YyN0lnCdJ8EVsJCXRO/Ze4Ds
         UA3WS5Q5u6/lwSbHOVfz+YjtzA6TYJyZA6weeRQd0Hqr8Mapu9IlRUXrmVa8O0qD0iSe
         CVOLZeDkmujpISYdZaCM0nwucuXIUCjbtMC1HiItgEfdQRE47lRPqsXJe2Rsi2AmiFWV
         LhOQ==
X-Gm-Message-State: AOJu0Yw9wG4MZanjDbOp2SVL9C6WFqITlMhToHOMLiXCToSAp/JdYHX2
        Qdf56KUWTIpfeWy13FniOUYp/w==
X-Google-Smtp-Source: AGHT+IFR+aJYWXhyvAFvm5RFoCOIyUrphvM/LPTdFXLLozBi7vigz5t/WcftOptI9fK95JruMkvELg==
X-Received: by 2002:a05:6402:520d:b0:53b:3225:93c2 with SMTP id s13-20020a056402520d00b0053b322593c2mr32412780edd.8.1699344261228;
        Tue, 07 Nov 2023 00:04:21 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id r15-20020a50aacf000000b00544f8271b5fsm83449edc.8.2023.11.07.00.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 00:04:20 -0800 (PST)
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
Subject: [PATCH 1/2] arm64: dts: qcom: qdu1000: correct LLCC reg entries
Date:   Tue,  7 Nov 2023 09:04:16 +0100
Message-Id: <20231107080417.16700-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

According to bindings and Linux driver there is no
"multi_channel_register" address space for LLCC.  The first "reg" entry
is supposed to be llcc0_base since commit 43aa006e074c ("dt-bindings:
arm: msm: Fix register regions used for LLCC banks"):

  qdu1000-idp.dtb: system-cache-controller@19200000: reg: [[0, 421527552, 0, 14155776], [0, 438304768, 0, 524288], [0, 572293416, 0, 4]] is too long
  qdu1000-idp.dtb: system-cache-controller@19200000: reg-names:0: 'llcc0_base' was expected
  qdu1000-idp.dtb: system-cache-controller@19200000: reg-names: ['llcc_base', 'llcc_broadcast_base', 'multi_channel_register'] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qdu1000.dtsi | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
index 1c0e5d271e91..618a101eb53a 100644
--- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
+++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
@@ -1446,11 +1446,9 @@ gem_noc: interconnect@19100000 {
 		system-cache-controller@19200000 {
 			compatible = "qcom,qdu1000-llcc";
 			reg = <0 0x19200000 0 0xd80000>,
-			      <0 0x1a200000 0 0x80000>,
-			      <0 0x221c8128 0 0x4>;
-			reg-names = "llcc_base",
-				    "llcc_broadcast_base",
-				    "multi_channel_register";
+			      <0 0x1a200000 0 0x80000>;
+			reg-names = "llcc0_base",
+				    "llcc_broadcast_base";
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 			multi-ch-bit-off = <24 2>;
 		};
-- 
2.34.1

