Return-Path: <linux-kernel+bounces-43018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 570B4840A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2CDDB24A0B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD596155315;
	Mon, 29 Jan 2024 15:42:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBFA15444E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542926; cv=none; b=re2EQvTt7MFSgGVstHTfaATpiZaEEYfzwJ00srLAPKP++dUGiQbthLKr4ZgDAwhZBVu+Y93W6tKiFHuB21PB88FQF5XJK/CoE9p3VNHPL7HzuIvH6N2PANhWcqrk56HTkEhJpsL911dKUROAdcrX3kuJar8lCNGXkDZtQHZ8FXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542926; c=relaxed/simple;
	bh=OQ4hamt2i2f8CUNIh/M0imHcVgWR9NyJGUninVs37mQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=enBqncXIfwCtBlMho9pYBLuvbLDdXcHKmJE6ZLNMNI+noSJ7tCI/vi8xeW/tW+eyOaS+mFe/U7B3Btts+GuanE2ciRoZL66piylhAwoaBKcOCmOVH8gKc5Ew/M0v004+rxMrKFHhI6Dj2JU8zLO8al2in1D3bMHvL5Cel06OAcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 883EEDA7;
	Mon, 29 Jan 2024 07:42:46 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 70E7F3F738;
	Mon, 29 Jan 2024 07:42:00 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 06/12] coresight: Move all sysfs code to sysfs file
Date: Mon, 29 Jan 2024 15:40:37 +0000
Message-Id: <20240129154050.569566-7-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129154050.569566-1-james.clark@arm.com>
References: <20240129154050.569566-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment the core file contains both sysfs functionality and
core functionality, while the Perf mode is in a separate file in
coresight-etm-perf.c

Many of the functions have ambiguous names like
coresight_enable_source() which actually only work in relation to the
sysfs mode. To avoid further confusion, move everything that isn't core
functionality into the sysfs file and append  _sysfs to the ambiguous
functions.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 394 +-----------------
 .../coresight/coresight-etm3x-core.c          |   4 +-
 .../coresight/coresight-etm4x-core.c          |   4 +-
 drivers/hwtracing/coresight/coresight-priv.h  |   5 +-
 drivers/hwtracing/coresight/coresight-stm.c   |   4 +-
 drivers/hwtracing/coresight/coresight-sysfs.c | 390 +++++++++++++++++
 include/linux/coresight.h                     |   8 +-
 7 files changed, 407 insertions(+), 402 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index e59fa9a906a3..0243b1de0315 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -9,7 +9,6 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/io.h>
-#include <linux/idr.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/slab.h>
@@ -25,15 +24,12 @@
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
 
-static DEFINE_MUTEX(coresight_mutex);
-static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
-
 /*
- * Use IDR to map the hash of the source's device name
- * to the pointer of path for the source. The idr is for
- * the sources which aren't associated with CPU.
+ * Mutex used to lock all sysfs enable and disable actions and loading and
+ * unloading devices by the Coresight core.
  */
-static DEFINE_IDR(path_idr);
+DEFINE_MUTEX(coresight_mutex);
+static DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
 
 /**
  * struct coresight_node - elements of a path, from source to sink
@@ -45,12 +41,6 @@ struct coresight_node {
 	struct list_head link;
 };
 
-/*
- * When operating Coresight drivers from the sysFS interface, only a single
- * path can exist from a tracer (associated to a CPU) to a sink.
- */
-static DEFINE_PER_CPU(struct list_head *, tracer_path);
-
 /*
  * When losing synchronisation a new barrier packet needs to be inserted at the
  * beginning of the data collected in a buffer.  That way the decoder knows that
@@ -61,34 +51,6 @@ EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
 static const struct cti_assoc_op *cti_assoc_ops;
 
-ssize_t coresight_simple_show_pair(struct device *_dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
-	struct cs_pair_attribute *cs_attr = container_of(attr, struct cs_pair_attribute, attr);
-	u64 val;
-
-	pm_runtime_get_sync(_dev->parent);
-	val = csdev_access_relaxed_read_pair(&csdev->access, cs_attr->lo_off, cs_attr->hi_off);
-	pm_runtime_put_sync(_dev->parent);
-	return sysfs_emit(buf, "0x%llx\n", val);
-}
-EXPORT_SYMBOL_GPL(coresight_simple_show_pair);
-
-ssize_t coresight_simple_show32(struct device *_dev,
-			      struct device_attribute *attr, char *buf)
-{
-	struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
-	struct cs_off_attribute *cs_attr = container_of(attr, struct cs_off_attribute, attr);
-	u64 val;
-
-	pm_runtime_get_sync(_dev->parent);
-	val = csdev_access_relaxed_read32(&csdev->access, cs_attr->off);
-	pm_runtime_put_sync(_dev->parent);
-	return sysfs_emit(buf, "0x%llx\n", val);
-}
-EXPORT_SYMBOL_GPL(coresight_simple_show32);
-
 void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
 {
 	cti_assoc_ops = cti_op;
@@ -324,29 +286,6 @@ static void coresight_disable_link(struct coresight_device *csdev,
 	link_ops(csdev)->disable(csdev, inconn, outconn);
 }
 
-int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
-			    void *data)
-{
-	int ret;
-
-	/*
-	 * Comparison with CS_MODE_SYSFS works without taking any device
-	 * specific spinlock because the truthyness of that comparison can only
-	 * change with coresight_mutex held, which we already have here.
-	 */
-	lockdep_assert_held(&coresight_mutex);
-	if (local_read(&csdev->mode) != CS_MODE_SYSFS) {
-		ret = source_ops(csdev)->enable(csdev, data, mode);
-		if (ret)
-			return ret;
-	}
-
-	atomic_inc(&csdev->refcnt);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(coresight_enable_source);
-
 static bool coresight_is_helper(struct coresight_device *csdev)
 {
 	return csdev->type == CORESIGHT_DEV_TYPE_HELPER;
@@ -392,30 +331,6 @@ void coresight_disable_source(struct coresight_device *csdev, void *data)
 }
 EXPORT_SYMBOL_GPL(coresight_disable_source);
 
-/**
- *  coresight_disable_source_sysfs - Drop the reference count by 1 and disable
- *  the device if there are no users left.
- *
- *  @csdev: The coresight device to disable
- *  @data: Opaque data to pass on to the disable function of the source device.
- *         For example in perf mode this is a pointer to the struct perf_event.
- *
- *  Returns true if the device has been disabled.
- */
-static bool coresight_disable_source_sysfs(struct coresight_device *csdev,
-					   void *data)
-{
-	lockdep_assert_held(&coresight_mutex);
-	if (local_read(&csdev->mode) != CS_MODE_SYSFS)
-		return false;
-
-	if (atomic_dec_return(&csdev->refcnt) == 0) {
-		coresight_disable_source(csdev, data);
-		return true;
-	}
-	return false;
-}
-
 /*
  * coresight_disable_path_from : Disable components in the given path beyond
  * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
@@ -572,39 +487,6 @@ struct coresight_device *coresight_get_sink(struct list_head *path)
 	return csdev;
 }
 
-/**
- * coresight_find_activated_sysfs_sink - returns the first sink activated via
- * sysfs using connection based search starting from the source reference.
- *
- * @csdev: Coresight source device reference
- */
-static struct coresight_device *
-coresight_find_activated_sysfs_sink(struct coresight_device *csdev)
-{
-	int i;
-	struct coresight_device *sink = NULL;
-
-	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
-	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
-	     csdev->sysfs_sink_activated)
-		return csdev;
-
-	/*
-	 * Recursively explore each port found on this element.
-	 */
-	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
-		struct coresight_device *child_dev;
-
-		child_dev = csdev->pdata->out_conns[i]->dest_dev;
-		if (child_dev)
-			sink = coresight_find_activated_sysfs_sink(child_dev);
-		if (sink)
-			return sink;
-	}
-
-	return NULL;
-}
-
 static int coresight_sink_by_id(struct device *dev, const void *data)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
@@ -1015,274 +897,6 @@ static void coresight_clear_default_sink(struct coresight_device *csdev)
 	}
 }
 
-/** coresight_validate_source - make sure a source has the right credentials
- *  @csdev:	the device structure for a source.
- *  @function:	the function this was called from.
- *
- * Assumes the coresight_mutex is held.
- */
-static int coresight_validate_source(struct coresight_device *csdev,
-				     const char *function)
-{
-	u32 type, subtype;
-
-	type = csdev->type;
-	subtype = csdev->subtype.source_subtype;
-
-	if (type != CORESIGHT_DEV_TYPE_SOURCE) {
-		dev_err(&csdev->dev, "wrong device type in %s\n", function);
-		return -EINVAL;
-	}
-
-	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
-	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
-	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
-	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
-		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
-int coresight_enable(struct coresight_device *csdev)
-{
-	int cpu, ret = 0;
-	struct coresight_device *sink;
-	struct list_head *path;
-	enum coresight_dev_subtype_source subtype;
-	u32 hash;
-
-	subtype = csdev->subtype.source_subtype;
-
-	mutex_lock(&coresight_mutex);
-
-	ret = coresight_validate_source(csdev, __func__);
-	if (ret)
-		goto out;
-
-	/*
-	 * mode == SYSFS implies that it's already enabled. Don't look at the
-	 * refcount to determine this because we don't claim the source until
-	 * coresight_enable_source() so can still race with Perf mode which
-	 * doesn't hold coresight_mutex.
-	 */
-	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
-		/*
-		 * There could be multiple applications driving the software
-		 * source. So keep the refcount for each such user when the
-		 * source is already enabled.
-		 */
-		if (subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE)
-			atomic_inc(&csdev->refcnt);
-		goto out;
-	}
-
-	sink = coresight_find_activated_sysfs_sink(csdev);
-	if (!sink) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	path = coresight_build_path(csdev, sink);
-	if (IS_ERR(path)) {
-		pr_err("building path(s) failed\n");
-		ret = PTR_ERR(path);
-		goto out;
-	}
-
-	ret = coresight_enable_path(path, CS_MODE_SYSFS, NULL);
-	if (ret)
-		goto err_path;
-
-	ret = coresight_enable_source(csdev, CS_MODE_SYSFS, NULL);
-	if (ret)
-		goto err_source;
-
-	switch (subtype) {
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
-		/*
-		 * When working from sysFS it is important to keep track
-		 * of the paths that were created so that they can be
-		 * undone in 'coresight_disable()'.  Since there can only
-		 * be a single session per tracer (when working from sysFS)
-		 * a per-cpu variable will do just fine.
-		 */
-		cpu = source_ops(csdev)->cpu_id(csdev);
-		per_cpu(tracer_path, cpu) = path;
-		break;
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM:
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
-		/*
-		 * Use the hash of source's device name as ID
-		 * and map the ID to the pointer of the path.
-		 */
-		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
-		ret = idr_alloc_u32(&path_idr, path, &hash, hash, GFP_KERNEL);
-		if (ret)
-			goto err_source;
-		break;
-	default:
-		/* We can't be here */
-		break;
-	}
-
-out:
-	mutex_unlock(&coresight_mutex);
-	return ret;
-
-err_source:
-	coresight_disable_path(path);
-
-err_path:
-	coresight_release_path(path);
-	goto out;
-}
-EXPORT_SYMBOL_GPL(coresight_enable);
-
-void coresight_disable(struct coresight_device *csdev)
-{
-	int cpu, ret;
-	struct list_head *path = NULL;
-	u32 hash;
-
-	mutex_lock(&coresight_mutex);
-
-	ret = coresight_validate_source(csdev, __func__);
-	if (ret)
-		goto out;
-
-	if (!coresight_disable_source_sysfs(csdev, NULL))
-		goto out;
-
-	switch (csdev->subtype.source_subtype) {
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
-		cpu = source_ops(csdev)->cpu_id(csdev);
-		path = per_cpu(tracer_path, cpu);
-		per_cpu(tracer_path, cpu) = NULL;
-		break;
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM:
-	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
-		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
-		/* Find the path by the hash. */
-		path = idr_find(&path_idr, hash);
-		if (path == NULL) {
-			pr_err("Path is not found for %s\n", dev_name(&csdev->dev));
-			goto out;
-		}
-		idr_remove(&path_idr, hash);
-		break;
-	default:
-		/* We can't be here */
-		break;
-	}
-
-	coresight_disable_path(path);
-	coresight_release_path(path);
-
-out:
-	mutex_unlock(&coresight_mutex);
-}
-EXPORT_SYMBOL_GPL(coresight_disable);
-
-static ssize_t enable_sink_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct coresight_device *csdev = to_coresight_device(dev);
-
-	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->sysfs_sink_activated);
-}
-
-static ssize_t enable_sink_store(struct device *dev,
-				 struct device_attribute *attr,
-				 const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
-	struct coresight_device *csdev = to_coresight_device(dev);
-
-	ret = kstrtoul(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	csdev->sysfs_sink_activated = !!val;
-
-	return size;
-
-}
-static DEVICE_ATTR_RW(enable_sink);
-
-static ssize_t enable_source_show(struct device *dev,
-				  struct device_attribute *attr, char *buf)
-{
-	struct coresight_device *csdev = to_coresight_device(dev);
-
-	guard(mutex)(&coresight_mutex);
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 local_read(&csdev->mode) == CS_MODE_SYSFS);
-}
-
-static ssize_t enable_source_store(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t size)
-{
-	int ret = 0;
-	unsigned long val;
-	struct coresight_device *csdev = to_coresight_device(dev);
-
-	ret = kstrtoul(buf, 10, &val);
-	if (ret)
-		return ret;
-
-	if (val) {
-		ret = coresight_enable(csdev);
-		if (ret)
-			return ret;
-	} else {
-		coresight_disable(csdev);
-	}
-
-	return size;
-}
-static DEVICE_ATTR_RW(enable_source);
-
-static struct attribute *coresight_sink_attrs[] = {
-	&dev_attr_enable_sink.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(coresight_sink);
-
-static struct attribute *coresight_source_attrs[] = {
-	&dev_attr_enable_source.attr,
-	NULL,
-};
-ATTRIBUTE_GROUPS(coresight_source);
-
-static struct device_type coresight_dev_type[] = {
-	{
-		.name = "sink",
-		.groups = coresight_sink_groups,
-	},
-	{
-		.name = "link",
-	},
-	{
-		.name = "linksink",
-		.groups = coresight_sink_groups,
-	},
-	{
-		.name = "source",
-		.groups = coresight_source_groups,
-	},
-	{
-		.name = "helper",
-	}
-};
-/* Ensure the enum matches the names and groups */
-static_assert(ARRAY_SIZE(coresight_dev_type) == CORESIGHT_DEV_TYPE_MAX);
-
 static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 29f62dfac673..a8be115636f0 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -714,7 +714,7 @@ static int etm_online_cpu(unsigned int cpu)
 		return 0;
 
 	if (etmdrvdata[cpu]->boot_enable && !etmdrvdata[cpu]->sticky_enable)
-		coresight_enable(etmdrvdata[cpu]->csdev);
+		coresight_enable_sysfs(etmdrvdata[cpu]->csdev);
 	return 0;
 }
 
@@ -924,7 +924,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	dev_info(&drvdata->csdev->dev,
 		 "%s initialized\n", (char *)coresight_get_uci_data(id));
 	if (boot_enable) {
-		coresight_enable(drvdata->csdev);
+		coresight_enable_sysfs(drvdata->csdev);
 		drvdata->boot_enable = true;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index ebf55b1f67d7..3480b563981c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1648,7 +1648,7 @@ static int etm4_online_cpu(unsigned int cpu)
 		return etm4_probe_cpu(cpu);
 
 	if (etmdrvdata[cpu]->boot_enable && !etmdrvdata[cpu]->sticky_enable)
-		coresight_enable(etmdrvdata[cpu]->csdev);
+		coresight_enable_sysfs(etmdrvdata[cpu]->csdev);
 	return 0;
 }
 
@@ -2096,7 +2096,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 		 drvdata->cpu, type_name, major, minor);
 
 	if (boot_enable) {
-		coresight_enable(drvdata->csdev);
+		coresight_enable_sysfs(drvdata->csdev);
 		drvdata->boot_enable = true;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index ced5be05a527..eb365236f9a9 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -12,6 +12,9 @@
 #include <linux/coresight.h>
 #include <linux/pm_runtime.h>
 
+extern struct mutex coresight_mutex;
+extern struct device_type coresight_dev_type[];
+
 /*
  * Coresight management registers (0xf00-0xfcc)
  * 0xfa0 - 0xfa4: Management	registers in PFTv1.0
@@ -229,8 +232,6 @@ void coresight_add_helper(struct coresight_device *csdev,
 
 void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
 struct coresight_device *coresight_get_percpu_sink(int cpu);
-int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
-			    void *data);
 void coresight_disable_source(struct coresight_device *csdev, void *data);
 
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 190ba569b05a..af9b21224246 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -332,7 +332,7 @@ static int stm_generic_link(struct stm_data *stm_data,
 	if (!drvdata || !drvdata->csdev)
 		return -EINVAL;
 
-	return coresight_enable(drvdata->csdev);
+	return coresight_enable_sysfs(drvdata->csdev);
 }
 
 static void stm_generic_unlink(struct stm_data *stm_data,
@@ -343,7 +343,7 @@ static void stm_generic_unlink(struct stm_data *stm_data,
 	if (!drvdata || !drvdata->csdev)
 		return;
 
-	coresight_disable(drvdata->csdev);
+	coresight_disable_sysfs(drvdata->csdev);
 }
 
 static phys_addr_t
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index dd78e9fcfc4d..92cdf8139f23 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -5,10 +5,400 @@
  */
 
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/kernel.h>
 
 #include "coresight-priv.h"
 
+/*
+ * Use IDR to map the hash of the source's device name
+ * to the pointer of path for the source. The idr is for
+ * the sources which aren't associated with CPU.
+ */
+static DEFINE_IDR(path_idr);
+
+/*
+ * When operating Coresight drivers from the sysFS interface, only a single
+ * path can exist from a tracer (associated to a CPU) to a sink.
+ */
+static DEFINE_PER_CPU(struct list_head *, tracer_path);
+
+ssize_t coresight_simple_show_pair(struct device *_dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
+	struct cs_pair_attribute *cs_attr = container_of(attr, struct cs_pair_attribute, attr);
+	u64 val;
+
+	pm_runtime_get_sync(_dev->parent);
+	val = csdev_access_relaxed_read_pair(&csdev->access, cs_attr->lo_off, cs_attr->hi_off);
+	pm_runtime_put_sync(_dev->parent);
+	return sysfs_emit(buf, "0x%llx\n", val);
+}
+EXPORT_SYMBOL_GPL(coresight_simple_show_pair);
+
+ssize_t coresight_simple_show32(struct device *_dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct coresight_device *csdev = container_of(_dev, struct coresight_device, dev);
+	struct cs_off_attribute *cs_attr = container_of(attr, struct cs_off_attribute, attr);
+	u64 val;
+
+	pm_runtime_get_sync(_dev->parent);
+	val = csdev_access_relaxed_read32(&csdev->access, cs_attr->off);
+	pm_runtime_put_sync(_dev->parent);
+	return sysfs_emit(buf, "0x%llx\n", val);
+}
+EXPORT_SYMBOL_GPL(coresight_simple_show32);
+
+static int coresight_enable_source_sysfs(struct coresight_device *csdev,
+					 enum cs_mode mode, void *data)
+{
+	int ret;
+
+	/*
+	 * Comparison with CS_MODE_SYSFS works without taking any device
+	 * specific spinlock because the truthyness of that comparison can only
+	 * change with coresight_mutex held, which we already have here.
+	 */
+	lockdep_assert_held(&coresight_mutex);
+	if (local_read(&csdev->mode) != CS_MODE_SYSFS) {
+		ret = source_ops(csdev)->enable(csdev, data, mode);
+		if (ret)
+			return ret;
+	}
+
+	atomic_inc(&csdev->refcnt);
+
+	return 0;
+}
+
+/**
+ *  coresight_disable_source_sysfs - Drop the reference count by 1 and disable
+ *  the device if there are no users left.
+ *
+ *  @csdev: The coresight device to disable
+ *  @data: Opaque data to pass on to the disable function of the source device.
+ *         For example in perf mode this is a pointer to the struct perf_event.
+ *
+ *  Returns true if the device has been disabled.
+ */
+static bool coresight_disable_source_sysfs(struct coresight_device *csdev,
+					   void *data)
+{
+	lockdep_assert_held(&coresight_mutex);
+	if (local_read(&csdev->mode) != CS_MODE_SYSFS)
+		return false;
+
+	if (atomic_dec_return(&csdev->refcnt) == 0) {
+		coresight_disable_source(csdev, data);
+		return true;
+	}
+	return false;
+}
+
+/**
+ * coresight_find_activated_sysfs_sink - returns the first sink activated via
+ * sysfs using connection based search starting from the source reference.
+ *
+ * @csdev: Coresight source device reference
+ */
+static struct coresight_device *
+coresight_find_activated_sysfs_sink(struct coresight_device *csdev)
+{
+	int i;
+	struct coresight_device *sink = NULL;
+
+	if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
+	     csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
+	     csdev->sysfs_sink_activated)
+		return csdev;
+
+	/*
+	 * Recursively explore each port found on this element.
+	 */
+	for (i = 0; i < csdev->pdata->nr_outconns; i++) {
+		struct coresight_device *child_dev;
+
+		child_dev = csdev->pdata->out_conns[i]->dest_dev;
+		if (child_dev)
+			sink = coresight_find_activated_sysfs_sink(child_dev);
+		if (sink)
+			return sink;
+	}
+
+	return NULL;
+}
+
+/** coresight_validate_source - make sure a source has the right credentials to
+ *  be used via sysfs.
+ *  @csdev:	the device structure for a source.
+ *  @function:	the function this was called from.
+ *
+ * Assumes the coresight_mutex is held.
+ */
+static int coresight_validate_source_sysfs(struct coresight_device *csdev,
+				     const char *function)
+{
+	u32 type, subtype;
+
+	type = csdev->type;
+	subtype = csdev->subtype.source_subtype;
+
+	if (type != CORESIGHT_DEV_TYPE_SOURCE) {
+		dev_err(&csdev->dev, "wrong device type in %s\n", function);
+		return -EINVAL;
+	}
+
+	if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
+	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
+	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
+	    subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
+		dev_err(&csdev->dev, "wrong device subtype in %s\n", function);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int coresight_enable_sysfs(struct coresight_device *csdev)
+{
+	int cpu, ret = 0;
+	struct coresight_device *sink;
+	struct list_head *path;
+	enum coresight_dev_subtype_source subtype;
+	u32 hash;
+
+	subtype = csdev->subtype.source_subtype;
+
+	mutex_lock(&coresight_mutex);
+
+	ret = coresight_validate_source_sysfs(csdev, __func__);
+	if (ret)
+		goto out;
+
+	/*
+	 * mode == SYSFS implies that it's already enabled. Don't look at the
+	 * refcount to determine this because we don't claim the source until
+	 * coresight_enable_source() so can still race with Perf mode which
+	 * doesn't hold coresight_mutex.
+	 */
+	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
+		/*
+		 * There could be multiple applications driving the software
+		 * source. So keep the refcount for each such user when the
+		 * source is already enabled.
+		 */
+		if (subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE)
+			atomic_inc(&csdev->refcnt);
+		goto out;
+	}
+
+	sink = coresight_find_activated_sysfs_sink(csdev);
+	if (!sink) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	path = coresight_build_path(csdev, sink);
+	if (IS_ERR(path)) {
+		pr_err("building path(s) failed\n");
+		ret = PTR_ERR(path);
+		goto out;
+	}
+
+	ret = coresight_enable_path(path, CS_MODE_SYSFS, NULL);
+	if (ret)
+		goto err_path;
+
+	ret = coresight_enable_source_sysfs(csdev, CS_MODE_SYSFS, NULL);
+	if (ret)
+		goto err_source;
+
+	switch (subtype) {
+	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
+		/*
+		 * When working from sysFS it is important to keep track
+		 * of the paths that were created so that they can be
+		 * undone in 'coresight_disable()'.  Since there can only
+		 * be a single session per tracer (when working from sysFS)
+		 * a per-cpu variable will do just fine.
+		 */
+		cpu = source_ops(csdev)->cpu_id(csdev);
+		per_cpu(tracer_path, cpu) = path;
+		break;
+	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
+	case CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM:
+	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
+		/*
+		 * Use the hash of source's device name as ID
+		 * and map the ID to the pointer of the path.
+		 */
+		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
+		ret = idr_alloc_u32(&path_idr, path, &hash, hash, GFP_KERNEL);
+		if (ret)
+			goto err_source;
+		break;
+	default:
+		/* We can't be here */
+		break;
+	}
+
+out:
+	mutex_unlock(&coresight_mutex);
+	return ret;
+
+err_source:
+	coresight_disable_path(path);
+
+err_path:
+	coresight_release_path(path);
+	goto out;
+}
+EXPORT_SYMBOL_GPL(coresight_enable_sysfs);
+
+void coresight_disable_sysfs(struct coresight_device *csdev)
+{
+	int cpu, ret;
+	struct list_head *path = NULL;
+	u32 hash;
+
+	mutex_lock(&coresight_mutex);
+
+	ret = coresight_validate_source_sysfs(csdev, __func__);
+	if (ret)
+		goto out;
+
+	if (!coresight_disable_source_sysfs(csdev, NULL))
+		goto out;
+
+	switch (csdev->subtype.source_subtype) {
+	case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
+		cpu = source_ops(csdev)->cpu_id(csdev);
+		path = per_cpu(tracer_path, cpu);
+		per_cpu(tracer_path, cpu) = NULL;
+		break;
+	case CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE:
+	case CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM:
+	case CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS:
+		hash = hashlen_hash(hashlen_string(NULL, dev_name(&csdev->dev)));
+		/* Find the path by the hash. */
+		path = idr_find(&path_idr, hash);
+		if (path == NULL) {
+			pr_err("Path is not found for %s\n", dev_name(&csdev->dev));
+			goto out;
+		}
+		idr_remove(&path_idr, hash);
+		break;
+	default:
+		/* We can't be here */
+		break;
+	}
+
+	coresight_disable_path(path);
+	coresight_release_path(path);
+
+out:
+	mutex_unlock(&coresight_mutex);
+}
+EXPORT_SYMBOL_GPL(coresight_disable_sysfs);
+
+static ssize_t enable_sink_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->sysfs_sink_activated);
+}
+
+static ssize_t enable_sink_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	int ret;
+	unsigned long val;
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	csdev->sysfs_sink_activated = !!val;
+
+	return size;
+
+}
+static DEVICE_ATTR_RW(enable_sink);
+
+static ssize_t enable_source_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	guard(mutex)(&coresight_mutex);
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 local_read(&csdev->mode) == CS_MODE_SYSFS);
+}
+
+static ssize_t enable_source_store(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t size)
+{
+	int ret = 0;
+	unsigned long val;
+	struct coresight_device *csdev = to_coresight_device(dev);
+
+	ret = kstrtoul(buf, 10, &val);
+	if (ret)
+		return ret;
+
+	if (val) {
+		ret = coresight_enable_sysfs(csdev);
+		if (ret)
+			return ret;
+	} else {
+		coresight_disable_sysfs(csdev);
+	}
+
+	return size;
+}
+static DEVICE_ATTR_RW(enable_source);
+
+static struct attribute *coresight_sink_attrs[] = {
+	&dev_attr_enable_sink.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(coresight_sink);
+
+static struct attribute *coresight_source_attrs[] = {
+	&dev_attr_enable_source.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(coresight_source);
+
+struct device_type coresight_dev_type[] = {
+	{
+		.name = "sink",
+		.groups = coresight_sink_groups,
+	},
+	{
+		.name = "link",
+	},
+	{
+		.name = "linksink",
+		.groups = coresight_sink_groups,
+	},
+	{
+		.name = "source",
+		.groups = coresight_source_groups,
+	},
+	{
+		.name = "helper",
+	}
+};
+/* Ensure the enum matches the names and groups */
+static_assert(ARRAY_SIZE(coresight_dev_type) == CORESIGHT_DEV_TYPE_MAX);
+
 /*
  * Connections group - links attribute.
  * Count of created links between coresight components in the group.
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 46e6667f72ce..e8dd0df98881 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -578,8 +578,8 @@ static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
-extern int coresight_enable(struct coresight_device *csdev);
-extern void coresight_disable(struct coresight_device *csdev);
+extern int coresight_enable_sysfs(struct coresight_device *csdev);
+extern void coresight_disable_sysfs(struct coresight_device *csdev);
 extern int coresight_timeout(struct csdev_access *csa, u32 offset,
 			     int position, int value);
 
@@ -609,8 +609,8 @@ static inline struct coresight_device *
 coresight_register(struct coresight_desc *desc) { return NULL; }
 static inline void coresight_unregister(struct coresight_device *csdev) {}
 static inline int
-coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
-static inline void coresight_disable(struct coresight_device *csdev) {}
+coresight_enable_sysfs(struct coresight_device *csdev) { return -ENOSYS; }
+static inline void coresight_disable_sysfs(struct coresight_device *csdev) {}
 
 static inline int coresight_timeout(struct csdev_access *csa, u32 offset,
 				    int position, int value)
-- 
2.34.1


