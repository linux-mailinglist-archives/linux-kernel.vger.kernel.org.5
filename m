Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D84377E0E9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244903AbjHPLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244891AbjHPLwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:52:05 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D7B212B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:51:59 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fe2048c910so59419295e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 04:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692186718; x=1692791518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=42aTomtEutSZIoTJca8uXgd74cE218R8+M1C+k9J/YQ=;
        b=UfaJ2N0cFaOEM0KK+0csd3LOq0jyps3FdTDKnYJev6q7dwoa1+c6EgHtJLQCsA7tsU
         FDuiuXDxHOkFIKJFBvSe5jC7iWfgEspVHczRqaH+YZmEb57uhMHWRAtg52PP3MwCbfo+
         RCQbDtqpaAqTI5si08BCI4mR2oN5EJxSGKS8b7kqP2i5wIy23ahW92dAgox+88eUT1HW
         qTLe2fj7p0c5B9kmhkOvs+lJBE8Q4kS6/zbaI/uba1Q7mC+jsJQHJZaoomSPgeWEkKqu
         t3S0t2q3lAacxRpIadhd7LCBIJ+Ix2YD6ss/7mQdlVY9ck7KUTDxYvDKrlNSQE7h5zaM
         qXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692186718; x=1692791518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=42aTomtEutSZIoTJca8uXgd74cE218R8+M1C+k9J/YQ=;
        b=QExjq2wWVdohnnvvyAgQeltlqHce/N2z9/+lun6FN2/hbJSHtfMKiRYa4vNOoLeruy
         VMe77QRVduajc1bFT2PhaNbic9hoe8Yn3JRTBD7GGPqnWkUBayBWdeI1nDSoO93f9Wyn
         IMwbVHfC5nM0ybVTD5rEPm3wz1AbesVj2NuNkw+JkFsaN/IoEDS/BTPfm2CClPJv8w0Z
         pHGBeCN8KxwMgCftdtoxYSaENaVEzziK9eBbaZ1zZJJbsyTrLN96fYUzR9kYGWv1lSqK
         7owm7vSBvA693qrCenfa4Kd92yqFgM71oREPVg5wSTSECmeuHPFbrT1B/Gy7yqHO4asG
         Z0gg==
X-Gm-Message-State: AOJu0Yy3MYSG2DEJgqLppaLTev/9PzhfkhdIqq80Mn0vWm9muCEi/GID
        cH5e8G675LG9HBvolZtpXVV3GA==
X-Google-Smtp-Source: AGHT+IG0sVz2Z6BjXqDENCNlr1OVyPr1X6oLg8Jm7OPxZBFr63UolJSUDfe5UeEAH3Pt5ZTy0/cgMQ==
X-Received: by 2002:a1c:f707:0:b0:3fe:15f0:dfbc with SMTP id v7-20020a1cf707000000b003fe15f0dfbcmr1385194wmh.12.1692186718075;
        Wed, 16 Aug 2023 04:51:58 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id fk3-20020a05600c0cc300b003fc05b89e5bsm21280663wmb.34.2023.08.16.04.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 04:51:57 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        sboyd@kernel.org, luca.weiss@fairphone.com
Cc:     bryan.odonoghue@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/7] arm64: dts: qcom: pm8150b: Add a TCPM description
Date:   Wed, 16 Aug 2023 12:51:47 +0100
Message-ID: <20230816115151.501736-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816115151.501736-1-bryan.odonoghue@linaro.org>
References: <20230816115151.501736-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type-C port management functionality lives inside of the PMIC block on
pm8150b.

The Type-C port management logic controls orientation detection, vbus/vconn
sense and to send/receive Type-C Power Domain messages.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8150b.dtsi | 40 +++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 66752cc063d60..136e5f96a3d53 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -59,6 +59,46 @@ pm8150b_vbus: usb-vbus-regulator@1100 {
 			reg = <0x1100>;
 		};
 
+		pm8150b_typec: typec@1500 {
+			compatible = "qcom,pm8150b-typec";
+			status = "disabled";
+			reg = <0x1500>,
+			      <0x1700>;
+			interrupts = <0x2 0x15 0x00 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x15 0x01 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x15 0x02 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x15 0x03 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x15 0x04 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x15 0x05 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x15 0x06 IRQ_TYPE_EDGE_BOTH>,
+				     <0x2 0x15 0x07 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x17 0x00 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x17 0x01 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x17 0x02 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x17 0x03 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x17 0x04 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x17 0x05 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x17 0x06 IRQ_TYPE_EDGE_RISING>,
+				     <0x2 0x17 0x07 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "or-rid-detect-change",
+					  "vpd-detect",
+					  "cc-state-change",
+					  "vconn-oc",
+					  "vbus-change",
+					  "attach-detach",
+					  "legacy-cable-detect",
+					  "try-snk-src-detect",
+					  "sig-tx",
+					  "sig-rx",
+					  "msg-tx",
+					  "msg-rx",
+					  "msg-tx-failed",
+					  "msg-tx-discarded",
+					  "msg-rx-discarded",
+					  "fr-swap";
+			vdd-vbus-supply = <&pm8150b_vbus>;
+		};
+
 		pm8150b_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
-- 
2.41.0

