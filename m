Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E961077722D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbjHJIJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjHJIJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9715610F5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:16 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9e6cc93d8so10202681fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654955; x=1692259755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ie4XHfXmLN17VpRpXqW8hX803ADkU00/SZ+VLSEgXo=;
        b=Hq+/takm7mG/JzYZdoPMLRzMncOo+pJwi3qya1XAGOY5caiL0xscmhVnPwNc1RPtVv
         dIhPLCCsYug4tXukVatgw4215Q3ijgiblxlRe93XGG1Qhyk036Vu4lRjkEdprhaLDt7X
         WQA7EMBaSQXV7M2owB3Cof4mO4BLSXfAVfu40Rj/VOnECqzDPsDuzITlxvd8tqwDCfch
         Q4P69/Az4N1BXhxdk004RIQfZALbKmKDyKVVJERWyCV563GqaaMWnU8f4Ql1VbIzZsRo
         4i4lL1wluHcQZSORRUoTDcwu3CG7D8qVJ8RQ79le1hx7MZ+h7S638SOs3GO+Mo7NBDjO
         Sj2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654955; x=1692259755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ie4XHfXmLN17VpRpXqW8hX803ADkU00/SZ+VLSEgXo=;
        b=QfQ94qfB42tTLYGRRzaSCB89KL6+f5KHUH4GbgHnQxV0AjqPtfSCQKB0DtoYdZVJuL
         IP6wJMok7PrgPfACYK9WG9rcbqAWFZfZZlPJdoAGV8ZC9h+qcO4VRxr2EZFIOt2I3gHc
         M/r3jcAGcVkXk7FL3MkbaUW5mYErfO6IzWnsVsLgtaB+WdxQ/pyCIqSIJmsIoay1iw86
         ktzTuJRvTZ7DbEOovnbxE2dKhdk0IQwxqrB+R1ZyWcREvmklslP3DKTdcD2S6DrfQfBu
         hgJb4jYEZDaB1z928x1k+KmMHnqTej5vDTocU6L0jIo/TdDPtXyReu/TsmIoBSmVpZn5
         j8tg==
X-Gm-Message-State: AOJu0YwqGQ7I342GIxAU3nMnocumEyu2lb6abXz9j2+Hh/IyEKUDcH6c
        DmVMf5JVDuqtkxCGGzBMKPr12g==
X-Google-Smtp-Source: AGHT+IGYachim5YZFTB4/OS81PMKVTpqicCYQY5WZZFI1VQQMvNmVJWHKT1resQUK5uwm5kf3VTtrg==
X-Received: by 2002:a2e:998c:0:b0:2b6:9f5d:e758 with SMTP id w12-20020a2e998c000000b002b69f5de758mr1333858lji.9.1691654954704;
        Thu, 10 Aug 2023 01:09:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:14 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 1/9] arm64: dts: qcom: sa8775p: add a node for the second serdes PHY
Date:   Thu, 10 Aug 2023 10:09:01 +0200
Message-Id: <20230810080909.6259-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the SerDes PHY used by EMAC1 on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 7b55cb701472..38d10af37ab0 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1846,6 +1846,15 @@ serdes0: phy@8901000 {
 			status = "disabled";
 		};
 
+		serdes1: phy@8902000 {
+			compatible = "qcom,sa8775p-dwmac-sgmii-phy";
+			reg = <0x0 0x08902000 0x0 0xe10>;
+			clocks = <&gcc GCC_SGMI_CLKREF_EN>;
+			clock-names = "sgmi_ref";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sa8775p-pdc", "qcom,pdc";
 			reg = <0x0 0x0b220000 0x0 0x30000>,
-- 
2.39.2

