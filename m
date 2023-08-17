Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2777FDD0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354453AbjHQSXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354464AbjHQSXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:23:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083BF359D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:23:09 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58c54f4e2a2so1233987b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296487; x=1692901287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UbN8hteG6YSwFJxRxYYT0MEpu8iWEUW9NUmuxxHFuvs=;
        b=V/qRRHg6MxCpJtqxo3ZVdjG1rtcfb3VN30OZkf2bYzKnf1dwUQpDRAbgJHRa1W4GPN
         GeC8ir3P3lkFNpMfTUdMMn0ETUtjNTn5bpC6uHjzkLIQ0OO7K2xEyO9eo3ZfyRAVAyyL
         CIYUQQujP3AWaXOBHYklLLP5lTjXPJMgOhcJhA7ZvQB0qe5P8EY1w2SdL9SIJzdaDMkb
         Um/na90xfIJIGQlpGgHYR0JestTgRSFW6fO7IqDjCnoTFwky6qgBC6W4ZCk/hwSxPQCS
         bkcSuWBUJOZqHYvAYH4tvk6Qc/YUA5NJnp5dW6V9ZNs4O0ULt5x9B/CQRhmeh8ZJTQE/
         XKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296487; x=1692901287;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UbN8hteG6YSwFJxRxYYT0MEpu8iWEUW9NUmuxxHFuvs=;
        b=eS6983X0opR36HAeF5fSub3sUcAjW9YZdS8D4iJTbuvQ+Eh7O1LJQWpILhCSWHItZn
         3XVBJGWV9MBqOkv8zZlnoPvM6yFh1J4Ptdw1PcHv1f/C8JJmFZumNmvwf3fx6hOJyWeP
         Y5QbFy5bDD1xE9MgP32fqRbdZ5c1K0u7jLwyHmOy4i9ViasSiRACou1jjsVbfu+xzcNv
         V1CSUpy5+2SZ8KpP49vuuWhyEh1AnlZZYos2yb1qeHL1E9YSsyLgufwtVBxWZXU4+zsj
         bfRxSHg/f4fLBFJI9LyLMCzRjq/ZNakpZHGB5RHbZkE/C/PabhrtGVBk+HCXu+XhNSSt
         3/5w==
X-Gm-Message-State: AOJu0YwpO0BGURFWRpcgfFWpWn1OsrOvl/Q1KbMelXcTyMCk15pDwcTY
        +666lCsMLPFjeeWgcTlgGs+jXQraU4/y
X-Google-Smtp-Source: AGHT+IGTAACVuz6ZInq7S1tmwe0PZqsqwSGF8b8sGnN43WrsM/3yciEvcFsY+UaDmtHr5pX+49suRdb9CKv9
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a05:6902:168a:b0:d49:e117:3a17 with SMTP
 id bx10-20020a056902168a00b00d49e1173a17mr6554ybb.4.1692296487005; Thu, 17
 Aug 2023 11:21:27 -0700 (PDT)
Date:   Fri, 18 Aug 2023 02:16:26 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.4.I100c49a1e2ce915982965a065f95a494c2e9ad28@changeid>
Subject: [RFC PATCH v1 4/8] iommu/arm-smmu-v3: check smmu compatibility on attach
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, jgg@nvidia.com, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com, Michael Shavit <mshavit@google.com>
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

Record the domain's pgtbl_cfg when it's being prepared so that it can
later be compared to the features an smmu supports.
Verify a domain's compatibility with the smmu when it's being attached
to a master belong to a different smmu device.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 103 ++++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   2 +
 2 files changed, 86 insertions(+), 19 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 447af74dbe280..c0943cf3c09ca 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2195,17 +2195,48 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_domain *smmu_domain,
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
-	struct io_pgtable_cfg pgtbl_cfg;
 	struct io_pgtable_ops *pgtbl_ops;
 	int (*finalise_stage_fn)(struct arm_smmu_domain *,
 				 struct io_pgtable_cfg *);
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct io_pgtable_cfg *pgtbl_cfg = &smmu_domain->pgtbl_cfg;
 
 	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
 		smmu_domain->stage = ARM_SMMU_DOMAIN_BYPASS;
@@ -2220,16 +2251,11 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
 
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
@@ -2237,24 +2263,19 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain)
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
+	ret = arm_smmu_prepare_pgtbl_cfg(smmu, smmu_domain->stage, pgtbl_cfg);
+	if (ret)
+		return ret;
 
-	pgtbl_ops = alloc_io_pgtable_ops(fmt, &pgtbl_cfg, smmu_domain);
+	pgtbl_ops = alloc_io_pgtable_ops(fmt, pgtbl_cfg, smmu_domain);
 	if (!pgtbl_ops)
 		return -ENOMEM;
 
-	domain->pgsize_bitmap = pgtbl_cfg.pgsize_bitmap;
-	domain->geometry.aperture_end = (1UL << pgtbl_cfg.ias) - 1;
+	domain->pgsize_bitmap = pgtbl_cfg->pgsize_bitmap;
+	domain->geometry.aperture_end = (1UL << pgtbl_cfg->ias) - 1;
 	domain->geometry.force_aperture = true;
 
-	ret = finalise_stage_fn(smmu_domain, &pgtbl_cfg);
+	ret = finalise_stage_fn(smmu_domain, pgtbl_cfg);
 	if (ret < 0) {
 		free_io_pgtable_ops(pgtbl_ops);
 		return ret;
@@ -2406,6 +2427,46 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
+static int
+arm_smmu_verify_domain_compatible(struct arm_smmu_device *smmu,
+				  struct arm_smmu_domain *smmu_domain)
+{
+	struct io_pgtable_cfg pgtbl_cfg;
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
+	if (smmu_domain->pgtbl_cfg.ias > pgtbl_cfg.ias ||
+	    smmu_domain->pgtbl_cfg.oas > pgtbl_cfg.oas ||
+	    /*
+	     * The supported pgsize_bitmap must be a superset of the domain's
+	     * pgsize_bitmap.
+	     */
+	    (smmu_domain->pgtbl_cfg.pgsize_bitmap ^ pgtbl_cfg.pgsize_bitmap) &
+		    smmu_domain->pgtbl_cfg.pgsize_bitmap ||
+	    smmu_domain->pgtbl_cfg.coherent_walk != pgtbl_cfg.coherent_walk)
+		return -EINVAL;
+
+	return 0;
+}
+
 static void arm_smmu_installed_smmus_remove_device(
 	struct arm_smmu_domain *smmu_domain,
 	struct arm_smmu_master *master)
@@ -2449,6 +2510,10 @@ arm_smmu_installed_smmus_add_device(struct arm_smmu_domain *smmu_domain,
 		}
 	}
 	if (!list_entry_found) {
+		ret = arm_smmu_verify_domain_compatible(smmu, smmu_domain);
+		if (ret)
+			goto unlock;
+
 		installed_smmu = kzalloc(sizeof(*installed_smmu), GFP_KERNEL);
 		if (!installed_smmu) {
 			ret = -ENOMEM;
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 2ab23139c796e..143b287be2f8b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -9,6 +9,7 @@
 #define _ARM_SMMU_V3_H
 
 #include <linux/bitfield.h>
+#include <linux/io-pgtable.h>
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/mmzone.h>
@@ -729,6 +730,7 @@ struct arm_smmu_domain {
 	struct mutex			init_mutex; /* Protects smmu pointer */
 
 	struct io_pgtable_ops		*pgtbl_ops;
+	struct io_pgtable_cfg		pgtbl_cfg;
 	atomic_t			nr_ats_masters;
 
 	enum arm_smmu_domain_stage	stage;
-- 
2.42.0.rc1.204.g551eb34607-goog

