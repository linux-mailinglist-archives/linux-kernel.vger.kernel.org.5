Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A128A77FDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354308AbjHQSXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354329AbjHQSWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:22:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491FA3AAF
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:06 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d62858b0914so2420220276.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 11:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692296472; x=1692901272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+2D70KRXNWhhcPVOCTxbPCzMxKwpJ9kMCl7BCRH1CBA=;
        b=gJr4ZsyQvZcjc2Pt/pveOp9R4MwHTIcB7oarl0HOsTGMYprA4U+50iabB0HHjnq7EU
         ycFLSKx6rqWi49wrijynWCNdiavuy2qDlPHvXNCWDfWHFqRINtDveCEXp6wcY9PKt/hV
         m0tCvaRJno6xBpQYyzb9DR8cAnM1njLUpHTn3ub/6IqMX+FJTN/ZBeEFsSJp5+M+Tzzq
         aWVlPPfUsS9KLy0CoTG33Imb7YpEKVL3dBKntBKNB7u0QAwZsl9eAdylIrcwwrK9ICDm
         Qs2bcTk0KpLxc/xGMZenHbjn5BToWLj/qAYPYI7Fo/t/30tte08VXPxPAtPGjjlHJJWd
         f68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692296472; x=1692901272;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+2D70KRXNWhhcPVOCTxbPCzMxKwpJ9kMCl7BCRH1CBA=;
        b=aIuCvfBkTb1YdgjSiLrES9i9tCKYPmFeSbcFFeGsR2s+1+YNAXoSaUi8AA2dtXGiyE
         m1J5PjL6mW3nLtZpIQ3xnKwihhx9YvwtOW+Ad0uwM76rdtMryjyK5TAbunGKwfiKihqB
         ecCBM8epciEThcsrFiThelWJPh1eAi/2vFCeG+VGZw3DKNNdsVmnNvfoRjjFy3EMgYRj
         GjzqTVwFxaR3yK0tH4XPPZn2XiUavpVPe2K1FSExVFyGFjxeAFsKwFkLHq9XU+BQN/FI
         aF8BvvUYRSinQEIDL9E+5NJZuGXA36vcz7maHmDPxX/uYM3847vRR8VUE680hJmig0l7
         NRaw==
X-Gm-Message-State: AOJu0YzYQUK+chGgWR4Sn4l/3CPeKr/ykgiKPmRJyjj6XnoXbrVTEsCL
        BMrZnqbgivhs26AGBNTy3+hckFpzzYtg
X-Google-Smtp-Source: AGHT+IEfGIdi50eVGb7u0h+TWz7zRSXVqh1WuPmcOmzYvjkcKgmVMU4WPccj8sV7aIFWIbA0pRIoE9IkWWP4
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:4a77:fd20:7069:bdf9])
 (user=mshavit job=sendgmr) by 2002:a25:d152:0:b0:ca3:3341:6315 with SMTP id
 i79-20020a25d152000000b00ca333416315mr4578ybg.0.1692296472695; Thu, 17 Aug
 2023 11:21:12 -0700 (PDT)
Date:   Fri, 18 Aug 2023 02:16:23 +0800
In-Reply-To: <20230817182055.1770180-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230817182055.1770180-1-mshavit@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230818021629.RFC.v1.1.I9df3dec9e33165276eba8e2dbf7025bfee286d90@changeid>
Subject: [RFC PATCH v1 1/8] iommu/arm-smmu-v3: Add list of installed_smmus
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

Add a new arm_smmu_installed_smmu class to aggregate masters belonging
to the same SMMU that a domain is attached to.
Update usages of the domain->devices list to first iterate over this
parent installed_smmus list.

This allows functions that batch commands to an SMMU to first iterate
over the list of installed SMMUs before preparing the batched command
from the set of attached masters.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  28 ++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 109 ++++++++++++++----
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  14 ++-
 3 files changed, 118 insertions(+), 33 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
index 238ede8368d10..a4e235b4f1c4b 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
@@ -48,21 +48,37 @@ static int arm_smmu_write_ctx_desc_devices(struct arm_smmu_domain *smmu_domain,
 					   int ssid,
 					   struct arm_smmu_ctx_desc *cd)
 {
+	struct arm_smmu_installed_smmu *installed_smmu;
 	struct arm_smmu_master *master;
 	unsigned long flags;
 	int ret;
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		ret = arm_smmu_write_ctx_desc(master, ssid, cd);
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus, list) {
+		list_for_each_entry(master, &installed_smmu->devices, list) {
+			ret = arm_smmu_write_ctx_desc(master, ssid, cd);
+			if (ret) {
+				list_for_each_entry_from_reverse(
+					master, &installed_smmu->devices, list)
+					arm_smmu_write_ctx_desc(master, ssid,
+								NULL);
+				break;
+			}
+		}
 		if (ret) {
-			list_for_each_entry_from_reverse(master, &smmu_domain->devices, domain_head)
-				arm_smmu_write_ctx_desc(master, ssid, NULL);
+			list_for_each_entry_continue_reverse(
+				installed_smmu, &smmu_domain->installed_smmus,
+				list) {
+				list_for_each_entry(
+					master, &installed_smmu->devices, list)
+					arm_smmu_write_ctx_desc(master, ssid,
+								NULL);
+			}
 			break;
 		}
 	}
 
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
 	return ret;
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index f17704c35858d..cb4bf0c7c3dd6 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1811,10 +1811,12 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 			    unsigned long iova, size_t size)
 {
 	int i;
+	int ret;
 	unsigned long flags;
 	struct arm_smmu_cmdq_ent cmd;
 	struct arm_smmu_master *master;
 	struct arm_smmu_cmdq_batch cmds;
+	struct arm_smmu_installed_smmu *installed_smmu;
 
 	if (!(smmu_domain->smmu->features & ARM_SMMU_FEAT_ATS))
 		return 0;
@@ -1838,21 +1840,26 @@ int arm_smmu_atc_inv_domain(struct arm_smmu_domain *smmu_domain, int ssid,
 
 	arm_smmu_atc_inv_to_cmd(ssid, iova, size, &cmd);
 
-	cmds.num = 0;
-
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_for_each_entry(master, &smmu_domain->devices, domain_head) {
-		if (!master->ats_enabled)
-			continue;
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus, list) {
+		cmds.num = 0;
+		list_for_each_entry(master, &installed_smmu->devices, list) {
+			if (!master->ats_enabled)
+				continue;
 
-		for (i = 0; i < master->num_streams; i++) {
-			cmd.atc.sid = master->streams[i].id;
-			arm_smmu_cmdq_batch_add(smmu_domain->smmu, &cmds, &cmd);
+			for (i = 0; i < master->num_streams; i++) {
+				cmd.atc.sid = master->streams[i].id;
+				arm_smmu_cmdq_batch_add(installed_smmu->smmu,
+							&cmds, &cmd);
+			}
 		}
+		ret = arm_smmu_cmdq_batch_submit(installed_smmu->smmu, &cmds);
+		if (ret)
+			break;
 	}
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
 
-	return arm_smmu_cmdq_batch_submit(smmu_domain->smmu, &cmds);
+	return ret;
 }
 
 /* IO_PGTABLE API */
@@ -2049,8 +2056,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
 		return NULL;
 
 	mutex_init(&smmu_domain->init_mutex);
-	INIT_LIST_HEAD(&smmu_domain->devices);
-	spin_lock_init(&smmu_domain->devices_lock);
+	INIT_LIST_HEAD(&smmu_domain->installed_smmus);
+	spin_lock_init(&smmu_domain->installed_smmus_lock);
 	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
 
 	return &smmu_domain->domain;
@@ -2353,9 +2360,66 @@ static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 	pci_disable_pasid(pdev);
 }
 
-static void arm_smmu_detach_dev(struct arm_smmu_master *master)
+static void arm_smmu_installed_smmus_remove_device(
+	struct arm_smmu_domain *smmu_domain,
+	struct arm_smmu_master *master)
 {
+	struct arm_smmu_installed_smmu *installed_smmu;
+	struct arm_smmu_device *smmu;
 	unsigned long flags;
+
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list) {
+		smmu = installed_smmu->smmu;
+		if (smmu != master->smmu)
+			continue;
+		list_del(&master->list);
+		if (list_empty(&installed_smmu->devices)) {
+			list_del(&installed_smmu->list);
+			kfree(installed_smmu);
+		}
+		break;
+	}
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
+}
+
+static int
+arm_smmu_installed_smmus_add_device(struct arm_smmu_domain *smmu_domain,
+				    struct arm_smmu_master *master)
+{
+	struct arm_smmu_installed_smmu *installed_smmu;
+	struct arm_smmu_device *smmu = master->smmu;
+	bool list_entry_found = false;
+	unsigned long flags;
+	int ret = 0;
+
+	spin_lock_irqsave(&smmu_domain->installed_smmus_lock, flags);
+	list_for_each_entry(installed_smmu, &smmu_domain->installed_smmus,
+			    list) {
+		if (installed_smmu->smmu == smmu) {
+			list_entry_found = true;
+			break;
+		}
+	}
+	if (!list_entry_found) {
+		installed_smmu = kzalloc(sizeof(*installed_smmu), GFP_KERNEL);
+		if (!installed_smmu) {
+			ret = -ENOMEM;
+			goto unlock;
+		}
+		INIT_LIST_HEAD(&installed_smmu->devices);
+		installed_smmu->smmu = smmu;
+		list_add(&installed_smmu->list, &smmu_domain->installed_smmus);
+	}
+	list_add(&master->list, &installed_smmu->devices);
+unlock:
+	spin_unlock_irqrestore(&smmu_domain->installed_smmus_lock, flags);
+	return ret;
+}
+
+static void arm_smmu_detach_dev(struct arm_smmu_master *master)
+{
 	struct arm_smmu_domain *smmu_domain = master->domain;
 
 	if (!smmu_domain)
@@ -2363,9 +2427,7 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 
 	arm_smmu_disable_ats(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	arm_smmu_installed_smmus_remove_device(smmu_domain, master);
 
 	master->domain = NULL;
 	master->ats_enabled = false;
@@ -2385,7 +2447,6 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
-	unsigned long flags;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
@@ -2435,9 +2496,11 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	if (smmu_domain->stage != ARM_SMMU_DOMAIN_BYPASS)
 		master->ats_enabled = arm_smmu_ats_supported(master);
 
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_add(&master->domain_head, &smmu_domain->devices);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	ret = arm_smmu_installed_smmus_add_device(smmu_domain, master);
+	if (ret) {
+		master->domain = NULL;
+		return ret;
+	}
 
 	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
 		if (!master->cd_table.cdtab) {
@@ -2467,9 +2530,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 
 out_list_del:
-	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
-	list_del(&master->domain_head);
-	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
+	arm_smmu_installed_smmus_remove_device(smmu_domain, master);
 
 	return ret;
 }
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 83d2790b701e7..a9202d2045537 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -690,12 +690,20 @@ struct arm_smmu_stream {
 	struct rb_node			node;
 };
 
+/* List of smmu devices that a domain is installed to */
+struct arm_smmu_installed_smmu {
+	struct list_head	list;
+	/* List of masters that the domain is attached to*/
+	struct list_head	devices;
+	struct arm_smmu_device	*smmu;
+};
+
 /* SMMU private data for each master */
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
 	struct arm_smmu_domain		*domain;
-	struct list_head		domain_head;
+	struct list_head		list;
 	struct arm_smmu_stream		*streams;
 	/* Locked by the iommu core using the group mutex */
 	struct arm_smmu_ctx_desc_cfg	cd_table;
@@ -731,8 +739,8 @@ struct arm_smmu_domain {
 
 	struct iommu_domain		domain;
 
-	struct list_head		devices;
-	spinlock_t			devices_lock;
+	struct list_head		installed_smmus;
+	spinlock_t			installed_smmus_lock;
 
 	struct list_head		mmu_notifiers;
 };
-- 
2.42.0.rc1.204.g551eb34607-goog

