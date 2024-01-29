Return-Path: <linux-kernel+bounces-43013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC79840A42
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9100B21BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CCA6154445;
	Mon, 29 Jan 2024 15:41:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49315442B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542878; cv=none; b=O8l6XqStmvTwBaFIrBiDahxgDCqakxtR5VCSCaiqAG5gQBiaYlNjH6JSYmI2wNoCmb3qggLDyTnNJEITEkzI5ZWhLQxbM3jqn8PAWXgvWC/fHwhrzYSDA1JjypaOEd9mKb2rMU5zyO7/fxfyHeIgNmwiTucgyGf586SH8OvCFSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542878; c=relaxed/simple;
	bh=PEOGuzP6PFl+ajWCIITm7euvHPgcigmvwaqg3Z4L3tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kwor5vZo/qrcY7wEysKxhI+k8vPzc9zag1IzCbrsYlBRk8XsiVex5gHDjc9hFdIZ19lquuxA1sYXNZzX5D0cVKLy5r+YFhH2aNcj+Jc0vJlyYLnWMOX01mzkpxFzvxSEytzc1zoWN2qqRQWgGF+aYUPvNh3SE2AJ3d8sSOpJnIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D9A4DA7;
	Mon, 29 Jan 2024 07:41:59 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 578993F738;
	Mon, 29 Jan 2024 07:41:13 -0800 (PST)
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
Subject: [PATCH v2 01/12] coresight: Fix issue where a source device's helpers aren't disabled
Date: Mon, 29 Jan 2024 15:40:32 +0000
Message-Id: <20240129154050.569566-2-james.clark@arm.com>
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

The linked commit reverts the change that accidentally used some sysfs
enable/disable functions from Perf which broke the refcounting, but it
also removes the fact that the sysfs disable function disabled the
helpers.

Add a new wrapper function that does both which is used by both Perf and
sysfs, and label the sysfs disable function appropriately. The naming of
all of the functions will be tidied up later to avoid this happening
again.

Fixes: 287e82cf69aa ("coresight: Fix crash when Perf and sysfs modes are used concurrently")
Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 30 ++++++++++++++-----
 .../hwtracing/coresight/coresight-etm-perf.c  |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  2 +-
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index d7f0e231feb9..965bb6d4e1bf 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -441,8 +441,26 @@ static void coresight_disable_helpers(struct coresight_device *csdev)
 	}
 }
 
+/*
+ * Helper function to call source_ops(csdev)->disable and also disable the
+ * helpers.
+ *
+ * There is an imbalance between coresight_enable_path() and
+ * coresight_disable_path(). Enabling also enables the source's helpers as part
+ * of the path, but disabling always skips the first item in the path (which is
+ * the source), so sources and their helpers don't get disabled as part of that
+ * function and we need the extra step here.
+ */
+void coresight_disable_source(struct coresight_device *csdev, void *data)
+{
+	if (source_ops(csdev)->disable)
+		source_ops(csdev)->disable(csdev, data);
+	coresight_disable_helpers(csdev);
+}
+EXPORT_SYMBOL_GPL(coresight_disable_source);
+
 /**
- *  coresight_disable_source - Drop the reference count by 1 and disable
+ *  coresight_disable_source_sysfs - Drop the reference count by 1 and disable
  *  the device if there are no users left.
  *
  *  @csdev: The coresight device to disable
@@ -451,17 +469,15 @@ static void coresight_disable_helpers(struct coresight_device *csdev)
  *
  *  Returns true if the device has been disabled.
  */
-bool coresight_disable_source(struct coresight_device *csdev, void *data)
+static bool coresight_disable_source_sysfs(struct coresight_device *csdev,
+					   void *data)
 {
 	if (atomic_dec_return(&csdev->refcnt) == 0) {
-		if (source_ops(csdev)->disable)
-			source_ops(csdev)->disable(csdev, data);
-		coresight_disable_helpers(csdev);
+		coresight_disable_source(csdev, data);
 		csdev->enable = false;
 	}
 	return !csdev->enable;
 }
-EXPORT_SYMBOL_GPL(coresight_disable_source);
 
 /*
  * coresight_disable_path_from : Disable components in the given path beyond
@@ -1204,7 +1220,7 @@ void coresight_disable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (!csdev->enable || !coresight_disable_source(csdev, NULL))
+	if (!csdev->enable || !coresight_disable_source_sysfs(csdev, NULL))
 		goto out;
 
 	switch (csdev->subtype.source_subtype) {
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index a52cfcce25d6..c0c60e6a1703 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -589,7 +589,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		return;
 
 	/* stop tracer */
-	source_ops(csdev)->disable(csdev, event);
+	coresight_disable_source(csdev, event);
 
 	/* tell the core */
 	event->hw.state = PERF_HES_STOPPED;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 767076e07970..30c051055e54 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -233,6 +233,6 @@ void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
 struct coresight_device *coresight_get_percpu_sink(int cpu);
 int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
 			    void *data);
-bool coresight_disable_source(struct coresight_device *csdev, void *data);
+void coresight_disable_source(struct coresight_device *csdev, void *data);
 
 #endif
-- 
2.34.1


