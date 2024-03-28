Return-Path: <linux-kernel+bounces-122391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E002288F616
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:56:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ADB62978AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1937163;
	Thu, 28 Mar 2024 03:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSxV0nX2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A35376E1;
	Thu, 28 Mar 2024 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711598153; cv=none; b=nXH1oVcjksHkeRkPGPMzs5idUK4J4KdE8QBfTaP7u+PGmoAc9vJOUNY/izWWT9VvYUIpfazk3vee7k0BzWUjvLdMz1Z1DfrLK03dJIxsVPR8HVg8yfx7FkYJMqhrLqIMi5rTdfUHtx3AFJqBCmN9q+l7oNaedeCacQDW7q7l1qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711598153; c=relaxed/simple;
	bh=8qYAERBQGCHec4afmPtkDK884L7d7FIyHJ2D+fRxMCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jloizku4le0W+l2iZcFrq8O4F+8HGgGWDc3Co3/ZOmPPfvDkfDAl4q5ZC6wS9EkLKtVSOc+EqoVZmnTaIDrDlnDhn1TsWUw8UzVxUI3y6CyzrljG14pctFaW/4x4o+1bA89gNY3Lv2464KGqSxbzhzODnSD6FW5U6QTP0ftfdfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=none smtp.mailfrom=ecsmtp.iind.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSxV0nX2; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ecsmtp.iind.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711598153; x=1743134153;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8qYAERBQGCHec4afmPtkDK884L7d7FIyHJ2D+fRxMCg=;
  b=jSxV0nX2HMNx/6yn11o6BFKmxyd6V16yvmclBY8N/qqa0B7R2qoGba8V
   2at86DC2ZzjAGh+YUfhlO9bSWwypgoGtzPDWemk7KXOx/O5TFLC8espg4
   rRR8uS4VJ7asFZjacJqQ14iIFFYL1OLmZf41GqidE3nhU/mpb3xdf8/jR
   59IhfrlR6pHhNgwQCeix4u0fYfWRFhJMLqaIX+XOitmzktrQ28lggX8yW
   I7bP+3lmueiSEaMggKtci89c1QjWHM2hf4nMx5yV81AmgkuRQ2xBro9nv
   ISMM7V1u87BnQZRPlcDoCDmrto7gxu+jV30HS8Lcu1vLPGrdZ7d4sj5ow
   A==;
X-CSE-ConnectionGUID: Etmf4Zo4Qi622nSkPVldyQ==
X-CSE-MsgGUID: OvyYG85kR4ugjpERKpmHFg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6588840"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6588840"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 20:55:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="16969321"
Received: from inesxmail01.iind.intel.com ([10.223.57.40])
  by orviesa006.jf.intel.com with ESMTP; 27 Mar 2024 20:55:46 -0700
Received: from inlubt0316.iind.intel.com (inlubt0316.iind.intel.com [10.191.20.213])
	by inesxmail01.iind.intel.com (Postfix) with ESMTP id 481261B32F;
	Thu, 28 Mar 2024 09:25:45 +0530 (IST)
Received: by inlubt0316.iind.intel.com (Postfix, from userid 12101951)
	id 443C51600102; Thu, 28 Mar 2024 09:25:45 +0530 (IST)
From: Raag Jadav <raag.jadav@intel.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	robert.moore@intel.com,
	mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	stanislaw.gruszka@linux.intel.com
Cc: linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] ACPI: bus: allow _UID matching for integer zero
Date: Thu, 28 Mar 2024 09:25:40 +0530
Message-Id: <20240328035540.13194-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b2b32a173881 ("ACPI: bus: update acpi_dev_hid_uid_match() to
support multiple types") added _UID matching support for both integer
and string types, which satisfies NULL @uid2 argument for string types
using inversion, but this logic prevents _UID comparision in case the
argument is integer 0, which may result in false positives.

Fix this using _Generic(), which will allow NULL @uid2 argument for
string types as well as _UID matching for all possible integer values.

Fixes: b2b32a173881 ("ACPI: bus: update acpi_dev_hid_uid_match() to support multiple types")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 include/acpi/acpi_bus.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 5de954e2b18a..683458de5a81 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -911,17 +911,19 @@ static inline bool acpi_int_uid_match(struct acpi_device *adev, u64 uid2)
  * acpi_dev_hid_uid_match - Match device by supplied HID and UID
  * @adev: ACPI device to match.
  * @hid2: Hardware ID of the device.
- * @uid2: Unique ID of the device, pass 0 or NULL to not check _UID.
+ * @uid2: Unique ID of the device, pass NULL to not check _UID.
  *
  * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
  * will be treated as a match. If user wants to validate @uid2, it should be
  * done before calling this function.
  *
- * Returns: %true if matches or @uid2 is 0 or NULL, %false otherwise.
+ * Returns: %true if matches or @uid2 is NULL, %false otherwise.
  */
 #define acpi_dev_hid_uid_match(adev, hid2, uid2)			\
 	(acpi_dev_hid_match(adev, hid2) &&				\
-		(!(uid2) || acpi_dev_uid_match(adev, uid2)))
+		/* Differentiate integer 0 from NULL @uid2 */		\
+		(_Generic(uid2,	ACPI_STR_TYPES(!(uid2)), default: 0) ||	\
+		acpi_dev_uid_match(adev, uid2)))
 
 void acpi_dev_clear_dependencies(struct acpi_device *supplier);
 bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
-- 
2.35.3


