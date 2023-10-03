Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4BE7B678C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbjJCLOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbjJCLOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:14:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753E1CFD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 04:13:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c1ff5b741cso6363565ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 04:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696331634; x=1696936434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tI6Pcdke+ZCMScqm6RYMcPg5JywhhOVA13YJD5+toLE=;
        b=xoE6GTnxtzOmBtrU0nbXMWzbjbfv2qlqXZLcvRabXNAmvnTCBKdY9rf7QY559wMji1
         zE6Mp8OL8VGPoHruuOMbUoWcace46RhjLn0gN9cEw984LpnBP0mecrRuKa9Aq/YdYcAj
         DrasvAGWqzO8RT2iXre3EkajAAdFbgrZYT+boVAmtvfb8gNHl2+cZfkxMvzIGk/dd0dV
         oxPgKq9/xSxURUtYsfxT3fgOTTVhrcLIOUNU3QMgdkVnw4pF+XCoabjeDCtUjsAecoFA
         GdHooBvmKSc2ZjCnMs8a+8iepR5gNos1DkJ6Psqo8WgcwtpObhD7ZNJMvXn9r0P9PoxP
         berA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696331634; x=1696936434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tI6Pcdke+ZCMScqm6RYMcPg5JywhhOVA13YJD5+toLE=;
        b=ERAKrv56FAG3ynYfot7V8AlwYx3FSKj4CmIzssGVzfIqj4g+6e1i+Ie/FIpsT4Wf58
         QRjNMfbgwmKpW2Tn6hCoeF+faDdYih1IA6/R7a0UoWv7y/yl/cxfLWgsvPRQtNxFpa3H
         4MVcDKl3Zk+YttgNpVxvcAbq6Udn0ngw2tzUFzewA9mJmSTZkYA+vv5fA9AGObGsP1rp
         KUl0yJKhnEk3zIQd7zy/uS+/P8Nsz9K1JIPovXUoAKYFj7FxbaJ2vxWOvANhs04bF5u6
         czWAyxwYqaiwOc5GeJrgg9pQBr9SOeyOmEGYiixucTN9ouYrxviRepiNbajIYOHycP1T
         rQSg==
X-Gm-Message-State: AOJu0Yx0Gq8AWrwNsULOLrkDQlZKgU6F3f+Q26Aq8Frb5f0h/CWHIEPu
        EBvgSDu//ReBzFLidAfbjkvk
X-Google-Smtp-Source: AGHT+IHXjGAwqaAR8iuZgLaLIJrFx9daiXcUrzw8Sxbliq+GRtrvjzxn10oK6FBXsg9SgUjmX2+rlA==
X-Received: by 2002:a17:902:ed54:b0:1c6:2d13:5b79 with SMTP id y20-20020a170902ed5400b001c62d135b79mr13850679plb.47.1696331633859;
        Tue, 03 Oct 2023 04:13:53 -0700 (PDT)
Received: from localhost.localdomain ([117.217.185.220])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b001ab2b4105ddsm1250328plh.60.2023.10.03.04.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 04:13:53 -0700 (PDT)
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
Subject: [PATCH v4 6/6] arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
Date:   Tue,  3 Oct 2023 16:42:32 +0530
Message-Id: <20231003111232.42663-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org>
References: <20231003111232.42663-1-manivannan.sadhasivam@linaro.org>
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

UFS host controller, when scaling gears, should choose appropriate
performance state of RPMh power domain controller along with clock
frequency. So let's add the OPP table support to specify both clock
frequency and RPMh performance states replacing the old "freq-table-hz"
property.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 39 +++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index a4e58ad731c3..33abd84aae53 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2198,21 +2198,42 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_TX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_0_CLK>,
 				<&gcc GCC_UFS_PHY_RX_SYMBOL_1_CLK>;
-			freq-table-hz =
-				<37500000 300000000>,
-				<0 0>,
-				<0 0>,
-				<37500000 300000000>,
-				<0 0>,
-				<0 0>,
-				<0 0>,
-				<0 0>;
+
+			operating-points-v2 = <&ufs_opp_table>;
 
 			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mc_virt SLAVE_EBI_CH0 0>,
 					<&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
 			interconnect-names = "ufs-ddr", "cpu-ufs";
 
 			status = "disabled";
+
+			ufs_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-37500000 {
+					opp-hz = /bits/ 64 <37500000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <37500000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-300000000 {
+					opp-hz = /bits/ 64 <300000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <300000000>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>,
+						 /bits/ 64 <0>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
 		};
 
 		ufs_mem_phy: phy@1d87000 {
-- 
2.25.1

