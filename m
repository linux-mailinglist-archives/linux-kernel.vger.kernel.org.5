Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F78783E75
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjHVK6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbjHVK6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:58:34 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51630CFC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6412374defso5556029276.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701896; x=1693306696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=058zW3MOZIvxq/mgODQOiyKY2M7mNXQxp9+nR9ONw0Q=;
        b=5+nwyDRA1YhgcC7yjP/COkXuoeJIFR4fcF0iWpy2ZNNXf8pimuDQ+Wg6wMUM9kj+Iz
         5OshLB8QIVkkY8xBnDADhvwc6uHg4TbudkHRhB/4IJvfmI4bMthiQCvT0JTbZuQDK5XK
         7f/HrmpTPN1Ey8I+KKWg/cCg1Ox7Uej1GYkIN3ifW0TswxfZP8/rkpURgtIKxDCgzrvn
         wsS367nGc/4hAJW+24oYrz93c7KISdatf9XahRnybxm827ZkXqCFboEcxSXHaYeT5DQo
         BKoGRlKQkQGWgY4RiXphhqDQpi6yuADPwuiiCowqsOERml0+jSE8e1ibveXKTH6ujlQX
         Kzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701896; x=1693306696;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=058zW3MOZIvxq/mgODQOiyKY2M7mNXQxp9+nR9ONw0Q=;
        b=Iud0L9zSMFRdwXKWhCtqDxkSxx+oxCd21zeNDJAbiTmG4u/isB8lKqMrpQOTQyoehY
         Ta2kVZ0zcYtjsKiUGRsnW7TBZtRVuNyOoVYzpmYSs1ilEs8C1kzAyhPJ9G2kua5tHgCE
         HAJ4cId/q1wutnBFUi96jtetDdbsxuOxRV5NakgDY1ZiBRxg8BrsbImk/mtHKfAxviU7
         0FqxpsOdb1Vix3hEIFLZLnXQUiu4ya6vm8Sxp0H1dpgs2g2U1ne/ek6NH9EULqdONDuB
         wsneyxD7Z3xDVvlKYSgoBYEkVYJolsESORbIR33eewddDVEz8XV1sd1XWZLKeCSwb/vv
         uE4w==
X-Gm-Message-State: AOJu0YxAGNAxV8UOmahQ359bolboXJCaGfav3+L3rMaY+jpDzSLk24Px
        zl3bW7sDhej7DBSh6JCSnjMd4AEP/XeL
X-Google-Smtp-Source: AGHT+IHIKqF9VBejqCdz69o9Z+MqzhDnO89Uie4GHPeRpguVq2z8h+BipHm6eAM5P0OGBfj4WYuHrcJO+NHT
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a25:81c5:0:b0:d63:8364:328 with SMTP id
 n5-20020a2581c5000000b00d6383640328mr77169ybm.5.1692701896632; Tue, 22 Aug
 2023 03:58:16 -0700 (PDT)
Date:   Tue, 22 Aug 2023 18:57:03 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.7.Ia591869e7a4b88af16a57e09c92df21599d3312c@changeid>
Subject: [RFC PATCH v2 7/9] iommu/arm-smmu-v3: Add arm_smmu_device as a
 parameter to domain_finalise
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, tina.zhang@intel.com,
        jean-philippe@linaro.org, will@kernel.org, robin.murphy@arm.com,
        jgg@nvidia.com, Michael Shavit <mshavit@google.com>,
        Dawei Li <set_pte_at@outlook.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the usage of arm_smmu_domain->smmu in arm_smmu_domain_finalise as
it will be removed in a subsequent commit.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v1)

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 2f305037b9250..7c9897702bcde 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2150,11 +2150,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 }
 
 static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int ret;
 	u32 asid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2187,10 +2187,10 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 }
 
 static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
+				       struct arm_smmu_device *smmu,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
 	int vmid;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
 	typeof(&pgtbl_cfg->arm_lpae_s2_cfg.vtcr) vtcr;
 
@@ -2245,16 +2245,17 @@ static int arm_smmu_prepare_pgtbl_cfg(struct arm_smmu_device *smmu,
 	return 0;
 }
 
-static int arm_smmu_domain_finalise(struct iommu_domain *domain)
+static int arm_smmu_domain_finalise(struct iommu_domain *domain,
+				    struct arm_smmu_device *smmu)
 {
 	int ret;
 	enum io_pgtable_fmt fmt;
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
+				 struct arm_smmu_device *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
@@ -2293,7 +2294,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, smmu, &pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2565,7 +2566,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain);
+		ret = arm_smmu_domain_finalise(domain, smmu);
 		if (ret)
 			smmu_domain->smmu = NULL;
 	} else if (smmu_domain->smmu != smmu ||
-- 
2.42.0.rc1.204.g551eb34607-goog

