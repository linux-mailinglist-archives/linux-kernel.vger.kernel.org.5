Return-Path: <linux-kernel+bounces-131865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1DD898CDA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D94E1C20EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9824012AAD6;
	Thu,  4 Apr 2024 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mGqfDqoQ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A2E1C6AF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250026; cv=none; b=LhqegiwWAq+aY4Mx3kK96k1JW/VKjYnO3N0+Ey3fzWGQ/vp14X5n2AAY9k1b9d3YSTMlo2lC7yqzIxNMJkuELkjtqsJaItxXWby2RwWDT5xBnvnJ5iwPMMI0PCx/5r7kXOMUjpdfPtCRrXRU9tqsMGJAd7BelLiWbOPCs3Fai+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250026; c=relaxed/simple;
	bh=BC4stwRnuZ8B9nod5blwzf4F2iZ6G+Mch86v9r92YKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XgDCmrLZgSlqQ/ii/ri2V7gZM5Ux4gIsiz5Mu+ozORF5ZhcQxlvTma6pR7FlN6SCXRbuLVhaPuYzXEzWuWAKjtpWifB0GJYHdUOFCbggeAricajQOJ2I6vOc8/eE0oaLWQRBapLq/JIhhyUjTzPPJCYRy6CySAmar3qIrJjlJ/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mGqfDqoQ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712250025; x=1743786025;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BC4stwRnuZ8B9nod5blwzf4F2iZ6G+Mch86v9r92YKU=;
  b=mGqfDqoQlM10WFxrZCFexHwQ+3ETKTREcNk1ynJya8xVyDEiv8/BOmZO
   PhcmK+1Lv/TxAiB7h474xSa8m/+k40+a9zrrYJh13W/4OEtd1xvC4eLZx
   aoMafmPimWHOkJ2VWky3kG5F+Hh0VFq0w+FZp0BH7JtFD2y5rWI+w9zV3
   /RrWhuptnvkLtxZzEBkkWocrzpFHJE9kYOf0WJWFc35AGeDU44+QbY6Rr
   61EQBKjwYntm4xSluZ5XlOP7GmZkC+/19owqr8NLiDkMNGkX5Ab7uWN3Y
   GZYrLsq0GVxWdciucgakzRYXB0F4UK2WpjGRrS8SDIwFavpqzedhX5V1r
   w==;
X-CSE-ConnectionGUID: qtexuKQAS2mwumHqQMP3cA==
X-CSE-MsgGUID: ij2C4s7LR5eKeL26uFp8Xg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18986167"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="18986167"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 10:00:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="937086879"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="937086879"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 04 Apr 2024 10:00:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id EFFC3812; Thu,  4 Apr 2024 20:00:21 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 1/1] drivers/perf: thunderx2_pmu: Replace open coded acpi_match_acpi_device()
Date: Thu,  4 Apr 2024 19:59:23 +0300
Message-ID: <20240404170016.2466898-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace open coded acpi_match_acpi_device() in get_tx2_pmu_type().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2:
switched to acpi_match_acpi_device() which is newer API suitable for this case

 drivers/perf/thunderx2_pmu.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/perf/thunderx2_pmu.c b/drivers/perf/thunderx2_pmu.c
index e16d10c763de..f03aa85072ec 100644
--- a/drivers/perf/thunderx2_pmu.c
+++ b/drivers/perf/thunderx2_pmu.c
@@ -504,24 +504,19 @@ static void tx2_uncore_event_update(struct perf_event *event)
 
 static enum tx2_uncore_type get_tx2_pmu_type(struct acpi_device *adev)
 {
-	int i = 0;
-	struct acpi_tx2_pmu_device {
-		__u8 id[ACPI_ID_LEN];
-		enum tx2_uncore_type type;
-	} devices[] = {
+	struct acpi_device_id devices[] = {
 		{"CAV901D", PMU_TYPE_L3C},
 		{"CAV901F", PMU_TYPE_DMC},
 		{"CAV901E", PMU_TYPE_CCPI2},
-		{"", PMU_TYPE_INVALID}
+		{}
 	};
+	const struct acpi_device_id *id;
 
-	while (devices[i].type != PMU_TYPE_INVALID) {
-		if (!strcmp(acpi_device_hid(adev), devices[i].id))
-			break;
-		i++;
-	}
+	id = acpi_match_acpi_device(devices, adev);
+	if (!id)
+		return PMU_TYPE_INVALID;
 
-	return devices[i].type;
+	return (enum tx2_uncore_type)id->driver_data;
 }
 
 static bool tx2_uncore_validate_event(struct pmu *pmu,
-- 
2.43.0.rc1.1.gbec44491f096


