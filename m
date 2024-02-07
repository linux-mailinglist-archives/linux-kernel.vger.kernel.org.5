Return-Path: <linux-kernel+bounces-56922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C969084D16C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE4B21C252BA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D8C126F0A;
	Wed,  7 Feb 2024 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee+/qVnN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F3C86AC3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707331356; cv=none; b=Qi4ljkF/vrHX4nGpBDUrtvAH5KfZ/+ZvBs+3ObruDqt5/imlLDriE18fjdk5rWWXEvSnYBMpwgOZFOYZiUa60Oe2wcjoh5Wx2ZtwcG9uYFb+viRrNupSGKcK9pDyXbzieD/Z5awcRp3PrlWbwpPKFB6zRsGZYbaS5SNVqBxcdT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707331356; c=relaxed/simple;
	bh=WxvH6FDX/eWNGMCI+SWHVfMnLqP3askGdu0ASe254/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dti5G61IYM7E/xP0blr6rXq8jHow9ioL3O1qFm/+sKT+dUgZIlL1MSqzUbIBGphb/gbBbAC3k1jn6magHNPt9VouvC+tKqh+ctQdJpzqY4TntEi1AySekKQrDZkxTwq2gbvX3EkWaaBde7iAVMeqkWP5Y3smT61/sXmoGAUTrt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ee+/qVnN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707331353;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwU//eJ9yadzq/fsfDhiEtvVbtfHI98m1htYpt9Ipdk=;
	b=ee+/qVnNk8KVahdZouW+oiRq+/6BcPlD/19dTMp7FKf/ffDaQlzVIwY7lzY3yRKfdSKLwQ
	mSlf9lkl5x/41VPySBTQ8mJWuoicJinakPK3hXwGTmmtp9q0wlhFExOy2snv9o5hLpSCkq
	KwzjtSM8HjhAeHd1WaXxvKefl70x0Iw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-m-6gGQ7ROWmYlHUy-tFPLQ-1; Wed, 07 Feb 2024 13:42:28 -0500
X-MC-Unique: m-6gGQ7ROWmYlHUy-tFPLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28C2C84AF81;
	Wed,  7 Feb 2024 18:42:28 +0000 (UTC)
Received: from fedora-work.redhat.com (unknown [10.22.32.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id AC90B4011FF1;
	Wed,  7 Feb 2024 18:42:27 +0000 (UTC)
From: David Jeffery <djeffery@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Laurence Oberman <loberman@redhat.com>
Subject: [RFC PATCH 6/6] sd: async cache flush on shutdown
Date: Wed,  7 Feb 2024 13:41:00 -0500
Message-ID: <20240207184100.18066-7-djeffery@redhat.com>
In-Reply-To: <20240207184100.18066-1-djeffery@redhat.com>
References: <20240207184100.18066-1-djeffery@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Add async shutdown for the cache flush to the sd device by sending a
SYNCHRONIZE_CACHE command asynchronously. If there is any sort of error,
falls back to the synchronous sd_sync_cache() to try again and resolve
any errors.

Signed-off-by: David Jeffery <djeffery@redhat.com>
Tested-by:     Laurence Oberman <loberman@redhat.com>

---
 drivers/scsi/sd.c | 66 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/scsi/sd.h |  2 ++
 2 files changed, 62 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0833b3e6aa6e..f972310df76a 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3838,23 +3838,64 @@ static int sd_start_stop_device(struct scsi_disk *sdkp, int start)
 	return 0;
 }
 
-/*
- * Send a SYNCHRONIZE CACHE instruction down to the device through
- * the normal SCSI command structure.  Wait for the command to
- * complete.
- */
-static void sd_shutdown(struct device *dev)
+static void sd_sync_cache_callback(struct scsi_cmnd *scmd,
+				   struct scsi_exec_args *args) {
+	struct scsi_disk *sdkp;
+
+	sdkp = container_of(args, struct scsi_disk, shutdown_params);
+	complete(&sdkp->shutdown_done);
+}
+
+static void sd_async_shutdown_start(struct device *dev)
 {
 	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	const int timeout = sdkp->device->request_queue->rq_timeout
+			    * SD_FLUSH_TIMEOUT_MULTIPLIER;
+	int ret;
 
 	if (!sdkp)
 		return;         /* this can happen */
 
+	init_completion(&sdkp->shutdown_done);
+	sdkp->shutdown_params.callback = sd_sync_cache_callback;
+
 	if (pm_runtime_suspended(dev))
 		return;
 
 	if (sdkp->WCE && sdkp->media_present) {
+		unsigned char cmd[16] = { 0 };
+
 		sd_printk(KERN_NOTICE, sdkp, "Synchronizing SCSI cache\n");
+		if (sdkp->device->use_16_for_sync)
+			cmd[0] = SYNCHRONIZE_CACHE_16;
+		else
+			cmd[0] = SYNCHRONIZE_CACHE;
+
+		ret = scsi_execute_cmd_nowait(sdkp->device, cmd, REQ_OP_DRV_IN,
+					      timeout, sdkp->max_retries,
+					      &sdkp->shutdown_params);
+		if (!ret)
+			return;
+		sdkp->shutdown_params.result = ret;
+	}
+	/* no async I/O to do, go ahead and mark it complete */
+	complete(&sdkp->shutdown_done);
+}
+
+static void sd_async_shutdown_end(struct device *dev)
+{
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+
+	if (!sdkp)
+		return;
+
+	if (pm_runtime_suspended(dev))
+		return;
+
+	wait_for_completion(&sdkp->shutdown_done);
+
+	if (sdkp->WCE && sdkp->media_present && sdkp->shutdown_params.result) {
+		/* for any error with the async flush, retry as sync */
 		sd_sync_cache(sdkp);
 	}
 
@@ -3867,6 +3908,17 @@ static void sd_shutdown(struct device *dev)
 	}
 }
 
+/*
+ * Send a SYNCHRONIZE CACHE instruction down to the device through
+ * the normal SCSI command structure.  Wait for the command to
+ * complete.
+ */
+static void sd_shutdown(struct device *dev)
+{
+	sd_async_shutdown_start(dev);
+	sd_async_shutdown_end(dev);
+}
+
 static inline bool sd_do_start_stop(struct scsi_device *sdev, bool runtime)
 {
 	return (sdev->manage_system_start_stop && !runtime) ||
@@ -4003,6 +4055,8 @@ static struct scsi_driver sd_template = {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.remove		= sd_remove,
 		.shutdown	= sd_shutdown,
+		.async_shutdown_start = sd_async_shutdown_start,
+		.async_shutdown_end   = sd_async_shutdown_end,
 		.pm		= &sd_pm_ops,
 	},
 	.rescan			= sd_rescan,
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 409dda5350d1..7b5098211cec 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -91,6 +91,8 @@ struct scsi_disk {
 	struct device	disk_dev;
 	struct gendisk	*disk;
 	struct opal_dev *opal_dev;
+	struct scsi_exec_args shutdown_params;
+	struct completion shutdown_done;
 #ifdef CONFIG_BLK_DEV_ZONED
 	/* Updated during revalidation before the gendisk capacity is known. */
 	struct zoned_disk_info	early_zone_info;
-- 
2.43.0


