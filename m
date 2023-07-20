Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0C475A5C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjGTFoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGTFn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:43:29 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8CD172A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:43:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b8bbce9980so2178745ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831782; x=1690436582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1pcWt8K+FK2wfI9pVkhS/rPdimyJshB0C7q20l1ZU8=;
        b=hTbAwQGQvoq90ltUGcgpTFRLiSddOhNlJPqRcLxSBdobh+X4c2foZzFwy2AFMnyjvq
         rGQyQvDJjIeR4egbJW1hEkIjym5J5YlTD98zhwQwa1tnEIR7TNLtwgxsTz3yA3BFIfc1
         a9PI/UghB01jaNrMg+Tg1TkUgiipnA7xuRF7378lnCPJTB1fiMesfmFlMRRWcFJFoKKa
         1MxYCzwgA4IXrQ2fYLrMk5dkBFwJAFFKgFRpXmkRByrEAhO81roJnokfIUElhfsEq2/d
         s1C6/KmxyJmG40FragZ9iJQrGfx7oN4rhe6wyRFfAdWaqWYB5CwQQUEN4ZTyXGqFyDeB
         klnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831782; x=1690436582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n1pcWt8K+FK2wfI9pVkhS/rPdimyJshB0C7q20l1ZU8=;
        b=hiMEKnwKruZblFwgbkTgZ0hHMEUF1XEMvwkp0Udw7WbimOSZKc/3sBsw/isHBgSFc9
         17IYMhf/RZxcRsvNd/7iLEnnMwIsfYUg0Jr8RRat4segmm61S7GvNxaUXLbEGpK9Yj+6
         GK45Loc6NEvfXVPxlhNMBwa8wfqsPzFDPQsQaj9aDd251fWtjr2xX1mfdzhEjX/wZrNx
         oddd9CMq2XBK1o1JOaEKuYCSVrDPLxRhXBvPGddea9UohfJ5ZSe8J2UQCxH/hC0s99jh
         kwhbhm0db81e9HOWKgZ8A+5x2ykpnCmUIlkMYCPXwyDRcPgxhKra1+Y4JF+5UgHBZOLT
         2yYg==
X-Gm-Message-State: ABy/qLbMefsJYctwXz9otROHpJX/iPrAWnle6h5a9uIDzOofS5CdWfXB
        quRhar9L1R3G6eXyXUDDXQ1U
X-Google-Smtp-Source: APBJJlG55HVqVD8VAAuTNsFGHB2PljWCVRcl6DGWV6zErupcqmf2bXv/gJEjCi6phx01jKOIL7/bcw==
X-Received: by 2002:a17:902:eacb:b0:1b8:76d1:bdcf with SMTP id p11-20020a170902eacb00b001b876d1bdcfmr4001732pld.23.1689831782191;
        Wed, 19 Jul 2023 22:43:02 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:43:01 -0700 (PDT)
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
Subject: [PATCH v2 12/15] arm64: dts: qcom: sdm845: Add interconnect paths to UFSHC
Date:   Thu, 20 Jul 2023 11:10:57 +0530
Message-Id: <20230720054100.9940-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
References: <20230720054100.9940-1-manivannan.sadhasivam@linaro.org>
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

UFS host controller requires interconnect path configuration for proper
working. So let's specify them for SDM845 SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e04a3cbb1017..2ea6eb44953e 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2607,6 +2607,11 @@ ufs_mem_hc: ufshc@1d84000 {
 				<&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 
 			operating-points-v2 = <&ufs_opp_table>;
+
+			interconnects = <&aggre1_noc MASTER_UFS_MEM 0 &mem_noc SLAVE_EBI1 0>,
+					<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_UFS_MEM_CFG 0>;
+			interconnect-names = "ufs-ddr", "cpu-ufs";
+
 			status = "disabled";
 
 			ufs_opp_table: opp-table {
-- 
2.25.1

