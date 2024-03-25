Return-Path: <linux-kernel+bounces-117012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DAC88A61C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3014B1C34F26
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAF814A089;
	Mon, 25 Mar 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJVwpKJj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5FA1420A0;
	Mon, 25 Mar 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370096; cv=none; b=k0PIcoAK24+DraWRIXSPw3RIrxJdX56WL5Eks1eB1hTiV9JBh41G29V2oqxVrRMwk4gdGuygIrNezKOYgtt/mYOJcn0frEgTt3a4XYJID+hD2xqwdTiFmMIaLiePwtauOfN1mVWgBv00K5EgzkKK/+YLs6s2gkHw5fEuga+cHWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370096; c=relaxed/simple;
	bh=oJ6UBa3Usaa6uDF3+sd8tBSCjSHUcPsUvLsqUUXSaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWutS63XYne7pKEgqsxyiNaeP51fP9/rGOCCdYsifNPpO9b8K3oFmA5nIx3Nq1DgsyGV9l8bW8qqSQQ2i9cu60KQpveiwmxt37y1MDCWUCcYlAaHxSR24shNabyzIiJydJZuNwQ87JKhiS9/EBs+F6wyXeiJ9I2BQbO9PfbqGKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJVwpKJj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370094; x=1742906094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJ6UBa3Usaa6uDF3+sd8tBSCjSHUcPsUvLsqUUXSaOY=;
  b=mJVwpKJjl2bV7iItVpVg30iw86jEvsCbsIYT0QOjA/SGozVCyA7L2ZnC
   YuhyuL2S0ydlmg0zp/Z5B5vidHiTEr+dB8YnlwZbjm9MxFzPE4tklwJGr
   3xzq9IrZ3u7MxLBjSd6xi4vx3JNPwoNaVRrGQz9w39EgJXp6F3nmwHEw/
   0GB7oMHJvqMuIIyOeXhT7kICcqD0VS9nJ4KzME29AxWCiPdc8lvjKnFHc
   923nKI2OuUK2g+xB6GTecYweJKHdkdPrF2LUy36/4G7AX1DE9uE+E2jV9
   jK6mS4nRTRMXVt9X+CQbLxfaOb9vmdozV+pGQ/G2/hyCUPNvoLMh+BPhq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549691"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549691"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070331"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070331"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id ABC32101; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 1/7] ACPI: bus: Make container_of() no-op where it makes sense
Date: Mon, 25 Mar 2024 14:32:57 +0200
Message-ID: <20240325123444.3031851-2-andriy.shevchenko@linux.intel.com>
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

Move list head node to be the first member in a few data structures
in order to make container_of() no-op at compile time. On x86_64 with
a custom (default + a few dozens of drivers enabled) configuration:

  add/remove: 0/0 grow/shrink: 5/12 up/down: 21/-124 (-103)
  ...
  Total: Before=39924675, After=39924572, chg -0.00%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/acpi/acpi_bus.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5de954e2b18a..cdee38ef9ba5 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -124,8 +124,8 @@ static inline struct acpi_hotplug_profile *to_acpi_hotplug_profile(
 }
 
 struct acpi_scan_handler {
-	const struct acpi_device_id *ids;
 	struct list_head list_node;
+	const struct acpi_device_id *ids;
 	bool (*match)(const char *idstr, const struct acpi_device_id **matchid);
 	int (*attach)(struct acpi_device *dev, const struct acpi_device_id *id);
 	void (*detach)(struct acpi_device *dev);
@@ -269,6 +269,7 @@ struct acpi_device_power_flags {
 };
 
 struct acpi_device_power_state {
+	struct list_head resources;	/* Power resources referenced */
 	struct {
 		u8 valid:1;
 		u8 explicit_set:1;	/* _PSx present? */
@@ -276,7 +277,6 @@ struct acpi_device_power_state {
 	} flags;
 	int power;		/* % Power (compared to D0) */
 	int latency;		/* Dx->D0 time (microseconds) */
-	struct list_head resources;	/* Power resources referenced */
 };
 
 struct acpi_device_power {
@@ -342,16 +342,16 @@ struct acpi_device_wakeup {
 };
 
 struct acpi_device_physical_node {
-	unsigned int node_id;
 	struct list_head node;
+	unsigned int node_id;
 	struct device *dev;
 	bool put_online:1;
 };
 
 struct acpi_device_properties {
+	struct list_head list;
 	const guid_t *guid;
 	union acpi_object *properties;
-	struct list_head list;
 	void **bufs;
 };
 
@@ -488,12 +488,12 @@ struct acpi_device {
 
 /* Non-device subnode */
 struct acpi_data_node {
+	struct list_head sibling;
 	const char *name;
 	acpi_handle handle;
 	struct fwnode_handle fwnode;
 	struct fwnode_handle *parent;
 	struct acpi_device_data data;
-	struct list_head sibling;
 	struct kobject kobj;
 	struct completion kobj_done;
 };
-- 
2.43.0.rc1.1.gbec44491f096


