Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB827AC2F7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 17:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjIWPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231840AbjIWPBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 11:01:04 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F571B4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:00:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40531812168so39773465e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 08:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695481256; x=1696086056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vA79xyD+PI0yTnhfaRji6jl5WeCnlojw8Sdf795ardQ=;
        b=pLAtZWi52lNZyMgkzyD21GM66S2r19aRkyd3N35MDulpauOp/VD0CooNRRub/dad5a
         ePg9+dY43b4gro1G/Y8byDc6KAvgZ/c+CBwF3z4kEKuGtt1ZqAW2qjGO6rLqgKqYEI/M
         f4NkLiG+BWgsVwEKr+dxe8pF7tCi/G5FN2JnqnJysNBzhhxr70Y+up2bb5mGlDOht14v
         lbI1e6J7f4FkvP//mUQ8LdA5Oo4zS7y7NIcGB6IGYmOXxk1UKIfJfzpQIpbHVE9F5MPU
         ru4M4+36osmGtZACLWP3M+vY7x0if0ikvUKdi0Ek+VOOsu8+Fnc5zxb6AahA2XWQQChP
         mYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695481256; x=1696086056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vA79xyD+PI0yTnhfaRji6jl5WeCnlojw8Sdf795ardQ=;
        b=wxgDk5Q5Pyoeprrcm+j+pcCpp4HLua7gsKQgvNP5rijIFunsmoLxVHUBoycNISvvmu
         tD6/KdgSMtV5Uj8pXrCWf7ugZdYyyaa9yTgDzKHTXv2rfRwKXRrQVNBZ2FhpZD+XDRAa
         yKiqhfwvo1w9t2vNkXij/m0M+cyVUHM+2SmCl7g/OpShf/olRbkoJn3lJaP6SsaFX43e
         7eSRZD4XSLBhH0GcTGXHmBVD5cWZgItEaXFCNEH0HfNdtEFfE0VecSOzz28LD1bYzG0Z
         3DJ0qBaIdjzaxYHL8ZhJ5XFps5483EsVNmYgQaAFGwsSSQslDEkASXCq62xObjOLfG7H
         DYzQ==
X-Gm-Message-State: AOJu0YyC2QNx2n11Er5IHloqeocS9GNPeJv/cSz/OZgVgbXcpeMqhDxz
        pceXOVaAhMy5PX1PBzRTqx9aVA==
X-Google-Smtp-Source: AGHT+IFer9fB1MpYho3IkwkJ6C0+JOEp2GkPhJjHoub4fFsQziH0jcjSVV8tvLVhn0zHn2yAw4294w==
X-Received: by 2002:a05:600c:2183:b0:3f9:b244:c294 with SMTP id e3-20020a05600c218300b003f9b244c294mr1856618wme.35.1695481256422;
        Sat, 23 Sep 2023 08:00:56 -0700 (PDT)
Received: from x13s-linux.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b004053a2138bfsm5787006wms.12.2023.09.23.08.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 08:00:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bryan.odonoghue@linaro.org
Subject: [PATCH 4/4] arm64: boot: dts: qcom: sc8280xp: Add in CAMCC for sc8280xp
Date:   Sat, 23 Sep 2023 16:00:45 +0100
Message-Id: <20230923150045.1068556-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
References: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in CAMCC for sc8280xp. The sc8280xp Camera Clock Controller looks
similar to most of the sdmX, smX and now scX controllers.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index cad59af7ccef..dad4894f358c 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -3450,6 +3450,21 @@ usb_1_role_switch: endpoint {
 			};
 		};
 
+		camcc: clock-controller@ad00000 {
+			compatible = "qcom,sc8280xp-camcc";
+			reg = <0 0x0ad00000 0 0x20000>;
+			clocks = <&gcc GCC_CAMERA_AHB_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>;
+			clock-names = "iface", "bi_tcxo", "bi_tcxo_ao", "sleep_clk";
+			power-domains = <&rpmhpd SC8280XP_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		mdss0: display-subsystem@ae00000 {
 			compatible = "qcom,sc8280xp-mdss";
 			reg = <0 0x0ae00000 0 0x1000>;
-- 
2.40.1

