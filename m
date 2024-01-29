Return-Path: <linux-kernel+bounces-43019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D1C840A4F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E164D28A8F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF92155A3E;
	Mon, 29 Jan 2024 15:42:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F7F155A26
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542934; cv=none; b=fybKsh3iy7C99eS2ILLysThNF5id3cbyXTFFmaUtQHHN+pTEnBfYAwzk/Q6ZCoXrDrvUJ4lHad22y21BoLWPmMo9jDjXmaOkPFtgby/w+DORGx2QkYAkBBXPo6hL9Ngrb856/he0N+pByFk6CTZXoCMyKKL0ly2bzKmewJSReSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542934; c=relaxed/simple;
	bh=5JdVOj7/kKFNurszO5pO871l5aFZwDGkMpnJ/wSOv7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b8Vma54wnP8euuWYEh8Z9ptj6YKzM95PNbm6NCX2pqs/cgsb9SjrRB4xAep2W1d+E0eyLLUVjhNOaQw5PpeNLuO5fuG2PvkQbFy9xoxZ92FcMrlBuN5WL1zoFobq3XOFPSnA8JhaPyv7OCZ2aGAo+z63B5FSgWwYFIdcRITiuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 874D7DA7;
	Mon, 29 Jan 2024 07:42:55 -0800 (PST)
Received: from e127643.lan (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 594443F738;
	Mon, 29 Jan 2024 07:42:09 -0800 (PST)
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
Subject: [PATCH v2 07/12] coresight: Remove atomic type from refcnt
Date: Mon, 29 Jan 2024 15:40:38 +0000
Message-Id: <20240129154050.569566-8-james.clark@arm.com>
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

Refcnt is only ever accessed from either inside the coresight_mutex, or
the device's spinlock, making the atomic type and atomic_dec_return()
calls confusing and unnecessary. The only point of synchronisation
outside of these two types of locks is already done with a compare and
swap on 'mode', which a comment has been added for.

There was one instance of refcnt being used outside of a lock in TPIU,
but that can easily be fixed by making it the same as all the other
devices and adding a spinlock. Potentially in the future all the
refcounting and locking can be moved up into the core code, and all the
mostly duplicate code from the individual devices can be removed.

Signed-off-by: James Clark <james.clark@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 11 +++++-----
 drivers/hwtracing/coresight/coresight-sysfs.c |  7 ++++---
 .../hwtracing/coresight/coresight-tmc-etf.c   | 20 ++++++++++---------
 .../hwtracing/coresight/coresight-tmc-etr.c   | 13 ++++++------
 drivers/hwtracing/coresight/coresight-tpda.c  |  7 ++++---
 drivers/hwtracing/coresight/coresight-tpiu.c  | 14 +++++++++++--
 drivers/hwtracing/coresight/ultrasoc-smb.c    |  9 +++++----
 include/linux/coresight.h                     | 13 +++++++++---
 8 files changed, 59 insertions(+), 35 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 08e5bba862db..5f2bb95955b7 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -161,7 +161,7 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 		local_set(&csdev->mode, CS_MODE_SYSFS);
 	}
 
-	atomic_inc(&csdev->refcnt);
+	csdev->refcnt++;
 out:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return ret;
@@ -197,7 +197,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	 * use for this session.
 	 */
 	if (drvdata->pid == pid) {
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 		goto out;
 	}
 
@@ -215,7 +215,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 		/* Associate with monitored process. */
 		drvdata->pid = pid;
 		local_set(&drvdata->csdev->mode, CS_MODE_PERF);
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 	}
 
 out:
@@ -354,7 +354,8 @@ static int etb_disable(struct coresight_device *csdev)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	if (atomic_dec_return(&csdev->refcnt)) {
+	csdev->refcnt--;
+	if (csdev->refcnt) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
@@ -445,7 +446,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
-	if (atomic_read(&csdev->refcnt) != 1)
+	if (csdev->refcnt != 1)
 		goto out;
 
 	__etb_disable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index 92cdf8139f23..5992f2c2200a 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -68,7 +68,7 @@ static int coresight_enable_source_sysfs(struct coresight_device *csdev,
 			return ret;
 	}
 
-	atomic_inc(&csdev->refcnt);
+	csdev->refcnt++;
 
 	return 0;
 }
@@ -90,7 +90,8 @@ static bool coresight_disable_source_sysfs(struct coresight_device *csdev,
 	if (local_read(&csdev->mode) != CS_MODE_SYSFS)
 		return false;
 
-	if (atomic_dec_return(&csdev->refcnt) == 0) {
+	csdev->refcnt--;
+	if (csdev->refcnt == 0) {
 		coresight_disable_source(csdev, data);
 		return true;
 	}
@@ -190,7 +191,7 @@ int coresight_enable_sysfs(struct coresight_device *csdev)
 		 * source is already enabled.
 		 */
 		if (subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE)
-			atomic_inc(&csdev->refcnt);
+			csdev->refcnt++;
 		goto out;
 	}
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 2a7e516052a2..f3281c958a57 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -206,7 +206,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	 * touched.
 	 */
 	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 		goto out;
 	}
 
@@ -229,7 +229,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	ret = tmc_etb_enable_hw(drvdata);
 	if (!ret) {
 		local_set(&csdev->mode, CS_MODE_SYSFS);
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 	} else {
 		/* Free up the buffer if we failed to enable */
 		used = false;
@@ -284,7 +284,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 		 * use for this session.
 		 */
 		if (drvdata->pid == pid) {
-			atomic_inc(&csdev->refcnt);
+			csdev->refcnt++;
 			break;
 		}
 
@@ -293,7 +293,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 			/* Associate with monitored process. */
 			drvdata->pid = pid;
 			local_set(&csdev->mode, CS_MODE_PERF);
-			atomic_inc(&csdev->refcnt);
+			csdev->refcnt++;
 		}
 	} while (0);
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
@@ -338,7 +338,8 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	if (atomic_dec_return(&csdev->refcnt)) {
+	csdev->refcnt--;
+	if (csdev->refcnt) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
@@ -371,7 +372,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		return -EBUSY;
 	}
 
-	if (atomic_read(&csdev->refcnt) == 0) {
+	if (csdev->refcnt == 0) {
 		ret = tmc_etf_enable_hw(drvdata);
 		if (!ret) {
 			local_set(&csdev->mode, CS_MODE_SYSFS);
@@ -379,7 +380,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 		}
 	}
 	if (!ret)
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
@@ -401,7 +402,8 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 		return;
 	}
 
-	if (atomic_dec_return(&csdev->refcnt) == 0) {
+	csdev->refcnt--;
+	if (csdev->refcnt == 0) {
 		tmc_etf_disable_hw(drvdata);
 		local_set(&csdev->mode, CS_MODE_DISABLED);
 		last_disable = true;
@@ -489,7 +491,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
-	if (atomic_read(&csdev->refcnt) != 1)
+	if (csdev->refcnt != 1)
 		goto out;
 
 	CS_UNLOCK(drvdata->base);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 3dc989d4fcab..88a0fc375b4d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1231,14 +1231,14 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	 * touched, even if the buffer size has changed.
 	 */
 	if (local_read(&csdev->mode) == CS_MODE_SYSFS) {
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 		goto out;
 	}
 
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
 	if (!ret) {
 		local_set(&csdev->mode, CS_MODE_SYSFS);
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 	}
 
 out:
@@ -1564,7 +1564,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
-	if (atomic_read(&csdev->refcnt) != 1) {
+	if (csdev->refcnt != 1) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		goto out;
 	}
@@ -1676,7 +1676,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	 * use for this session.
 	 */
 	if (drvdata->pid == pid) {
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 		goto unlock_out;
 	}
 
@@ -1686,7 +1686,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		drvdata->pid = pid;
 		local_set(&csdev->mode, CS_MODE_PERF);
 		drvdata->perf_buf = etr_perf->etr_buf;
-		atomic_inc(&csdev->refcnt);
+		csdev->refcnt++;
 	}
 
 unlock_out:
@@ -1719,7 +1719,8 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 		return -EBUSY;
 	}
 
-	if (atomic_dec_return(&csdev->refcnt)) {
+	csdev->refcnt--;
+	if (csdev->refcnt) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-tpda.c b/drivers/hwtracing/coresight/coresight-tpda.c
index 65c70995ab00..135a89654c4c 100644
--- a/drivers/hwtracing/coresight/coresight-tpda.c
+++ b/drivers/hwtracing/coresight/coresight-tpda.c
@@ -152,7 +152,8 @@ static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
 	 * Only do pre-port enable for first port that calls enable when the
 	 * device's main refcount is still 0
 	 */
-	if (!atomic_read(&drvdata->csdev->refcnt))
+	lockdep_assert_held(&drvdata->spinlock);
+	if (!drvdata->csdev->refcnt)
 		tpda_enable_pre_port(drvdata);
 
 	ret = tpda_enable_port(drvdata, port);
@@ -173,7 +174,7 @@ static int tpda_enable(struct coresight_device *csdev,
 		ret = __tpda_enable(drvdata, in->dest_port);
 		if (!ret) {
 			atomic_inc(&in->dest_refcnt);
-			atomic_inc(&csdev->refcnt);
+			csdev->refcnt++;
 			dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
 		}
 	}
@@ -204,7 +205,7 @@ static void tpda_disable(struct coresight_device *csdev,
 	spin_lock(&drvdata->spinlock);
 	if (atomic_dec_return(&in->dest_refcnt) == 0) {
 		__tpda_disable(drvdata, in->dest_port);
-		atomic_dec(&csdev->refcnt);
+		csdev->refcnt--;
 	}
 	spin_unlock(&drvdata->spinlock);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 59eac93fd6bb..c23a6b9b41fe 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -58,6 +58,7 @@ struct tpiu_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
+	spinlock_t		spinlock;
 };
 
 static void tpiu_enable_hw(struct csdev_access *csa)
@@ -72,8 +73,11 @@ static void tpiu_enable_hw(struct csdev_access *csa)
 static int tpiu_enable(struct coresight_device *csdev, enum cs_mode mode,
 		       void *__unused)
 {
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	guard(spinlock)(&drvdata->spinlock);
 	tpiu_enable_hw(&csdev->access);
-	atomic_inc(&csdev->refcnt);
+	csdev->refcnt++;
 	dev_dbg(&csdev->dev, "TPIU enabled\n");
 	return 0;
 }
@@ -96,7 +100,11 @@ static void tpiu_disable_hw(struct csdev_access *csa)
 
 static int tpiu_disable(struct coresight_device *csdev)
 {
-	if (atomic_dec_return(&csdev->refcnt))
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+
+	guard(spinlock)(&drvdata->spinlock);
+	csdev->refcnt--;
+	if (csdev->refcnt)
 		return -EBUSY;
 
 	tpiu_disable_hw(&csdev->access);
@@ -132,6 +140,8 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
+	spin_lock_init(&drvdata->spinlock);
+
 	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 1a8c64645b92..1146584a1745 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -103,7 +103,7 @@ static int smb_open(struct inode *inode, struct file *file)
 	if (drvdata->reading)
 		return -EBUSY;
 
-	if (atomic_read(&drvdata->csdev->refcnt))
+	if (drvdata->csdev->refcnt)
 		return -EBUSY;
 
 	smb_update_data_size(drvdata);
@@ -271,7 +271,7 @@ static int smb_enable(struct coresight_device *csdev, enum cs_mode mode,
 	if (ret)
 		return ret;
 
-	atomic_inc(&csdev->refcnt);
+	csdev->refcnt++;
 	dev_dbg(&csdev->dev, "Ultrasoc SMB enabled\n");
 
 	return ret;
@@ -286,7 +286,8 @@ static int smb_disable(struct coresight_device *csdev)
 	if (drvdata->reading)
 		return -EBUSY;
 
-	if (atomic_dec_return(&csdev->refcnt))
+	csdev->refcnt--;
+	if (csdev->refcnt)
 		return -EBUSY;
 
 	/* Complain if we (somehow) got out of sync */
@@ -381,7 +382,7 @@ static unsigned long smb_update_buffer(struct coresight_device *csdev,
 	guard(spinlock)(&drvdata->spinlock);
 
 	/* Don't do anything if another tracer is using this sink. */
-	if (atomic_read(&csdev->refcnt) != 1)
+	if (csdev->refcnt != 1)
 		return 0;
 
 	smb_disable_hw(drvdata);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index e8dd0df98881..4400d554a16b 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -230,8 +230,15 @@ struct coresight_sysfs_link {
  *		actually an 'enum cs_mode', but is stored in an atomic type.
  *		This is always accessed through local_read() and local_set(),
  *		but wherever it's done from within the Coresight device's lock,
- *		a non-atomic read would also work.
- * @refcnt:	keep track of what is in use.
+ *		a non-atomic read would also work. This is the main point of
+ *		synchronisation between code happening inside the sysfs mode's
+ *		coresight_mutex and outside when running in Perf mode. A compare
+ *		and exchange swap is done to atomically claim one mode or the
+ *		other.
+ * @refcnt:	keep track of what is in use. Only access this outside of the
+ *		device's spinlock when the coresight_mutex held and mode ==
+ *		CS_MODE_SYSFS. Otherwise it must be accessed from inside the
+ *		spinlock.
  * @orphan:	true if the component has connections that haven't been linked.
  * @sysfs_sink_activated: 'true' when a sink has been selected for use via sysfs
  *		by writing a 1 to the 'enable_sink' file.  A sink can be
@@ -257,7 +264,7 @@ struct coresight_device {
 	struct csdev_access access;
 	struct device dev;
 	local_t	mode;
-	atomic_t refcnt;
+	int refcnt;
 	bool orphan;
 	/* sink specific fields */
 	bool sysfs_sink_activated;
-- 
2.34.1


