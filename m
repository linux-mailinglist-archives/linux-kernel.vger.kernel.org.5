Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A108976BC98
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjHASjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHASjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:39:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EDF268E
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 11:39:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56942667393so73946837b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 11:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690915141; x=1691519941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8GsVuPA2e9/wbjhk0i8iB7mxy1pTO61hf/WYqUhiMB0=;
        b=dHen3PddlFbo9VHClsVYgexTe5jHKLENO0cYz9lzTxCV2cWF8pZbspkWZPUsRHVLSi
         CLt3O5ojyXMtUkviLtiNWOWSSgOPvo84oe5mxRP6DWM+DCkI3+lBmzO7h6BfrFoHi405
         lr97OvZUVH2AqShRfunyVEg7JikuObUR1d3BotwQE94r0xIn9B+B6mYsCzn6eYIuIHHF
         gs9wzo0kzjw+So+AG4Hq7WM3pnq+GlpyR7a8+8QBdX8XvlLZhNc2M29wD71w7COlCkRS
         utxwoPZVv3aR2njMu14rFHpx47xafz7vBKqycNRhSgNVvriuWxnEsZs/JsotvPJK6IOG
         +o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690915141; x=1691519941;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8GsVuPA2e9/wbjhk0i8iB7mxy1pTO61hf/WYqUhiMB0=;
        b=YZhckqYNorCZdTEc3t1WVp/PcmNGDIFXB+6h5Cp+OQlMc/i+kyDmZueJ9OrEJRSXWt
         Iip5jBaKMjhfg+G8RvPiTQubx9e+AqkijVVpP1R9XYLzzGXEghD1skrjkRL6SxrvDrtn
         gu+BGgg7be+Jqc2YnzMrKWvg0SWD6NgdzI0AIj6Zi++lctlkynWTFEWbMQAEtbHH9WL8
         XEptzK634qUXJ3WCyZffGycCau2JVRUK6R4LjjvlPnfqN6RKiPMJdqsmyJti3SXkh+5m
         +1AxrECascrqN/RnCREs6ZbkG3CfpcjUkzjKL0GLmsN6VkGPzt18lpmydVeYV0M8s8JE
         eCLQ==
X-Gm-Message-State: ABy/qLbXIliHUhYEEPFdZsFhD1uTf3eUjDlOqaaiz8Dhv/CmPYxO38EQ
        kjxZejnEl8eUA6C9dDRZt5nw+7GFdAvz
X-Google-Smtp-Source: APBJJlH+XuKGiMZINgNw8yWcsXEolPvbXdHq/U9NqtvzLEZpwrbvXeLwSo8l0U9leRUi9exDJUTYfSO//Ea9
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:a54:d53d:50e4:b5b8])
 (user=mshavit job=sendgmr) by 2002:a81:ad27:0:b0:581:3899:91bc with SMTP id
 l39-20020a81ad27000000b00581389991bcmr118889ywh.6.1690915140864; Tue, 01 Aug
 2023 11:39:00 -0700 (PDT)
Date:   Wed,  2 Aug 2023 02:35:19 +0800
In-Reply-To: <20230801183845.4026101-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230801183845.4026101-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230802023524.v3.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
Subject: [PATCH v3 2/8] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, will@kernel.org, jean-philippe@linaro.org,
        jgg@nvidia.com, nicolinc@nvidia.com,
        Michael Shavit <mshavit@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove struct arm_smmu_s1_cfg. This is really just a CD table with a
bit of extra information. Enhance the existing CD table structure,
struct arm_smmu_ctx_desc_cfg, with max_cds_bits and replace all usages
of arm_smmu_s1_cfg with arm_smmu_ctx_desc_cfg.

Compute the other values that were stored in s1cfg directly from
existing arm_smmu_ctx_desc_cfg.

For clarity, use the name "cd_table" for the variables pointing to
arm_smmu_ctx_desc_cfg in the new code instead of cdcfg. A later patch
will make this fully consistent.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v3:
- Updated commit messages again
- Replace more usages of cdcfg with cdtable (lines that were already
  touched by this commit anyways).

Changes in v2:
- Updated commit message

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 10 ++---
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index bb277ff86f65f..ded613aedbb04 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1033,9 +1033,9 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
-	if (smmu_domain->s1_cfg.s1fmt == STRTAB_STE_0_S1FMT_LINEAR)
+	if (!cdcfg->l1_desc)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
 
 	idx = ssid >> CTXDESC_SPLIT;
@@ -1071,7 +1071,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	bool cd_live;
 	__le64 *cdptr;
 
-	if (WARN_ON(ssid >= (1 << smmu_domain->s1_cfg.s1cdmax)))
+	if (WARN_ON(ssid >= (1 << smmu_domain->cd_table.max_cds_bits)))
 		return -E2BIG;
 
 	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
@@ -1138,19 +1138,16 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain)
 	size_t l1size;
 	size_t max_contexts;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &cfg->cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
-	max_contexts = 1 << cfg->s1cdmax;
+	max_contexts = 1 << cdcfg->max_cds_bits;
 
 	if (!(smmu->features & ARM_SMMU_FEAT_2_LVL_CDTAB) ||
 	    max_contexts <= CTXDESC_L2_ENTRIES) {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_LINEAR;
 		cdcfg->num_l1_ents = max_contexts;
 
 		l1size = max_contexts * (CTXDESC_CD_DWORDS << 3);
 	} else {
-		cfg->s1fmt = STRTAB_STE_0_S1FMT_64K_L2;
 		cdcfg->num_l1_ents = DIV_ROUND_UP(max_contexts,
 						  CTXDESC_L2_ENTRIES);
 
@@ -1186,7 +1183,7 @@ static void arm_smmu_free_cd_tables(struct arm_smmu_domain *smmu_domain)
 	int i;
 	size_t size, l1size;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->s1_cfg.cdcfg;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
 	if (cdcfg->l1_desc) {
 		size = CTXDESC_L2_ENTRIES * (CTXDESC_CD_DWORDS << 3);
@@ -1276,7 +1273,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	u64 val = le64_to_cpu(dst[0]);
 	bool ste_live = false;
 	struct arm_smmu_device *smmu = NULL;
-	struct arm_smmu_s1_cfg *s1_cfg = NULL;
+	struct arm_smmu_ctx_desc_cfg *cd_table = NULL;
 	struct arm_smmu_s2_cfg *s2_cfg = NULL;
 	struct arm_smmu_domain *smmu_domain = NULL;
 	struct arm_smmu_cmdq_ent prefetch_cmd = {
@@ -1294,7 +1291,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	if (smmu_domain) {
 		switch (smmu_domain->stage) {
 		case ARM_SMMU_DOMAIN_S1:
-			s1_cfg = &smmu_domain->s1_cfg;
+			cd_table = &smmu_domain->cd_table;
 			break;
 		case ARM_SMMU_DOMAIN_S2:
 		case ARM_SMMU_DOMAIN_NESTED:
@@ -1325,7 +1322,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	val = STRTAB_STE_0_V;
 
 	/* Bypass/fault */
-	if (!smmu_domain || !(s1_cfg || s2_cfg)) {
+	if (!smmu_domain || !(cd_table || s2_cfg)) {
 		if (!smmu_domain && disable_bypass)
 			val |= FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_ABORT);
 		else
@@ -1344,7 +1341,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		return;
 	}
 
-	if (s1_cfg) {
+	if (cd_table) {
 		u64 strw = smmu->features & ARM_SMMU_FEAT_E2H ?
 			STRTAB_STE_1_STRW_EL2 : STRTAB_STE_1_STRW_NSEL1;
 
@@ -1360,10 +1357,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 		    !master->stall_enabled)
 			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
 
-		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
-			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
-			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
-			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
+		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
+		       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
+		       FIELD_PREP(STRTAB_STE_0_S1CDMAX,
+				  cd_table->max_cds_bits) |
+		       FIELD_PREP(STRTAB_STE_0_S1FMT,
+				  cd_table->l1_desc ?
+					  STRTAB_STE_0_S1FMT_64K_L2 :
+					  STRTAB_STE_0_S1FMT_LINEAR);
 	}
 
 	if (s2_cfg) {
@@ -2082,11 +2083,11 @@ static void arm_smmu_domain_free(struct iommu_domain *domain)
 
 	/* Free the CD and ASID, if we allocated them */
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
-		struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+		struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 
 		/* Prevent SVA from touching the CD while we're freeing it */
 		mutex_lock(&arm_smmu_asid_lock);
-		if (cfg->cdcfg.cdtab)
+		if (cd_table->cdtab)
 			arm_smmu_free_cd_tables(smmu_domain);
 		arm_smmu_free_asid(&smmu_domain->cd);
 		mutex_unlock(&arm_smmu_asid_lock);
@@ -2106,7 +2107,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	u32 asid;
 	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_s1_cfg *cfg = &smmu_domain->s1_cfg;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &smmu_domain->cd_table;
 	struct arm_smmu_ctx_desc *cd = &smmu_domain->cd;
 	typeof(&pgtbl_cfg->arm_lpae_s1_cfg.tcr) tcr = &pgtbl_cfg->arm_lpae_s1_cfg.tcr;
 
@@ -2119,7 +2120,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 	if (ret)
 		goto out_unlock;
 
-	cfg->s1cdmax = master->ssid_bits;
+	cd_table->max_cds_bits = master->ssid_bits;
 
 	smmu_domain->stall_enabled = master->stall_enabled;
 
@@ -2457,7 +2458,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   master->ssid_bits != smmu_domain->s1_cfg.s1cdmax) {
+		   master->ssid_bits != smmu_domain->cd_table.max_cds_bits) {
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f841383a55a35..35a93e8858872 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -595,12 +595,8 @@ struct arm_smmu_ctx_desc_cfg {
 	dma_addr_t			cdtab_dma;
 	struct arm_smmu_l1_ctx_desc	*l1_desc;
 	unsigned int			num_l1_ents;
-};
-
-struct arm_smmu_s1_cfg {
-	struct arm_smmu_ctx_desc_cfg	cdcfg;
-	u8				s1fmt;
-	u8				s1cdmax;
+	/* log2 of the maximum number of CDs supported by this table */
+	u8				max_cds_bits;
 };
 
 struct arm_smmu_s2_cfg {
@@ -725,7 +721,7 @@ struct arm_smmu_domain {
 	union {
 		struct {
 		struct arm_smmu_ctx_desc	cd;
-		struct arm_smmu_s1_cfg		s1_cfg;
+		struct arm_smmu_ctx_desc_cfg	cd_table;
 		};
 		struct arm_smmu_s2_cfg	s2_cfg;
 	};
-- 
2.41.0.585.gd2178a4bd4-goog

