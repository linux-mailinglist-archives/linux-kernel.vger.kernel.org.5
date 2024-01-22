Return-Path: <linux-kernel+bounces-32453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE05835BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3875A1F24484
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C199020DDF;
	Mon, 22 Jan 2024 07:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOD6tbCq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EA1A70A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909481; cv=none; b=ZO0nyZzkyFow8v+neSDOwBbi/X32bbAWqX0kQ5j9kfT9R31Sx3n/Uk2NW53siMm8UZKZDIv9vDGDetgE1alJN3xgvvU2HpGWO21P1v63bziDzmVlCex+wHusmRh6vjpr8DU6emGSf4mmtPgwQ4H+1hK5TGtU8eo8q3EpZ6ywSz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909481; c=relaxed/simple;
	bh=+2PMIWS/pE25l+KTaQjwg/kxEyeBkuzck4hCSJ/D/zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OA4iIG8jxXhpMhoBZT7lbx75ZHOxhgmA25UujCS1BPirYD/sQUFY+3knsC/OHmp0lwCFwXT1llDeAnh+9Gq8J1NW9jWSWds9OWNYCODZLeeQGdLGxyvgssnsq4LzEvOIkf5SDemS4VuMFFACeb7eeHYla5EcFeI3G8qdLZLmB5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOD6tbCq; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705909480; x=1737445480;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+2PMIWS/pE25l+KTaQjwg/kxEyeBkuzck4hCSJ/D/zU=;
  b=TOD6tbCqzjdVkoeH/u9BGZWw8IHIIzYJBHn7vlecp+0962ocR1e0cATi
   AmtYOaeHzOkWvuiod3QTvO0TBiIsmiwiYJIntiWVmB0xVAuEkUHQr2BJZ
   n7ukLw0iZ67Rzhn661lE7Teroo1gnsTSHbzTAeKFpVakTIjZ45y5hUG3F
   FYCI7ZMj/Hc17HrdvmSQGgbn576tjGjnuEM92s32D31RVUyoNeufH2T1x
   tN10Y7cGRpvMBJz1GP99TiRHoF7ESro4CnkL9sfew16r4E7bY7cvJPZb0
   kKykaekCK2QVu18Jw0+R140i368nALkz4NYF+AUe6MG0rK3gbJOKhOCwp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="22611533"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22611533"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 23:44:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="778504968"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="778504968"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 21 Jan 2024 23:44:35 -0800
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
Subject: [PATCH v3 2/8] iommu/sva: Use iopf domain attach/detach interface
Date: Mon, 22 Jan 2024 15:38:57 +0800
Message-Id: <20240122073903.24406-3-baolu.lu@linux.intel.com>
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

The iommu sva implementation relies on iopf handling. Allocate an
attachment cookie and use the iopf domain attach/detach interface.
The SVA domain is guaranteed to be released after all outstanding
page faults are handled.

In the fault delivering path, the attachment cookie is retrieved,
instead of the domain. This ensures that the page fault is forwarded
only if an iopf-capable domain is attached, and the domain will only
be released after all outstanding faults are handled.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 include/linux/iommu.h      |  2 +-
 drivers/iommu/io-pgfault.c | 59 +++++++++++++++++++-------------------
 drivers/iommu/iommu-sva.c  | 48 ++++++++++++++++++++++++-------
 3 files changed, 68 insertions(+), 41 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 6d85be23952a..511dc7b4bdb2 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -142,9 +142,9 @@ struct iopf_group {
 	/* list node for iommu_fault_param::faults */
 	struct list_head pending_node;
 	struct work_struct work;
-	struct iommu_domain *domain;
 	/* The device's fault data parameter. */
 	struct iommu_fault_param *fault_param;
+	struct iopf_attach_cookie *cookie;
 };
 
 /**
diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index f7ce41573799..2567d8c04e46 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -40,7 +40,7 @@ static void iopf_put_dev_fault_param(struct iommu_fault_param *fault_param)
 }
 
 /* Get the domain attachment cookie for pasid of a device. */
-static struct iopf_attach_cookie __maybe_unused *
+static struct iopf_attach_cookie *
 iopf_pasid_cookie_get(struct device *dev, ioasid_t pasid)
 {
 	struct iommu_fault_param *iopf_param = iopf_get_dev_fault_param(dev);
@@ -147,6 +147,7 @@ static void __iopf_free_group(struct iopf_group *group)
 
 	/* Pair with iommu_report_device_fault(). */
 	iopf_put_dev_fault_param(group->fault_param);
+	iopf_pasid_cookie_put(group->cookie);
 }
 
 void iopf_free_group(struct iopf_group *group)
@@ -156,30 +157,6 @@ void iopf_free_group(struct iopf_group *group)
 }
 EXPORT_SYMBOL_GPL(iopf_free_group);
 
-static struct iommu_domain *get_domain_for_iopf(struct device *dev,
-						struct iommu_fault *fault)
-{
-	struct iommu_domain *domain;
-
-	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
-		domain = iommu_get_domain_for_dev_pasid(dev, fault->prm.pasid, 0);
-		if (IS_ERR(domain))
-			domain = NULL;
-	} else {
-		domain = iommu_get_domain_for_dev(dev);
-	}
-
-	if (!domain || !domain->iopf_handler) {
-		dev_warn_ratelimited(dev,
-			"iopf (pasid %d) without domain attached or handler installed\n",
-			 fault->prm.pasid);
-
-		return NULL;
-	}
-
-	return domain;
-}
-
 /* Non-last request of a group. Postpone until the last one. */
 static int report_partial_fault(struct iommu_fault_param *fault_param,
 				struct iommu_fault *fault)
@@ -199,10 +176,20 @@ static int report_partial_fault(struct iommu_fault_param *fault_param,
 	return 0;
 }
 
+static ioasid_t fault_to_pasid(struct iommu_fault *fault)
+{
+	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
+		return fault->prm.pasid;
+
+	return IOMMU_NO_PASID;
+}
+
 static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 					   struct iopf_fault *evt,
 					   struct iopf_group *abort_group)
 {
+	ioasid_t pasid = fault_to_pasid(&evt->fault);
+	struct iopf_attach_cookie *cookie;
 	struct iopf_fault *iopf, *next;
 	struct iopf_group *group;
 
@@ -215,7 +202,23 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 		group = abort_group;
 	}
 
+	cookie = iopf_pasid_cookie_get(iopf_param->dev, pasid);
+	if (!cookie && pasid != IOMMU_NO_PASID)
+		cookie = iopf_pasid_cookie_get(iopf_param->dev, IOMMU_NO_PASID);
+	if (IS_ERR(cookie) || !cookie) {
+		/*
+		 * The PASID of this device was not attached by an I/O-capable
+		 * domain. Ask the caller to abort handling of this fault.
+		 * Otherwise, the reference count will be switched to the new
+		 * iopf group and will be released in iopf_free_group().
+		 */
+		kfree(group);
+		group = abort_group;
+		cookie = NULL;
+	}
+
 	group->fault_param = iopf_param;
+	group->cookie = cookie;
 	group->last_fault.fault = evt->fault;
 	INIT_LIST_HEAD(&group->faults);
 	INIT_LIST_HEAD(&group->pending_node);
@@ -305,15 +308,11 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 	if (group == &abort_group)
 		goto err_abort;
 
-	group->domain = get_domain_for_iopf(dev, fault);
-	if (!group->domain)
-		goto err_abort;
-
 	/*
 	 * On success iopf_handler must call iopf_group_response() and
 	 * iopf_free_group()
 	 */
-	if (group->domain->iopf_handler(group))
+	if (group->cookie->domain->iopf_handler(group))
 		goto err_abort;
 
 	return;
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b51995b4fe90..fff3ee1ee9ce 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -50,6 +50,39 @@ static struct iommu_mm_data *iommu_alloc_mm_data(struct mm_struct *mm, struct de
 	return iommu_mm;
 }
 
+static void release_attach_cookie(struct iopf_attach_cookie *cookie)
+{
+	struct iommu_domain *domain = cookie->domain;
+
+	mutex_lock(&iommu_sva_lock);
+	if (--domain->users == 0) {
+		list_del(&domain->next);
+		iommu_domain_free(domain);
+	}
+	mutex_unlock(&iommu_sva_lock);
+
+	kfree(cookie);
+}
+
+static int sva_attach_device_pasid(struct iommu_domain *domain,
+				   struct device *dev, ioasid_t pasid)
+{
+	struct iopf_attach_cookie *cookie;
+	int ret;
+
+	cookie = kzalloc(sizeof(*cookie), GFP_KERNEL);
+	if (!cookie)
+		return -ENOMEM;
+
+	cookie->release = release_attach_cookie;
+
+	ret = iopf_domain_attach(domain, dev, pasid, cookie);
+	if (ret)
+		kfree(cookie);
+
+	return ret;
+}
+
 /**
  * iommu_sva_bind_device() - Bind a process address space to a device
  * @dev: the device
@@ -90,7 +123,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Search for an existing domain. */
 	list_for_each_entry(domain, &mm->iommu_mm->sva_domains, next) {
-		ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
+		ret = sva_attach_device_pasid(domain, dev, iommu_mm->pasid);
 		if (!ret) {
 			domain->users++;
 			goto out;
@@ -104,7 +137,7 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 		goto out_free_handle;
 	}
 
-	ret = iommu_attach_device_pasid(domain, dev, iommu_mm->pasid);
+	ret = sva_attach_device_pasid(domain, dev, iommu_mm->pasid);
 	if (ret)
 		goto out_free_domain;
 	domain->users = 1;
@@ -140,13 +173,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
 	struct iommu_mm_data *iommu_mm = domain->mm->iommu_mm;
 	struct device *dev = handle->dev;
 
-	mutex_lock(&iommu_sva_lock);
-	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
-	if (--domain->users == 0) {
-		list_del(&domain->next);
-		iommu_domain_free(domain);
-	}
-	mutex_unlock(&iommu_sva_lock);
+	iopf_domain_detach(domain, dev, iommu_mm->pasid);
 	kfree(handle);
 }
 EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
@@ -242,7 +269,8 @@ static void iommu_sva_handle_iopf(struct work_struct *work)
 		if (status != IOMMU_PAGE_RESP_SUCCESS)
 			break;
 
-		status = iommu_sva_handle_mm(&iopf->fault, group->domain->mm);
+		status = iommu_sva_handle_mm(&iopf->fault,
+					     group->cookie->domain->mm);
 	}
 
 	iopf_group_response(group, status);
-- 
2.34.1


