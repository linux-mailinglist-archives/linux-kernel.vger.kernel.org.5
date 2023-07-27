Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF033765B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjG0S3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjG0S3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:29:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADECA3A93
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1c693a29a0so1189912276.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482524; x=1691087324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+XaGd+lwmmXR+GwY2bhB+F0bLXGMG0FsoADNP9UKHU8=;
        b=Huzupw64sQ/oWwysOfLmhuKKq5ezb7uwjHPZBSsdr6XWlTxvU2K2QP3P/wRmkdpDGD
         tq/+YhrQeuzdxwuMEm4VYigUYBzwf4uSbu1Aplmihx0AWxrz0+phc6K4ysD6G8y2PZqV
         BqBHU1gDYgwsI203BLEXWtBnnJQvcMC/96My9UeGutQt1X5LEOrwHiAswcWTW/o7sORX
         +9TTvh4hse2+6AWY44EWdI6u+JrENv/wpKSCeMQ+gL68XtXOImZazqSmSAoTeKK/D3Uj
         8k92PCBuIT99JYmXwrccgPi5TZPD1dPor4lv3neNU++nBnW5Kevp+cc/OD62SCFgz3m0
         6I4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482524; x=1691087324;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XaGd+lwmmXR+GwY2bhB+F0bLXGMG0FsoADNP9UKHU8=;
        b=XbZV+Nwzbk+Wts29R4g+BFNvYWUjXhutRZtXtEWjJsAlYRUj1jzYe3UcUBjBQFq3jI
         O2lDfvS53nedGLxFCnBBOQE8rqpZbYs614ovpKHmbLGAsDNl3JHRhWy7IdZgQEnETnLS
         sYZpVv1NpUYCUrfnffqYbpLQyQ5V1y+CQcOX+LPOCoP54cnfkFK8TN7aVxWC5fOegT+Z
         XHH6Wkq7DFvkq3m+wg/WdgP+t4A0pEJK2uJ48jtf9NlZtZpcOMaHr6Ag5DtfKD9DaxsV
         qO42JWJThX48v+rImGUI/MCoL7SOWaQJENT6lSlZP9RdQ49kUSo16G0Sd/9rJIKCff6y
         WYoA==
X-Gm-Message-State: ABy/qLY4QkkGqVit+RMWxwpzFnIQQoSdaxgS85mqFqIp7CswbOmudv9c
        cRxbNPFzZdu2PM3dvOYDKDt95tv9fHrL
X-Google-Smtp-Source: APBJJlHjlnMoZFxsUPTe/Ly5UNfbHsT4f693Ment4uzBAWhKL9NWDrwQcAuZdzW+xN/vwW2ciQBVXhYKwo7O
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:780f:26da:d952:3463])
 (user=mshavit job=sendgmr) by 2002:a25:74cc:0:b0:d07:cb52:a3cf with SMTP id
 p195-20020a2574cc000000b00d07cb52a3cfmr1052ybc.5.1690482524004; Thu, 27 Jul
 2023 11:28:44 -0700 (PDT)
Date:   Fri, 28 Jul 2023 02:26:22 +0800
In-Reply-To: <20230727182647.4106140-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230727182647.4106140-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230727182647.4106140-7-mshavit@google.com>
Subject: [PATCH v1 6/7] iommu/arm-smmu-v3: Refactor write_ctx_desc
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

Update arm_smmu_write_ctx_desc and downstream functions to operate on
a master instead of an smmu domain. We expect arm_smmu_write_ctx_desc()
to only be called to write a CD entry into a CD table owned by the
master. Under the hood, arm_smmu_write_ctx_desc still fetches the CD
table from the domain that is attached to the master, but a subsequent
commit will move that table's ownership to the master.

Note that this change isn't a nop refactor since SVA will call
arm_smmu_write_ctx_desc in a loop for every master the domain is
attached to despite the fact that they all share the same CD table. This
loop may look weird but becomes necessary when the CD table becomes
per-master in a subsequent commit.

Signed-off-by: Michael Shavit <mshavit@google.com>
---
v4->v5: arm_smmu_write_ctx_desc now get's the CD table to write to from
the master parameter instead of a distinct parameter. This works well
because the CD table being written to should always be owned by the
master by the end of this series. This version no longer allows master
to be NULL.
---
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 33 ++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 61 ++++++++-----------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 3 files changed, 54 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 968559d625c40..57073d278cd7e 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -45,10 +45,12 @@ static struct arm_smmu_ctx_desc *
 arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 {
 	int ret;
+	unsigned long flags;
 	u32 new_asid;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_master *master;
 
 	cd = xa_load(&arm_smmu_asid_xa, asid);
 	if (!cd)
@@ -80,7 +82,11 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		arm_smmu_write_ctx_desc(master, 0, cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
@@ -211,6 +217,8 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 {
 	struct arm_smmu_mmu_notifier *smmu_mn = mn_to_smmu(mn);
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
+	struct arm_smmu_master *master;
+	unsigned long flags;
 
 	mutex_lock(&sva_lock);
 	if (smmu_mn->cleared) {
@@ -222,7 +230,11 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		arm_smmu_write_ctx_desc(master, mm->pasid, &quiet_cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
@@ -248,8 +260,10 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 			  struct mm_struct *mm)
 {
 	int ret;
+	unsigned long flags;
 	struct arm_smmu_ctx_desc *cd;
 	struct arm_smmu_mmu_notifier *smmu_mn;
+	struct arm_smmu_master *master;
 
 	list_for_each_entry(smmu_mn, &smmu_domain->mmu_notifiers, list) {
 		if (smmu_mn->mn.mm == mm) {
@@ -279,7 +293,11 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		ret = arm_smmu_write_ctx_desc(master, mm->pasid, cd);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 	if (ret)
 		goto err_put_notifier;
 
@@ -296,15 +314,22 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 
 static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 {
+	unsigned long flags;
 	struct mm_struct *mm = smmu_mn->mn.mm;
 	struct arm_smmu_ctx_desc *cd = smmu_mn->cd;
+	struct arm_smmu_master *master;
 	struct arm_smmu_domain *smmu_domain = smmu_mn->domain;
 
 	if (!refcount_dec_and_test(&smmu_mn->refs))
 		return;
 
 	list_del(&smmu_mn->list);
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		arm_smmu_write_ctx_desc(master, mm->pasid, NULL);
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index af7949b62327b..b211424a85fb2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -971,14 +971,12 @@ void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid)
 	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 }
 
-static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
+static void arm_smmu_sync_cd(struct arm_smmu_master *master,
 			     int ssid, bool leaf)
 {
 	size_t i;
-	unsigned long flags;
-	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_device *smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
 		.cfgi	= {
@@ -987,19 +985,15 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 		},
 	};
 
-	if (!smmu_domain->cd_table.installed)
+	if (!master->domain->cd_table.installed)
 		return;
 
+	smmu = master->smmu;
 	cmds.num = 0;
-
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		for (i = 0; i < master->num_streams; i++) {
-			cmd.cfgi.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
-		}
+	for (i = 0; i < master->num_streams; i++) {
+		cmd.cfgi.sid = master->streams[i].id;
+		arm_smmu_cmdq_batch_add(smmu, &cmds, &cmd);
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
 
 	arm_smmu_cmdq_batch_submit(smmu, &cmds);
 }
@@ -1029,14 +1023,12 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
 	WRITE_ONCE(*dst, cpu_to_le64(val));
 }
 
-static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
-				   u32 ssid)
+static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_master *master, u32 ssid)
 {
 	__le64 *l1ptr;
 	unsigned int idx;
 	struct arm_smmu_l1_ctx_desc *l1_desc;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
-	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->domain->cd_table;
 
 	if (!cdcfg->l1_desc)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
@@ -1044,19 +1036,19 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
 	idx = ssid >> CTXDESC_SPLIT;
 	l1_desc = &cdcfg->l1_desc[idx];
 	if (!l1_desc->l2ptr) {
-		if (arm_smmu_alloc_cd_leaf_table(smmu, l1_desc))
+		if (arm_smmu_alloc_cd_leaf_table(master->smmu, l1_desc))
 			return NULL;
 
 		l1ptr = cdcfg->cdtab + idx * CTXDESC_L1_DESC_DWORDS;
 		arm_smmu_write_cd_l1_desc(l1ptr, l1_desc);
 		/* An invalid L1CD can be cached */
-		arm_smmu_sync_cd(smmu_domain, ssid, false);
+		arm_smmu_sync_cd(master, ssid, false);
 	}
 	idx = ssid & (CTXDESC_L2_ENTRIES - 1);
 	return l1_desc->l2ptr + idx * CTXDESC_CD_DWORDS;
 }
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
 			    struct arm_smmu_ctx_desc *cd)
 {
 	/*
@@ -1073,11 +1065,12 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	u64 val;
 	bool cd_live;
 	__le64 *cdptr;
+	struct arm_smmu_ctx_desc_cfg *cd_table = &master->domain->cd_table;
 
-	if (WARN_ON(ssid >= (1 << smmu_domain->cd_table.max_cds_bits)))
+	if (WARN_ON(ssid >= (1 << cd_table->max_cds_bits)))
 		return -E2BIG;
 
-	cdptr = arm_smmu_get_cd_ptr(smmu_domain, ssid);
+	cdptr = arm_smmu_get_cd_ptr(master, ssid);
 	if (!cdptr)
 		return -ENOMEM;
 
@@ -1101,11 +1094,11 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		cdptr[3] = cpu_to_le64(cd->mair);
 
 		/*
-		 * STE is live, and the SMMU might read dwords of this CD in any
-		 * order. Ensure that it observes valid values before reading
-		 * V=1.
+		 * STE may be live, and the SMMU might read dwords of this CD
+		 * in any order. Ensure that it observes valid values before
+		 * reading V=1.
 		 */
-		arm_smmu_sync_cd(smmu_domain, ssid, true);
+		arm_smmu_sync_cd(master, ssid, true);
 
 		val = cd->tcr |
 #ifdef __BIG_ENDIAN
@@ -1117,7 +1110,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		if (smmu_domain->cd_table.stall_enabled)
+		if (cd_table->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1131,7 +1124,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	 *   without first making the structure invalid.
 	 */
 	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
-	arm_smmu_sync_cd(smmu_domain, ssid, true);
+	arm_smmu_sync_cd(master, ssid, true);
 	return 0;
 }
 
@@ -1141,7 +1134,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
 	cdcfg->stall_enabled = master->stall_enabled;
@@ -2141,12 +2134,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
 			  CTXDESC_CD_0_TCR_EPD1 | CTXDESC_CD_0_AA64;
 	cd->mair	= pgtbl_cfg->arm_lpae_s1_cfg.mair;
 
-	/*
-	 * Note that this will end up calling arm_smmu_sync_cd() before
-	 * the master has been added to the devices list for this domain.
-	 * This isn't an issue because the STE hasn't been installed yet.
-	 */
-	ret = arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+	ret = arm_smmu_write_ctx_desc(master, 0, cd);
 	if (ret)
 		goto out_free_cd_tables;
 
@@ -2464,8 +2452,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		ret = -EINVAL;
 		goto out_unlock;
 	} else if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1 &&
-		   smmu_domain->cd_table.stall_enabled !=
-			   master->stall_enabled) {
+		   smmu_domain->cd_table.stall_enabled != master->stall_enabled) {
 		ret = -EINVAL;
 		goto out_unlock;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index f301efe90b599..a8cc2de0cc254 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -746,7 +746,7 @@ extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-- 
2.41.0.585.gd2178a4bd4-goog

