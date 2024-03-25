Return-Path: <linux-kernel+bounces-117009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B0388A616
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAD11C3B72A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC661420BB;
	Mon, 25 Mar 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mB8PtC8y"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2278D13EFE8;
	Mon, 25 Mar 2024 12:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370093; cv=none; b=u9G9IWk1PXRHKAT4Ef9FqhJ2cM+FfnIrIE0JPaZIltTJX7G7qABWUj1wpNKvZyeF62mGg1YHPQeo/hGyrjjYF0xH61GuI0AqePYIEWqaKgtidFNuYr1dw5REAnopDr8CnC/S+LUHwoiNwgBjVkXWFPAx8ajsS8LKahy6kHnq/B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370093; c=relaxed/simple;
	bh=xP4F0Dzs6Z1vnbHfWvIrP7rhalwxftEshnlKle1DX1g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q11OYOjc3OQp0LuImSL0KZIaTuzs3fLVKWwaWTCwS+Z3kw/KKJvhlpaJKu2cy9yUMkxRsDjdreTDz0Y4RkIWJ+PCWUq9tx0IQkwMAtTirD6VdeNCBHbOjC/9CjPtktXkqXMdgta8mEcrevhD5/4MRunUT8gIDZbMl7Pil9Oj0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mB8PtC8y; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370092; x=1742906092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xP4F0Dzs6Z1vnbHfWvIrP7rhalwxftEshnlKle1DX1g=;
  b=mB8PtC8yFYJkM7RBxnYkvDfDbuRu2ZYh0a5ivwjJkB6pgdAxNcPu+iEU
   WYpVk1JbRyx1JCSQTj0Zqo5LxE30CNf/GASWYo+YucJl6+AKpcYZCposw
   BH9SLSxvwEzBmMuJxVN+w/9deY2zVI3QvZnd+ZgoqLuRMc45Jfl+mi7mC
   5JO7LS+TmsedGVxsb+njleLg4+s9qcmwgNXqR5UojECb11DepYRI74i4u
   KKKE10flNpMmRtuPVti1s8kQDCy8KL4AR6a2QMT5OHTqV0IEnBlhnZ9QD
   Zhck8Jl/GH84NyBIUoLsCtpwHCVy5+HQluBYgqHH/6zdlYWJNTBY5FFqQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549685"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549685"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070327"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070327"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id C4A14233; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 3/7] ACPI: scan: Replace infinite for-loop with finite while-loop
Date: Mon, 25 Mar 2024 14:32:59 +0200
Message-ID: <20240325123444.3031851-4-andriy.shevchenko@linux.intel.com>
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

The infinite loops is harder to understand (as one has to go
over the body in order to find main exit conditional) and it's
more verbose than usual approach with a while-loop.

Note, we may not use list_for_each_entry_safe() as there is locking
involved and the saved pointer may become invalid behind our back.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7c157bf92695..5e4118970285 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -530,15 +530,10 @@ static DEFINE_MUTEX(acpi_device_del_lock);
 
 static void acpi_device_del_work_fn(struct work_struct *work_not_used)
 {
-	for (;;) {
-		struct acpi_device *adev;
+	struct acpi_device *adev;
 
-		mutex_lock(&acpi_device_del_lock);
-
-		if (list_empty(&acpi_device_del_list)) {
-			mutex_unlock(&acpi_device_del_lock);
-			break;
-		}
+	mutex_lock(&acpi_device_del_lock);
+	while (!list_empty(&acpi_device_del_list)) {
 		adev = list_first_entry(&acpi_device_del_list,
 					struct acpi_device, del_list);
 		list_del(&adev->del_list);
@@ -555,7 +550,10 @@ static void acpi_device_del_work_fn(struct work_struct *work_not_used)
 		 */
 		acpi_power_transition(adev, ACPI_STATE_D3_COLD);
 		acpi_dev_put(adev);
+
+		mutex_lock(&acpi_device_del_lock);
 	}
+	mutex_unlock(&acpi_device_del_lock);
 }
 
 /**
-- 
2.43.0.rc1.1.gbec44491f096


