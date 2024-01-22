Return-Path: <linux-kernel+bounces-32452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5089835BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83282286CD2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA4218640;
	Mon, 22 Jan 2024 07:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nu8syqUB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC1B168A3
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909477; cv=none; b=WcKqGlw0X/JwctmCw6Qi54YhpajAFIA98KM2IEp6smNTLl669vQ+FlCWBPy5VryQud1ejQcB8hUncRllzIdFbKHmS83zJ21G71VoYyE1u3DPmg7NKSFu3a9odEMc3hPoU2kZcaw4eB915jiA76hJIqfXSTUawt4dt0uCaEPTJhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909477; c=relaxed/simple;
	bh=FQXUwQaz7SgmCkzzKtrhwjjGOR58hsRCfdf9rJPSwqE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzPkce3cYGZGSwGDvmFGyDcglqzG4WQVWLiLPy07FapoSS4GkZftaouaqRxHNiqDuZETYHP7f30hBBuDIu96VIv0URQTcCF/yf4aa9C7MTgbGiOEYNaDk6Z0ipNv0jq6W2bbtvl2MyL/o6HIpuUv752ylxy9cQZRDlnGRKKqQyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nu8syqUB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705909476; x=1737445476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FQXUwQaz7SgmCkzzKtrhwjjGOR58hsRCfdf9rJPSwqE=;
  b=nu8syqUBcRUthzHa9gb1LNztIEK3NaaI1+gCddMi5B8LF7qkeHxXrJnX
   vPzZo+s2TyHBS4zLKzoJXhCEAPn++565z5tZ0OZPUpvYRl//UmM5N/mAD
   cju7V9PddpF35C4RI67IYkbofPdbcMauYUpAhPFElYjXDjiadZB6WdXyt
   +HyqpL6eQmPvVQqMimGZKqxAdRo0if4y2SqacLAic4Tcn3hbybGveOVX3
   SlQ9GtOL+b4zdvVOw+gro4I/ZidBVkhHCMc5QGG3SVPekRM1bV6bB5AD3
   S8xvYH8N6N62mKTWwXnpkX6vzAxszjf/yAIr5ONeHaAdjq4LzJg4BhKHJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22611509"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22611509"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 23:44:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778504959"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778504959"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2024 23:44:31 -0800
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Joel Granados <j.granados@samsung.com>
Cc: iommu@lists.linux.dev,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH v3 1/8] iommu: Add iopf domain attach/detach/replace interface
Date: Mon, 22 Jan 2024 15:38:56 +0800
Message-Id: <20240122073903.24406-2-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122073903.24406-1-baolu.lu@linux.intel.com>
References: <20240122073903.24406-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a slight difference between iopf domains and non-iopf domains.
In the latter, references to domains occur between attach and detach;
While in the former, due to the existence of asynchronous iopf handling
paths, references to the domain may occur after detach, which leads to
potential UAF issues.

Introduce iopf-specific domain attach/detach/replace interface where the
caller provides an attach cookie. This cookie can only be freed after all
outstanding iopf groups are handled and the domain is detached from the
RID or PASID. The presence of this attach cookie indicates that a domain
has been attached to the RID or PASID and won't be released until all
outstanding iopf groups are handled.

The cookie data structure also includes a private field for storing a
caller-specific pointer that will be passed back to its page fault handler.
This field provides flexibility for various uses. For example, the IOMMUFD
could use it to store the iommufd_device pointer, so that it could easily
retrieve the dev_id of the device that triggered the fault.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      |  36 +++++++++
 drivers/iommu/io-pgfault.c | 158 +++++++++++++++++++++++++++++++++++++
 2 files changed, 194 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 1ccad10e8164..6d85be23952a 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -120,6 +120,16 @@ struct iommu_page_response {
 	u32	code;
 };
 
+struct iopf_attach_cookie {
+	struct iommu_domain *domain;
+	struct device *dev;
+	unsigned int pasid;
+	refcount_t users;
+
+	void *private;
+	void (*release)(struct iopf_attach_cookie *cookie);
+};
+
 struct iopf_fault {
 	struct iommu_fault fault;
 	/* node for pending lists */
@@ -699,6 +709,7 @@ struct iommu_fault_param {
 	struct device *dev;
 	struct iopf_queue *queue;
 	struct list_head queue_list;
+	struct xarray pasid_cookie;
 
 	struct list_head partial;
 	struct list_head faults;
@@ -1552,6 +1563,12 @@ void iopf_free_group(struct iopf_group *group);
 void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
+int iopf_domain_attach(struct iommu_domain *domain, struct device *dev,
+		       ioasid_t pasid, struct iopf_attach_cookie *cookie);
+void iopf_domain_detach(struct iommu_domain *domain, struct device *dev,
+			ioasid_t pasid);
+int iopf_domain_replace(struct iommu_domain *domain, struct device *dev,
+			ioasid_t pasid, struct iopf_attach_cookie *cookie);
 #else
 static inline int
 iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
@@ -1596,5 +1613,24 @@ static inline void iopf_group_response(struct iopf_group *group,
 				       enum iommu_page_response_code status)
 {
 }
+
+static inline int iopf_domain_attach(struct iommu_domain *domain,
+				     struct device *dev, ioasid_t pasid,
+				     struct iopf_attach_cookie *cookie)
+{
+	return -ENODEV;
+}
+
+static inline void iopf_domain_detach(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid)
+{
+}
+
+static inline int iopf_domain_replace(struct iommu_domain *domain,
+				      struct device *dev, ioasid_t pasid,
+				      struct iopf_attach_cookie *cookie)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_IOMMU_IOPF */
 #endif /* __LINUX_IOMMU_H */
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index b64229dab976..f7ce41573799 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -39,6 +39,103 @@ static void iopf_put_dev_fault_param(struct iommu_fault_param *fault_param)
 		kfree_rcu(fault_param, rcu);
 }
 
+/* Get the domain attachment cookie for pasid of a device. */
+static struct iopf_attach_cookie __maybe_unused *
+iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
+	struct iopf_attach_cookie *curr;
+
+	if (!iopf_param)
+		return ERR_PTR(-ENODEV);
+
+	xa_lock(&iopf_param->pasid_cookie);
+	curr = xa_load(&iopf_param->pasid_cookie, pasid);
+	if (curr && !refcount_inc_not_zero(&curr->users))
+		curr = ERR_PTR(-EINVAL);
+	xa_unlock(&iopf_param->pasid_cookie);
+
+	iopf_put_dev_fault_param(iopf_param);
+
+	return curr;
+}
+
+/* Put the domain attachment cookie. */
+static void iopf_pasid_cookie_put(struct iopf_attach_cookie *cookie)
+{
+	if (cookie && refcount_dec_and_test(&cookie->users))
+		cookie->release(cookie);
+}
+
+/*
+ * Set the domain attachment cookie for pasid of a device. Return 0 on
+ * success, or error number on failure.
+ */
+static int iopf_pasid_cookie_set(struct iommu_domain *domain, struct device *dev,
+				 ioasid_t pasid, struct iopf_attach_cookie *cookie)
+{
+	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
+	struct iopf_attach_cookie *curr;
+
+	if (!iopf_param)
+		return -ENODEV;
+
+	refcount_set(&cookie->users, 1);
+	cookie->dev = dev;
+	cookie->pasid = pasid;
+	cookie->domain = domain;
+
+	curr = xa_cmpxchg(&iopf_param->pasid_cookie, pasid, NULL, cookie, GFP_KERNEL);
+	iopf_put_dev_fault_param(iopf_param);
+
+	return curr ? xa_err(curr) : 0;
+}
+
+/* Clear the domain attachment cookie for pasid of a device. */
+static void iopf_pasid_cookie_clear(struct device *dev, ioasid_t pasid)
+{
+	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
+	struct iopf_attach_cookie *curr;
+
+	if (WARN_ON(!iopf_param))
+		return;
+
+	curr = xa_erase(&iopf_param->pasid_cookie, pasid);
+	/* paired with iopf_pasid_cookie_set/replace() */
+	iopf_pasid_cookie_put(curr);
+
+	iopf_put_dev_fault_param(iopf_param);
+}
+
+/* Replace the domain attachment cookie for pasid of a device. */
+static int iopf_pasid_cookie_replace(struct iommu_domain *domain, struct device *dev,
+				     ioasid_t pasid, struct iopf_attach_cookie *cookie)
+{
+	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
+	struct iopf_attach_cookie *curr;
+
+	if (!iopf_param)
+		return -ENODEV;
+
+	if (cookie) {
+		refcount_set(&cookie->users, 1);
+		cookie->dev = dev;
+		cookie->pasid = pasid;
+		cookie->domain = domain;
+	}
+
+	curr = xa_store(&iopf_param->pasid_cookie, pasid, cookie, GFP_KERNEL);
+	if (xa_err(curr))
+		return xa_err(curr);
+
+	/* paired with iopf_pasid_cookie_set/replace() */
+	iopf_pasid_cookie_put(curr);
+
+	iopf_put_dev_fault_param(iopf_param);
+
+	return 0;
+}
+
 static void __iopf_free_group(struct iopf_group *group)
 {
 	struct iopf_fault *iopf, *next;
@@ -362,6 +459,7 @@ int iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
 	mutex_init(&fault_param->lock);
 	INIT_LIST_HEAD(&fault_param->faults);
 	INIT_LIST_HEAD(&fault_param->partial);
+	xa_init(&fault_param->pasid_cookie);
 	fault_param->dev = dev;
 	refcount_set(&fault_param->users, 1);
 	list_add(&fault_param->queue_list, &queue->devices);
@@ -502,3 +600,63 @@ void iopf_queue_free(struct iopf_queue *queue)
 	kfree(queue);
 }
 EXPORT_SYMBOL_GPL(iopf_queue_free);
+
+int iopf_domain_attach(struct iommu_domain *domain, struct device *dev,
+		       ioasid_t pasid, struct iopf_attach_cookie *cookie)
+{
+	int ret;
+
+	if (!domain->iopf_handler)
+		return -EINVAL;
+
+	if (pasid == IOMMU_NO_PASID)
+		ret = iommu_attach_group(domain, dev->iommu_group);
+	else
+		ret = iommu_attach_device_pasid(domain, dev, pasid);
+	if (ret)
+		return ret;
+
+	ret = iopf_pasid_cookie_set(domain, dev, pasid, cookie);
+	if (ret) {
+		if (pasid == IOMMU_NO_PASID)
+			iommu_detach_group(domain, dev->iommu_group);
+		else
+			iommu_detach_device_pasid(domain, dev, pasid);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(iopf_domain_attach);
+
+void iopf_domain_detach(struct iommu_domain *domain, struct device *dev, ioasid_t pasid)
+{
+	iopf_pasid_cookie_clear(dev, pasid);
+
+	if (pasid == IOMMU_NO_PASID)
+		iommu_detach_group(domain, dev->iommu_group);
+	else
+		iommu_detach_device_pasid(domain, dev, pasid);
+}
+EXPORT_SYMBOL_GPL(iopf_domain_detach);
+
+int iopf_domain_replace(struct iommu_domain *domain, struct device *dev,
+			ioasid_t pasid, struct iopf_attach_cookie *cookie)
+{
+	struct iommu_domain *old_domain = iommu_get_domain_for_dev(dev);
+	int ret;
+
+	if (!old_domain || pasid != IOMMU_NO_PASID ||
+	    (!old_domain->iopf_handler && !domain->iopf_handler))
+		return -EINVAL;
+
+	ret = iommu_group_replace_domain(dev->iommu_group, domain);
+	if (ret)
+		return ret;
+
+	ret = iopf_pasid_cookie_replace(domain, dev, pasid, cookie);
+	if (ret)
+		iommu_group_replace_domain(dev->iommu_group, old_domain);
+
+	return ret;
+}
+EXPORT_SYMBOL_NS_GPL(iopf_domain_replace, IOMMUFD_INTERNAL);
-- 
2.34.1


