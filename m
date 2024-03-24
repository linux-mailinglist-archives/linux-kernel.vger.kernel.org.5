Return-Path: <linux-kernel+bounces-113952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294DD888EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934A81F27614
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6417C1553A9;
	Sun, 24 Mar 2024 23:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mt0EwLVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC8514B08D;
	Sun, 24 Mar 2024 22:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321064; cv=none; b=llEp0VmLYRxbA8GbjfV5mxeqHPaolHGQkgSKIz9dF4UdI5BfWpDlCZcjrNgPaS/VJTSLrhjLhSi09A8oUUG5O4EwnONhvi8PJ8rt/4EEZ6ANQiRwgO8qQfr6zB0qUh7qRUD9wvzVxU4jAh5fHMw6Ll5gkCcO03Sjff7fVYHhDSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321064; c=relaxed/simple;
	bh=GmA85pVNgXfICJsOgFzqtfBOM3XZ/b6jZoewaOK83m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmVmrHD67RUjX3v7fDsrmt7tQ3SeYDghtCX07QEaxGcxAvXTVaEPhWDB+8r8ev0o8v66qN1P42ECMlQMXznk1jGgxbQZ+s4NHUMFMXSfiF+NHq38rWdUtsd327vp+yjfRbTG75q4pDoNSvwJ40jvMJEJt1ZNmgip4djsDIN4MRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mt0EwLVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC90FC433F1;
	Sun, 24 Mar 2024 22:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321063;
	bh=GmA85pVNgXfICJsOgFzqtfBOM3XZ/b6jZoewaOK83m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mt0EwLVOoAxVQ66tBK81ant3K0Wqb2K0ia+UhUYkz7odhqLZJiOjeVi6t7r+/+Kuk
	 lQZsdpccgOt/q5RoU556sfo9dsAR5YeYzHlYOr/MO4ue2S/Aj+Za3X5jPl0WxPNpyI
	 5uXa7kjegMXg7ckafpZAxQtiT/81k9A1tjowqrjzzUEvqTnb61SrN+FjHPJ/ajDyoa
	 zTgT3t3Hvx8ibotHRdnij0oAVZzrk0x5KGwEFe99nbfeGFqnQxaAHDQdoKSjRYgphn
	 UzJj66VlJcOkjrn1xcnynHDizhuufvOPV/VrYYiyOf+UIOAt4QB+SlJ01Zdm+U2Ts1
	 a0OSjCfWPno8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: James Clark <james.clark@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 627/713] coresight: Fix issue where a source device's helpers aren't disabled
Date: Sun, 24 Mar 2024 18:45:53 -0400
Message-ID: <20240324224720.1345309-628-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: James Clark <james.clark@arm.com>

[ Upstream commit f68bbe4dcfa303164922bc331d2e8d38ed2d4f23 ]

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
Link: https://lore.kernel.org/r/20240129154050.569566-2-james.clark@arm.com
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-core.c  | 30 ++++++++++++++-----
 .../hwtracing/coresight/coresight-etm-perf.c  |  2 +-
 drivers/hwtracing/coresight/coresight-priv.h  |  2 +-
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 9fabe00a40d6a..4b80026db1ab6 100644
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
@@ -1202,7 +1218,7 @@ void coresight_disable(struct coresight_device *csdev)
 	if (ret)
 		goto out;
 
-	if (!csdev->enable || !coresight_disable_source(csdev, NULL))
+	if (!csdev->enable || !coresight_disable_source_sysfs(csdev, NULL))
 		goto out;
 
 	switch (csdev->subtype.source_subtype) {
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 89e8ed214ea49..58b32b399fac2 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -587,7 +587,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
 		return;
 
 	/* stop tracer */
-	source_ops(csdev)->disable(csdev, event);
+	coresight_disable_source(csdev, event);
 
 	/* tell the core */
 	event->hw.state = PERF_HES_STOPPED;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 767076e079701..30c051055e54b 100644
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
2.43.0


