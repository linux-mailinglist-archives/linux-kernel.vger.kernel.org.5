Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01FD7C74B5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441845AbjJLRYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 13:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379603AbjJLRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863BD7C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:22:15 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c5bf7871dcso10272115ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697131335; x=1697736135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTqO3Bk11vaIqEHJBs3qluSIAGA/bXfT2WWIycF5MX0=;
        b=Ypm5MxoRlXX9f7mCHOefZOqRIKyxdUePqgNXMCbQVqEVPvMsVcTq69nDfbSYeQZIY6
         8Dqo01BWaAOS+/YUhgtlkKL8LACG58nFU+YdpQVKmcnuKF0/d5If2o+zwdqjZrlTuImx
         zL8hx4I3138kHH9IHAZVRcs/8kwwlHTOax655J2VW9MEhv3bMSDBNBxho0a4Xz/ycmbe
         Xm30E7Cmc3bN4bpA6I3s0ovjjtD3NI1Zl3bCqo/XarbmlNg13PW3hFb0Ych8a3XVtEfj
         E40YMD0B3p98FKDYuCmIvt2juH8FN+XbeXETEryiVYkteUQ2HtmU/+3j1dK7lrHbH3LM
         A7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131335; x=1697736135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTqO3Bk11vaIqEHJBs3qluSIAGA/bXfT2WWIycF5MX0=;
        b=MU3aH/wTXclpmX6XqdZCHZrCmS+CEaPSWQwaI0+IyYIv0uCa/cP+X6QY4sygak2ucV
         V0cBC59ks/Ki6muNEqMwS//PCYJPJZOlQ/aGzzMMO2wloKT1Xa7s0uuugXzNZkEKfM0f
         RtFgLBU0ejoTCHs/jC/0NB3k6vrmd+r9L48aydxZpGiI6v/F0iskwJbRBEzkz2j0DGKQ
         P0eGxWRZGq9SnYxa1sGnbI+74rvv2rD1KqerepLVj/wXUmlQqqlCzwYfnl4kkb1fk89f
         vhn7+VNmoAk2pQtKvmzKpNUxUFL+zTpWMQqkPi6NB0nqv9d0GuW3gFCeLcBpPX9hW+cG
         keEg==
X-Gm-Message-State: AOJu0YxTbglNFgWCPMOvGuoBZkfj/7ZaYESq55gY5vrI/c1uoPczDN9f
        qJl0Y3OuPhFczae7g/XspcBw
X-Google-Smtp-Source: AGHT+IG+K1ll0BoDEqVsGaro2F8rWRP5x+DvifGYKPJQoAfOSPGJhvw1QR3HTYl1n1nMB6hLXBj6QA==
X-Received: by 2002:a17:902:e80f:b0:1c4:152a:496c with SMTP id u15-20020a170902e80f00b001c4152a496cmr26443275plg.19.1697131335099;
        Thu, 12 Oct 2023 10:22:15 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.180])
        by smtp.gmail.com with ESMTPSA id f9-20020a170902ce8900b001c75a07f62esm2242359plg.34.2023.10.12.10.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 10:22:14 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, alessandro.carminati@gmail.com,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 4/5] arm64: dts: qcom: sdm845: Add OPP table support to UFSHC
Date:   Thu, 12 Oct 2023 22:51:28 +0530
Message-Id: <20231012172129.65172-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
References: <20231012172129.65172-1-manivannan.sadhasivam@linaro.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

UFS host controller, when scaling gears, should choose appropriate
performance state of RPMh power domain controller along with clock
frequency. So let's add the OPP table support to specify both clock
frequency and RPMh performance states replacing the old "freq-table-hz"
property.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
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

