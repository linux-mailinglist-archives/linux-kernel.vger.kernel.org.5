Return-Path: <linux-kernel+bounces-43024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC07840A56
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDBACB21656
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8555E156989;
	Mon, 29 Jan 2024 15:42:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08352155315
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542972; cv=none; b=TgyBJmkRIMvn8VgQsAkl4jWxwfKH2paXhJo/3JaGLnr7Y0/zp1XMNB5P7fdhLbKIK7EwpzpMN5qdwUCcJV9XdSpT5vDo3nUWSnqlJU0e8o+AFeY8BPnOv3cV0roAumUpfZoVgsxZOUNTfVux6Hdqz6TKForyKe13Zlu5yX1wYa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542972; c=relaxed/simple;
	bh=XEpC9RLHz8gMYjNbaubK5t/hFVUAb+O1TG1IOGUDI88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cRVLZavbIeiuuB1CVyPGPPRAwaSWIBBvN64gVUMgOJWj57ERq4arv3R91s0SUvE3Ymuf2PjxgSA3jKWXjIBT4oSwuL9761VaKhBsmLKnbxLQVPA0pbCJSQWO2f3YZNA8gwtIPwn+2pZ4ZOh94FA9OjCBZINGrQhqVt0GCOXqEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53DF6139F;
	Mon, 29 Jan 2024 07:43:33 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CF1843F738;
	Mon, 29 Jan 2024 07:42:46 -0800 (PST)
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
Subject: [PATCH v2 11/12] coresight: Add a helper for getting csdev->mode
Date: Mon, 29 Jan 2024 15:40:42 +0000
Message-Id: <20240129154050.569566-12-james.clark@arm.com>
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

Now that mode is in struct coresight_device accesses can be wrapped.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c    | 10 +++++-----
 .../hwtracing/coresight/coresight-etm3x-core.c   |  6 +++---
 .../hwtracing/coresight/coresight-etm3x-sysfs.c  |  4 ++--
 .../hwtracing/coresight/coresight-etm4x-core.c   |  8 ++++----
 drivers/hwtracing/coresight/coresight-stm.c      | 14 +++++++-------
 drivers/hwtracing/coresight/coresight-sysfs.c    |  8 ++++----
 drivers/hwtracing/coresight/coresight-tmc-core.c |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c  | 16 ++++++++--------
 drivers/hwtracing/coresight/coresight-tmc-etr.c  | 14 +++++++-------
 drivers/hwtracing/coresight/ultrasoc-smb.c       |  8 ++++----
 include/linux/coresight.h                        |  5 +++++
 11 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 5f2bb95955b7..4e82d9c20d36 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -148,12 +148,12 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't messup with perf sessions. */
-	if (local_read(&csdev->mode) == CS_MODE_PERF) {
+	if (coresight_get_mode(csdev) == CS_MODE_PERF) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	if (local_read(&csdev->mode) == CS_MODE_DISABLED) {
+	if (coresight_get_mode(csdev) == CS_MODE_DISABLED) {
 		ret = etb_enable_hw(drvdata);
 		if (ret)
 			goto out;
@@ -179,7 +179,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* No need to continue if the component is already in used by sysFS. */
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -361,7 +361,7 @@ static int etb_disable(struct coresight_device *csdev)
 	}
 
 	/* Complain if we (somehow) got out of sync */
-	WARN_ON_ONCE(local_read(&csdev->mode) == CS_MODE_DISABLED);
+	WARN_ON_ONCE(coresight_get_mode(csdev) == CS_MODE_DISABLED);
 	etb_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
@@ -588,7 +588,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		__etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
 		__etb_enable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index ce2b3ed90fb9..63991029cda0 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -676,7 +676,7 @@ static void etm_disable(struct coresight_device *csdev,
 	 * change its status.  As such we can read the status here without
 	 * fearing it will change under us.
 	 */
-	mode = local_read(&csdev->mode);
+	mode = coresight_get_mode(csdev);
 
 	switch (mode) {
 	case CS_MODE_DISABLED:
@@ -727,7 +727,7 @@ static int etm_starting_cpu(unsigned int cpu)
 		etmdrvdata[cpu]->os_unlock = true;
 	}
 
-	if (local_read(&etmdrvdata[cpu]->csdev->mode))
+	if (coresight_get_mode(etmdrvdata[cpu]->csdev))
 		etm_enable_hw(etmdrvdata[cpu]);
 	spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
@@ -739,7 +739,7 @@ static int etm_dying_cpu(unsigned int cpu)
 		return 0;
 
 	spin_lock(&etmdrvdata[cpu]->spinlock);
-	if (local_read(&etmdrvdata[cpu]->csdev->mode))
+	if (coresight_get_mode(etmdrvdata[cpu]->csdev))
 		etm_disable_hw(etmdrvdata[cpu]);
 	spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 6c8429c980b1..68c644be9813 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -722,7 +722,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	if (!local_read(&drvdata->csdev->mode)) {
+	if (!coresight_get_mode(drvdata->csdev)) {
 		spin_lock(&drvdata->spinlock);
 		for (i = 0; i < drvdata->nr_cntr; i++)
 			ret += sprintf(buf, "counter %d: %x\n",
@@ -941,7 +941,7 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	if (!local_read(&drvdata->csdev->mode)) {
+	if (!coresight_get_mode(drvdata->csdev)) {
 		val = config->seq_curr_state;
 		goto out;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 8fca7fc379e6..08451b3f8eaa 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1007,7 +1007,7 @@ static void etm4_disable(struct coresight_device *csdev,
 	 * change its status.  As such we can read the status here without
 	 * fearing it will change under us.
 	 */
-	mode = local_read(&csdev->mode);
+	mode = coresight_get_mode(csdev);
 
 	switch (mode) {
 	case CS_MODE_DISABLED:
@@ -1659,7 +1659,7 @@ static int etm4_starting_cpu(unsigned int cpu)
 	if (!etmdrvdata[cpu]->os_unlock)
 		etm4_os_unlock(etmdrvdata[cpu]);
 
-	if (local_read(&etmdrvdata[cpu]->csdev->mode))
+	if (coresight_get_mode(etmdrvdata[cpu]->csdev))
 		etm4_enable_hw(etmdrvdata[cpu]);
 	spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
@@ -1671,7 +1671,7 @@ static int etm4_dying_cpu(unsigned int cpu)
 		return 0;
 
 	spin_lock(&etmdrvdata[cpu]->spinlock);
-	if (local_read(&etmdrvdata[cpu]->csdev->mode))
+	if (coresight_get_mode(etmdrvdata[cpu]->csdev))
 		etm4_disable_hw(etmdrvdata[cpu]);
 	spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
@@ -1829,7 +1829,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	 * Save and restore the ETM Trace registers only if
 	 * the ETM is active.
 	 */
-	if (local_read(&drvdata->csdev->mode) && drvdata->save_state)
+	if (coresight_get_mode(drvdata->csdev) && drvdata->save_state)
 		ret = __etm4_cpu_save(drvdata);
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 80fed4c377f1..53a07a536968 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -262,7 +262,7 @@ static void stm_disable(struct coresight_device *csdev,
 	 * change its status.  As such we can read the status here without
 	 * fearing it will change under us.
 	 */
-	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
 		spin_lock(&drvdata->spinlock);
 		stm_disable_hw(drvdata);
 		spin_unlock(&drvdata->spinlock);
@@ -369,7 +369,7 @@ static long stm_generic_set_options(struct stm_data *stm_data,
 {
 	struct stm_drvdata *drvdata = container_of(stm_data,
 						   struct stm_drvdata, stm);
-	if (!(drvdata && local_read(&drvdata->csdev->mode)))
+	if (!(drvdata && coresight_get_mode(drvdata->csdev)))
 		return -EINVAL;
 
 	if (channel >= drvdata->numsp)
@@ -404,7 +404,7 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 						   struct stm_drvdata, stm);
 	unsigned int stm_flags;
 
-	if (!(drvdata && local_read(&drvdata->csdev->mode)))
+	if (!(drvdata && coresight_get_mode(drvdata->csdev)))
 		return -EACCES;
 
 	if (channel >= drvdata->numsp)
@@ -511,7 +511,7 @@ static ssize_t port_select_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val;
 
-	if (!local_read(&drvdata->csdev->mode)) {
+	if (!coresight_get_mode(drvdata->csdev)) {
 		val = drvdata->stmspscr;
 	} else {
 		spin_lock(&drvdata->spinlock);
@@ -537,7 +537,7 @@ static ssize_t port_select_store(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	drvdata->stmspscr = val;
 
-	if (local_read(&drvdata->csdev->mode)) {
+	if (coresight_get_mode(drvdata->csdev)) {
 		CS_UNLOCK(drvdata->base);
 		/* Process as per ARM's TRM recommendation */
 		stmsper = readl_relaxed(drvdata->base + STMSPER);
@@ -558,7 +558,7 @@ static ssize_t port_enable_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val;
 
-	if (!local_read(&drvdata->csdev->mode)) {
+	if (!coresight_get_mode(drvdata->csdev)) {
 		val = drvdata->stmsper;
 	} else {
 		spin_lock(&drvdata->spinlock);
@@ -584,7 +584,7 @@ static ssize_t port_enable_store(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	drvdata->stmsper = val;
 
-	if (local_read(&drvdata->csdev->mode)) {
+	if (coresight_get_mode(drvdata->csdev)) {
 		CS_UNLOCK(drvdata->base);
 		writel_relaxed(drvdata->stmsper, drvdata->base + STMSPER);
 		CS_LOCK(drvdata->base);
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index fa52297c73d2..f9444e2cb1d9 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -62,7 +62,7 @@ static int coresight_enable_source_sysfs(struct coresight_device *csdev,
 	 * change with coresight_mutex held, which we already have here.
 	 */
 	lockdep_assert_held(&coresight_mutex);
-	if (local_read(&csdev->mode) != CS_MODE_SYSFS) {
+	if (coresight_get_mode(csdev) != CS_MODE_SYSFS) {
 		ret = source_ops(csdev)->enable(csdev, data, mode);
 		if (ret)
 			return ret;
@@ -87,7 +87,7 @@ static bool coresight_disable_source_sysfs(struct coresight_device *csdev,
 					   void *data)
 {
 	lockdep_assert_held(&coresight_mutex);
-	if (local_read(&csdev->mode) != CS_MODE_SYSFS)
+	if (coresight_get_mode(csdev) != CS_MODE_SYSFS)
 		return false;
 
 	csdev->refcnt--;
@@ -184,7 +184,7 @@ int coresight_enable_sysfs(struct coresight_device *csdev)
 	 * coresight_enable_source() so can still race with Perf mode which
 	 * doesn't hold coresight_mutex.
 	 */
-	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
 		/*
 		 * There could be multiple applications driving the software
 		 * source. So keep the refcount for each such user when the
@@ -338,7 +338,7 @@ static ssize_t enable_source_show(struct device *dev,
 
 	guard(mutex)(&coresight_mutex);
 	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 local_read(&csdev->mode) == CS_MODE_SYSFS);
+			 coresight_get_mode(csdev) == CS_MODE_SYSFS);
 }
 
 static ssize_t enable_source_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index e5d47f61f9f3..9c076cfa740c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -558,7 +558,7 @@ static void tmc_shutdown(struct amba_device *adev)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_DISABLED)
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_DISABLED)
 		goto out;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index f3281c958a57..77ef67c976e9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -89,7 +89,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
 	 */
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS)
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		tmc_etb_dump_hw(drvdata);
 	tmc_disable_hw(drvdata);
 
@@ -205,7 +205,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	 * sink is already enabled no memory is needed and the HW need not be
 	 * touched.
 	 */
-	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
 		csdev->refcnt++;
 		goto out;
 	}
@@ -262,7 +262,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		 * No need to continue if the ETB/ETF is already operated
 		 * from sysFS.
 		 */
-		if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
+		if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
 			ret = -EBUSY;
 			break;
 		}
@@ -345,7 +345,7 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	}
 
 	/* Complain if we (somehow) got out of sync */
-	WARN_ON_ONCE(local_read(&csdev->mode) == CS_MODE_DISABLED);
+	WARN_ON_ONCE(coresight_get_mode(csdev) == CS_MODE_DISABLED);
 	tmc_etb_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
@@ -485,7 +485,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 		return 0;
 
 	/* This shouldn't happen */
-	if (WARN_ON_ONCE(local_read(&csdev->mode) != CS_MODE_PERF))
+	if (WARN_ON_ONCE(coresight_get_mode(csdev) != CS_MODE_PERF))
 		return 0;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
@@ -631,7 +631,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Don't interfere if operated from Perf */
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_PERF) {
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_PERF) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -643,7 +643,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		/* There is no point in reading a TMC in HW FIFO mode */
 		mode = readl_relaxed(drvdata->base + TMC_MODE);
 		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
@@ -675,7 +675,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Re-enable the TMC if need be */
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		/* There is no point in reading a TMC in HW FIFO mode */
 		mode = readl_relaxed(drvdata->base + TMC_MODE);
 		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 88a0fc375b4d..383cb8647589 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1143,7 +1143,7 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
 	 */
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS)
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		tmc_etr_sync_sysfs_buf(drvdata);
 
 	tmc_disable_hw(drvdata);
@@ -1189,7 +1189,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 		spin_lock_irqsave(&drvdata->spinlock, flags);
 	}
 
-	if (drvdata->reading || local_read(&csdev->mode) == CS_MODE_PERF) {
+	if (drvdata->reading || coresight_get_mode(csdev) == CS_MODE_PERF) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1230,7 +1230,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	 * sink is already enabled no memory is needed and the HW need not be
 	 * touched, even if the buffer size has changed.
 	 */
-	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
 		csdev->refcnt++;
 		goto out;
 	}
@@ -1652,7 +1652,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	 /* Don't use this sink if it is already claimed by sysFS */
-	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
 		rc = -EBUSY;
 		goto unlock_out;
 	}
@@ -1726,7 +1726,7 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	}
 
 	/* Complain if we (somehow) got out of sync */
-	WARN_ON_ONCE(local_read(&csdev->mode) == CS_MODE_DISABLED);
+	WARN_ON_ONCE(coresight_get_mode(csdev) == CS_MODE_DISABLED);
 	tmc_etr_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
@@ -1778,7 +1778,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if we are trying to read from a running session. */
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS)
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		__tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
@@ -1800,7 +1800,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* RE-enable the TMC if need be */
-	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
 		 * buffer. Since the tracer is still enabled drvdata::buf can't
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 1146584a1745..ad533aeb6786 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -207,7 +207,7 @@ static void smb_enable_sysfs(struct coresight_device *csdev)
 {
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	if (local_read(&csdev->mode) != CS_MODE_DISABLED)
+	if (coresight_get_mode(csdev) != CS_MODE_DISABLED)
 		return;
 
 	smb_enable_hw(drvdata);
@@ -253,8 +253,8 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 		return -EBUSY;
 
 	/* Do nothing, the SMB is already enabled as other mode */
-	if (local_read(&csdev->mode) != CS_MODE_DISABLED &&
-	    local_read(&csdev->mode) != mode)
+	if (coresight_get_mode(csdev) != CS_MODE_DISABLED &&
+	    coresight_get_mode(csdev) != mode)
 		return -EBUSY;
 
 	switch (mode) {
@@ -291,7 +291,7 @@ static int smb_disable(struct coresight_device *csdev)
 		return -EBUSY;
 
 	/* Complain if we (somehow) got out of sync */
-	WARN_ON_ONCE(local_read(&csdev->mode) == CS_MODE_DISABLED);
+	WARN_ON_ONCE(coresight_get_mode(csdev) == CS_MODE_DISABLED);
 
 	smb_disable_hw(drvdata);
 
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 175d184b3a1b..4a728dd9338a 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -591,6 +591,11 @@ static inline bool coresight_take_mode(struct coresight_device *csdev,
 	       CS_MODE_DISABLED;
 }
 
+static inline enum cs_mode coresight_get_mode(struct coresight_device *csdev)
+{
+	return local_read(&csdev->mode);
+}
+
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
-- 
2.34.1


