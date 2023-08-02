Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06EEE76D3D0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjHBQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbjHBQeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:34:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D60358B
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:34:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1d9814b89fso16117276.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690994043; x=1691598843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CzAFxyJDXJsx0hZ+hbsCVkJECtcH8fWndodY3u5zpmw=;
        b=cEDNdOI8JNpc2QWjId+mul5PAIF12jDtATLJGhmIRCTsPeUo6cGzEcWxs46simEVZ2
         HK7L8OdNkwNNAh9A/cMVFKC5hH+qISXl5IWtI5ueMmqEP+1Zi9tR2zeF8I/CEoxcsX1L
         3v1z8gGpNg9SUYBA7DNdYXx4v7DHN5lh4v7e60ZaGaVCpm2/Pta6lB6QlYmzFnzkpMFF
         26oNUBPAI5nbvLD9kfWhKyX6SsUHv3sbf2a4MjbTlV3F+CdUWI/waDwa3bnTkU4qSbnC
         6yvAv7E76YYabnZSzVEBTQHSdN7tmcu2ofH4fFb9fk/7gHn0Kj41CpycgMjrYrZvo4Bw
         V1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690994043; x=1691598843;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CzAFxyJDXJsx0hZ+hbsCVkJECtcH8fWndodY3u5zpmw=;
        b=QGsE6dwbrduj/IFUqVV68EeLBKgTnop1imQCXMx2+RGpQ2n4Hph1p2i7WJvaU/h+fl
         Lw0i4Jomzhq/YKA8sG90X3oXJyQVxRe3cPh0YVvPhf9sLZyh1s/6mlLGzCbVnzm9Hv5k
         D/U5PmodnXV7ndLolbQBUO0zZZFSo0NDVr8gWGcUD3PVBMSr56G/poVa0zkGbyPdFr8U
         Iyu46y+TOxB4DAYTs8dbnrxqBbaH2BlRqmL34v+ltkdhayLB1NkwG1APSPZivggj9RyR
         aAO+AZ/TpsWwBsAP4XPSQL1su9S3KBlze/BXN7q376LiVDcCd2BRvC47uWtiDDzn+ENj
         b3aQ==
X-Gm-Message-State: ABy/qLZCcDkXKmALAgGsrP8cgwMwndqMDZJcQ0/04A7LS9qaSz6dqd29
        qxDprXvxZUBxfeEFsKJ/Tr/msHcsdZY+
X-Google-Smtp-Source: APBJJlHSZVoJ0Zt/UGM3qKViSNreWEl+6b6i/oXi858Hw8Zgz3igrPhVPKME4uqykzkxufvxGPYDY/gFZ82o
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:2311:0:b0:d07:e80c:412e with SMTP id
 j17-20020a252311000000b00d07e80c412emr111717ybj.12.1690994043019; Wed, 02 Aug
 2023 09:34:03 -0700 (PDT)
Date:   Thu,  3 Aug 2023 00:32:34 +0800
In-Reply-To: <20230802163328.2623773-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230802163328.2623773-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
Subject: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to arm_smmu_master
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
        Michael Shavit <mshavit@google.com>
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

With this change, each master will now own its own CD table instead of
sharing one with other masters attached to the same domain. Attaching a
stage 1 domain installs CD entries into the master's CD table. SVA
writes its CD entries into each master's CD table if the domain is
shared across masters.

Signed-off-by: Michael Shavit <mshavit@google.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---

Changes in v4:
- Added comment about the cd_table's dependency on the iommu core's
  group mutex.
- Narrowed the range of code for which the domain's init_mutex is held
  on attach since it now only protects the arm_smmu_domain_finalise
  call.

Changes in v2:
- Allocate CD table when it's first needed instead of on probe.

Changes in v1:
- The master's CD table allocation was previously split to a different
  commit. This change now atomically allocates the new CD table, uses
  it, and removes the old one.

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 82 +++++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  7 +-
 2 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 34bd7815aeb8..e2c33024ad85 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1025,7 +1025,7 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	if (!cdcfg->l1_desc)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
@@ -1062,7 +1062,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	u64 val;
 	bool cd_live;
 	__le64 *cdptr;
-	struct arm_smmu_ctx_desc_cfg *cd_table = &master->domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->cd_table;
 
 	if (WARN_ON(ssid >= (1 << cd_table->max_cds_bits)))
 		return -E2BIG;
@@ -1125,14 +1125,13 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 	return 0;
 }
 
-static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
-				    struct arm_smmu_master *master)
+static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master)
 {
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	cdcfg->stall_enabled = master->stall_enabled;
 	cdcfg->max_cds_bits = master->ssid_bits;
@@ -1174,12 +1173,12 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	return ret;
 }
 
-static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
+static void arm_smmu_free_cd_tables(struct arm_smmu_master *master)
 {
 	int i;
 	size_t size, l1size;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->cd_table;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -1287,7 +1286,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
-			cd_table = &smmu_domain->cd_table;
+			cd_table = &master->cd_table;
 			break;
 		case ARM_SMMU_DOMAIN_S2:
 		case ARM_SMMU_DOMAIN_NESTED:
@@ -2077,14 +2076,10 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	free_io_pgtable_ops(smmu_domain->pgtbl_ops);
 
-	/* Free the CD and ASID, if we allocated them */
+	/* Free the ASID or VMID */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
-
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cd_table->cdtab)
-			arm_smmu_free_cd_tables(smmu_domain);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
 	} else {
@@ -2096,7 +2091,7 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 	kfree(smmu_domain);
 }
 
-static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
+static int arm_smmu_domain_finalise_cd(struct arm_smmu_domain *smmu_domain,
 				       struct arm_smmu_master *master,
 				       struct io_pgtable_cfg *pgtbl_cfg)
 {
@@ -2115,10 +2110,6 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	ret = arm_smmu_alloc_cd_tables(smmu_domain, master);
-	if (ret)
-		goto out_free_asid;
-
 	cd->asid	= (u16)asid;
 	cd->ttbr	= pgtbl_cfg->arm_lpae_s1_cfg.ttbr;
 	cd->tcr		= FIELD_PREP(CTXDESC_CD_0_TCR_T0SZ, tcr->tsz) |
@@ -2130,17 +2121,9 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
-	ret = arm_smmu_write_ctx_desc(master, 0, cd);
-	if (ret)
-		goto out_free_cd_tables;
-
 	mutex_unlock(&arm_smmu_asid_lock);
 	return 0;
 
-out_free_cd_tables:
-	arm_smmu_free_cd_tables(smmu_domain);
-out_free_asid:
-	arm_smmu_free_asid(cd);
 out_unlock:
 	mutex_unlock(&arm_smmu_asid_lock);
 	return ret;
@@ -2203,7 +2186,7 @@ static int arm_smmu_domain_finalise(struct iommu_domain *domain,
 		ias = min_t(unsigned long, ias, VA_BITS);
 		oas = smmu->ias;
 		fmt = ARM_64_LPAE_S1;
-		finalise_stage_fn = arm_smmu_domain_finalise_s1;
+		finalise_stage_fn = arm_smmu_domain_finalise_cd;
 		break;
 	case ARM_SMMU_DOMAIN_NESTED:
 	case ARM_SMMU_DOMAIN_S2:
@@ -2436,22 +2419,14 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (!smmu_domain->smmu) {
 		smmu_domain->smmu = smmu;
 		ret = arm_smmu_domain_finalise(domain, master);
-		if (ret) {
+		if (ret)
 			smmu_domain->smmu = NULL;
-			goto out_unlock;
-		}
-	} else if (smmu_domain->smmu != smmu) {
+	} else if (smmu_domain->smmu != smmu)
 		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->cd_table.max_cds_bits) {
-		ret = -EINVAL;
-		goto out_unlock;
-	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->cd_table.stall_enabled != master->stall_enabled) {
-		ret = -EINVAL;
-		goto out_unlock;
-	}
+
+	mutex_unlock(&smmu_domain->init_mutex);
+	if (ret)
+		return ret;
 
 	master->domain = smmu_domain;
 
@@ -2465,6 +2440,22 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
+	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
+		if (!master->cd_table.cdtab) {
+			ret = arm_smmu_alloc_cd_tables(master);
+			if (ret) {
+				master->domain = NULL;
+				return ret;
+			}
+		}
+
+		ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
+		if (ret) {
+			master->domain = NULL;
+			return ret;
+		}
+	}
+
 	arm_smmu_install_ste_for_dev(master);
 
 	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
@@ -2472,10 +2463,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_enable_ats(master);
-
-out_unlock:
-	mutex_unlock(&smmu_domain->init_mutex);
-	return ret;
+	return 0;
 }
 
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
@@ -2719,6 +2707,8 @@ static void arm_smmu_release_device(struct device *dev)
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
+	if (master->cd_table.cdtab_dma)
+		arm_smmu_free_cd_tables(master);
 	kfree(master);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 6066a09c0199..1f3b37025777 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -694,6 +694,8 @@ struct arm_smmu_master {
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
+	/* Locked by the iommu core using the group mutex */
+	struct arm_smmu_ctx_desc_cfg	cd_table;
 	unsigned int			num_streams;
 	bool				ats_enabled;
 	bool				stall_enabled;
@@ -720,11 +722,8 @@ struct arm_smmu_domain {
 
 	enum arm_smmu_domain_stage	stage;
 	union {
-		struct {
 		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_ctx_desc_cfg	cd_table;
-		};
-		struct arm_smmu_s2_cfg	s2_cfg;
+		struct arm_smmu_s2_cfg		s2_cfg;
 	};
 
 	struct iommu_domain		domain;
-- 
2.41.0.585.gd2178a4bd4-goog

