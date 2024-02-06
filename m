Return-Path: <linux-kernel+bounces-55682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBED84BFE7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C43F71C20DEF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726401BF24;
	Tue,  6 Feb 2024 22:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKsvKrw9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAF61BF37;
	Tue,  6 Feb 2024 22:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707257745; cv=none; b=XyvhN3DHfg+5mEwVlGrQ6EkiX1bxCWUhyLyujykhvu8DiQBZNS5C/12WG4c2yVh+gq0QsoKMREsEYTUi+jS628R0zxcp56DsPurNKx5Q+eskyaaQKKV6ahwV8Dqs8EJXab2AgFqOn71IU2J0hFWhJ35QCEoVFWX/wWtODU0nzF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707257745; c=relaxed/simple;
	bh=pNOvyJzuQeqsakt9aKOjJ4ZIQm/Pu1dcPBieRGr2pfY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JquZTGxddezq5+6uxPbrYdo8OlWyt9cqXkLQTYIhjlQJXkINjo3veAjMfPBM10qazqUagDlY2tizNNyh7r3VvLSiy/S8YsQNCh7IKc105aXzPaPJzUQCT1XaONoigZWa0iXQRHNIW4JhSvLXMPcum1b4fd+DXsY0vhY0fm2/WwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKsvKrw9; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707257744; x=1738793744;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=pNOvyJzuQeqsakt9aKOjJ4ZIQm/Pu1dcPBieRGr2pfY=;
  b=cKsvKrw9A0ya1sjn9KhwKu0A/Sabb5be5vBwQAB2K21K/JJ62pHLsIZT
   kfwtz0A7rngV7EbUqYnG+rKfla68STZiCM79Brs/FFHzoUyJFS9L1FZkE
   HV/VpdavsuCoEB4A50dsni6bK6//RP+e89d1OGEWek/G5sYZPn9GaU8e8
   Bmw56bSKiShgGzJZbCxWskZlTPDld7BiZDttK3h5XHLPGJRitiiRyY1he
   HuznZ95MTVcl7sKNrLpActCZWPRLPOaZUg7FtLmp8Mw5PqcRFoJz9fSs3
   ES3jTGMIO7JCl7UiE8Al3of9m99VvzVwgdS3Gcph7CAdqA9ZbPiFvX+M+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="752032"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="752032"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 14:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="31961892"
Received: from iweiny-desk3.amr.corp.intel.com (HELO localhost) ([10.212.121.225])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 14:15:41 -0800
From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 06 Feb 2024 14:15:32 -0800
Subject: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
X-B4-Tracking: v=1; b=H4sIAIOvwmUC/2WNzQrCMBCEX6Xs2ZVkjbT11PeQHmLc2oX+kYRSK
 Xl3Y8GTMJdvYL7ZIbAXDnArdvC8SpB5ykCnAlxvpxejPDMDKTKKlEa3DegW9hhGG12PFT001aa
 uciCvFs+dbIfx3mbuJcTZv4+DVX/bn4v+XKtGjaU1Wl1c2V2tamSKPJzdPEKbUvoA/Vifua4AA
 AA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>, 
 Jonathan Cameron <jonathan.cameron@Huawei.com>, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-acpi@vger.kernel.org, linux-cxl@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>, 
 Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.13-dev-2d940
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707257741; l=3430;
 i=ira.weiny@intel.com; s=20221222; h=from:subject:message-id;
 bh=pNOvyJzuQeqsakt9aKOjJ4ZIQm/Pu1dcPBieRGr2pfY=;
 b=zulniw+JGONEhhR3l9xf9ERy4LztcTPp0L7Czo1Q81GvydQm3+3uD4h0r22IytdFlLkj27dIH
 98npAckYuUsAiANciy2AeJqOMBeToAPJ1iFaRScYD0fwtg/rclcUvXl
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=brwqReAJklzu/xZ9FpSsMPSQ/qkSalbg6scP3w809Ec=

Smatch caught that cxl_cper_post_event() is called with a spinlock held
or preemption disabled.[1]  The callback takes the device lock to
perform address translation and therefore might sleep.  The record data
is released back to BIOS in ghes_clear_estatus() which requires it to be
copied for use in the workqueue.

Copy the record to a lockless list and schedule a work item to process
the record outside of atomic context.

[1] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
Changes in v2:
- djbw: device_lock() sleeps so we need to call the callback in process context
- iweiny: create work queue to handle processing the callback
- Link to v1: https://lore.kernel.org/r/20240202-cxl-cper-smatch-v1-1-7a4103c7f5a0@intel.com
---
 drivers/acpi/apei/ghes.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 7b7c605166e0..aa41e9128118 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -679,6 +679,12 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
  */
 static DECLARE_RWSEM(cxl_cper_rw_sem);
 static cxl_cper_callback cper_callback;
+static LLIST_HEAD(cxl_cper_rec_list);
+struct cxl_cper_work_item {
+	struct llist_node node;
+	enum cxl_event_type event_type;
+	struct cxl_cper_event_rec rec;
+};
 
 /* CXL Event record UUIDs are formatted as GUIDs and reported in section type */
 
@@ -706,9 +712,34 @@ static cxl_cper_callback cper_callback;
 	GUID_INIT(0xfe927475, 0xdd59, 0x4339,				\
 		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74)
 
+static void cxl_cper_work_fn(struct work_struct *work)
+{
+	struct llist_node *entries, *cur, *n;
+	struct cxl_cper_work_item *wi;
+
+	guard(rwsem_read)(&cxl_cper_rw_sem);
+
+	entries = llist_del_all(&cxl_cper_rec_list);
+	if (!entries)
+		return;
+
+	/* Process oldest to newest */
+	entries = llist_reverse_order(entries);
+	llist_for_each_safe(cur, n, entries) {
+		wi = llist_entry(cur, struct cxl_cper_work_item, node);
+
+		if (cper_callback)
+			cper_callback(wi->event_type, &wi->rec);
+		kfree(wi);
+	}
+}
+static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
+
 static void cxl_cper_post_event(enum cxl_event_type event_type,
 				struct cxl_cper_event_rec *rec)
 {
+	struct cxl_cper_work_item *wi;
+
 	if (rec->hdr.length <= sizeof(rec->hdr) ||
 	    rec->hdr.length > sizeof(*rec)) {
 		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
@@ -721,9 +752,16 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
 		return;
 	}
 
-	guard(rwsem_read)(&cxl_cper_rw_sem);
-	if (cper_callback)
-		cper_callback(event_type, rec);
+	wi = kmalloc(sizeof(*wi), GFP_ATOMIC);
+	if (!wi) {
+		pr_err(FW_WARN "CXL CPER failed to allocate work item\n");
+		return;
+	}
+
+	wi->event_type = event_type;
+	memcpy(&wi->rec, rec, sizeof(wi->rec));
+	llist_add(&wi->node, &cxl_cper_rec_list);
+	schedule_work(&cxl_cper_work);
 }
 
 int cxl_cper_register_callback(cxl_cper_callback callback)

---
base-commit: 99bd3cb0d12e85d5114425353552121ec8f93adc
change-id: 20240201-cxl-cper-smatch-82b129498498

Best regards,
-- 
Ira Weiny <ira.weiny@intel.com>


