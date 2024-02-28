Return-Path: <linux-kernel+bounces-84244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A74386A420
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEDFA1C244CA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC863FE1;
	Wed, 28 Feb 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IgWxomVA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EF3838A;
	Wed, 28 Feb 2024 00:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078420; cv=none; b=XRMylcBt3OuCWdSyhXjH6PcKoAWiGMatGXdM/V9rHAST7BT3e5rULl4m+lQ1JZdfgz+iXCAMiWwWx/WI9KUoBLVIWIu8wUDCV/hU4fxgMzZ+r2uGoMAuYryReb9eGDv2u80oxuMIibm1XRjWvRIAcGO3cCW9hN6soTDhuAgv7Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078420; c=relaxed/simple;
	bh=tbwiqecWv333Dv92Qlp888aKfOTOHtcWbrck4ee1Idk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDrFx9ilh3ueYD2we/TWQsX76MbCR4YNLJIJb+v1RXfDJ7ykBCL8B2yPLFQqospuBcDig8gVrs+UdBE/kbv32Y9MFNDaUoRVJHBSV3u79A9uBc4JDma2AVa5ozl5+f6gKY4sws2xyCpl1stLqEYWdu4oWCsadLrPRm6NIXc/6fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IgWxomVA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078418; x=1740614418;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=tbwiqecWv333Dv92Qlp888aKfOTOHtcWbrck4ee1Idk=;
  b=IgWxomVA9fj3D7qjH0m+t8Bx7s7mtjbs5BPvr0NU1cLzweckt0XCfznt
   uIKiwPqxuDrb/c8RCadjIiFDUpNt+YnY+vid2R8vtX9s941KjxU2o2LNX
   XdttJJt5VADq8q8QECDcrPn2wMV0eIOidHnm+7bYZSN82ByANYDrbtOp0
   HCSo+h1bdr7jumr1RvmLApHsz4w2czrljefzPLCY43BoM4CHwO33URepg
   WeEccyMNdhkTP5Mgtaie8Rm3f1daSWScm8LvnWkqq5LJFiB488tsXEZ0F
   H+V1N/NZ41xOMyk5b5BHvz+VBwRhLRsoH5HuhEJ9/YkXXD0/QrrSuu7u7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14604935"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="14604935"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7176939"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:17 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id A789B580D7F;
	Tue, 27 Feb 2024 16:00:16 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 2/9] platform/x86/intel/sdsi: Combine read and write mailbox flows
Date: Tue, 27 Feb 2024 16:00:09 -0800
Message-Id: <20240228000016.1685518-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228000016.1685518-1-david.e.box@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current mailbox commands are either read-only or write-only and the
flow is different for each. New commands will need to send and receive
data. In preparation for these commands, create a common polling function
to handle sending data and receiving in the same transaction.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - In sdsi_cmd_read() remove unnecessary check for non-zero packet_size
     in do loop since the loop is exited earlier when packet_size is
     zero.

 drivers/platform/x86/intel/sdsi.c | 79 +++++++++++++++++--------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index a70c071de6e2..d80c2dc0ce71 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -15,6 +15,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -156,8 +157,8 @@ static int sdsi_status_to_errno(u32 status)
 	}
 }
 
-static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
-			      size_t *data_size)
+static int sdsi_mbox_poll(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			  size_t *data_size)
 {
 	struct device *dev = priv->dev;
 	u32 total, loop, eom, status, message_size;
@@ -166,18 +167,10 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 
 	lockdep_assert_held(&priv->mb_lock);
 
-	/* Format and send the read command */
-	control = FIELD_PREP(CTRL_EOM, 1) |
-		  FIELD_PREP(CTRL_SOM, 1) |
-		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
-		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
-	writeq(control, priv->control_addr);
-
 	/* For reads, data sizes that are larger than the mailbox size are read in packets. */
 	total = 0;
 	loop = 0;
 	do {
-		void *buf = info->buffer + (SDSI_SIZE_MAILBOX * loop);
 		u32 packet_size;
 
 		/* Poll on ready bit */
@@ -195,6 +188,11 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 		if (ret)
 			break;
 
+		if (!packet_size) {
+			sdsi_complete_transaction(priv);
+			break;
+		}
+
 		/* Only the last packet can be less than the mailbox size. */
 		if (!eom && packet_size != SDSI_SIZE_MAILBOX) {
 			dev_err(dev, "Invalid packet size\n");
@@ -208,9 +206,13 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 			break;
 		}
 
-		sdsi_memcpy64_fromio(buf, priv->mbox_addr, round_up(packet_size, SDSI_SIZE_CMD));
+		if (info->buffer) {
+			void *buf = info->buffer + array_size(SDSI_SIZE_MAILBOX, loop);
 
-		total += packet_size;
+			sdsi_memcpy64_fromio(buf, priv->mbox_addr,
+					     round_up(packet_size, SDSI_SIZE_CMD));
+			total += packet_size;
+		}
 
 		sdsi_complete_transaction(priv);
 	} while (!eom && ++loop < MBOX_MAX_PACKETS);
@@ -230,16 +232,33 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 		dev_warn(dev, "Read count %u differs from expected count %u\n",
 			 total, message_size);
 
-	*data_size = total;
+	if (data_size)
+		*data_size = total;
 
 	return 0;
 }
 
-static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			      size_t *data_size)
+{
+	u64 control;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Format and send the read command */
+	control = FIELD_PREP(CTRL_EOM, 1) |
+		  FIELD_PREP(CTRL_SOM, 1) |
+		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+	writeq(control, priv->control_addr);
+
+	return sdsi_mbox_poll(priv, info, data_size);
+}
+
+static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			       size_t *data_size)
 {
 	u64 control;
-	u32 status;
-	int ret;
 
 	lockdep_assert_held(&priv->mb_lock);
 
@@ -256,20 +275,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
 		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
 	writeq(control, priv->control_addr);
 
-	/* Poll on ready bit */
-	ret = readq_poll_timeout(priv->control_addr, control, control & CTRL_READY,
-				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
-
-	if (ret)
-		goto release_mbox;
-
-	status = FIELD_GET(CTRL_STATUS, control);
-	ret = sdsi_status_to_errno(status);
-
-release_mbox:
-	sdsi_complete_transaction(priv);
-
-	return ret;
+	return sdsi_mbox_poll(priv, info, data_size);
 }
 
 static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
@@ -313,7 +319,8 @@ static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info
 	return ret;
 }
 
-static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			   size_t *data_size)
 {
 	int ret;
 
@@ -323,7 +330,7 @@ static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
 	if (ret)
 		return ret;
 
-	return sdsi_mbox_cmd_write(priv, info);
+	return sdsi_mbox_cmd_write(priv, info, data_size);
 }
 
 static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, size_t *data_size)
@@ -342,7 +349,7 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, s
 static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 			      enum sdsi_command command)
 {
-	struct sdsi_mbox_info info;
+	struct sdsi_mbox_info info = {};
 	int ret;
 
 	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
@@ -364,7 +371,9 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 	ret = mutex_lock_interruptible(&priv->mb_lock);
 	if (ret)
 		goto free_payload;
-	ret = sdsi_mbox_write(priv, &info);
+
+	ret = sdsi_mbox_write(priv, &info, NULL);
+
 	mutex_unlock(&priv->mb_lock);
 
 free_payload:
@@ -408,7 +417,7 @@ static ssize_t
 certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
 		 size_t count)
 {
-	struct sdsi_mbox_info info;
+	struct sdsi_mbox_info info = {};
 	size_t size;
 	int ret;
 
-- 
2.34.1


