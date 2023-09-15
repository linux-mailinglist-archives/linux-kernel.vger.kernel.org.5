Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595D7A2413
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbjIOQ7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjIOQ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:58:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CDE719BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 09:58:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ED48C15;
        Fri, 15 Sep 2023 09:59:16 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F23EC3F5A1;
        Fri, 15 Sep 2023 09:58:37 -0700 (PDT)
From:   Robin Murphy <robin.murphy@arm.com>
To:     joro@8bytes.org, will@kernel.org
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, jgg@nvidia.com,
        baolu.lu@linux.intel.com
Subject: [PATCH v3 7/7] iommu: Clean up open-coded ownership checks
Date:   Fri, 15 Sep 2023 17:58:11 +0100
Message-Id: <05f95c41ec644440f2f375b1dc04c8254f667316.1694693889.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1694693889.git.robin.murphy@arm.com>
References: <cover.1694693889.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers already implement their own defence against the possibility
of being given someone else's device. Since this is now taken care of by
the core code (and via a slightly different path from the original
fwspec-based idea), let's clean them up.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  3 ---
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  9 +--------
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     | 14 ++------------
 drivers/iommu/mtk_iommu.c                   |  7 +------
 drivers/iommu/mtk_iommu_v1.c                |  3 ---
 drivers/iommu/sprd-iommu.c                  |  8 +-------
 drivers/iommu/virtio-iommu.c                |  3 ---
 7 files changed, 5 insertions(+), 42 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e82bf1c449a3..01ea307c7791 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2653,9 +2653,6 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 	struct arm_smmu_master *master;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!fwspec || fwspec->ops != &arm_smmu_ops)
-		return ERR_PTR(-ENODEV);
-
 	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
 		return ERR_PTR(-EBUSY);
 
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 4b83a3adacd6..4d09c0047892 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1116,11 +1116,6 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 	struct arm_smmu_device *smmu;
 	int ret;
 
-	if (!fwspec || fwspec->ops != &arm_smmu_ops) {
-		dev_err(dev, "cannot attach to SMMU, is it on the same bus?\n");
-		return -ENXIO;
-	}
-
 	/*
 	 * FIXME: The arch/arm DMA API code tries to attach devices to its own
 	 * domains between of_xlate() and probe_device() - we have no way to cope
@@ -1357,10 +1352,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		fwspec = dev_iommu_fwspec_get(dev);
 		if (ret)
 			goto out_free;
-	} else if (fwspec && fwspec->ops == &arm_smmu_ops) {
-		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 	} else {
-		return ERR_PTR(-ENODEV);
+		smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
 	}
 
 	ret = -EINVAL;
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 775a3cbaff4e..b86fcd761ff7 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -79,16 +79,6 @@ static struct qcom_iommu_domain *to_qcom_iommu_domain(struct iommu_domain *dom)
 
 static const struct iommu_ops qcom_iommu_ops;
 
-static struct qcom_iommu_dev * to_iommu(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!fwspec || fwspec->ops != &qcom_iommu_ops)
-		return NULL;
-
-	return dev_iommu_priv_get(dev);
-}
-
 static struct qcom_iommu_ctx * to_ctx(struct qcom_iommu_domain *d, unsigned asid)
 {
 	struct qcom_iommu_dev *qcom_iommu = d->iommu;
@@ -374,7 +364,7 @@ static void qcom_iommu_domain_free(struct iommu_domain *domain)
 
 static int qcom_iommu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
+	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
 	struct qcom_iommu_domain *qcom_domain = to_qcom_iommu_domain(domain);
 	int ret;
 
@@ -499,7 +489,7 @@ static bool qcom_iommu_capable(struct device *dev, enum iommu_cap cap)
 
 static struct iommu_device *qcom_iommu_probe_device(struct device *dev)
 {
-	struct qcom_iommu_dev *qcom_iommu = to_iommu(dev);
+	struct qcom_iommu_dev *qcom_iommu = dev_iommu_priv_get(dev);
 	struct device_link *link;
 
 	if (!qcom_iommu)
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 640275873a27..dc292aeb6dbf 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -844,16 +844,11 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 static struct iommu_device *mtk_iommu_probe_device(struct device *dev)
 {
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct mtk_iommu_data *data;
+	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
 	struct device_link *link;
 	struct device *larbdev;
 	unsigned int larbid, larbidx, i;
 
-	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
-		return ERR_PTR(-ENODEV); /* Not a iommu client device */
-
-	data = dev_iommu_priv_get(dev);
-
 	if (!MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM))
 		return &data->iommu;
 
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 8a0a5e5d049f..2a764b73eb32 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -478,9 +478,6 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
 		idx++;
 	}
 
-	if (!fwspec || fwspec->ops != &mtk_iommu_v1_ops)
-		return ERR_PTR(-ENODEV); /* Not a iommu client device */
-
 	data = dev_iommu_priv_get(dev);
 
 	/* Link the consumer device with the smi-larb device(supplier) */
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 2fa9afebd4f5..a69680fbb519 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -388,13 +388,7 @@ static phys_addr_t sprd_iommu_iova_to_phys(struct iommu_domain *domain,
 
 static struct iommu_device *sprd_iommu_probe_device(struct device *dev)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	struct sprd_iommu_device *sdev;
-
-	if (!fwspec || fwspec->ops != &sprd_iommu_ops)
-		return ERR_PTR(-ENODEV);
-
-	sdev = dev_iommu_priv_get(dev);
+	struct sprd_iommu_device *sdev = dev_iommu_priv_get(dev);
 
 	return &sdev->iommu;
 }
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 17dcd826f5c2..bb2e795a80d0 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -969,9 +969,6 @@ static struct iommu_device *viommu_probe_device(struct device *dev)
 	struct viommu_dev *viommu = NULL;
 	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!fwspec || fwspec->ops != &viommu_ops)
-		return ERR_PTR(-ENODEV);
-
 	viommu = viommu_get_by_fwnode(fwspec->iommu_fwnode);
 	if (!viommu)
 		return ERR_PTR(-ENODEV);
-- 
2.39.2.101.g768bb238c484.dirty

