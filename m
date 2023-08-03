Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFFC76E555
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbjHCKOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjHCKOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:14:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4278E3A8D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 03:14:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d052f49702dso845409276.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 03:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691057661; x=1691662461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7z5OBENHOr2eyPDXE+tfWeU2HnsC9/l+M3HstrRsv94=;
        b=4QHFgQUz86psObn8rqXE96jintVeFyZR35xzg9vOmflXpYO0PFbxuqsmlweMhUyr32
         vvFq/X22VGeQUffOj2LowuNN14kNeh1exPxyIHK6iorLiAJaUvsTfmR54Ja3uWSYoj+K
         wHwk8QvAu93nEOl9iwvn2H9dvkc74xR7xbg3RtyEn4XCPooe2xQxuXh0RSIscAWlq0Sl
         IzhGppqwyVK3eZFtOSbFmx/hgQL7NAhApxNRK/g5uJhvrqX1D2Mskmt507nzwfbxGjuP
         AnsyYIfVraineTEMavWQs8qcmr1vAiZpzI1xLzKZeB0QitKz0Uqxb1nB+OxX2ujF9nFv
         NtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691057661; x=1691662461;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z5OBENHOr2eyPDXE+tfWeU2HnsC9/l+M3HstrRsv94=;
        b=WfIOoPlqYJqvYoPw2LaKaqrmlHdPk1RL2LUOkDiaVFwx6qwV2PD07m0h/ZEaaq7GXZ
         8ds7MjFLHVvO5+Q1gb5biYiOuczvBZhiMl+Ib0ap0uflg8ZOfoDk6KppxhNYCznx/jUg
         eXz7Qe/qGUMGWCrMvuWXvsYyq1C6ml9UhI885/Ns1c+31RiNSBKXSV9P7uAyhsQV3qHR
         mkkMPNczxSOJBDCiweqmBhG4ZB8Jkr1ujgAg8Zw+ZdrLGa3oAifZxOOAQflMlkqhLdPt
         Aad+5Vk1d989Q2ypm3C1q1ilUfa60ETqLCAHIElX68sBcW2DGtRrCNYzhnuu8ih8ktoh
         505w==
X-Gm-Message-State: ABy/qLZLBjS0cviryovK+VtdvubWGPDyzoxFSQLtGlCFtoo6RB3SdGbP
        4OWRnlAgMM+gR70H5yTqkG3mMN05km44
X-Google-Smtp-Source: APBJJlGCHddp3RdaF6WFwHVXgiwX+tBKMPbRCk0pc6RCj+MlyNyRm7wsquSL5VW9/VzNUGGLERFhfnIyncME
X-Received: from mshavit.ntc.corp.google.com ([2401:fa00:95:20c:39d1:8774:b733:6210])
 (user=mshavit job=sendgmr) by 2002:a25:db82:0:b0:d0f:15a4:5a53 with SMTP id
 g124-20020a25db82000000b00d0f15a45a53mr121006ybf.2.1691057661160; Thu, 03 Aug
 2023 03:14:21 -0700 (PDT)
Date:   Thu,  3 Aug 2023 18:12:24 +0800
In-Reply-To: <20230803101351.1561031-1-mshavit@google.com>
Mime-Version: 1.0
References: <20230803101351.1561031-1-mshavit@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803181225.v5.4.I4ba46c0f7d599f43094d6ba1113c0b4fe49bd908@changeid>
Subject: [PATCH v5 4/6] iommu/arm-smmu-v3: Implement set_dev_pasid
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

This change enables the use of the iommu_attach_dev_pasid API for
UNMANAGED domains. The primary use-case is to allow in-kernel users of
the iommu API to manage domains with PASID. This change also allows for
future support of pasid in the DMA api.

Signed-off-by: Michael Shavit <mshavit@google.com>
---

Changes in v5:
- Fix missing error value return in set_dev_pasid
- Fix issue where nr_attached_pasid_domains isn't updated when
  arm_smmu_write_ctx_desc fails
- Fix missing free of the attached_domain node
- Split off the CD table refactor to separate patch series: https://lore.kernel.org/all/20230802163328.2623773-1-mshavit@google.com/
- Link to v4: https://lore.kernel.org/all/20230621063825.268890-1-mshavit@google.com/
- Remove districting change where a NULL master is passed to
  arm_smmu_prepare_domain_for_smmu

Changes in v4:
- Fix build warning and error on patch 07. The error was introduced
  during a v1->v2 rebase and hidden by patch 09 which removed the
  offending line.
- Link to v3: https://lore.kernel.org/all/20230614154304.2860121-1-mshavit@google.com/

Changes in v3:
- Dropped the bulk of the SVA refactoring to re-work as a follow-up
  series.
- Reworded cover letter to omit dropped changes.
- Rebased on 6.4 tip
- Link to v2: https://lore.kernel.org/all/20230606120854.4170244-1-mshavit@google.com/

Changes in v2:
- Reworded cover letter and commits based on v1 feedback.
- Split and reworked `iommu/arm-smmu-v3: Move cdtable to arm_smmu_master`
- Added SVA clean-up and refactor.
- A few other small bug fixes and cosmetics.
- Link to v1: https://lore.kernel.org/all/20230510205054.2667898-1-mshavit@google.com/
- Add missing atc invalidation when detaching with pasid

 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 156 ++++++++++++++++++--
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |   1 +
 2 files changed, 141 insertions(+), 16 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e0565c644ffdb..7b296458dafec 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2388,6 +2388,11 @@ static int arm_smmu_enable_pasid(struct arm_smmu_master *master)
 	return 0;
 }
 
+static bool arm_smmu_master_has_pasid_domains(struct arm_smmu_master *master)
+{
+	return master->nr_attached_pasid_domains > 0;
+}
+
 static void arm_smmu_disable_pasid(struct arm_smmu_master *master)
 {
 	struct pci_dev *pdev;
@@ -2423,6 +2428,25 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
 	arm_smmu_install_ste_for_dev(master);
 }
 
+static int arm_smmu_prepare_domain_for_smmu(struct arm_smmu_device *smmu,
+					    struct arm_smmu_domain *smmu_domain,
+					    struct arm_smmu_master *master)
+{
+	int ret = 0;
+
+	mutex_lock(&smmu_domain->init_mutex);
+	if (!smmu_domain->smmu) {
+		smmu_domain->smmu = smmu;
+		ret = arm_smmu_domain_finalise(&smmu_domain->domain, master);
+		if (ret)
+			smmu_domain->smmu = NULL;
+	} else if (smmu_domain->smmu != smmu)
+		ret = -EINVAL;
+
+	mutex_unlock(&smmu_domain->init_mutex);
+	return ret;
+}
+
 static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
@@ -2438,6 +2462,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
+	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain, master);
+	if (ret)
+		return ret;
+
 	/*
 	 * Checking that SVA is disabled ensures that this device isn't bound to
 	 * any mm, and can be safely detached from its old domain. Bonds cannot
@@ -2448,21 +2476,17 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 		return -EBUSY;
 	}
 
-	arm_smmu_detach_dev(master);
-
-	mutex_lock(&smmu_domain->init_mutex);
-
-	if (!smmu_domain->smmu) {
-		smmu_domain->smmu = smmu;
-		ret = arm_smmu_domain_finalise(domain, master);
-		if (ret)
-			smmu_domain->smmu = NULL;
-	} else if (smmu_domain->smmu != smmu)
-		ret = -EINVAL;
+	/*
+	 * Attaching a bypass or stage 2 domain would break any domains attached
+	 * with pasid. Attaching an S1 domain should be feasible but requires
+	 * more complicated logic to handle.
+	 */
+	if (arm_smmu_master_has_pasid_domains(master)) {
+		dev_err(dev, "cannot attach - domain attached with pasid\n");
+		return -EBUSY;
+	}
 
-	mutex_unlock(&smmu_domain->init_mutex);
-	if (ret)
-		return ret;
+	arm_smmu_detach_dev(master);
 
 	/*
 	 * The SMMU does not support enabling ATS with bypass. When the STE is
@@ -2500,6 +2524,72 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	return 0;
 }
 
+static int arm_smmu_set_dev_pasid(struct iommu_domain *domain,
+				  struct device *dev, ioasid_t pasid)
+{
+	int ret = 0;
+	unsigned long flags;
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct arm_smmu_device *smmu;
+	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
+	struct arm_smmu_attached_domain *attached_domain;
+	struct arm_smmu_master *master;
+
+	if (!fwspec)
+		return -ENOENT;
+
+	master = dev_iommu_priv_get(dev);
+	smmu = master->smmu;
+
+	ret = arm_smmu_prepare_domain_for_smmu(smmu, smmu_domain, master);
+	if (ret)
+		return ret;
+
+	if (pasid == 0) {
+		dev_err(dev, "pasid 0 is reserved for the device's primary domain\n");
+		return -ENODEV;
+	}
+
+	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1) {
+		dev_err(dev, "set_dev_pasid only supports stage 1 domains\n");
+		return -EINVAL;
+	}
+
+	if (!master->cd_table.cdtab)
+		return -EBUSY;
+
+	attached_domain = kzalloc(sizeof(*attached_domain), GFP_KERNEL);
+	if (!attached_domain)
+		return -ENOMEM;
+
+	attached_domain->master = master;
+	attached_domain->domain = smmu_domain;
+	attached_domain->ssid = pasid;
+
+	/*
+	 * arm_smmu_share_asid may update the cd's asid value and write the
+	 * ctx_desc for every attached_domains in the list. There's a potential
+	 * race here regardless of whether we first write the ctx_desc or
+	 * first insert into the domain's list. Grabbing the asic_lock prevents
+	 * SVA from changing the cd's ASID while the cd is being attached.
+	 */
+	mutex_lock(&arm_smmu_asid_lock);
+	ret = arm_smmu_write_ctx_desc(master, pasid, &smmu_domain->cd);
+	if (ret) {
+		mutex_unlock(&arm_smmu_asid_lock);
+		kfree(attached_domain);
+		return ret;
+	}
+
+	spin_lock_irqsave(&smmu_domain->attached_ssids_lock, flags);
+	list_add(&attached_domain->list, &smmu_domain->attached_ssids);
+	spin_unlock_irqrestore(&smmu_domain->attached_ssids_lock, flags);
+	mutex_unlock(&arm_smmu_asid_lock);
+
+	master->nr_attached_pasid_domains += 1;
+	return 0;
+}
+
 static int arm_smmu_map_pages(struct iommu_domain *domain, unsigned long iova,
 			      phys_addr_t paddr, size_t pgsize, size_t pgcount,
 			      int prot, gfp_t gfp, size_t *mapped)
@@ -2738,6 +2828,15 @@ static void arm_smmu_release_device(struct device *dev)
 
 	if (WARN_ON(arm_smmu_master_sva_enabled(master)))
 		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
+	if (WARN_ON(master->nr_attached_pasid_domains != 0)) {
+		/*
+		 * TODO: Do we need to handle this case?
+		 * This requires a mechanism to obtain all the pasid domains
+		 * that this master is attached to so that we can clean up the
+		 * domain's attached_domain list.
+		 */
+	}
+
 	arm_smmu_detach_dev(master);
 	arm_smmu_disable_pasid(master);
 	arm_smmu_remove_master(master);
@@ -2874,12 +2973,36 @@ static int arm_smmu_def_domain_type(struct device *dev)
 static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 {
 	struct iommu_domain *domain;
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_domain *smmu_domain;
+	struct arm_smmu_attached_domain *attached_domain;
+	unsigned long flags;
 
-	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	if (!master || pasid == 0)
+		return;
+
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
 	if (WARN_ON(IS_ERR(domain)) || !domain)
 		return;
+	if (domain->type == IOMMU_DOMAIN_SVA)
+		return arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
 
-	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
+	smmu_domain = to_smmu_domain(domain);
+	mutex_lock(&arm_smmu_asid_lock);
+	spin_lock_irqsave(&smmu_domain->attached_ssids_lock, flags);
+	list_for_each_entry(attached_domain, &smmu_domain->attached_ssids, list) {
+		if (attached_domain->master != master ||
+		    attached_domain->ssid != pasid)
+			continue;
+		list_del(&attached_domain->list);
+		master->nr_attached_pasid_domains -= 1;
+		kfree(attached_domain);
+		break;
+	}
+	spin_unlock_irqrestore(&smmu_domain->attached_ssids_lock, flags);
+	arm_smmu_write_ctx_desc(master, pasid, NULL);
+	arm_smmu_atc_inv_master_ssid(master, pasid);
+	mutex_unlock(&arm_smmu_asid_lock);
 }
 
 static struct iommu_ops arm_smmu_ops = {
@@ -2899,6 +3022,7 @@ static struct iommu_ops arm_smmu_ops = {
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= arm_smmu_attach_dev,
+		.set_dev_pasid		= arm_smmu_set_dev_pasid,
 		.map_pages		= arm_smmu_map_pages,
 		.unmap_pages		= arm_smmu_unmap_pages,
 		.flush_iotlb_all	= arm_smmu_flush_iotlb_all,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 66a492cafe2e8..433f58bd99dd2 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -713,6 +713,7 @@ struct arm_smmu_master {
 	bool				iopf_enabled;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
+	unsigned int			nr_attached_pasid_domains;
 };
 
 /* SMMU private data for an IOMMU domain */
-- 
2.41.0.585.gd2178a4bd4-goog

