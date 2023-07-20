Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C5275A5A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 07:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjGTFmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGTFm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 01:42:27 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CB52720
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:42:00 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666e97fcc60so230868b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 22:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689831720; x=1690436520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtXPc8izSWzg3ugRLXmOcd7egouahP59rkY9I+qN6II=;
        b=wh51zWFTLjgMKbmNKi29uVTt4kvmghX1ebKHutYJfeIUfsv0B727qj4HCKxGwiSq+M
         2OMdsmhDnKRqwaQPXyI243+j4zExBPYQl2ye6ygw0OU8ip0UiNKKhNVb6u9JKo3FxVlF
         Y6Z0PxbAXi1SHXLDsXKujOxJufKxduWOOW8dck7FQ7G28Qnb6bLdtz30JUrgo5Ya404X
         94KF/yVRVJJLPGQqSq+x3YRT+z63uXSPME6gnhKFRPftfRYHCUYQ1QKj2ANjuSeHCyON
         jsnVJGYQyAil031a5dtQrFjQW6zYnK1hZldkKJ0sOTYai5Cy+AX2+9zJPXVcwAetbjTD
         mO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689831720; x=1690436520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtXPc8izSWzg3ugRLXmOcd7egouahP59rkY9I+qN6II=;
        b=Tsv9a90Fkb4vlfzmKmduYRMLxgi5pgqA4THLNPglqcOLI3WSYWwaW+Tbwyub1aREev
         rWoVfYIAVbWBPt6FvqlMi7ja+VwjOU799U6UI8iTh3MUQQlX3MJbbBen9F298nghz+RY
         BRsz1TGpW0lFZTkYwfJyu/ajU1gNtsXFzK+5uZ8PNXkj1oTW7qgtuY55WIGNaXWRT649
         tQEoFiOTiibab7MllLuxJtRLkdEkRnzx8NKrU02qsb7z1A5ZqLJLEwsPUX0zENdFg4jt
         q/cyeBmb9p+LTV1e9cxL6MbTgqjw50HAzOIohjRbQX89QlgIkFx8OzfO6EPpLpcurhVy
         SBvQ==
X-Gm-Message-State: ABy/qLY/hdQD4p1+kn2N6NXJToCBLibZp7/aB1zeveJwaDAH+mIjqRGg
        4g8vzSAZ1kz8ZKxZxzUTDCo8
X-Google-Smtp-Source: APBJJlEfDxgxCoUYkZtFIN4LQq8BF4LpNXytQnCCbmSuj7RGZRkbe/g5C0H3IPMWTV5pjz0ZJdEd6g==
X-Received: by 2002:a05:6a20:3d87:b0:12f:c61e:7cac with SMTP id s7-20020a056a203d8700b0012fc61e7cacmr4263115pzi.31.1689831719918;
        Wed, 19 Jul 2023 22:41:59 -0700 (PDT)
Received: from localhost.localdomain ([117.206.119.70])
        by smtp.gmail.com with ESMTPSA id r2-20020a170902be0200b001b85bb5fd77sm263367pls.119.2023.07.19.22.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 22:41:59 -0700 (PDT)
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
Subject: [PATCH v2 04/15] arm64: dts: qcom: sdm845: Fix the min frequency of "ice_core_clk"
Date:   Thu, 20 Jul 2023 11:10:49 +0530
Message-Id: <20230720054100.9940-5-manivannan.sadhasivam@linaro.org>
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

Minimum frequency of the "ice_core_clk" should be 75MHz as specified in the
downstream vendor devicetree. So fix it!

https://git.codelinaro.org/clo/la/kernel/msm-4.9/-/blob/LA.UM.7.3.r1-09300-sdm845.0/arch/arm64/boot/dts/qcom/sdm845.dtsi

Fixes: 433f9a57298f ("arm64: dts: sdm845: add Inline Crypto Engine registers and clock")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 9ed74bf72d05..89520a9fe1e3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -2614,7 +2614,7 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 300000000>;
+				<75000000 300000000>;
 
 			status = "disabled";
 		};
-- 
2.25.1

