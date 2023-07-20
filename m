Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B189375A5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGTFn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGTFnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:43:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2792733
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:42:37 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-54290603887so187196a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831735; x=1690436535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIJwX+rRxRyxzpkMToX1TQb/1UCAf5+FnTJGGYz4XKg=;
        b=spBKL23pQZiuHNlsGsgeh45EbVEuI+G9cqILcMhP48E3UQSGPwHkaOElarS+a/KR7c
         z5sN/8944MFGOBTytUKLOscCDukd2rGHE1nIWdVpWqqrwuy0iaIQeEtZU5DDk57L/guH
         6EnwnicNtOkjlQ3fPY28NXvtfw7tBOj6I6Gg+XKn9ClG8vzr96b6HATzKDWIIHG39Jcd
         CxjuFcrCMjo9JNTM9oJfZ3CDPnJ6fVNhQ7oCv6qatPa+DrChRg/decM2ZB09WHqBl1Ez
         eehK7bk1/XAdBxNpAiFLIFl54IMeRZoMDzW2KsXKxzoNJj5ia6kdqlc6IGzaeRyS0oZY
         212A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831735; x=1690436535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIJwX+rRxRyxzpkMToX1TQb/1UCAf5+FnTJGGYz4XKg=;
        b=dkn8/7ujvgep2U0mdH+0hxjPVkvu2AmJRWk6+Co9feGKA8yQBpIrCrMQXbMc7eu3DQ
         4s467ykTEAzbU5NoyA1/Ve8L1ssp6cfny0O/CrRGyaUopeIBoBPmwFGX1FfSy5Yq1P79
         Ppm9+WT7q6FeORZfr7Z26PGCqcG8lAIuRe0X5DnL1I9Tc03Ldd8ZeEVaJ8GfS244d7TG
         7IS1F07cGRMRoUFKhXUawlFOqicYc/E/Sw4KArlk8S/e104ms5EiJStNa3wO00dcQwv6
         I/GRKCkNf849udo7SZiqA0AfdA1ySpy1tfRvO2buReQ50vjwHvhL4V1AJkopI99bSwQy
         zm2A==
X-Gm-Message-State: ABy/qLbLSrYxF/LMzDLFZeqsdQmroRyqwp++C72oV8iG2Nfv/WUdChKo
        krvvZkMveYP0ayd3aEM70xpo
X-Google-Smtp-Source: APBJJlGKMzAXTbAybybYaz7y672i43FBRXbwuel9Scs3E8/WFNyGZYn0Qkn9lCp7a/GXrii39IHMyQ==
X-Received: by 2002:a05:6a20:12ca:b0:135:8a04:9045 with SMTP id v10-20020a056a2012ca00b001358a049045mr7358575pzg.1.1689831735342;
        Wed, 19 Jul 2023 22:42:15 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:42:14 -0700 (PDT)
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
Subject: [PATCH v2 06/15] arm64: dts: qcom: sm8250: Add OPP table support to UFSHC
Date:   Thu, 20 Jul 2023 11:10:51 +0530
Message-Id: <20230720054100.9940-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 83ab6de459bc..72fd66db9c51 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -2194,17 +2194,38 @@ ufs_mem_hc: ufshc@1d84000 {
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

