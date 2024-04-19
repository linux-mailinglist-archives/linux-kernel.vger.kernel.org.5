Return-Path: <linux-kernel+bounces-151796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5438AB3F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF401C211DD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6569F13D27D;
	Fri, 19 Apr 2024 16:56:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767B113B5BE;
	Fri, 19 Apr 2024 16:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713545792; cv=none; b=HgqIpKWndMMylTClnNSL8a95e8ymAWzoIDldqKKvoZzS8O4zdzE/2oei9zqLhry82nbFGtYuoesLYTkG9CTq4B1VPofvM2iYXWssU7awBLo5b4T2pqXEj+SwTIlo1G/9ULtKPuaUnnOFmkcnUVRaye5GtVe2X1MnbiAQkdS2h40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713545792; c=relaxed/simple;
	bh=0yp/FZZMQc5hYIr1LfFNeb5WKTxy3Na7JljiqpLCQ/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pl/CG6OWeiuwWRDJB4lL6uYgM7Nf5NHDOMdy6UBS39IBSbBVocWp+NMOmZYTR5BRMQPmv7RNRDiJYBV0NBhPBZvcMajhC+XmVRRlyS8Mfc/92S2xVnJrkE78mwB9+romJinId/WhUY74jCZ97SHIjiGWkekB9K3vFnHepT7n8cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 414E5153B;
	Fri, 19 Apr 2024 09:56:59 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id C0BC63F792;
	Fri, 19 Apr 2024 09:56:28 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH 4/4] iommu: Remove iommu_fwspec ops
Date: Fri, 19 Apr 2024 17:56:02 +0100
Message-Id: <3b8cf1725b20beccf009f7589ab4ab41447721b3.1713523251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713523251.git.robin.murphy@arm.com>
References: <cover.1713523251.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ops in iommu_fwspec are only needed for the early configuration and
probe process, and by now are easy enough to derive on-demand in those
couple of places which need them, so remove the redundant stored copy.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu-priv.h |  5 +++++
 drivers/iommu/iommu.c      | 11 ++---------
 drivers/iommu/of_iommu.c   |  4 +++-
 include/linux/iommu.h      |  2 --
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index 078cafcf49b4..a34efed2884b 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -19,6 +19,11 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
 
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
 
+static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
+{
+	return iommu_ops_from_fwnode(fwspec ? fwspec->iommu_fwnode : NULL);
+}
+
 int iommu_group_replace_domain(struct iommu_group *group,
 			       struct iommu_domain *new_domain);
 
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 07a647e34c72..996e79dc582d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -510,7 +510,6 @@ DEFINE_MUTEX(iommu_probe_device_lock);
 static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
 {
 	const struct iommu_ops *ops;
-	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
 	struct group_device *gdev;
 	int ret;
@@ -523,12 +522,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
 	 * be present, and that any of their registered instances has suitable
 	 * ops for probing, and thus cheekily co-opt the same mechanism.
 	 */
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec && fwspec->ops)
-		ops = fwspec->ops;
-	else
-		ops = iommu_ops_from_fwnode(NULL);
-
+	ops = iommu_fwspec_ops(dev_iommu_fwspec_get(dev));
 	if (!ops)
 		return -ENODEV;
 	/*
@@ -2831,7 +2825,7 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 		return -EPROBE_DEFER;
 
 	if (fwspec)
-		return ops == fwspec->ops ? 0 : -EINVAL;
+		return ops == iommu_fwspec_ops(fwspec) ? 0 : -EINVAL;
 
 	if (!dev_iommu_get(dev))
 		return -ENOMEM;
@@ -2843,7 +2837,6 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode)
 
 	fwnode_handle_get(iommu_fwnode);
 	fwspec->iommu_fwnode = iommu_fwnode;
-	fwspec->ops = ops;
 	dev_iommu_fwspec_set(dev, fwspec);
 	return 0;
 }
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index a5d6ff8e4e72..fde3053706c0 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -17,6 +17,8 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
+#include "iommu-priv.h"
+
 static int of_iommu_xlate(struct device *dev,
 			  struct of_phandle_args *iommu_spec)
 {
@@ -32,7 +34,7 @@ static int of_iommu_xlate(struct device *dev,
 	if (ret)
 		return ret;
 
-	ops = dev_iommu_fwspec_get(dev)->ops;
+	ops = iommu_ops_from_fwnode(&iommu_spec->np->fwnode);
 	if (!ops->of_xlate || !try_module_get(ops->owner))
 		return -ENODEV;
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0614b2736d66..ddfc2c9cdda4 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -965,7 +965,6 @@ extern struct iommu_group *generic_single_device_group(struct device *dev);
 
 /**
  * struct iommu_fwspec - per-device IOMMU instance data
- * @ops: ops for this device's IOMMU
  * @iommu_fwnode: firmware handle for this device's IOMMU
  * @flags: IOMMU_FWSPEC_* flags
  * @num_ids: number of associated device IDs
@@ -976,7 +975,6 @@ extern struct iommu_group *generic_single_device_group(struct device *dev);
  * consumers.
  */
 struct iommu_fwspec {
-	const struct iommu_ops	*ops;
 	struct fwnode_handle	*iommu_fwnode;
 	u32			flags;
 	unsigned int		num_ids;
-- 
2.39.2.101.g768bb238c484.dirty


