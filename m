Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 598DD76E553
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235265AbjHCKOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjHCKOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:14:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4693211F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:14:12 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d087ffcc43cso828566276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057652; x=1691662452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IgE52kHcfRPOfED/lVwbKZpQuW1B4++XZftllscpWsM=;
        b=j2OVAQZZ7MDjPx3io3qsYNX350Y8kbR8uyyFo4vpsvU1CTrDPyy339XvDoTtkCfLKl
         hjuPhFUVdHds84l/I3DUxRLC11T1vIyAbXfh7nF0cLGUVaaLcssV1ZPLXJgRWTlUXiiS
         sAPOWKRpC4CWBpE5Tosmj7zGbyCzgLSkhayxDyzvH6arF2iY/dL3u2xXVqZfXf/BeTpc
         3RHFbmb6uv9SkPCVhpZcis7e3ORDX//7PRXqKm2A1GBAsk3u9SrbHtdu+VCbDrNZeWpe
         JLQ2yz0xlOAwyFQGIXMYDDWqpsno2z24Vp47ND8adkdHa2UB5BBeMjjKzlqDfGOkFwSt
         Rsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057652; x=1691662452;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IgE52kHcfRPOfED/lVwbKZpQuW1B4++XZftllscpWsM=;
        b=aFVRM9CuYOT0i0xH8Cjj5DocuB1T+eR/rMCnxRsvhpXXEVweEDPe5qxvg3NI8k7W/a
         9C2TPr7tGUrxQ4KfSP8mg/mQOOzLvjprkBLg1VN4E/Bn42BxPa3Z2N+UZ8DDbVLVRGkp
         8Jfui4mog6/KLEpVOQwiAV7ZGJ5XwaH3qalhFYZYsvXgy0NZiwre0rP3zDMAdgFyYuL6
         LZva5icVFLfGaS7nl1WZDNM+PRXSw9FkP1VLjbfEX0buHZpfe6h89od+9TPHhTgQqC1Z
         /GLHC98ErJ3FIAc8xAOG8RiVHQ5mqBmRhxZI6Q3wjnxZOlmHhYH3GAnfk8dxzNqk3D16
         uQSw==
X-Gm-Message-State: ABy/qLY0M2OM18NHakaqs75qMgbQeBL6goyjM69+33EjQ8ZI65qfyNQu
        tGDloNVReIHtDMjfJQQx4D8CTUGJ78ur
X-Google-Smtp-Source: APBJJlEgEds+gT/fNLvAp8/c4zfzgVx9Ij/FBCk6jJtg1pjmXeqiokAEkZmsWVgHFgnyT7rhESChAa4lqPAv
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:48a:0:b0:d37:353:b7eb with SMTP id
 132-20020a25048a000000b00d370353b7ebmr74807ybe.11.1691057651922; Thu, 03 Aug
 2023 03:14:11 -0700 (PDT)
Date:   Thu,  3 Aug 2023 18:12:22 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.2.I8db07b9eaef3bd5ef9bfc5c8c6d44768a4d95293@changeid>
Subject: [PATCH v5 2/6] iommu/arm-smmu-v3: Keep track of attached ssids
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     baolu.lu@linux.intel.com, will@kernel.org, jgg@nvidia.com,
        jean-philippe@linaro.org, robin.murphy@arm.com,
        nicolinc@nvidia.com, Michael Shavit <mshavit@google.com>
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

The arm-smmu-v3 driver keeps track of all masters that a domain is
attached to so that it can re-write their STEs when the domain's ASID is
upated by SVA. This tracking is also used to invalidate ATCs on all
masters that a domain is attached to.

This change introduces a new data structures to track all the CD entries
that a domain is attached to. This change is a pre-requisite to allow
domain attachment on non 0 SSIDs.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v5:
- Renamed domain_head to list for consistency with other lists
- Renamed attached_domains to attached_ssids to avoid confusion. This is
  a list of master/ssid pairs the domain is attached to, not a list of
  other domains.

Changes in v4:
- Remove reference to the master's domain accidentally re-introduced
  during a rebase.  Make arm_smmu_atc_inv_domain static.

Changes in v2:
- Fix arm_smmu_atc_inv_cmd_set_ssid and other cosmetic changes

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 28 ++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 99 +++++++++++--------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 22 ++++-
 3 files changed, 98 insertions(+), 51 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index e3992a0c16377..d80c39e7e2fb5 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -37,21 +37,35 @@ struct arm_smmu_bond {
 
 static DEFINE_MUTEX(sva_lock);
 
+/*
+ * When ssid is 0, update all the CD entries that this domain is attached to.
+ * When ssid is non-zero, write the CD into all the masters where this domain is
+ * the primary domain, with the provided SSID. This is used because SVA still
+ * piggybacks over the primary domain.
+ */
 static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
 					    int ssid,
 					    struct arm_smmu_ctx_desc *cd)
 {
+	struct arm_smmu_attached_domain *attached_domain;
 	struct arm_smmu_master *master;
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		ret = arm_smmu_write_ctx_desc(master, ssid, cd);
+	spin_lock_irqsave(&smmu_domain->attached_ssids_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_ssids,
+			    list) {
+		master = attached_domain->master;
+		if (ssid && attached_domain->ssid == 0) {
+			ret = arm_smmu_write_ctx_desc(master, ssid, cd);
+		} else {
+			ret = arm_smmu_write_ctx_desc(
+				master, attached_domain->ssid, cd);
+		}
 		if (ret)
 			break;
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_ssids_lock, flags);
 	return ret;
 }
 
@@ -222,7 +236,7 @@ static void arm_smmu_mm_invalidate_range(struct mmu_notifier *mn,
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_BTM))
 		arm_smmu_tlb_inv_range_asid(start, size, smmu_mn->cd->asid,
 					    PAGE_SIZE, false, smmu_domain);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, start, size);
+	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, start, size);
 }
 
 static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -243,7 +257,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
-	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+	arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
 
 	smmu_mn->cleared = true;
 	mutex_unlock(&sva_lock);
@@ -333,7 +347,7 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 	 */
 	if (!smmu_mn->cleared) {
 		arm_smmu_tlb_inv_asid(smmu_domain->smmu, cd->asid);
-		arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
+		arm_smmu_atc_inv_domain_ssid(smmu_domain, mm->pasid, 0, 0);
 	}
 
 	/* Frees smmu_mn */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4df335424b266..6e614ad12fb48 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1282,7 +1282,7 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
 	};
 
 	if (master) {
-		smmu_domain = master->domain;
+		smmu_domain = master->non_pasid_domain.domain;
 		smmu = master->smmu;
 	}
 
@@ -1725,7 +1725,14 @@ static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
 }
 
 static void
-arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
+arm_smmu_atc_inv_cmd_set_ssid(int ssid, struct arm_smmu_cmdq_ent *cmd)
+{
+	cmd->substream_valid = !!ssid;
+	cmd->atc.ssid = ssid;
+}
+
+static void
+arm_smmu_atc_inv_to_cmd(unsigned long iova, size_t size,
 			struct arm_smmu_cmdq_ent *cmd)
 {
 	size_t log2_span;
@@ -1750,8 +1757,8 @@ arm_smmu_atc_inv_to_cmd(int ssid, unsigned long iova, size_t size,
 	 */
 	*cmd = (struct arm_smmu_cmdq_ent) {
 		.opcode			= CMDQ_OP_ATC_INV,
-		.substream_valid	= !!ssid,
-		.atc.ssid		= ssid,
+		.substream_valid	= false,
+		.atc.ssid		= 0,
 	};
 
 	if (!size) {
@@ -1797,8 +1804,7 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_cmdq_batch cmds;
 
-	arm_smmu_atc_inv_to_cmd(0, 0, 0, &cmd);
-
+	arm_smmu_atc_inv_to_cmd(0, 0, &cmd);
 	cmds.num = 0;
 	for (i = 0; i < master->num_streams; i++) {
 		cmd.atc.sid = master->streams[i].id;
@@ -1808,13 +1814,19 @@ static int arm_smmu_atc_inv_master(struct arm_smmu_master *master)
 	return arm_smmu_cmdq_batch_submit(master->smmu, &cmds);
 }
 
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-			    unsigned long iova, size_t size)
+/*
+ * If ssid is non-zero, issue atc invalidations with the given ssid instead of
+ * the one the domain is attached to. This is used by SVA since it's pasid
+ * attachments aren't recorded in smmu_domain yet.
+ */
+int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
+				 unsigned long iova, size_t size)
 {
 	int i;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
+	struct arm_smmu_attached_domain *attached_domain;
 	struct arm_smmu_cmdq_batch cmds;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
@@ -1837,25 +1849,37 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 	if (!atomic_read(&smmu_domain->nr_ats_masters))
 		return 0;
 
-	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
+	arm_smmu_atc_inv_to_cmd(iova, size, &cmd);
 
 	cmds.num = 0;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+	spin_lock_irqsave(&smmu_domain->attached_ssids_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_ssids,
+			    list) {
+		master = attached_domain->master;
 		if (!master->ats_enabled)
 			continue;
+		if (ssid != 0)
+			arm_smmu_atc_inv_cmd_set_ssid(ssid, &cmd);
+		else
+			arm_smmu_atc_inv_cmd_set_ssid(attached_domain->ssid, &cmd);
 
 		for (i = 0; i < master->num_streams; i++) {
 			cmd.atc.sid = master->streams[i].id;
 			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
 		}
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->attached_ssids_lock, flags);
 
 	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
 }
 
+static int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain,
+				   unsigned long iova, size_t size)
+{
+	return arm_smmu_atc_inv_domain_ssid(smmu_domain, 0, iova, size);
+}
+
 /* IO_PGTABLE API */
 static void arm_smmu_tlb_inv_context(void *cookie)
 {
@@ -1877,7 +1901,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
 		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
 		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
 	}
-	arm_smmu_atc_inv_domain(smmu_domain, 0, 0, 0);
+	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
 }
 
 static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
@@ -1970,7 +1994,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
 	 * Unfortunately, this can't be leaf-only since we may have
 	 * zapped an entire table.
 	 */
-	arm_smmu_atc_inv_domain(smmu_domain, 0, iova, size);
+	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
 }
 
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
@@ -2050,8 +2074,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 
 	mutex_init(&smmu_domain->init_mutex);
-	INIT_LIST_HEAD(&smmu_domain->devices);
-	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->attached_ssids);
+	spin_lock_init(&smmu_domain->attached_ssids_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
@@ -2289,12 +2313,12 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
 }
 
-static void arm_smmu_enable_ats(struct arm_smmu_master *master)
+static void arm_smmu_enable_ats(struct arm_smmu_master *master,
+				struct arm_smmu_domain *smmu_domain)
 {
 	size_t stu;
 	struct pci_dev *pdev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	/* Don't enable ATS at the endpoint if it's not enabled in the STE */
 	if (!master->ats_enabled)
@@ -2310,10 +2334,9 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
 		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
 }
 
-static void arm_smmu_disable_ats(struct arm_smmu_master *master)
+static void arm_smmu_disable_ats(struct arm_smmu_master *master,
+				 struct arm_smmu_domain *smmu_domain)
 {
-	struct arm_smmu_domain *smmu_domain = master->domain;
-
 	if (!master->ats_enabled)
 		return;
 
@@ -2377,19 +2400,19 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 {
 	unsigned long flags;
-	struct arm_smmu_domain *smmu_domain = master->domain;
+	struct arm_smmu_domain *smmu_domain = master->non_pasid_domain.domain;
 
 	if (!smmu_domain)
 		return;
 
-	arm_smmu_disable_ats(master);
+	arm_smmu_disable_ats(master, smmu_domain);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_lock_irqsave(&smmu_domain->attached_ssids_lock, flags);
+	list_del(&master->non_pasid_domain.list);
+	spin_unlock_irqrestore(&smmu_domain->attached_ssids_lock, flags);
 
-	master->domain = NULL;
 	master->ats_enabled = false;
+	master->non_pasid_domain.domain = NULL;
 	arm_smmu_install_ste_for_dev(master);
 }
 
@@ -2434,8 +2457,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (ret)
 		return ret;
 
-	master->domain = smmu_domain;
-
 	/*
 	 * The SMMU does not support enabling ATS with bypass. When the STE is
 	 * in bypass (STE.Config[2:0] == 0b100), ATS Translation Requests and
@@ -2449,26 +2470,26 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		if (!master->cd_table.cdtab) {
 			ret = arm_smmu_alloc_cd_tables(master);
-			if (ret) {
-				master->domain = NULL;
+			if (ret)
 				return ret;
-			}
 		}
 
 		ret = arm_smmu_write_ctx_desc(master, 0, &smmu_domain->cd);
-		if (ret) {
-			master->domain = NULL;
+		if (ret)
 			return ret;
-		}
 	}
 
+	master->non_pasid_domain.master = master;
+	master->non_pasid_domain.domain = smmu_domain;
+	master->non_pasid_domain.ssid = 0;
 	arm_smmu_install_ste_for_dev(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master->domain_head, &smmu_domain->devices);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_lock_irqsave(&smmu_domain->attached_ssids_lock, flags);
+	list_add(&master->non_pasid_domain.list,
+		 &smmu_domain->attached_ssids);
+	spin_unlock_irqrestore(&smmu_domain->attached_ssids_lock, flags);
 
-	arm_smmu_enable_ats(master);
+	arm_smmu_enable_ats(master, smmu_domain);
 	return 0;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index e76452e735a04..66a492cafe2e8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -689,11 +689,19 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+/* List of {masters, ssid} that a domain is attached to */
+struct arm_smmu_attached_domain {
+	struct list_head	list;
+	struct arm_smmu_domain  *domain;
+	struct arm_smmu_master  *master;
+	int			ssid;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
-	struct arm_smmu_domain		*domain;
+	struct arm_smmu_attached_domain	non_pasid_domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
 	/* Locked by the iommu core using the group mutex */
@@ -730,8 +738,12 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
-	struct list_head		devices;
-	spinlock_t			devices_lock;
+	/*
+	 * List of arm_smmu_attached_domain nodes used to track all the
+	 * {master, ssid} pairs that this domain is attached to.
+	 */
+	struct list_head		attached_ssids;
+	spinlock_t			attached_ssids_lock;
 
 	struct list_head		mmu_notifiers;
 };
@@ -752,8 +764,8 @@ void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
 				 size_t granule, bool leaf,
 				 struct arm_smmu_domain *smmu_domain);
 bool arm_smmu_free_asid(struct arm_smmu_ctx_desc *cd);
-int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
-			    unsigned long iova, size_t size);
+int arm_smmu_atc_inv_domain_ssid(struct arm_smmu_domain *smmu_domain, int ssid,
+				 unsigned long iova, size_t size);
 
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
-- 
2.41.0.585.gd2178a4bd4-goog

