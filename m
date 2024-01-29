Return-Path: <linux-kernel+bounces-43016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0572840A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46A651F213FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB59154C0C;
	Mon, 29 Jan 2024 15:41:48 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15984155311
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542907; cv=none; b=SddtcpcvqH4UiMI3hUTyVzGxSdLL2Z20aOPArHDTGtjXgHj1wBaiD4N0z3rKcWda2nr9soLct+yj6dWM8SaufnXXdIYl/D+sS7aFinUerZE/2ID0ppHdOYzMLyestyJkH4e/J5HO48LxzBFhwsOr3F0+h3Z5heH/cn62UEqmAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542907; c=relaxed/simple;
	bh=5pkjlY26712AVzOJEoX+BYv78XNb7nai0NoU7c3v6XE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aVpHolzV3Ke9YGZnTbcxPa9WsPp5+2ojkME8I8vtU2tsHoGfEjhNIzVcJF+GEICenfi+JwDk3SiLmCE5N0C7r368pJ4FCPauXxXBAVJ82I4IPEHMSTur/f2dNiea/htkFQGYPneYzmnUKMqNAL/USYTqAEkHRiBu/g32l8ysZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4995DDA7;
	Mon, 29 Jan 2024 07:42:27 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CDCC13F738;
	Mon, 29 Jan 2024 07:41:40 -0800 (PST)
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
Subject: [PATCH v2 04/12] coresight: Move mode to struct coresight_device
Date: Mon, 29 Jan 2024 15:40:35 +0000
Message-Id: <20240129154050.569566-5-james.clark@arm.com>
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

Most devices use mode, so move the mode definition out of the individual
devices and up to the Coresight device. This will allow the core code to
also know the mode which will be useful in a later commit.

This also fixes the inconsistency of the documentation of the mode field
on the individual device types. For example ETB10 had "this ETB is being
used".

Two devices didn't require an atomic mode type, so these usages have
been converted to atomic_get() and atomic_set() only to make it compile,
but the documentation of the field in struct coresight_device explains
this type of usage.

In the future, manipulation of the mode could be completely moved out of
the individual devices and into the core code because it's almost all
duplicate code, and this change is a step towards that.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 18 ++++++-------
 drivers/hwtracing/coresight/coresight-etm.h   |  2 --
 .../coresight/coresight-etm3x-core.c          | 13 +++++-----
 .../coresight/coresight-etm3x-sysfs.c         |  4 +--
 .../coresight/coresight-etm4x-core.c          | 16 +++++-------
 drivers/hwtracing/coresight/coresight-etm4x.h |  1 -
 drivers/hwtracing/coresight/coresight-stm.c   | 20 +++++++-------
 .../hwtracing/coresight/coresight-tmc-core.c  |  2 +-
 .../hwtracing/coresight/coresight-tmc-etf.c   | 26 +++++++++----------
 .../hwtracing/coresight/coresight-tmc-etr.c   | 20 +++++++-------
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 --
 drivers/hwtracing/coresight/ultrasoc-smb.c    | 13 +++++-----
 drivers/hwtracing/coresight/ultrasoc-smb.h    |  2 --
 include/linux/coresight.h                     |  6 +++++
 14 files changed, 69 insertions(+), 76 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index fa80039e0821..08e5bba862db 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -76,7 +76,6 @@ DEFINE_CORESIGHT_DEVLIST(etb_devs, "etb");
  * @pid:	Process ID of the process being monitored by the session
  *		that is using this component.
  * @buf:	area of memory where ETB buffer content gets sent.
- * @mode:	this ETB is being used.
  * @buffer_depth: size of @buf.
  * @trigger_cntr: amount of words to store after a trigger.
  */
@@ -89,7 +88,6 @@ struct etb_drvdata {
 	local_t			reading;
 	pid_t			pid;
 	u8			*buf;
-	u32			mode;
 	u32			buffer_depth;
 	u32			trigger_cntr;
 };
@@ -150,17 +148,17 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't messup with perf sessions. */
-	if (drvdata->mode == CS_MODE_PERF) {
+	if (local_read(&csdev->mode) == CS_MODE_PERF) {
 		ret = -EBUSY;
 		goto out;
 	}
 
-	if (drvdata->mode == CS_MODE_DISABLED) {
+	if (local_read(&csdev->mode) == CS_MODE_DISABLED) {
 		ret = etb_enable_hw(drvdata);
 		if (ret)
 			goto out;
 
-		drvdata->mode = CS_MODE_SYSFS;
+		local_set(&csdev->mode, CS_MODE_SYSFS);
 	}
 
 	atomic_inc(&csdev->refcnt);
@@ -181,7 +179,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* No need to continue if the component is already in used by sysFS. */
-	if (drvdata->mode == CS_MODE_SYSFS) {
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -216,7 +214,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	if (!ret) {
 		/* Associate with monitored process. */
 		drvdata->pid = pid;
-		drvdata->mode = CS_MODE_PERF;
+		local_set(&drvdata->csdev->mode, CS_MODE_PERF);
 		atomic_inc(&csdev->refcnt);
 	}
 
@@ -362,11 +360,11 @@ static int etb_disable(struct coresight_device *csdev)
 	}
 
 	/* Complain if we (somehow) got out of sync */
-	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	WARN_ON_ONCE(local_read(&csdev->mode) == CS_MODE_DISABLED);
 	etb_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
-	drvdata->mode = CS_MODE_DISABLED;
+	local_set(&csdev->mode, CS_MODE_DISABLED);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&csdev->dev, "ETB disabled\n");
@@ -589,7 +587,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	unsigned long flags;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (drvdata->mode == CS_MODE_SYSFS) {
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
 		__etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
 		__etb_enable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 9a0d08b092ae..e02c3ea972c9 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -215,7 +215,6 @@ struct etm_config {
  * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
  * @arch:	ETM/PTM version number.
  * @use_cpu14:	true if management registers need to be accessed via CP14.
- * @mode:	this tracer's mode, i.e sysFS, Perf or disabled.
  * @sticky_enable: true if ETM base configuration has been done.
  * @boot_enable:true if we should start tracing at boot time.
  * @os_unlock:	true if access to management registers is allowed.
@@ -238,7 +237,6 @@ struct etm_drvdata {
 	int				port_size;
 	u8				arch;
 	bool				use_cp14;
-	local_t				mode;
 	bool				sticky_enable;
 	bool				boot_enable;
 	bool				os_unlock;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 116a91d90ac2..29f62dfac673 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -559,7 +559,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 	u32 val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	val = local_cmpxchg(&drvdata->csdev->mode, CS_MODE_DISABLED, mode);
 
 	/* Someone is already using the tracer */
 	if (val)
@@ -578,7 +578,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 
 	/* The tracer didn't start */
 	if (ret)
-		local_set(&drvdata->mode, CS_MODE_DISABLED);
+		local_set(&drvdata->csdev->mode, CS_MODE_DISABLED);
 
 	return ret;
 }
@@ -672,14 +672,13 @@ static void etm_disable(struct coresight_device *csdev,
 			struct perf_event *event)
 {
 	enum cs_mode mode;
-	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	/*
 	 * For as long as the tracer isn't disabled another entity can't
 	 * change its status.  As such we can read the status here without
 	 * fearing it will change under us.
 	 */
-	mode = local_read(&drvdata->mode);
+	mode = local_read(&csdev->mode);
 
 	switch (mode) {
 	case CS_MODE_DISABLED:
@@ -696,7 +695,7 @@ static void etm_disable(struct coresight_device *csdev,
 	}
 
 	if (mode)
-		local_set(&drvdata->mode, CS_MODE_DISABLED);
+		local_set(&csdev->mode, CS_MODE_DISABLED);
 }
 
 static const struct coresight_ops_source etm_source_ops = {
@@ -730,7 +729,7 @@ static int etm_starting_cpu(unsigned int cpu)
 		etmdrvdata[cpu]->os_unlock = true;
 	}
 
-	if (local_read(&etmdrvdata[cpu]->mode))
+	if (local_read(&etmdrvdata[cpu]->csdev->mode))
 		etm_enable_hw(etmdrvdata[cpu]);
 	spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
@@ -742,7 +741,7 @@ static int etm_dying_cpu(unsigned int cpu)
 		return 0;
 
 	spin_lock(&etmdrvdata[cpu]->spinlock);
-	if (local_read(&etmdrvdata[cpu]->mode))
+	if (local_read(&etmdrvdata[cpu]->csdev->mode))
 		etm_disable_hw(etmdrvdata[cpu]);
 	spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 2f271b7fb048..6c8429c980b1 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -722,7 +722,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	if (!local_read(&drvdata->mode)) {
+	if (!local_read(&drvdata->csdev->mode)) {
 		spin_lock(&drvdata->spinlock);
 		for (i = 0; i < drvdata->nr_cntr; i++)
 			ret += sprintf(buf, "counter %d: %x\n",
@@ -941,7 +941,7 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	if (!local_read(&drvdata->mode)) {
+	if (!local_read(&drvdata->csdev->mode)) {
 		val = config->seq_curr_state;
 		goto out;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index ce1995a2827f..ebf55b1f67d7 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -841,9 +841,8 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
 {
 	int ret;
 	u32 val;
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	val = local_cmpxchg(&csdev->mode, CS_MODE_DISABLED, mode);
 
 	/* Someone is already using the tracer */
 	if (val)
@@ -862,7 +861,7 @@ static int etm4_enable(struct coresight_device *csdev, struct perf_event *event,
 
 	/* The tracer didn't start */
 	if (ret)
-		local_set(&drvdata->mode, CS_MODE_DISABLED);
+		local_set(&csdev->mode, CS_MODE_DISABLED);
 
 	return ret;
 }
@@ -1004,14 +1003,13 @@ static void etm4_disable(struct coresight_device *csdev,
 			 struct perf_event *event)
 {
 	enum cs_mode mode;
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
 	/*
 	 * For as long as the tracer isn't disabled another entity can't
 	 * change its status.  As such we can read the status here without
 	 * fearing it will change under us.
 	 */
-	mode = local_read(&drvdata->mode);
+	mode = local_read(&csdev->mode);
 
 	switch (mode) {
 	case CS_MODE_DISABLED:
@@ -1025,7 +1023,7 @@ static void etm4_disable(struct coresight_device *csdev,
 	}
 
 	if (mode)
-		local_set(&drvdata->mode, CS_MODE_DISABLED);
+		local_set(&csdev->mode, CS_MODE_DISABLED);
 }
 
 static const struct coresight_ops_source etm4_source_ops = {
@@ -1663,7 +1661,7 @@ static int etm4_starting_cpu(unsigned int cpu)
 	if (!etmdrvdata[cpu]->os_unlock)
 		etm4_os_unlock(etmdrvdata[cpu]);
 
-	if (local_read(&etmdrvdata[cpu]->mode))
+	if (local_read(&etmdrvdata[cpu]->csdev->mode))
 		etm4_enable_hw(etmdrvdata[cpu]);
 	spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
@@ -1675,7 +1673,7 @@ static int etm4_dying_cpu(unsigned int cpu)
 		return 0;
 
 	spin_lock(&etmdrvdata[cpu]->spinlock);
-	if (local_read(&etmdrvdata[cpu]->mode))
+	if (local_read(&etmdrvdata[cpu]->csdev->mode))
 		etm4_disable_hw(etmdrvdata[cpu]);
 	spin_unlock(&etmdrvdata[cpu]->spinlock);
 	return 0;
@@ -1833,7 +1831,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	 * Save and restore the ETM Trace registers only if
 	 * the ETM is active.
 	 */
-	if (local_read(&drvdata->mode) && drvdata->save_state)
+	if (local_read(&drvdata->csdev->mode) && drvdata->save_state)
 		ret = __etm4_cpu_save(drvdata);
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index da17b6c49b0f..9ea678bc2e8e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1016,7 +1016,6 @@ struct etmv4_drvdata {
 	void __iomem			*base;
 	struct coresight_device		*csdev;
 	spinlock_t			spinlock;
-	local_t				mode;
 	int				cpu;
 	u8				arch;
 	u8				nr_pe;
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index a1c27c901ad1..190ba569b05a 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -119,7 +119,6 @@ DEFINE_CORESIGHT_DEVLIST(stm_devs, "stm");
  * @spinlock:		only one at a time pls.
  * @chs:		the channels accociated to this STM.
  * @stm:		structure associated to the generic STM interface.
- * @mode:		this tracer's mode (enum cs_mode), i.e sysFS, or disabled.
  * @traceid:		value of the current ID for this component.
  * @write_bytes:	Maximus bytes this STM can write at a time.
  * @stmsper:		settings for register STMSPER.
@@ -136,7 +135,6 @@ struct stm_drvdata {
 	spinlock_t		spinlock;
 	struct channel_space	chs;
 	struct stm_data		stm;
-	local_t			mode;
 	u8			traceid;
 	u32			write_bytes;
 	u32			stmsper;
@@ -201,7 +199,7 @@ static int stm_enable(struct coresight_device *csdev, struct perf_event *event,
 	if (mode != CS_MODE_SYSFS)
 		return -EINVAL;
 
-	val = local_cmpxchg(&drvdata->mode, CS_MODE_DISABLED, mode);
+	val = local_cmpxchg(&csdev->mode, CS_MODE_DISABLED, mode);
 
 	/* Someone is already using the tracer */
 	if (val)
@@ -266,7 +264,7 @@ static void stm_disable(struct coresight_device *csdev,
 	 * change its status.  As such we can read the status here without
 	 * fearing it will change under us.
 	 */
-	if (local_read(&drvdata->mode) == CS_MODE_SYSFS) {
+	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
 		spin_lock(&drvdata->spinlock);
 		stm_disable_hw(drvdata);
 		spin_unlock(&drvdata->spinlock);
@@ -276,7 +274,7 @@ static void stm_disable(struct coresight_device *csdev,
 
 		pm_runtime_put(csdev->dev.parent);
 
-		local_set(&drvdata->mode, CS_MODE_DISABLED);
+		local_set(&csdev->mode, CS_MODE_DISABLED);
 		dev_dbg(&csdev->dev, "STM tracing disabled\n");
 	}
 }
@@ -373,7 +371,7 @@ static long stm_generic_set_options(struct stm_data *stm_data,
 {
 	struct stm_drvdata *drvdata = container_of(stm_data,
 						   struct stm_drvdata, stm);
-	if (!(drvdata && local_read(&drvdata->mode)))
+	if (!(drvdata && local_read(&drvdata->csdev->mode)))
 		return -EINVAL;
 
 	if (channel >= drvdata->numsp)
@@ -408,7 +406,7 @@ static ssize_t notrace stm_generic_packet(struct stm_data *stm_data,
 						   struct stm_drvdata, stm);
 	unsigned int stm_flags;
 
-	if (!(drvdata && local_read(&drvdata->mode)))
+	if (!(drvdata && local_read(&drvdata->csdev->mode)))
 		return -EACCES;
 
 	if (channel >= drvdata->numsp)
@@ -515,7 +513,7 @@ static ssize_t port_select_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val;
 
-	if (!local_read(&drvdata->mode)) {
+	if (!local_read(&drvdata->csdev->mode)) {
 		val = drvdata->stmspscr;
 	} else {
 		spin_lock(&drvdata->spinlock);
@@ -541,7 +539,7 @@ static ssize_t port_select_store(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	drvdata->stmspscr = val;
 
-	if (local_read(&drvdata->mode)) {
+	if (local_read(&drvdata->csdev->mode)) {
 		CS_UNLOCK(drvdata->base);
 		/* Process as per ARM's TRM recommendation */
 		stmsper = readl_relaxed(drvdata->base + STMSPER);
@@ -562,7 +560,7 @@ static ssize_t port_enable_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val;
 
-	if (!local_read(&drvdata->mode)) {
+	if (!local_read(&drvdata->csdev->mode)) {
 		val = drvdata->stmsper;
 	} else {
 		spin_lock(&drvdata->spinlock);
@@ -588,7 +586,7 @@ static ssize_t port_enable_store(struct device *dev,
 	spin_lock(&drvdata->spinlock);
 	drvdata->stmsper = val;
 
-	if (local_read(&drvdata->mode)) {
+	if (local_read(&drvdata->csdev->mode)) {
 		CS_UNLOCK(drvdata->base);
 		writel_relaxed(drvdata->stmsper, drvdata->base + STMSPER);
 		CS_LOCK(drvdata->base);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 7ec5365e2b64..e5d47f61f9f3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -558,7 +558,7 @@ static void tmc_shutdown(struct amba_device *adev)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	if (drvdata->mode == CS_MODE_DISABLED)
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_DISABLED)
 		goto out;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 7406b65e2cdd..2a7e516052a2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -89,7 +89,7 @@ static void __tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
 	 */
-	if (drvdata->mode == CS_MODE_SYSFS)
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS)
 		tmc_etb_dump_hw(drvdata);
 	tmc_disable_hw(drvdata);
 
@@ -205,7 +205,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	 * sink is already enabled no memory is needed and the HW need not be
 	 * touched.
 	 */
-	if (drvdata->mode == CS_MODE_SYSFS) {
+	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
 		atomic_inc(&csdev->refcnt);
 		goto out;
 	}
@@ -228,7 +228,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 
 	ret = tmc_etb_enable_hw(drvdata);
 	if (!ret) {
-		drvdata->mode = CS_MODE_SYSFS;
+		local_set(&csdev->mode, CS_MODE_SYSFS);
 		atomic_inc(&csdev->refcnt);
 	} else {
 		/* Free up the buffer if we failed to enable */
@@ -262,7 +262,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		 * No need to continue if the ETB/ETF is already operated
 		 * from sysFS.
 		 */
-		if (drvdata->mode == CS_MODE_SYSFS) {
+		if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
 			ret = -EBUSY;
 			break;
 		}
@@ -292,7 +292,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		if (!ret) {
 			/* Associate with monitored process. */
 			drvdata->pid = pid;
-			drvdata->mode = CS_MODE_PERF;
+			local_set(&csdev->mode, CS_MODE_PERF);
 			atomic_inc(&csdev->refcnt);
 		}
 	} while (0);
@@ -344,11 +344,11 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	}
 
 	/* Complain if we (somehow) got out of sync */
-	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	WARN_ON_ONCE(local_read(&csdev->mode) == CS_MODE_DISABLED);
 	tmc_etb_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
-	drvdata->mode = CS_MODE_DISABLED;
+	local_set(&csdev->mode, CS_MODE_DISABLED);
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
@@ -374,7 +374,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	if (atomic_read(&csdev->refcnt) == 0) {
 		ret = tmc_etf_enable_hw(drvdata);
 		if (!ret) {
-			drvdata->mode = CS_MODE_SYSFS;
+			local_set(&csdev->mode, CS_MODE_SYSFS);
 			first_enable = true;
 		}
 	}
@@ -403,7 +403,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 
 	if (atomic_dec_return(&csdev->refcnt) == 0) {
 		tmc_etf_disable_hw(drvdata);
-		drvdata->mode = CS_MODE_DISABLED;
+		local_set(&csdev->mode, CS_MODE_DISABLED);
 		last_disable = true;
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -483,7 +483,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 		return 0;
 
 	/* This shouldn't happen */
-	if (WARN_ON_ONCE(drvdata->mode != CS_MODE_PERF))
+	if (WARN_ON_ONCE(local_read(&csdev->mode) != CS_MODE_PERF))
 		return 0;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
@@ -629,7 +629,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Don't interfere if operated from Perf */
-	if (drvdata->mode == CS_MODE_PERF) {
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_PERF) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -641,7 +641,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if need be */
-	if (drvdata->mode == CS_MODE_SYSFS) {
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
 		/* There is no point in reading a TMC in HW FIFO mode */
 		mode = readl_relaxed(drvdata->base + TMC_MODE);
 		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
@@ -673,7 +673,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Re-enable the TMC if need be */
-	if (drvdata->mode == CS_MODE_SYSFS) {
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
 		/* There is no point in reading a TMC in HW FIFO mode */
 		mode = readl_relaxed(drvdata->base + TMC_MODE);
 		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index af02ba5d5f15..3dc989d4fcab 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1143,7 +1143,7 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 	 * When operating in sysFS mode the content of the buffer needs to be
 	 * read before the TMC is disabled.
 	 */
-	if (drvdata->mode == CS_MODE_SYSFS)
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS)
 		tmc_etr_sync_sysfs_buf(drvdata);
 
 	tmc_disable_hw(drvdata);
@@ -1189,7 +1189,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 		spin_lock_irqsave(&drvdata->spinlock, flags);
 	}
 
-	if (drvdata->reading || drvdata->mode == CS_MODE_PERF) {
+	if (drvdata->reading || local_read(&csdev->mode) == CS_MODE_PERF) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1230,14 +1230,14 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	 * sink is already enabled no memory is needed and the HW need not be
 	 * touched, even if the buffer size has changed.
 	 */
-	if (drvdata->mode == CS_MODE_SYSFS) {
+	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
 		atomic_inc(&csdev->refcnt);
 		goto out;
 	}
 
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
 	if (!ret) {
-		drvdata->mode = CS_MODE_SYSFS;
+		local_set(&csdev->mode, CS_MODE_SYSFS);
 		atomic_inc(&csdev->refcnt);
 	}
 
@@ -1652,7 +1652,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	 /* Don't use this sink if it is already claimed by sysFS */
-	if (drvdata->mode == CS_MODE_SYSFS) {
+	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
 		rc = -EBUSY;
 		goto unlock_out;
 	}
@@ -1684,7 +1684,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	if (!rc) {
 		/* Associate with monitored process. */
 		drvdata->pid = pid;
-		drvdata->mode = CS_MODE_PERF;
+		local_set(&csdev->mode, CS_MODE_PERF);
 		drvdata->perf_buf = etr_perf->etr_buf;
 		atomic_inc(&csdev->refcnt);
 	}
@@ -1725,11 +1725,11 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	}
 
 	/* Complain if we (somehow) got out of sync */
-	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	WARN_ON_ONCE(local_read(&csdev->mode) == CS_MODE_DISABLED);
 	tmc_etr_disable_hw(drvdata);
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
-	drvdata->mode = CS_MODE_DISABLED;
+	local_set(&csdev->mode, CS_MODE_DISABLED);
 	/* Reset perf specific data */
 	drvdata->perf_buf = NULL;
 
@@ -1777,7 +1777,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	}
 
 	/* Disable the TMC if we are trying to read from a running session. */
-	if (drvdata->mode == CS_MODE_SYSFS)
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS)
 		__tmc_etr_disable_hw(drvdata);
 
 	drvdata->reading = true;
@@ -1799,7 +1799,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* RE-enable the TMC if need be */
-	if (drvdata->mode == CS_MODE_SYSFS) {
+	if (local_read(&drvdata->csdev->mode) == CS_MODE_SYSFS) {
 		/*
 		 * The trace run will continue with the same allocated trace
 		 * buffer. Since the tracer is still enabled drvdata::buf can't
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 8dcb426ac3e7..cef979c897e6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -178,7 +178,6 @@ struct etr_buf {
  * @size:	trace buffer size for this TMC (common for all modes).
  * @max_burst_size: The maximum burst size that can be initiated by
  *		TMC-ETR on AXI bus.
- * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
  * @memwidth:	width of the memory interface databus, in bytes.
  * @trigger_cntr: amount of words to store after a trigger.
@@ -203,7 +202,6 @@ struct tmc_drvdata {
 	u32			len;
 	u32			size;
 	u32			max_burst_size;
-	u32			mode;
 	enum tmc_config_type	config_type;
 	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 10e886455b8b..1a8c64645b92 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -207,11 +207,11 @@ static void smb_enable_sysfs(struct coresight_device *csdev)
 {
 	struct smb_drv_data *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	if (drvdata->mode != CS_MODE_DISABLED)
+	if (local_read(&csdev->mode) != CS_MODE_DISABLED)
 		return;
 
 	smb_enable_hw(drvdata);
-	drvdata->mode = CS_MODE_SYSFS;
+	local_set(&csdev->mode, CS_MODE_SYSFS);
 }
 
 static int smb_enable_perf(struct coresight_device *csdev, void *data)
@@ -234,7 +234,7 @@ static int smb_enable_perf(struct coresight_device *csdev, void *data)
 	if (drvdata->pid == -1) {
 		smb_enable_hw(drvdata);
 		drvdata->pid = pid;
-		drvdata->mode = CS_MODE_PERF;
+		local_set(&csdev->mode, CS_MODE_PERF);
 	}
 
 	return 0;
@@ -253,7 +253,8 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 		return -EBUSY;
 
 	/* Do nothing, the SMB is already enabled as other mode */
-	if (drvdata->mode != CS_MODE_DISABLED && drvdata->mode != mode)
+	if (local_read(&csdev->mode) != CS_MODE_DISABLED &&
+	    local_read(&csdev->mode) != mode)
 		return -EBUSY;
 
 	switch (mode) {
@@ -289,13 +290,13 @@ static int smb_disable(struct coresight_device *csdev)
 		return -EBUSY;
 
 	/* Complain if we (somehow) got out of sync */
-	WARN_ON_ONCE(drvdata->mode == CS_MODE_DISABLED);
+	WARN_ON_ONCE(local_read(&csdev->mode) == CS_MODE_DISABLED);
 
 	smb_disable_hw(drvdata);
 
 	/* Dissociate from the target process. */
 	drvdata->pid = -1;
-	drvdata->mode = CS_MODE_DISABLED;
+	local_set(&csdev->mode, CS_MODE_DISABLED);
 	dev_dbg(&csdev->dev, "Ultrasoc SMB disabled\n");
 
 	return 0;
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.h b/drivers/hwtracing/coresight/ultrasoc-smb.h
index 82a44c14a882..a91d39cfccb8 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.h
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.h
@@ -109,7 +109,6 @@ struct smb_data_buffer {
  * @reading:	Synchronise user space access to SMB buffer.
  * @pid:	Process ID of the process being monitored by the
  *		session that is using this component.
- * @mode:	How this SMB is being used, perf mode or sysfs mode.
  */
 struct smb_drv_data {
 	void __iomem *base;
@@ -119,7 +118,6 @@ struct smb_drv_data {
 	spinlock_t spinlock;
 	bool reading;
 	pid_t pid;
-	enum cs_mode mode;
 };
 
 #endif
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 65131bfbd904..ba817f563ff7 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -226,6 +226,11 @@ struct coresight_sysfs_link {
  *		by @coresight_ops.
  * @access:	Device i/o access abstraction for this device.
  * @dev:	The device entity associated to this component.
+ * @mode:	This tracer's mode, i.e sysFS, Perf or disabled. This is
+ *		actually an 'enum cs_mode', but is stored in an atomic type.
+ *		This is always accessed through local_read() and local_set(),
+ *		but wherever it's done from within the Coresight device's lock,
+ *		a non-atomic read would also work.
  * @refcnt:	keep track of what is in use.
  * @orphan:	true if the component has connections that haven't been linked.
  * @enable:	'true' if component is currently part of an active path.
@@ -252,6 +257,7 @@ struct coresight_device {
 	const struct coresight_ops *ops;
 	struct csdev_access access;
 	struct device dev;
+	local_t	mode;
 	atomic_t refcnt;
 	bool orphan;
 	bool enable;
-- 
2.34.1


