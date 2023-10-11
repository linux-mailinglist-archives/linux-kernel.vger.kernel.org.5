Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50F57C53EB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235106AbjJKM1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346867AbjJKM0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:26:42 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3B1C6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:26:38 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c4e38483d2so4779601a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697027197; x=1697631997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fZoRzqsVsl2DrqFfH7FNxDnDstpZGeIPe8SX7WYfkY=;
        b=BRiYixYUwXm5nd8F+wdASbFcxhSe19jgFEUzbYtrmCYgpQQvTQJGtZ0zA+9/sQpl+S
         vsGfgzUDNnLwVxrM4d+s9HEpyhUOSO0800AwwzhEY1ubSZwfu1GqrHT9cHQ9yhAQxT8R
         elMWi7RLF5YZjGW944LIkfbU7OGi1hxXVdxD6EtJ/t6dA92f3AtidpeYEKdPvtLrLub1
         Dxlb/eYSEnEbmYOxeJsyYhagi+7ojYs+djTWAD36E8oi8EYtHYL/LzApw1Cz0TcDhji9
         ExF8mEveKqrDUWYjIRxPkyWf9GcKp1Lgh4p9OHuwRjGrAyeryMJ7aFCnpIpCB2Vc+hBf
         pp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697027197; x=1697631997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fZoRzqsVsl2DrqFfH7FNxDnDstpZGeIPe8SX7WYfkY=;
        b=hNGnz2TENZzUa9Lhy2Yz5fdS6fum1nwDuOOmoObLLyO5Q4B2HTKWxX0YIPahDAmI8b
         8SsKTQF4vggE7y56zKvgUHH2cdM1woSALrxEnUDJOMPO64pBP6nxCrPwNvAuELt/x3sE
         jAkM12I6ejAe8cDus7Xj4ob5aOXrTkWWJr1SGHtCTm9RBOKKfX6b9iMHxKu4qCrIFjQ1
         msnsoVcR7cr7hOApUWugI4g3llcF7I8TF9UMl4ZAZ41y26l36viC1waKB8oqJqD+3tOD
         M3vXkTWSq5ZDd0IAKLP7iuamwNN2/kNdejBthR7t4490DrUHz3SNvWPOMnMuZP1X7pe3
         OhWw==
X-Gm-Message-State: AOJu0Yx25er78qyn6GUDKq0/KH9Jh4KfjsHchM5L+NVnC76dsctyHRa0
        jsSekPKNh1wmHk8qVPGaGWQT
X-Google-Smtp-Source: AGHT+IFa0yvhN7AQvjsnG6e+CohV+PmJExi/ZTAbCRvLg3Beh0CTXHpZ8VW8tU2839fyo+eKaLQJaQ==
X-Received: by 2002:a05:6830:1459:b0:6b9:3f64:4e8c with SMTP id w25-20020a056830145900b006b93f644e8cmr23532966otp.9.1697027197534;
        Wed, 11 Oct 2023 05:26:37 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.180])
        by smtp.gmail.com with ESMTPSA id a19-20020aa78653000000b0068fb8080939sm9953620pfo.65.2023.10.11.05.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:26:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        linux-scsi@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 4/5] arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
Date:   Wed, 11 Oct 2023 17:55:42 +0530
Message-Id: <20231011122543.11922-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011122543.11922-1-manivannan.sadhasivam@linaro.org>
References: <20231011122543.11922-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

UFS host controller, when scaling gears, should choose appropriate
performance state of RPMh power domain controller along with clock
frequency. So let's add the OPP table support to specify both clock
frequency and RPMh performance states replacing the old "freq-table-hz"
property.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
[mani: Splitted pd change and used rpmhpd_opp_low_svs]
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 42 +++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 055ca80c0075..2ea6eb44953e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2605,22 +2605,44 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>,
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
-			freq-table-hz =
-				<50000000 200000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 150000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<75000000 300000000>;
+
+			operating-points-v2 = <&ufs_opp_table>;
 
 			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mem_noc SLAVE_EBI1 0>,
 					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
 			interconnect-names = "ufs-ddr", "cpu-ufs";
 
 			status = "disabled";
+
+			ufs_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-50000000 {
+					opp-hz = /bits/ 64 <50000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <37500000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <75000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-200000000 {
+					opp-hz = /bits/ 64 <200000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <150000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <300000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ufs_mem_phy: phy@1d87000 {
-- 
2.25.1

