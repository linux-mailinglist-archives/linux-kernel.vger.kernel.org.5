Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6F765B57
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjG0S2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjG0S2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:28:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850373A89
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:24 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56cf9a86277so12115817b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482503; x=1691087303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEh6KP4aD9iwA1DEGVvIcvZM3EWGNO1aoyAMRV7Ud6k=;
        b=6UcibgH0/zkffRBM6W84mD4r9DVL/EtI4FlBWtfqBvSbi1VSiG3wp4YrHKqt6vHzYy
         FL2MbFxp1EGvbGO+4xMF+Ul6VUNY2qOz2r/geRKlZD+qda8WvOAL7HYPQh8TOidzSazK
         ugJ5I4UQGtFngty3B18HAjEslZ+idyUlbjflYpyFNa3plRr5FfAbtctMGDLnPyoxNtOS
         6FpT5ZB9Jv8/aYoHlojDjfdRmscKtknpjtYPCMOM1aExka6V6NlW7gpkcVVBw3bcM7s9
         XWOUE4qG2ZfyKwTuf1ifFEXLDfyme1jV/1Zat6c3zg9AQzQapm8MKOFJccHdzSEtbJSG
         2hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482503; x=1691087303;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEh6KP4aD9iwA1DEGVvIcvZM3EWGNO1aoyAMRV7Ud6k=;
        b=FBwK4VIRgnidrB8I5H0ea+2d99XMJ5Sy+t5CmZlmX2VP/yOjhRWwhSaKq4POvWfzPE
         ImCHcSzOJ5ynTki4/AfnoVICusnCZorDMQG6QQUDml/TBziGZVhtP/5YLSVllYePBZu7
         Mg2ikrUOoCDa4Cp1HAnPHJobLAz+KATXhgPITZkDKgUQi717YbAD8jl9eNA/FqlcVTSU
         fDHPtuRE5/lWSwirJn7gNHpfgZnuYmcr9aPTt9IQP1BHC/1ar5e6hHNvsJwnmCZ4oCdS
         xbaaSLzmBnd35SHkY1rPz+/EoOCYm8lqAI8DwB6i4CueoPC2a8QD6JyWekFwKel9/yfO
         aDOQ==
X-Gm-Message-State: ABy/qLbNHHzQnvizabdpGn4rz8Y3tDDs4ZoJ75OFJGE7XJDEejz67q+4
        1tXTKeRDNtitsgLiJmjpkt0TLnPHZOFA
X-Google-Smtp-Source: APBJJlE+KrNhoTJJuR379XpaV6B7mKSWJjpW1knp6z874M4nN41DJV5EsUO4z96yxRFrVrr4Pv89Se9VQOSG
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:780f:26da:d952:3463])
 (user=mshavit job=sendgmr) by 2002:a25:5012:0:b0:d0d:c74a:a6c0 with SMTP id
 e18-20020a255012000000b00d0dc74aa6c0mr907ybb.2.1690482503457; Thu, 27 Jul
 2023 11:28:23 -0700 (PDT)
Date:   Fri, 28 Jul 2023 02:26:19 +0800
In-Reply-To: <20230727182647.4106140-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727182647.4106140-4-mshavit@google.com>
Subject: [PATCH v1 3/7] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init in alloc_cd_tables
From:   Michael Shavit <mshavit@google.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Michael Shavit <mshavit@google.com>, jean-philippe@linaro.org,
        nicolinc@nvidia.com, jgg@nvidia.com, baolu.lu@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
single function instead of having pieces set ahead-of time by its caller.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 8cf4987dd9ec7..8a286e3838d70 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1132,7 +1132,8 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
@@ -1140,6 +1141,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
+	cdcfg->max_cds_bits = master->ssid_bits;
 	max_contexts = 1 << cdcfg->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
@@ -2107,7 +2109,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2120,11 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cdcfg->max_cds_bits = master->ssid_bits;
-
 	smmu_domain->stall_enabled = master->stall_enabled;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain);
+	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
 	if (ret)
 		goto out_free_asid;
 
-- 
2.41.0.585.gd2178a4bd4-goog

