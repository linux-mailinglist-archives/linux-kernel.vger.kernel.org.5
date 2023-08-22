Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0088783E74
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjHVK6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbjHVK6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:58:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C43E61
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7493fcd829so2918864276.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692701892; x=1693306692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jRWVgSqH/qYx1EjvX6UPDKu9s9iKlYb3v5piLi27lR0=;
        b=HIihOmDUjCkJ4FIuOfQjpm0L5n7sFvAatpFN/o2lyC5EYUfoX/QGQPDFH15mia68s/
         0G2KTXO1Hv2LM+jru5SEjiORwmtKXgjXOTNa3siYT8UFA2On4P1jIk9VSeh1ow9f7wF/
         EzTEXI+OXPHEleaRFYC7gKPeKKZHCei/uIlzp/ITG82HZX4KUdywe79TfGjXaFoe5/Uf
         e2bhK4CxcFZaqX71Oz6F2i5ZSisCHZ8zSlkcRrtcsSZ4tSIOucDXguJCOD9JTOEGZjbn
         9iTDYVI34nH2cLi5X3NQDdsq4YuOgItEDoaDBTqnewov2StYL9yRXlY1DrZh+KXLFauy
         eGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692701892; x=1693306692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRWVgSqH/qYx1EjvX6UPDKu9s9iKlYb3v5piLi27lR0=;
        b=iXzgoa8vd08laFLjIHp4D1W7K9LjhLDQdERBY9qJR/tab/oR37cM+3HHqtFXb72rJ2
         Y3mKeegmlFHrtNek3yzhaXuS6W3xFR7yAd/YboqB4PH9UOZtTsYblE0BvozkDV+c36gy
         Z/GN11pao2yaz911ALPsGhc8DCdhLlDUtgQt2nS2PwMFF6H7N8QZvAdgSSDWInYlP4Mq
         WvvRjG0YEZLoJhpjr+a9oFrzxT+7ohXLg2vD5uCtLMPvWYn33zvJPglXdW5u+wCv8vyY
         Wo1Sv7foTRTh3x5yKfDMFSIdlNm6JB6aGTU6HZ4isI9pQxPRNmjFAkVD7DqoyZ9h49dv
         VvjA==
X-Gm-Message-State: AOJu0YzdYzuK+bpbWRiyQfuOsDw1TD3qhO6UAd2uvoPs2H2DJSLywEl5
        R8iYlw7gkHvAtKhRsloWEeIL/MlFXfB9
X-Google-Smtp-Source: AGHT+IG1FKVb5fA8cDC+NAqDiRTn0hkxABY2MLjyaXrgT5clKa5oN7sa2OLjSYQGfR8ScBmUEdZwtFSjQK3K
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:44ad:3968:8aaa:c4fe])
 (user=mshavit job=sendgmr) by 2002:a25:81c5:0:b0:d63:8364:328 with SMTP id
 n5-20020a2581c5000000b00d6383640328mr77162ybm.5.1692701892264; Tue, 22 Aug
 2023 03:58:12 -0700 (PDT)
Date:   Tue, 22 Aug 2023 18:57:02 +0800
In-Reply-To: <20230822105738.1607365-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230822105738.1607365-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230822185632.RFC.v2.6.I100c49a1e2ce915982965a065f95a494c2e9ad28@changeid>
Subject: [RFC PATCH v2 6/9] iommu/arm-smmu-v3: check smmu compatibility on attach
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

Verify a domain's compatibility with the smmu when it's being attached
to a master belonging to a different smmu device.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v2:
- Access the pgtbl_cfg from the pgtable_ops instead of storing a copy in
  the arm_smmu_domain.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 94 +++++++++++++++++----
 1 file changed, 79 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 9adc2cedd487b..2f305037b9250 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2213,10 +2213,41 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
 	return 0;
 }
 
+static int arm_smmu_prepare_pgtbl_cfg(struct arm_smmu_device *smmu,
+				      enum arm_smmu_domain_stage stage,
+				      struct io_pgtable_cfg *pgtbl_cfg)
+{
+	unsigned long ias, oas;
+
+	switch (stage) {
+	case ARM_SMMU_DOMAIN_S1:
+		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
+		ias = min_t(unsigned long, ias, VA_BITS);
+		oas = smmu->ias;
+		break;
+	case ARM_SMMU_DOMAIN_NESTED:
+	case ARM_SMMU_DOMAIN_S2:
+		ias = smmu->ias;
+		oas = smmu->oas;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*pgtbl_cfg = (struct io_pgtable_cfg) {
+		.pgsize_bitmap	= smmu->pgsize_bitmap,
+		.ias		= ias,
+		.oas		= oas,
+		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
+		.tlb		= &arm_smmu_flush_ops,
+		.iommu_dev	= smmu->dev,
+	};
+	return 0;
+}
+
 static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 {
 	int ret;
-	unsigned long ias, oas;
 	enum io_pgtable_fmt fmt;
 	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
@@ -2238,16 +2269,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_S1:
-		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
-		ias = min_t(unsigned long, ias, VA_BITS);
-		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
 		finalise_stage_fn = arm_smmu_domain_finalise_s1;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
-		ias = smmu->ias;
-		oas = smmu->oas;
 		fmt = ARM_64_LPAE_S2;
 		finalise_stage_fn = arm_smmu_domain_finalise_s2;
 		break;
@@ -2255,14 +2281,9 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 		return -EINVAL;
 	}
 
-	pgtbl_cfg = (struct io_pgtable_cfg) {
-		.pgsize_bitmap	= smmu->pgsize_bitmap,
-		.ias		= ias,
-		.oas		= oas,
-		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
-		.tlb		= &arm_smmu_flush_ops,
-		.iommu_dev	= smmu->dev,
-	};
+	ret = arm_smmu_prepare_pgtbl_cfg(smmu, smmu_domain->stage, &pgtbl_cfg);
+	if (ret)
+		return ret;
 
 	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
@@ -2424,6 +2445,48 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
+static int
+arm_smmu_verify_domain_compatible(struct arm_smmu_device *smmu,
+				  struct arm_smmu_domain *smmu_domain)
+{
+	struct io_pgtable_cfg pgtbl_cfg;
+	struct io_pgtable_cfg *domain_pgtbl_cfg =
+		&io_pgtable_ops_to_pgtable(smmu_domain->pgtbl_ops)->cfg;
+	int ret;
+
+	if (smmu_domain->domain.type == IOMMU_DOMAIN_IDENTITY)
+		return 0;
+
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S2) {
+		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
+			return -EINVAL;
+		if (smmu_domain->s2_cfg.vmid >> smmu->vmid_bits)
+			return -EINVAL;
+	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
+			return -EINVAL;
+		if (smmu_domain->cd.asid >> smmu->asid_bits)
+			return -EINVAL;
+	}
+
+	ret = arm_smmu_prepare_pgtbl_cfg(smmu, smmu_domain->stage, &pgtbl_cfg);
+	if (ret)
+		return ret;
+
+	if (domain_pgtbl_cfg->ias > pgtbl_cfg.ias ||
+	    domain_pgtbl_cfg->oas > pgtbl_cfg.oas ||
+	    /*
+	     * The supported pgsize_bitmap must be a superset of the domain's
+	     * pgsize_bitmap.
+	     */
+	    (domain_pgtbl_cfg->pgsize_bitmap ^ pgtbl_cfg.pgsize_bitmap) &
+		    domain_pgtbl_cfg->pgsize_bitmap ||
+	    domain_pgtbl_cfg->coherent_walk != pgtbl_cfg.coherent_walk)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
@@ -2505,7 +2568,8 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = arm_smmu_domain_finalise(domain);
 		if (ret)
 			smmu_domain->smmu = NULL;
-	} else if (smmu_domain->smmu != smmu)
+	} else if (smmu_domain->smmu != smmu ||
+		   !arm_smmu_verify_domain_compatible(smmu, smmu_domain))
 		ret = -EINVAL;
 
 	mutex_unlock(&smmu_domain->init_mutex);
-- 
2.42.0.rc1.204.g551eb34607-goog

