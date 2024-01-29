Return-Path: <linux-kernel+bounces-43025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5E3840A57
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758B42855A0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314A4155A3F;
	Mon, 29 Jan 2024 15:43:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F19154C0C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542981; cv=none; b=fphoqa3EdyA/X7nXULgtwjUxcOS/OhfkvDZpLB9pws996teb3ZoMeom6u1gbIGPoY+IiyVfblHkqR313E+JMQuiP4rzz48raO6QlCyLsFY83UGYIQwoyoUNP+atPhlz+TDVxizlfDDeigzMS5YiJ98w970p4+9YqmoiKhFOH8ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542981; c=relaxed/simple;
	bh=V6gPdvWvE/f94nSb01JEWy7RqqLCh2EpZV9yIXNqpc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O/2mo4B1uiyMRJ5gRpWpjWG9frxZtS5johUtYeLJlLAnKELcecPj37V2IfL7dCL6ndj5jtZUi7vgk4XL+6W0kkCkp22gSAAXz24jY8TDZ5GqVvSU+Is5NjT4uB95sEyp3rD1Iitx/G48K5eADO2njLtdBp2eNRxW4HmyobY3CXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0DF1DA7;
	Mon, 29 Jan 2024 07:43:42 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 27FA63F738;
	Mon, 29 Jan 2024 07:42:55 -0800 (PST)
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
Subject: [PATCH v2 12/12] coresight: Add helper for setting csdev->mode
Date: Mon, 29 Jan 2024 15:40:43 +0000
Message-Id: <20240129154050.569566-13-james.clark@arm.com>
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

Now that mode is in struct coresight_device, sets can be wrapped. This
also allows us to add a sanity check that there have been no concurrent
modifications of mode. Currently all usages of local_set() were inside
the device's spin locks so this new warning shouldn't be triggered.

coresight_take_mode() could maybe have been used in place of adding
the warning, but there may be use cases which set the mode to the same
mode which are valid but would fail in coresight_take_mode() because
it requires the device to only be in the disabled state.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c    |  6 +++---
 .../hwtracing/coresight/coresight-etm3x-core.c   |  4 ++--
 .../hwtracing/coresight/coresight-etm4x-core.c   |  4 ++--
 drivers/hwtracing/coresight/coresight-stm.c      |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c  | 10 +++++-----
 drivers/hwtracing/coresight/coresight-tmc-etr.c  |  6 +++---
 drivers/hwtracing/coresight/ultrasoc-smb.c       |  6 +++---
 include/linux/coresight.h                        | 16 ++++++++++++++++
 8 files changed, 35 insertions(+), 19 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 4e82d9c20d36..aea4ce6fb0b6 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -158,7 +158,7 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 		if (ret)
 			goto out;
 
-		local_set(&csdev->mode, CS_MODE_SYSFS);
+		coresight_set_mode(csdev, CS_MODE_SYSFS);
 	}
 
 	csdev->refcnt++;
@@ -214,7 +214,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	if (!ret) {
 		/* Associate with monitored process. */
 		drvdata->pid = pid;
-		local_set(&drvdata->csdev->mode, CS_MODE_PERF);
+		coresight_set_mode(drvdata->csdev, CS_MODE_PERF);
 		csdev->refcnt++;
 	}
 
@@ -365,7 +365,7 @@ static int etb_disable(struct coresight_device *csdev)
 	etb_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
-	local_set(&csdev->mode, CS_MODE_DISABLED);
+	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&csdev->dev, "ETB disabled\n");
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 63991029cda0..bda9fb61559c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -576,7 +576,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 
 	/* The tracer didn't start */
 	if (ret)
-		local_set(&drvdata->csdev->mode, CS_MODE_DISABLED);
+		coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
 
 	return ret;
 }
@@ -693,7 +693,7 @@ static void etm_disable(struct coresight_device *csdev,
 	}
 
 	if (mode)
-		local_set(&csdev->mode, CS_MODE_DISABLED);
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 }
 
 static const struct coresight_ops_source etm_source_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 08451b3f8eaa..2d0a9da610c3 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -859,7 +859,7 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
 
 	/* The tracer didn't start */
 	if (ret)
-		local_set(&csdev->mode, CS_MODE_DISABLED);
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 
 	return ret;
 }
@@ -1021,7 +1021,7 @@ static void etm4_disable(struct coresight_device *csdev,
 	}
 
 	if (mode)
-		local_set(&csdev->mode, CS_MODE_DISABLED);
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 }
 
 static const struct coresight_ops_source etm4_source_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 53a07a536968..6e801191d1db 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -272,7 +272,7 @@ static void stm_disable(struct coresight_device *csdev,
 
 		pm_runtime_put(csdev->dev.parent);
 
-		local_set(&csdev->mode, CS_MODE_DISABLED);
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 		dev_dbg(&csdev->dev, "STM tracing disabled\n");
 	}
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 77ef67c976e9..d4f641cd9de6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -228,7 +228,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 
 	ret = tmc_etb_enable_hw(drvdata);
 	if (!ret) {
-		local_set(&csdev->mode, CS_MODE_SYSFS);
+		coresight_set_mode(csdev, CS_MODE_SYSFS);
 		csdev->refcnt++;
 	} else {
 		/* Free up the buffer if we failed to enable */
@@ -292,7 +292,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		if (!ret) {
 			/* Associate with monitored process. */
 			drvdata->pid = pid;
-			local_set(&csdev->mode, CS_MODE_PERF);
+			coresight_set_mode(csdev, CS_MODE_PERF);
 			csdev->refcnt++;
 		}
 	} while (0);
@@ -349,7 +349,7 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	tmc_etb_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
-	local_set(&csdev->mode, CS_MODE_DISABLED);
+	coresight_set_mode(csdev, CS_MODE_DISABLED);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -375,7 +375,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	if (csdev->refcnt == 0) {
 		ret = tmc_etf_enable_hw(drvdata);
 		if (!ret) {
-			local_set(&csdev->mode, CS_MODE_SYSFS);
+			coresight_set_mode(csdev, CS_MODE_SYSFS);
 			first_enable = true;
 		}
 	}
@@ -405,7 +405,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	csdev->refcnt--;
 	if (csdev->refcnt == 0) {
 		tmc_etf_disable_hw(drvdata);
-		local_set(&csdev->mode, CS_MODE_DISABLED);
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 		last_disable = true;
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 383cb8647589..e75428fa1592 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1237,7 +1237,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
 	if (!ret) {
-		local_set(&csdev->mode, CS_MODE_SYSFS);
+		coresight_set_mode(csdev, CS_MODE_SYSFS);
 		csdev->refcnt++;
 	}
 
@@ -1684,7 +1684,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	if (!rc) {
 		/* Associate with monitored process. */
 		drvdata->pid = pid;
-		local_set(&csdev->mode, CS_MODE_PERF);
+		coresight_set_mode(csdev, CS_MODE_PERF);
 		drvdata->perf_buf = etr_perf->etr_buf;
 		csdev->refcnt++;
 	}
@@ -1730,7 +1730,7 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	tmc_etr_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
-	local_set(&csdev->mode, CS_MODE_DISABLED);
+	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	/* Reset perf specific data */
 	drvdata->perf_buf = NULL;
 
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index ad533aeb6786..1ad6f319a096 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -211,7 +211,7 @@ static void smb_enable_sysfs(struct coresight_device *csdev)
 		return;
 
 	smb_enable_hw(drvdata);
-	local_set(&csdev->mode, CS_MODE_SYSFS);
+	coresight_set_mode(csdev, CS_MODE_SYSFS);
 }
 
 static int smb_enable_perf(struct coresight_device *csdev, void *data)
@@ -234,7 +234,7 @@ static int smb_enable_perf(struct coresight_device *csdev, void *data)
 	if (drvdata->pid == -1) {
 		smb_enable_hw(drvdata);
 		drvdata->pid = pid;
-		local_set(&csdev->mode, CS_MODE_PERF);
+		coresight_set_mode(csdev, CS_MODE_PERF);
 	}
 
 	return 0;
@@ -297,7 +297,7 @@ static int smb_disable(struct coresight_device *csdev)
 
 	/* Dissociate from the target process. */
 	drvdata->pid = -1;
-	local_set(&csdev->mode, CS_MODE_DISABLED);
+	coresight_set_mode(csdev, CS_MODE_DISABLED);
 	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
 
 	return 0;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4a728dd9338a..281b1b2603d8 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -596,6 +596,22 @@ static inline enum cs_mode coresight_get_mode(struct coresight_device *csdev)
 	return local_read(&csdev->mode);
 }
 
+static inline void coresight_set_mode(struct coresight_device *csdev,
+				      enum cs_mode new_mode)
+{
+	enum cs_mode current_mode = coresight_get_mode(csdev);
+
+	/*
+	 * Changing to a new mode must be done from an already disabled state
+	 * unless it's synchronized with coresight_take_mode(). Otherwise the
+	 * device is already in use and signifies a locking issue.
+	 */
+	WARN(new_mode != CS_MODE_DISABLED && current_mode != CS_MODE_DISABLED &&
+	     current_mode != new_mode, "Device already in use\n");
+
+	local_set(&csdev->mode, new_mode);
+}
+
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
-- 
2.34.1


