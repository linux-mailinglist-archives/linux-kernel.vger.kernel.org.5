Return-Path: <linux-kernel+bounces-49564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE82846BE1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 087E5298B0E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FE57E767;
	Fri,  2 Feb 2024 09:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJHykm0l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F677F06;
	Fri,  2 Feb 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865745; cv=none; b=BwfV5N+pTkaKH9Q5VrwU7lek2drPLNNnBd3nMwGF9K58jMF4v/XePEWbAzZvInBchNVVxmAJD4F8V+BTvtegnqI1JIt8Quy1cJNnGmKP08nTcePTVr/e6z1x9VBZWnd2zsceT8SLdwlZiLs3+eqM25jLsxB01/bh6MpO9An9H78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865745; c=relaxed/simple;
	bh=lCx6WOgbhUs1ZUj/emefnBwJYwMVwVQYh3bpqoSEs1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JMmGhOg5/6adr16aAmlTmBeEZJEqKHAQwEJEXNfyMBk08KaI8Gp8YjrquUb3wA6FMS3ovlDLTN51Ao7K8CfgtBZPZBzFe2D+A5AhauIqAeD1gD8pdMYnPx3W8bYnQO3eiiab4EivpbpcA7+jTIFzq2D0KSMzUCSJNG6ZlvBOBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJHykm0l; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865744; x=1738401744;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lCx6WOgbhUs1ZUj/emefnBwJYwMVwVQYh3bpqoSEs1U=;
  b=gJHykm0lC8CgGZUDf6simcWAuH65M5WNuSXJUIwMYr2ftiHD1FFJbju7
   pV9QCul7vZZLXh4/0A9f8BnvRGrh1a1yI9+HuREXjNavsvYBZqFhJtbti
   JBsmb0WCR8rL0qR79idbXEpO/pPAY9wzhqD1wqNpBAQCLCKsUbLhkgy8f
   dyC6ApTFOc345j4t3wMKhei0Szd8soaEOeCoqHuHBMUhdklSRFa43ANyt
   12GTZsPYY6Pk5inQ0nnfl4w7sh8TIk1HA0husWBaRvilT2nMKGihJdA8b
   5kQ054sCM5B5hSRk+/XtVucfbREM+mN8Waygqr2kYyohVGDHaX1E+yuTv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483147"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483147"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639785"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:21 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/11] hwmon: (coretemp) Use dynamic allocated memory for core temp_data
Date: Fri,  2 Feb 2024 17:21:44 +0800
Message-Id: <20240202092144.71180-12-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202092144.71180-1-rui.zhang@intel.com>
References: <20240202092144.71180-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The total memory needed for saving per core temperature data depends on
the number of cores in a package. Using static allocated memory wastes
memories on systems with low per package core count.

Improve the code to use dynamic allocated memory so that it can be
improved further when per package core count information becomes
available.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index e548f2145449..27c98c7faf32 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -91,10 +91,11 @@ struct temp_data {
 struct platform_data {
 	struct device		*hwmon_dev;
 	u16			pkg_id;
+	int			nr_cores;
 	struct ida		ida;
 	struct cpumask		cpumask;
 	struct temp_data	*pkg_data;
-	struct temp_data	*core_data[NUM_REAL_CORES];
+	struct temp_data	**core_data;
 	struct device_attribute name_attr;
 };
 
@@ -480,6 +481,20 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 {
 	struct temp_data *tdata;
 
+	if (!pdata->core_data) {
+		/*
+		 * TODO:
+		 * The information of actual possible cores in a package is broken for now.
+		 * Will replace hardcoded NUM_REAL_CORES with actual per package core count
+		 * when this information becomes available.
+		 */
+		pdata->nr_cores = NUM_REAL_CORES;
+		pdata->core_data = kcalloc(pdata->nr_cores, sizeof(struct temp_data *),
+						GFP_KERNEL);
+		if (!pdata->core_data)
+			return NULL;
+	}
+
 	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
 	if (!tdata)
 		return NULL;
@@ -489,7 +504,7 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 		/* Use tdata->index as indicator of package temp data */
 		tdata->index = -1;
 	} else {
-		tdata->index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
+		tdata->index = ida_alloc_max(&pdata->ida, pdata->nr_cores - 1, GFP_KERNEL);
 		if (tdata->index < 0) {
 			kfree(tdata);
 			return NULL;
@@ -510,6 +525,9 @@ static void destroy_temp_data(struct platform_data *pdata, struct temp_data *tda
 {
 	if (is_pkg_temp_data(tdata)) {
 		pdata->pkg_data = NULL;
+		kfree(pdata->core_data);
+		pdata->core_data = NULL;
+		pdata->nr_cores = 0;
 	} else {
 		pdata->core_data[tdata->index] = NULL;
 		ida_free(&pdata->ida, tdata->index);
@@ -525,7 +543,7 @@ static struct temp_data *get_temp_data(struct platform_data *pdata, int cpu)
 	if (cpu < 0)
 		return pdata->pkg_data;
 
-	for (i = 0; i < NUM_REAL_CORES; i++) {
+	for (i = 0; i < pdata->nr_cores; i++) {
 		if (pdata->core_data[i] &&
 		    pdata->core_data[i]->cpu_core_id == topology_core_id(cpu))
 			return pdata->core_data[i];
-- 
2.34.1


