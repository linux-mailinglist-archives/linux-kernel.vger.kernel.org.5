Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A9B77454D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbjHHSkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHHSkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:40:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541A56EEB6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:15:19 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5866e5f6e40so1472117b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 10:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691514918; x=1692119718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=y485cKhIek9vLyhbIqTDI2uIvUa5x+w2+I39ANa4D/w=;
        b=uEY73wszzzOLG1JA65e+H9Z9RjGrEmvBK3PxgOfsJcnluIiqzYvqkyznwz8jaWR81G
         LRuT9iGpK8HJLhDzbedCQ4r8DreivUwB+WD3vhLR9at3XH5G3jWjqE92uO/ISy6Y/7SI
         7HteSLLUtqS6zgaaNdcmU+ucNqTQbuep/fcdniKN1iYhVnOt4X6n8nisj+PhALggDiDb
         0aXNRzCBisr5u/cLCNOUR95lRq/NfvzJyZjcrzw6YJEI1XCFcFs55JS0dhKDnIbZZSdh
         gCcJ5ocdrIttaBgcEn8+6zmKJ53ZsN2o1bsLYXuP0p/oLirZHk8/UKEn5JS2FxqzLu7n
         nVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514918; x=1692119718;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y485cKhIek9vLyhbIqTDI2uIvUa5x+w2+I39ANa4D/w=;
        b=LfuHlOrHInWK1jX9F72N2k1M636X+4Uqiwa4c9tEqhqCEV3z8FZq40DZXQBo9bJxV2
         ub+p/p7zUEkniWawfz7ibobIj9veZoXVsxJornZSKyCuQyvPdW+Dp3PG28C6EewlmNzd
         1xv5nwLvHfUVuVW8X3YHlzj5VHFewqhdRLzct14w0HzKFQea2pYMekXk9GEnZxZFd7Dz
         ld79T7y8HF0B+gSDyn0jaoLKeV0Eyk+JdK/eG+PJttmgIF0uXRcWb0KwiBxff0d5hLdg
         Wm2wfGd3YuDGCjRUuGLpCJudAOSbVYTwP2SW5rxvzUsU1oa79oYhdriTz7Tvr6GAmyRN
         LEWg==
X-Gm-Message-State: AOJu0Ywh8uoWBc+Y8sHHKSECT4B3//AGfYXImU56RSEF1IcKniyTpZ61
        US+Idj41Ixi2IquCxHHS2wbKRVaKakZe
X-Google-Smtp-Source: AGHT+IGr45RvrRmmVpgPj6zgJscnE6QjI0W53c/9y5zZ4ElXZJycQEBIZLgstG+On7Eo70O13q0zG/zaVCGq
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:986a:71d7:3b1e:ac1d])
 (user=mshavit job=sendgmr) by 2002:a81:a7c1:0:b0:568:ed75:8b2f with SMTP id
 e184-20020a81a7c1000000b00568ed758b2fmr8823ywh.0.1691514918563; Tue, 08 Aug
 2023 10:15:18 -0700 (PDT)
Date:   Wed,  9 Aug 2023 01:12:01 +0800
In-Reply-To: <20230808171446.2187795-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230808171446.2187795-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230809011204.v5.5.I219054a6cf538df5bb22f4ada2d9933155d6058c@changeid>
Subject: [PATCH v5 5/9] iommu/arm-smmu-v3: Refactor write_ctx_desc
From:   Michael Shavit <mshavit@google.com>
To:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     will@kernel.org, robin.murphy@arm.com, nicolinc@nvidia.com,
        jgg@nvidia.com, jean-philippe@linaro.org,
        Michael Shavit <mshavit@google.com>
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

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Michael Shavit <mshavit@google.com>
---

(no changes since v3)

Changes in v3:
- Add a helper to write a CD to all masters that a domain is attached
  to.
- Fixed an issue where an arm_smmu_write_ctx_desc error return wasn't
  correctly handled by its caller.

Changes in v2:
- minor style fixes

Changes in v1:
- arm_smmu_write_ctx_desc now get's the CD table to write to from the
  master parameter instead of a distinct parameter. This works well
  because the CD table being written to should always be owned by the
  master by the end of this series. This version no longer allows master
  to be NULL.

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 31 +++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 51 +++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 +-
 3 files changed, 46 insertions(+), 38 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 968559d625c40..e3992a0c16377 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -37,6 +37,24 @@ struct arm_smmu_bond {
 
 static DEFINE_MUTEX(sva_lock);
 
+static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
+					    int ssid,
+					    struct arm_smmu_ctx_desc *cd)
+{
+	struct arm_smmu_master *master;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
+	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
+		ret = arm_smmu_write_ctx_desc(master, ssid, cd);
+		if (ret)
+			break;
+	}
+	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	return ret;
+}
+
 /*
  * Check if the CPU ASID is available on the SMMU side. If a private context
  * descriptor is using it, try to replace it.
@@ -80,7 +98,7 @@ arm_smmu_share_asid(struct mm_struct *mm, u16 asid)
 	 * be some overlap between use of both ASIDs, until we invalidate the
 	 * TLB.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, 0, cd);
+	arm_smmu_write_ctx_desc_devices(smmu_domain, 0, cd);
 
 	/* Invalidate TLB entries previously associated with that context */
 	arm_smmu_tlb_inv_asid(smmu, asid);
@@ -222,7 +240,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
 	 * but disable translation.
 	 */
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, &quiet_cd);
+	arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, &quiet_cd);
 
 	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_mn->cd->asid);
 	arm_smmu_atc_inv_domain(smmu_domain, mm->pasid, 0, 0);
@@ -279,9 +297,11 @@ arm_smmu_mmu_notifier_get(struct arm_smmu_domain *smmu_domain,
 		goto err_free_cd;
 	}
 
-	ret = arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, cd);
-	if (ret)
+	ret = arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, cd);
+	if (ret) {
+		arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
 		goto err_put_notifier;
+	}
 
 	list_add(&smmu_mn->list, &smmu_domain->mmu_notifiers);
 	return smmu_mn;
@@ -304,7 +324,8 @@ static void arm_smmu_mmu_notifier_put(struct arm_smmu_mmu_notifier *smmu_mn)
 		return;
 
 	list_del(&smmu_mn->list);
-	arm_smmu_write_ctx_desc(smmu_domain, mm->pasid, NULL);
+
+	arm_smmu_write_ctx_desc_devices(smmu_domain, mm->pasid, NULL);
 
 	/*
 	 * If we went through clear(), we've already invalidated, and no
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index c01023404c26c..34bd7815aeb8e 100644
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
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_cmdq_ent cmd = {
 		.opcode	= CMDQ_OP_CFGI_CD,
 		.cfgi	= {
@@ -988,15 +986,10 @@ static void arm_smmu_sync_cd(struct arm_smmu_domain *smmu_domain,
 	};
 
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
@@ -1026,14 +1019,13 @@ static void arm_smmu_write_cd_l1_desc(__le64 *dst,
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
+	struct arm_smmu_device *smmu = master->smmu;
+	struct arm_smmu_ctx_desc_cfg *cdcfg = &master->domain->cd_table;
 
 	if (!cdcfg->l1_desc)
 		return cdcfg->cdtab + ssid * CTXDESC_CD_DWORDS;
@@ -1047,13 +1039,13 @@ static __le64 *arm_smmu_get_cd_ptr(struct arm_smmu_domain *smmu_domain,
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
@@ -1070,11 +1062,12 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
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
 
@@ -1102,7 +1095,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 		 * order. Ensure that it observes valid values before reading
 		 * V=1.
 		 */
-		arm_smmu_sync_cd(smmu_domain, ssid, true);
+		arm_smmu_sync_cd(master, ssid, true);
 
 		val = cd->tcr |
 #ifdef __BIG_ENDIAN
@@ -1114,7 +1107,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 			FIELD_PREP(CTXDESC_CD_0_ASID, cd->asid) |
 			CTXDESC_CD_0_V;
 
-		if (smmu_domain->cd_table.stall_enabled)
+		if (cd_table->stall_enabled)
 			val |= CTXDESC_CD_0_S;
 	}
 
@@ -1128,7 +1121,7 @@ int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
 	 *   without first making the structure invalid.
 	 */
 	WRITE_ONCE(cdptr[0], cpu_to_le64(val));
-	arm_smmu_sync_cd(smmu_domain, ssid, true);
+	arm_smmu_sync_cd(master, ssid, true);
 	return 0;
 }
 
@@ -1138,7 +1131,7 @@ static int arm_smmu_alloc_cd_tables(struct arm_smmu_domain *smmu_domain,
 	int ret;
 	size_t l1size;
 	size_t max_contexts;
-	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct arm_smmu_device *smmu = master->smmu;
 	struct arm_smmu_ctx_desc_cfg *cdcfg = &smmu_domain->cd_table;
 
 	cdcfg->stall_enabled = master->stall_enabled;
@@ -2137,12 +2130,7 @@ static int arm_smmu_domain_finalise_s1(struct arm_smmu_domain *smmu_domain,
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
 
@@ -2460,8 +2448,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
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
index 05b1f0ee60808..6066a09c01996 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -744,7 +744,7 @@ extern struct xarray arm_smmu_asid_xa;
 extern struct mutex arm_smmu_asid_lock;
 extern struct arm_smmu_ctx_desc quiet_cd;
 
-int arm_smmu_write_ctx_desc(struct arm_smmu_domain *smmu_domain, int ssid,
+int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int ssid,
 			    struct arm_smmu_ctx_desc *cd);
 void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
 void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
-- 
2.41.0.640.ga95def55d0-goog

