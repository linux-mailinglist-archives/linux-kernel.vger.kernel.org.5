Return-Path: <linux-kernel+bounces-117013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19BD88A61E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0AA2C7751
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E9314D421;
	Mon, 25 Mar 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYyAhHMx"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDFC1428FC;
	Mon, 25 Mar 2024 12:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370096; cv=none; b=oZQoIXGPFXQ90bFEaSVDN0ZN33loLqdYWHFMOP4CjKop/wK0OzjvW3nLCRnYjTc7V3vqraUThbnRHguhycI51Jj2DK4jS/XI15QPOXHfTUkJNkY+0NNLzvm3z6DFCJ/yrmjnOGWP2ANXcyQJ01WfA/F/Znerqr2kVcRXp/ntglg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370096; c=relaxed/simple;
	bh=2QqcFaZw9ZOboSMWLp4Lpq84CkXZHQ0XhXntHOHAUGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RmaMi1KDeBUOGdJY3rX8NF4jAz/8PmGOOeknqiPU0ba2nMpum8JGSRwDFErbWA2+eTSssgmQNNcaFB9cuHEI/JuODi2vT4CiPZmS6x8m8nZd3tfwwO8HppQ7/FyWrUiV2gcMjhOwLoMSzovlYOo4YEDKKLPI85ZlVqleU/SUNeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYyAhHMx; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711370095; x=1742906095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2QqcFaZw9ZOboSMWLp4Lpq84CkXZHQ0XhXntHOHAUGY=;
  b=GYyAhHMxV055L1UCDKEB8y4ZmDUxuHh/ai1uKJ4RWWmg/qtdTyQcq98q
   3OO4YJkTpg6h86MgT/nGgGN/Skm2/KuFum51+zOTcqHBPZqoMQZUCEH4X
   AMNi7swuesMvjyw/plmptWZ8doBcQcXCineCV+IY55HcZFTkuB0/MB9u7
   syWxA1weR6Ppl2jhmA3eD2zvS4n3fGfjk9Wni7hyzcydiySA6JcbvUxAo
   6FUAuSGBactS1dvCrx6WiZpNyWZh7p0rkuclK4M3xyvXGd18NQoHzNuk9
   JK0Odytz8VSaKqq3sB+psU6Bah6dnNoFThyLXK55sQSqXOPJxOjCt9bxz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6549697"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6549697"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:34:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070335"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="937070335"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 05:34:47 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id D7FDB484; Mon, 25 Mar 2024 14:34:46 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linux.dev
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>
Subject: [PATCH v1 4/7] ACPI: scan: Use list_first_entry_or_null() in acpi_device_hid()
Date: Mon, 25 Mar 2024 14:33:00 +0200
Message-ID: <20240325123444.3031851-5-andriy.shevchenko@linux.intel.com>
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

To replace list_empty() + list_first_entry() pair to simplify code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 5e4118970285..f5581d3701f1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1296,10 +1296,10 @@ const char *acpi_device_hid(struct acpi_device *device)
 {
 	struct acpi_hardware_id *hid;
 
-	if (list_empty(&device->pnp.ids))
+	hid = list_first_entry_or_null(&device->pnp.ids, struct acpi_hardware_id, list);
+	if (!hid)
 		return dummy_hid;
 
-	hid = list_first_entry(&device->pnp.ids, struct acpi_hardware_id, list);
 	return hid->id;
 }
 EXPORT_SYMBOL(acpi_device_hid);
-- 
2.43.0.rc1.1.gbec44491f096


