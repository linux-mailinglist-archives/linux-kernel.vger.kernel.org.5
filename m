Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF87F7CAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjKXSRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:17:16 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919EB1BDD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:17:23 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-359d796abd6so7685775ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700849843; x=1701454643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tp7fD3jlV/6F46fUFoF/9D+88c9HNYfiQpt93xcwl4k=;
        b=oVRMlGNX+DaJ7+n4Lri6vDn4PsuJDSoJ/MAsglsZb5zerw2SVxp4EuR+ApjeZ3kcpA
         x2Haaprxts2MfameXInDPXSDSF+KadI+p2bOz4sxDWpMDeGSDmmhNQ6pqot830aodC72
         Lwb3l+CXdC6kMe98mtMCRMpfY3Rt3qRq9EnUeMJyshbW92Gw/ST9NFnBme91j23MeB9Q
         1rqyQtWEJBZ2YM3kROpHgViHbMFJqG1kKuoh8HMyvJEEGRZzDOj6nK8Rk6ajcHBdbs6e
         XGxaPT4HU9uv1vjlGAlIO+COlpbf8weJ0IKX2TToLn9DW2iZqWN1qVDPRfFmG04FQwNJ
         YDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700849843; x=1701454643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tp7fD3jlV/6F46fUFoF/9D+88c9HNYfiQpt93xcwl4k=;
        b=M5M1qc75YrRF7nfEFFjYv59O82XFBps9kVToOmBSEipgb5JT2sG6VPOSnJZtxnKKZc
         FvTrD+vmB3Z2GpKkouaTXnxgPEc6+u6VqlciGwwP3qnwEwagReD6Imxgp+KabUCAe3yf
         CkxR2/0b+hFksGKPXddnyTz+MNY6AZ/4cUQxPDne8E0gmpsbuS6veie+pNLBq7IGQk1i
         0KeCZrpIXn/gqE/TprbFmM11quRmgCwTi5u6GG3F6ATuOazXy4EkKP3zR6GIgbX1OzBA
         dCoLiLt3rtGTw0Br8XCsvHKm0UJ42vfSkQtL5J5uskcTJvOx/uUUDOtu1rfJvXkBbkMP
         O+mw==
X-Gm-Message-State: AOJu0Ywotp1F8IhnmQeIyNRVnZHPB72Sl7flwlf76LMfI+RnLzt/oppX
        8jrQBK6bJiyfQwS1G3Sci5ro1A==
X-Google-Smtp-Source: AGHT+IE0SEY3bBNErebJtlWLkaiO2fbuTA0XUbvSq+EA021neFWDA20xaC5wf9UNknQJxXVRytecgQ==
X-Received: by 2002:a05:6e02:1d8c:b0:35c:2ffa:4525 with SMTP id h12-20020a056e021d8c00b0035c2ffa4525mr6320284ila.4.1700849842935;
        Fri, 24 Nov 2023 10:17:22 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id et21-20020a0566382a1500b004665cf3e94dsm937031jab.2.2023.11.24.10.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 10:17:22 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, agross@kernel.org
Cc:     mka@chromium.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm8550: add IPA information
Date:   Fri, 24 Nov 2023 12:17:17 -0600
Message-Id: <20231124181718.915208-2-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124181718.915208-1-elder@linaro.org>
References: <20231124181718.915208-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IPA-related nodes and definitions to "sm8550.dtsi", which uses
IPA v5.5.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 39 ++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 7bafb3d88d69b..4d28150c985b5 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -1995,6 +1995,45 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		ipa: ipa@3f40000 {
+			compatible = "qcom,sm8550-ipa";
+
+			iommus = <&apps_smmu 0x4a0 0x0>,
+				 <&apps_smmu 0x4a2 0x0>;
+			reg = <0 0x3f40000 0 0x10000>,
+			      <0 0x3f50000 0 0x5000>,
+			      <0 0x3e04000 0 0xfc000>;
+			reg-names = "ipa-reg",
+				    "ipa-shared",
+				    "gsi";
+
+			interrupts-extended = <&intc GIC_SPI 654 IRQ_TYPE_EDGE_RISING>,
+					      <&intc GIC_SPI 432 IRQ_TYPE_LEVEL_HIGH>,
+					      <&ipa_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&ipa_smp2p_in 1 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "ipa",
+					  "gsi",
+					  "ipa-clock-query",
+					  "ipa-setup-ready";
+
+			clocks = <&rpmhcc RPMH_IPA_CLK>;
+			clock-names = "core";
+
+			interconnects = <&aggre2_noc MASTER_IPA 0 &mc_virt SLAVE_EBI1 0>,
+					<&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_IPA_CFG 0>;
+			interconnect-names = "memory",
+					     "config";
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&ipa_smp2p_out 0>,
+					   <&ipa_smp2p_out 1>;
+			qcom,smem-state-names = "ipa-clock-enabled-valid",
+						"ipa-clock-enabled";
+
+			status = "disabled";
+		};
+
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8550-mpss-pas";
 			reg = <0x0 0x04080000 0x0 0x4040>;
-- 
2.34.1

