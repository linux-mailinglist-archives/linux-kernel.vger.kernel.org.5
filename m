Return-Path: <linux-kernel+bounces-43017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB6D840A4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2A21F22C18
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B90E154443;
	Mon, 29 Jan 2024 15:41:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6D1552F5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542915; cv=none; b=n5P6cjboSl2WKoIlFEeWigD1fOrCdPTBzs7Ty1vL96+L+xRPCmSNWtYxrtnT1j3gbpymAs6oMNC83v5mCxGK+R6SpWYTgAHd6+uGDtwNWndbkpJRn5pJv16xEdLSsJ53b9L2V8I6KsnciwQKmPl3Lv8j1ZZxhUQDMHG2KrfuDcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542915; c=relaxed/simple;
	bh=UbUnSh23tU40T+TVh/u1YDSjb4XSwXKPaZ12LO/GXwE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfn6kn9Q3vxiGC52DP1k2ecL4VaXRx/md5H3k+L/HLb04jVVfUUjFqH/yuZmpvKA6FRW4Ep4c41w3ETtdxdu7xXgxm/A9pDFsDzCWvQGjkTHu0XYiPcKITn8vKWzgNZRWs/zwCvcn6wwloqLdHvm6llcXOtdMQbdTZc7F/RklyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C43F91682;
	Mon, 29 Jan 2024 07:42:35 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9366F3F738;
	Mon, 29 Jan 2024 07:41:49 -0800 (PST)
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
Subject: [PATCH v2 05/12] coresight: Remove the 'enable' field.
Date: Mon, 29 Jan 2024 15:40:36 +0000
Message-Id: <20240129154050.569566-6-james.clark@arm.com>
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

'enable', which probably should have been 'enabled', is only ever read
in the core code in relation to controlling sources, and specifically
only sources in sysfs mode. Confusingly it's not labelled as such and
relying on it can be a source of bugs like the one fixed by
commit 078dbba3f0c9 ("coresight: Fix crash when Perf and sysfs modes are
used concurrently").

Most importantly, it can only be used when the coresight_mutex is held
which is only done when enabling and disabling paths in sysfs mode, and
not Perf mode. So to prevent its usage spreading and leaking out to
other devices, remove it.

It's use is equivalent to checking if the mode is currently sysfs, as
due to the coresight_mutex lock, mode == CS_MODE_SYSFS can only become
true or untrue when that lock is held, and when mode == CS_MODE_SYSFS
the device is both enabled and in sysfs mode.

The one place it was used outside of the core code is in TPDA, but that
pattern is more appropriately represented using refcounts inside the
device's own spinlock.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 86 +++++++-------------
 drivers/hwtracing/coresight/coresight-tpda.c | 12 ++-
 include/linux/coresight.h                    |  2 -
 3 files changed, 38 insertions(+), 62 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 37767656bf9d..e59fa9a906a3 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -279,29 +279,18 @@ EXPORT_SYMBOL_GPL(coresight_add_helper);
 static int coresight_enable_sink(struct coresight_device *csdev,
 				 enum cs_mode mode, void *data)
 {
-	int ret = sink_ops(csdev)->enable(csdev, mode, data);
-
-	if (ret)
-		return ret;
-
-	csdev->enable = true;
-
-	return 0;
+	return sink_ops(csdev)->enable(csdev, mode, data);
 }
 
 static void coresight_disable_sink(struct coresight_device *csdev)
 {
-	int ret = sink_ops(csdev)->disable(csdev);
-	if (ret)
-		return;
-	csdev->enable = false;
+	sink_ops(csdev)->disable(csdev);
 }
 
 static int coresight_enable_link(struct coresight_device *csdev,
 				 struct coresight_device *parent,
 				 struct coresight_device *child)
 {
-	int ret = 0;
 	int link_subtype;
 	struct coresight_connection *inconn, *outconn;
 
@@ -317,19 +306,13 @@ static int coresight_enable_link(struct coresight_device *csdev,
 	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT && IS_ERR(outconn))
 		return PTR_ERR(outconn);
 
-	ret = link_ops(csdev)->enable(csdev, inconn, outconn);
-	if (!ret)
-		csdev->enable = true;
-
-	return ret;
+	return link_ops(csdev)->enable(csdev, inconn, outconn);
 }
 
 static void coresight_disable_link(struct coresight_device *csdev,
 				   struct coresight_device *parent,
 				   struct coresight_device *child)
 {
-	int i;
-	int link_subtype;
 	struct coresight_connection *inconn, *outconn;
 
 	if (!parent || !child)
@@ -337,26 +320,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
 
 	inconn = coresight_find_out_connection(parent, csdev);
 	outconn = coresight_find_out_connection(csdev, child);
-	link_subtype = csdev->subtype.link_subtype;
 
 	link_ops(csdev)->disable(csdev, inconn, outconn);
-
-	if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_MERG) {
-		for (i = 0; i < csdev->pdata->nr_inconns; i++)
-			if (atomic_read(&csdev->pdata->in_conns[i]->dest_refcnt) !=
-			    0)
-				return;
-	} else if (link_subtype == CORESIGHT_DEV_SUBTYPE_LINK_SPLIT) {
-		for (i = 0; i < csdev->pdata->nr_outconns; i++)
-			if (atomic_read(&csdev->pdata->out_conns[i]->src_refcnt) !=
-			    0)
-				return;
-	} else {
-		if (atomic_read(&csdev->refcnt) != 0)
-			return;
-	}
-
-	csdev->enable = false;
 }
 
 int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
@@ -364,11 +329,16 @@ int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
 {
 	int ret;
 
-	if (!csdev->enable) {
+	/*
+	 * Comparison with CS_MODE_SYSFS works without taking any device
+	 * specific spinlock because the truthyness of that comparison can only
+	 * change with coresight_mutex held, which we already have here.
+	 */
+	lockdep_assert_held(&coresight_mutex);
+	if (local_read(&csdev->mode) != CS_MODE_SYSFS) {
 		ret = source_ops(csdev)->enable(csdev, data, mode);
 		if (ret)
 			return ret;
-		csdev->enable = true;
 	}
 
 	atomic_inc(&csdev->refcnt);
@@ -385,22 +355,12 @@ static bool coresight_is_helper(struct coresight_device *csdev)
 static int coresight_enable_helper(struct coresight_device *csdev,
 				   enum cs_mode mode, void *data)
 {
-	int ret = helper_ops(csdev)->enable(csdev, mode, data);
-
-	if (ret)
-		return ret;
-
-	csdev->enable = true;
-	return 0;
+	return helper_ops(csdev)->enable(csdev, mode, data);
 }
 
 static void coresight_disable_helper(struct coresight_device *csdev)
 {
-	int ret = helper_ops(csdev)->disable(csdev, NULL);
-
-	if (ret)
-		return;
-	csdev->enable = false;
+	helper_ops(csdev)->disable(csdev, NULL);
 }
 
 static void coresight_disable_helpers(struct coresight_device *csdev)
@@ -445,11 +405,15 @@ EXPORT_SYMBOL_GPL(coresight_disable_source);
 static bool coresight_disable_source_sysfs(struct coresight_device *csdev,
 					   void *data)
 {
+	lockdep_assert_held(&coresight_mutex);
+	if (local_read(&csdev->mode) != CS_MODE_SYSFS)
+		return false;
+
 	if (atomic_dec_return(&csdev->refcnt) == 0) {
 		coresight_disable_source(csdev, data);
-		csdev->enable = false;
+		return true;
 	}
-	return !csdev->enable;
+	return false;
 }
 
 /*
@@ -1097,7 +1061,13 @@ int coresight_enable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (csdev->enable) {
+	/*
+	 * mode == SYSFS implies that it's already enabled. Don't look at the
+	 * refcount to determine this because we don't claim the source until
+	 * coresight_enable_source() so can still race with Perf mode which
+	 * doesn't hold coresight_mutex.
+	 */
+	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
 		/*
 		 * There could be multiple applications driving the software
 		 * source. So keep the refcount for each such user when the
@@ -1183,7 +1153,7 @@ void coresight_disable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (!csdev->enable || !coresight_disable_source_sysfs(csdev, NULL))
+	if (!coresight_disable_source_sysfs(csdev, NULL))
 		goto out;
 
 	switch (csdev->subtype.source_subtype) {
@@ -1249,7 +1219,9 @@ static ssize_t enable_source_show(struct device *dev,
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->enable);
+	guard(mutex)(&coresight_mutex);
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 local_read(&csdev->mode) == CS_MODE_SYSFS);
 }
 
 static ssize_t enable_source_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 5f82737c37bb..65c70995ab00 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -148,7 +148,11 @@ static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
 
 	CS_UNLOCK(drvdata->base);
 
-	if (!drvdata->csdev->enable)
+	/*
+	 * Only do pre-port enable for first port that calls enable when the
+	 * device's main refcount is still 0
+	 */
+	if (!atomic_read(&drvdata->csdev->refcnt))
 		tpda_enable_pre_port(drvdata);
 
 	ret = tpda_enable_port(drvdata, port);
@@ -169,6 +173,7 @@ static int tpda_enable(struct coresight_device *csdev,
 		ret = __tpda_enable(drvdata, in->dest_port);
 		if (!ret) {
 			atomic_inc(&in->dest_refcnt);
+			atomic_inc(&csdev->refcnt);
 			dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
 		}
 	}
@@ -197,9 +202,10 @@ static void tpda_disable(struct coresight_device *csdev,
 	struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	spin_lock(&drvdata->spinlock);
-	if (atomic_dec_return(&in->dest_refcnt) == 0)
+	if (atomic_dec_return(&in->dest_refcnt) == 0) {
 		__tpda_disable(drvdata, in->dest_port);
-
+		atomic_dec(&csdev->refcnt);
+	}
 	spin_unlock(&drvdata->spinlock);
 
 	dev_dbg(drvdata->dev, "TPDA inport %d disabled\n", in->dest_port);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index ba817f563ff7..46e6667f72ce 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -233,7 +233,6 @@ struct coresight_sysfs_link {
  *		a non-atomic read would also work.
  * @refcnt:	keep track of what is in use.
  * @orphan:	true if the component has connections that haven't been linked.
- * @enable:	'true' if component is currently part of an active path.
  * @sysfs_sink_activated: 'true' when a sink has been selected for use via sysfs
  *		by writing a 1 to the 'enable_sink' file.  A sink can be
  *		activated but not yet enabled.  Enabling for a _sink_ happens
@@ -260,7 +259,6 @@ struct coresight_device {
 	local_t	mode;
 	atomic_t refcnt;
 	bool orphan;
-	bool enable;
 	/* sink specific fields */
 	bool sysfs_sink_activated;
 	struct dev_ext_attribute *ea;
-- 
2.34.1


