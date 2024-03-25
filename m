Return-Path: <linux-kernel+bounces-117016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3A488A629
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401FE1C3A8F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C001428FC;
	Mon, 25 Mar 2024 12:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dXCjXhY1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5588149DFA;
	Mon, 25 Mar 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370099; cv=none; b=JFr/Oet9+mwdwbgLoMfl+ssUhfGurvMsKttJYvzxiNOplR0homQV9bYl2B5jhzpErcydkYArBBEulauLA4okujYyspJo/QLvmccQsUh1DfWXJKCGUka0/4GWcQpmqM9DaiYZedLAIH687E2O/zFixGNzNgcbFj9c45GIzfsdQZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370099; c=relaxed/simple;
	bh=WSEkVBdORAODjRrcbYfVLEM4QYPG1G7EGlAISHGvqxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMqznptl5w8MJeCPVRcT0XnN+mcrjijQ/fY9X8a0stWMgFBgapfzJvoS5oAReJA8no5zYXgmYU10ftOSjD078rXMd/MaMny0wnCdmZ5Mf7Brkb/7DFCfZalPlLMUYg+lr2Vw8hBr0fpoUV46fyYMsF2AyV30ESyAh3/I0XWsQA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dXCjXhY1; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370097; x=1742906097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WSEkVBdORAODjRrcbYfVLEM4QYPG1G7EGlAISHGvqxU=;
  b=dXCjXhY10Rx6rXx/QKKZcWW9aF1Yob3zmPE+PrnCymsIn6sJgKqtYgPM
   ye9kHZurEufb3LOiuJP9kW8u8Js09rwIPh4w4Awa2w5M1HO6VpICVAlnH
   wMb2Ko9U5I4z5KaolCSwAG2F/soHiluYnkP+aIFhAVDsEHXRDxYmYMkJK
   APSP/N02ZNKdw+4LVn7ucdTiQHqqFQSEtGznNxplZCh25ePikUI3TIVzu
   6BJ1RFl4/7MW0152hKyoj7k6vnB9vfH1SIsN0AtGTKZZR7fuD0GUK8TFK
   Wzy8bh5F6tV8NjfyOouYfmjb5B/07BeINNeowM0hRA6YRcZP5ocAGDTbE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549711"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549711"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070344"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070344"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 02AFD5A8; Mon, 25 Mar 2024 14:34:47 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 7/7] ACPI: scan: Introduce typedef:s for struct acpi_hotplug_context members
Date: Mon, 25 Mar 2024 14:33:03 +0200
Message-ID: <20240325123444.3031851-8-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
References: <20240325123444.3031851-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the struct acpi_device_ops approach and introduce typedef:s
for the members. It makes code less verbose and more particular on
what parameters we take or types we use.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/dock.c     | 48 +++++++++++++++--------------------------
 drivers/acpi/scan.c     |  5 ++---
 include/acpi/acpi_bus.h | 13 ++++++-----
 3 files changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index a7c00ef78086..34affbda295e 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -88,43 +88,29 @@ static void dock_hotplug_event(struct dock_dependent_device *dd, u32 event,
 			       enum dock_callback_type cb_type)
 {
 	struct acpi_device *adev = dd->adev;
+	acpi_hp_fixup fixup = NULL;
+	acpi_hp_uevent uevent = NULL;
+	acpi_hp_notify notify = NULL;
 
 	acpi_lock_hp_context();
 
-	if (!adev->hp)
-		goto out;
-
-	if (cb_type == DOCK_CALL_FIXUP) {
-		void (*fixup)(struct acpi_device *);
-
-		fixup = adev->hp->fixup;
-		if (fixup) {
-			acpi_unlock_hp_context();
-			fixup(adev);
-			return;
-		}
-	} else if (cb_type == DOCK_CALL_UEVENT) {
-		void (*uevent)(struct acpi_device *, u32);
-
-		uevent = adev->hp->uevent;
-		if (uevent) {
-			acpi_unlock_hp_context();
-			uevent(adev, event);
-			return;
-		}
-	} else {
-		int (*notify)(struct acpi_device *, u32);
-
-		notify = adev->hp->notify;
-		if (notify) {
-			acpi_unlock_hp_context();
-			notify(adev, event);
-			return;
-		}
+	if (adev->hp) {
+		if (cb_type == DOCK_CALL_FIXUP)
+			fixup = adev->hp->fixup;
+		else if (cb_type == DOCK_CALL_UEVENT)
+			uevent = adev->hp->uevent;
+		else
+			notify = adev->hp->notify;
 	}
 
- out:
 	acpi_unlock_hp_context();
+
+	if (fixup)
+		fixup(adev);
+	else if (uevent)
+		uevent(adev, event);
+	else if (notify)
+		notify(adev, event);
 }
 
 static struct dock_station *find_dock_station(acpi_handle handle)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 45f7ec3b6548..534cb15351f5 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -73,8 +73,7 @@ void acpi_unlock_hp_context(void)
 
 void acpi_initialize_hp_context(struct acpi_device *adev,
 				struct acpi_hotplug_context *hp,
-				int (*notify)(struct acpi_device *, u32),
-				void (*uevent)(struct acpi_device *, u32))
+				acpi_hp_notify notify, acpi_hp_uevent uevent)
 {
 	acpi_lock_hp_context();
 	hp->notify = notify;
@@ -428,7 +427,7 @@ void acpi_device_hotplug(struct acpi_device *adev, u32 src)
 	} else if (adev->flags.hotplug_notify) {
 		error = acpi_generic_hotplug_event(adev, src);
 	} else {
-		int (*notify)(struct acpi_device *, u32);
+		acpi_hp_notify notify;
 
 		acpi_lock_hp_context();
 		notify = adev->hp ? adev->hp->notify : NULL;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index acb62d1d3306..6aa0d8a1de79 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -144,11 +144,15 @@ struct acpi_scan_handler {
  * --------------------
  */
 
+typedef int (*acpi_hp_notify) (struct acpi_device *, u32);
+typedef void (*acpi_hp_uevent) (struct acpi_device *, u32);
+typedef void (*acpi_hp_fixup) (struct acpi_device *);
+
 struct acpi_hotplug_context {
 	struct acpi_device *self;
-	int (*notify)(struct acpi_device *, u32);
-	void (*uevent)(struct acpi_device *, u32);
-	void (*fixup)(struct acpi_device *);
+	acpi_hp_notify notify;
+	acpi_hp_uevent uevent;
+	acpi_hp_fixup fixup;
 };
 
 /*
@@ -583,8 +587,7 @@ static inline void acpi_set_hp_context(struct acpi_device *adev,
 
 void acpi_initialize_hp_context(struct acpi_device *adev,
 				struct acpi_hotplug_context *hp,
-				int (*notify)(struct acpi_device *, u32),
-				void (*uevent)(struct acpi_device *, u32));
+				acpi_hp_notify notify, acpi_hp_uevent uevent);
 
 /* acpi_device.dev.bus == &acpi_bus_type */
 extern const struct bus_type acpi_bus_type;
-- 
2.43.0.rc1.1.gbec44491f096


