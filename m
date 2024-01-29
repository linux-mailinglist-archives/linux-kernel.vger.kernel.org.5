Return-Path: <linux-kernel+bounces-43022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFA5840A52
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7452281318
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13039155A33;
	Mon, 29 Jan 2024 15:42:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84136155314
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542962; cv=none; b=aHYcITu5/+5NsiB82Mhq9NnPIpXCoXOOSo/EXEpH5rr4KvyZCqhYaBB9cxaYtAnzJelsmX0WQVc8w9IuR5Zlw3stY+/yXI6PyJNXcJwVq5OiCuNZaPw21qkt5KS1WaSjQAOXRbIguSpM37KgZszQmYpqU25c2HP1/9YRBVbr1Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542962; c=relaxed/simple;
	bh=xUWRBNQZVqitk4v7i63j+Unyd7Fb9W7l+PKYSUawyxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j4m4XqRBro8eOsITz6getshbwwd5bIX67Sg77FNG0v+C+OAPy0AWpFSIuWdsFBiph//bejwy+aoxqqXa3hbeIn4UbUbZ8ynz6PeAO7uJwOt/2L5h4zhK6XWGW67nixsEY8rqRBcQnYdwU+EGy7ACsFhSHkq8mOo27FOL5TNVWEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C84EEDA7;
	Mon, 29 Jan 2024 07:43:23 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4DF813F738;
	Mon, 29 Jan 2024 07:42:37 -0800 (PST)
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
Subject: [PATCH v2 10/12] coresight: Add helper for atomically taking the device
Date: Mon, 29 Jan 2024 15:40:41 +0000
Message-Id: <20240129154050.569566-11-james.clark@arm.com>
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

Now that mode is in struct coresight_device, this pattern can be wrapped
in a helper.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c |  8 +++-----
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  8 +++-----
 drivers/hwtracing/coresight/coresight-stm.c        |  8 +++-----
 include/linux/coresight.h                          | 11 +++++++++++
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index a8be115636f0..ce2b3ed90fb9 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -556,14 +556,12 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 		      enum cs_mode mode)
 {
 	int ret;
-	u32 val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	val = local_cmpxchg(&drvdata->csdev->mode, CS_MODE_DISABLED, mode);
-
-	/* Someone is already using the tracer */
-	if (val)
+	if (!coresight_take_mode(csdev, mode)) {
+		/* Someone is already using the tracer */
 		return -EBUSY;
+	}
 
 	switch (mode) {
 	case CS_MODE_SYSFS:
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 3480b563981c..8fca7fc379e6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -840,13 +840,11 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
 		       enum cs_mode mode)
 {
 	int ret;
-	u32 val;
 
-	val = local_cmpxchg(&csdev->mode, CS_MODE_DISABLED, mode);
-
-	/* Someone is already using the tracer */
-	if (val)
+	if (!coresight_take_mode(csdev, mode)) {
+		/* Someone is already using the tracer */
 		return -EBUSY;
+	}
 
 	switch (mode) {
 	case CS_MODE_SYSFS:
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index af9b21224246..80fed4c377f1 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -193,17 +193,15 @@ static void stm_enable_hw(struct stm_drvdata *drvdata)
 static int stm_enable(struct coresight_device *csdev, struct perf_event *event,
 		      enum cs_mode mode)
 {
-	u32 val;
 	struct stm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	if (mode != CS_MODE_SYSFS)
 		return -EINVAL;
 
-	val = local_cmpxchg(&csdev->mode, CS_MODE_DISABLED, mode);
-
-	/* Someone is already using the tracer */
-	if (val)
+	if (!coresight_take_mode(csdev, mode)) {
+		/* Someone is already using the tracer */
 		return -EBUSY;
+	}
 
 	pm_runtime_get_sync(csdev->dev.parent);
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c5be46d7f85c..175d184b3a1b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -580,6 +580,17 @@ static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
 	       (csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM);
 }
 
+/*
+ * Atomically try to take the device and set a new mode. Returns true on
+ * success, false if the device is already taken by someone else.
+ */
+static inline bool coresight_take_mode(struct coresight_device *csdev,
+				       enum cs_mode new_mode)
+{
+	return local_cmpxchg(&csdev->mode, CS_MODE_DISABLED, new_mode) ==
+	       CS_MODE_DISABLED;
+}
+
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
-- 
2.34.1


