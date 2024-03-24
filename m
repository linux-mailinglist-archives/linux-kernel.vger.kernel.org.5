Return-Path: <linux-kernel+bounces-116011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ACED58895F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE88B37D6A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BCC17B4F9;
	Mon, 25 Mar 2024 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhrCD2cp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28822174EE5;
	Sun, 24 Mar 2024 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323335; cv=none; b=FybbMggsRgxpFkPJ/fAgM2HE6bTxUTFDDvOKhIOJKvYq/89sIVi6Iae2nztRO9Sg4TrGbDYypyjD8cTi7yKeSiYsvtleYhi1330J7UlBdnlNJxlcuevfK3AvKDLhGCp+ZPV9UYpavmbEwGB5S9ONVnGnoTzmpHJ6oiAVdIlfFVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323335; c=relaxed/simple;
	bh=dU5rKxIRdpARhzb/iQNx1mD2zTtGGTT1rLng1T61/JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zj1XY8O4aDIw9AQiVPeWJulTY/JVjEtJnCMu8uDUOpa7qO20KZpZRUmfXO4UvwddMYnj78eBJVtOvGvWiL+0Tl2hJa/jz4viywSJdjFjy/zLQcwFktQofNtHpmSbsjFnzGLEusGhTaNl0iDBOQkHhVuxUfOUsfSIBVzxWSFkCo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhrCD2cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13016C43390;
	Sun, 24 Mar 2024 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323333;
	bh=dU5rKxIRdpARhzb/iQNx1mD2zTtGGTT1rLng1T61/JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RhrCD2cpwgrBMBsTURsOmmhuJ1hjqufXoVGhkPBAE1VA0Bi36+3JLNKFTOU0IX63G
	 W/6VHyzwRC7a2dB/PvG7wZYvRS1mv7Kj0TBOORC3EUnRhwkIbWQ3WSkmx3kSImO4YM
	 X/4KR2zLr4sUWLCVmPr9dSN4LoOl568dX80cjre8hskyfbBYfImKsXu8ghOXt3AAtq
	 829aMLfaor6pbj0/TXMVCM9NU8HMY66MN+sNd4cPVOQTpl/HZX6oh0fBROUuJdJg+5
	 ldC+eVJjKCct2j/+RpTOUaE7aBtSi71fBYtxbndCV0tHERcJIrSqXm6r8+Mm8l9ebk
	 Y97xiEqOyJWBw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 034/317] s390/dasd: add query PPRC function
Date: Sun, 24 Mar 2024 19:30:14 -0400
Message-ID: <20240324233458.1352854-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stefan Haberland <sth@linux.ibm.com>

[ Upstream commit 3f217cceb6846e7533511fc69bc774cdba37ff7d ]

Add function to query the Peer-to-Peer-Remote-Copy (PPRC) state of a
device by reading the related structure through a read subsystem data call.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Link: https://lore.kernel.org/r/20220920192616.808070-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: c3116e62ddef ("s390/dasd: fix double module refcount decrement")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/block/dasd_eckd.c | 66 ++++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.h |  6 ++++
 drivers/s390/block/dasd_int.h  | 32 +++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index cf80db7a74a3d..76f861c2ce614 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6105,6 +6105,71 @@ static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
 	return 0;
 }
 
+/*
+ * Perform Subsystem Function - Peer-to-Peer Remote Copy Extended Query
+ */
+static int dasd_eckd_query_pprc_status(struct dasd_device *device,
+				       struct dasd_pprc_data_sc4 *data)
+{
+	struct dasd_pprc_data_sc4 *pprc_data;
+	struct dasd_psf_prssd_data *prssdp;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	int rc;
+
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
+				   sizeof(*prssdp) + sizeof(*pprc_data) + 1,
+				   device, NULL);
+	if (IS_ERR(cqr)) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate query PPRC status request");
+		return PTR_ERR(cqr);
+	}
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	cqr->retries = 256;
+	cqr->expires = 10 * HZ;
+
+	/* Prepare for Read Subsystem Data */
+	prssdp = (struct dasd_psf_prssd_data *)cqr->data;
+	memset(prssdp, 0, sizeof(struct dasd_psf_prssd_data));
+	prssdp->order = PSF_ORDER_PRSSD;
+	prssdp->suborder = PSF_SUBORDER_PPRCEQ;
+	prssdp->varies[0] = PPRCEQ_SCOPE_4;
+	pprc_data = (struct dasd_pprc_data_sc4 *)(prssdp + 1);
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_PSF;
+	ccw->count = sizeof(struct dasd_psf_prssd_data);
+	ccw->flags |= CCW_FLAG_CC;
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->cda = (__u32)(addr_t)prssdp;
+
+	/* Read Subsystem Data - query host access */
+	ccw++;
+	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
+	ccw->count = sizeof(*pprc_data);
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->cda = (__u32)(addr_t)pprc_data;
+
+	cqr->buildclk = get_tod_clock();
+	cqr->status = DASD_CQR_FILLED;
+
+	rc = dasd_sleep_on_interruptible(cqr);
+	if (rc == 0) {
+		*data = *pprc_data;
+	} else {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"PPRC Extended Query failed with rc=%d\n",
+				rc);
+		rc = -EOPNOTSUPP;
+	}
+
+	dasd_sfree_request(cqr, cqr->memdev);
+	return rc;
+}
+
 /*
  * Perform Subsystem Function - CUIR response
  */
@@ -6723,6 +6788,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.ext_pool_exhaust = dasd_eckd_ext_pool_exhaust,
 	.ese_format = dasd_eckd_ese_format,
 	.ese_read = dasd_eckd_ese_read,
+	.pprc_status = dasd_eckd_query_pprc_status,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 65e4630ad2aea..ed83a9a55191b 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -66,9 +66,15 @@
  * Perform Subsystem Function / Sub-Orders
  */
 #define PSF_SUBORDER_QHA		 0x1C /* Query Host Access */
+#define PSF_SUBORDER_PPRCEQ		 0x50 /* PPRC Extended Query */
 #define PSF_SUBORDER_VSQ		 0x52 /* Volume Storage Query */
 #define PSF_SUBORDER_LCQ		 0x53 /* Logical Configuration Query */
 
+/*
+ * PPRC Extended Query Scopes
+ */
+#define PPRCEQ_SCOPE_4			 0x04 /* Scope 4 for PPRC Extended Query */
+
 /*
  * CUIR response condition codes
  */
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index d94ae067f085e..2ee8bc035b34a 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -260,6 +260,37 @@ struct dasd_uid {
 	char vduit[33];
 };
 
+/*
+ * PPRC Status data
+ */
+struct dasd_pprc_header {
+	__u8 entries;		/* 0     Number of device entries */
+	__u8 unused;		/* 1     unused */
+	__u16 entry_length;	/* 2-3   Length of device entry */
+	__u32 unused2;		/* 4-7   unused */
+} __packed;
+
+struct dasd_pprc_dev_info {
+	__u8 state;		/* 0       Copy State */
+	__u8 flags;		/* 1       Flags */
+	__u8 reserved1[2];	/* 2-3     reserved */
+	__u8 prim_lss;		/* 4       Primary device LSS */
+	__u8 primary;		/* 5       Primary device address */
+	__u8 sec_lss;		/* 6       Secondary device LSS */
+	__u8 secondary;		/* 7       Secondary device address */
+	__u16 pprc_id;		/* 8-9     Peer-to-Peer Remote Copy ID */
+	__u8 reserved2[12];	/* 10-21   reserved */
+	__u16 prim_cu_ssid;	/* 22-23   Pimary Control Unit SSID */
+	__u8 reserved3[12];	/* 24-35   reserved */
+	__u16 sec_cu_ssid;	/* 36-37   Secondary Control Unit SSID */
+	__u8 reserved4[90];	/* 38-127  reserved */
+} __packed;
+
+struct dasd_pprc_data_sc4 {
+	struct dasd_pprc_header header;
+	struct dasd_pprc_dev_info dev_info[5];
+} __packed;
+
 /*
  * the struct dasd_discipline is
  * sth like a table of virtual functions, if you think of dasd_eckd
@@ -388,6 +419,7 @@ struct dasd_discipline {
 	struct dasd_ccw_req *(*ese_format)(struct dasd_device *,
 					   struct dasd_ccw_req *, struct irb *);
 	int (*ese_read)(struct dasd_ccw_req *, struct irb *);
+	int (*pprc_status)(struct dasd_device *, struct	dasd_pprc_data_sc4 *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
-- 
2.43.0


