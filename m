Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215BC81399F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 19:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572977AbjLNSOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 13:14:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573028AbjLNSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 13:13:51 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA4124
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:57 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-50bf4f97752so10900862e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 10:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702577635; x=1703182435; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KDl/5My1xLkJRpwqZFmnSzRYwMADfJleMVV/jfBPrF8=;
        b=CI+NnKSWadXCpuDa34yiX6u4IC1a2qIIsxtyPnBx7emBjTLvpawGgG9G9gC10H6QzA
         B2G2bk/0fjInNyqg5UAM5P4YlBy4rdnhAeJUvs7oHTCwmlLHRZIULiLEjOlRihWpd1ng
         iR/NHTEjuvsQzHoFrYC9QilIb9/6neytEekOpnLCIxuk3n7ujJlwujBqt1+hb+MpOi7S
         HYbD9HXblbYaRowYoaYWXs3bOQlKqEUuYjeHGWiINpwB6iSRlltRj4GKScK4PQquLSCJ
         1NRSZNnwQJP7JpOCGQ52ReyQHxnA/o6OyPAe1xmxJVMrk/HtpnNSIXzoI7jngPSms9gj
         Qhaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702577635; x=1703182435;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDl/5My1xLkJRpwqZFmnSzRYwMADfJleMVV/jfBPrF8=;
        b=XPy9s79xRSZpf/bTOpUAc2MYPD/jnPUNq5lPXSfw8xq3cVnzAfdUgUh5l1JcLWQbPw
         U4v86hgHqjyTCRkJwtXyclFcop/TnymtUPZRRWuDh5GOjYLqvCKrkGxR9YFzxwxtIBkX
         Ex4aWUx3DWu9MDCx/LY9gzwiot/+eZ8fX65/EiOHCu47pdCyh7WOfCPrDlIeiO4+Xgmq
         7mf5sG8ZNQ7BfH/nBOzo2cbeLd3Yf0Ggl59gnHwKLHrvckEZVMmrOGgX0fGdBAg/mUxc
         AQ3pAYCFrDnY5zUIJ/ETfFP5YF4war+pF+HMpbezr7MVNpsLX7/FpHDxVVL2L0VEsO0E
         C+tg==
X-Gm-Message-State: AOJu0Yzh6n7LgKQUHo+9IHkhK8IdQIL+LTtUZToTzdzGCypZmPh5K42P
        LoTIkXlAKEqsXJyHL5BEP8dGMg==
X-Google-Smtp-Source: AGHT+IFiqxfsAnPjpTM4RI3tV+Q1YP0UXWmiaY7vOr7muxEYy1b5pZbdq+7ZX1Mhwflskp6g/OyciA==
X-Received: by 2002:ac2:5399:0:b0:50b:f8da:23f2 with SMTP id g25-20020ac25399000000b0050bf8da23f2mr5190095lfh.135.1702577635312;
        Thu, 14 Dec 2023 10:13:55 -0800 (PST)
Received: from [127.0.1.1] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n11-20020a0565120acb00b0050be6038170sm1928838lfu.48.2023.12.14.10.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 10:13:55 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 14 Dec 2023 19:13:41 +0100
Subject: [PATCH 4/6] arm64: dts: qcom: sc8180x: Add interconnects to UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231214-topic-sc8180_fixes-v1-4-421904863006@linaro.org>
References: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
In-Reply-To: <20231214-topic-sc8180_fixes-v1-0-421904863006@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Gustave Monce <gustave.monce@outlook.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.13-dev-0438c
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure the required paths don't collapse, add interconnect properties
to the UFS controller.

Fixes: 8575f197b077 ("arm64: dts: qcom: Introduce the SC8180x platform")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index c970dfb11fe5..98fc3ec881a3 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/qcom,gcc-sc8180x.h>
 #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8180x.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -2112,6 +2113,12 @@ ufs_mem_hc: ufshc@1d84000 {
 
 			power-domains = <&gcc UFS_PHY_GDSC>;
 
+			interconnects = <&aggre1_noc MASTER_UFS_MEM QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI_CH0 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_AMPSS_M0 QCOM_ICC_TAG_ALWAYS
+					 &config_noc SLAVE_UFS_MEM_0_CFG QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
 			status = "disabled";
 		};
 

-- 
2.40.1

