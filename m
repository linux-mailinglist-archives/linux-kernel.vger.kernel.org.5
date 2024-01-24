Return-Path: <linux-kernel+bounces-37628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3E183B2CD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E9E1C210C8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA60413474B;
	Wed, 24 Jan 2024 20:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i2h/fuDS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEC13343B;
	Wed, 24 Jan 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126667; cv=none; b=cqzUdayesjZoRL9jM1tBTKim0Qgg/3QrPAU42H6TUvXCv/oaIMZd6s21opCdGFq+o8AwBfzuX142H6CW19orVYY8GmEe1XZUS8Zgx+sFDHjiwZRrrut2GMRB9NIx33MPARV20L17bNzX1rRamFaWi5usrCiMntdTEUoe5bJyfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126667; c=relaxed/simple;
	bh=Orl+mZtfo3P92OAi6zjw0XQv4aRvq83sE++FPaqZvSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NlSBHs3WoZptY9kH1m9RDNdzWyzlzMxQkK169yXvKl6IiQuLEh6ePqhO7sDHHoFwiB4bEONEhqiDEyf7n5gEAAKUGZcPliV8XY3sm0Rtt4vYHYad67LVDyckqRJ4YncKiAL8evZgOTFs0CiwWcRk2ZKoj5YzeDz2R6WMMdEkivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i2h/fuDS; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706126666; x=1737662666;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Orl+mZtfo3P92OAi6zjw0XQv4aRvq83sE++FPaqZvSw=;
  b=i2h/fuDSRF3uCSPubHrtZSvLnFwlls3u+9Q97D/gz4IRJC26HrrAL6t/
   xh2bObi3s4WjpnAghv9lww6hWaQRe5HKxlNu+rQlwxJ0JQanRij5lysyU
   6H4fdfpBHQnQzIC5GA6rGr3K784ZD4xQJjmLIV3wQ8k4Ltjn7ZA82H0jX
   r39CJWNB+vYByd/5KmLh7a0t14+0KUA/n95AP0St3VS/pkYW9gACVOhY4
   kg4bPpzPAX0PKpDEqNvOqh5BjBpN5GL4CxBdzFRiK2li3Df8D51KDuZLD
   5xkwKcNsV4bzyMKaRoAIwqfTaN4zA9kG91JvtQLs3LL5t2ZGdd8n22HTy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1836117"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1836117"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117735142"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117735142"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.0.0.223]) ([10.251.14.61])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:23 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Wed, 24 Jan 2024 12:03:49 -0800
Subject: [PATCH v7 4/5] mm/memory_hotplug: export
 mhp_supports_memmap_on_memory()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-vv-dax_abi-v7-4-20d16cb8d23d@intel.com>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
In-Reply-To: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Huang Ying <ying.huang@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, 
 Michal Hocko <mhocko@suse.com>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4673;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=Orl+mZtfo3P92OAi6zjw0XQv4aRvq83sE++FPaqZvSw=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKkbc523Ta9vOi09a3bGqYv8n6JOx6T18S1boOA25RJ7L
 P+fjzrKHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZjItkpGhoPKq2Z5afNceV/D
 XRrhep3dROdqhKT6hrTy71VRU+ReCTIybOX1yTxzjmHHz5CFdRe+Lru4J7D9BkOBr/zmL9+PJae
 u5AIA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

In preparation for adding sysfs ABI to toggle memmap_on_memory semantics
for drivers adding memory, export the mhp_supports_memmap_on_memory()
helper. This allows drivers to check if memmap_on_memory support is
available before trying to request it, and display an appropriate
message if it isn't available. As part of this, remove the size argument
to this - with recent updates to allow memmap_on_memory for larger
ranges, and the internal splitting of altmaps into respective memory
blocks, the size argument is meaningless.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 include/linux/memory_hotplug.h |  6 ++++++
 mm/memory_hotplug.c            | 17 ++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7d2076583494..ebc9d528f00c 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -121,6 +121,7 @@ struct mhp_params {
 
 bool mhp_range_allowed(u64 start, u64 size, bool need_mapping);
 struct range mhp_get_pluggable_range(bool need_mapping);
+bool mhp_supports_memmap_on_memory(void);
 
 /*
  * Zone resizing functions
@@ -262,6 +263,11 @@ static inline bool movable_node_is_enabled(void)
 	return false;
 }
 
+static bool mhp_supports_memmap_on_memory(void)
+{
+	return false;
+}
+
 static inline void pgdat_kswapd_lock(pg_data_t *pgdat) {}
 static inline void pgdat_kswapd_unlock(pg_data_t *pgdat) {}
 static inline void pgdat_kswapd_lock_init(pg_data_t *pgdat) {}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 21890994c1d3..065fb4804f1b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1328,7 +1328,7 @@ static inline bool arch_supports_memmap_on_memory(unsigned long vmemmap_size)
 }
 #endif
 
-static bool mhp_supports_memmap_on_memory(unsigned long size)
+bool mhp_supports_memmap_on_memory(void)
 {
 	unsigned long vmemmap_size = memory_block_memmap_size();
 	unsigned long memmap_pages = memory_block_memmap_on_memory_pages();
@@ -1337,17 +1337,11 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
 	 * Besides having arch support and the feature enabled at runtime, we
 	 * need a few more assumptions to hold true:
 	 *
-	 * a) We span a single memory block: memory onlining/offlinin;g happens
-	 *    in memory block granularity. We don't want the vmemmap of online
-	 *    memory blocks to reside on offline memory blocks. In the future,
-	 *    we might want to support variable-sized memory blocks to make the
-	 *    feature more versatile.
-	 *
-	 * b) The vmemmap pages span complete PMDs: We don't want vmemmap code
+	 * a) The vmemmap pages span complete PMDs: We don't want vmemmap code
 	 *    to populate memory from the altmap for unrelated parts (i.e.,
 	 *    other memory blocks)
 	 *
-	 * c) The vmemmap pages (and thereby the pages that will be exposed to
+	 * b) The vmemmap pages (and thereby the pages that will be exposed to
 	 *    the buddy) have to cover full pageblocks: memory onlining/offlining
 	 *    code requires applicable ranges to be page-aligned, for example, to
 	 *    set the migratetypes properly.
@@ -1359,7 +1353,7 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       altmap as an alternative source of memory, and we do not exactly
 	 *       populate a single PMD.
 	 */
-	if (!mhp_memmap_on_memory() || size != memory_block_size_bytes())
+	if (!mhp_memmap_on_memory())
 		return false;
 
 	/*
@@ -1382,6 +1376,7 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
 
 	return arch_supports_memmap_on_memory(vmemmap_size);
 }
+EXPORT_SYMBOL_GPL(mhp_supports_memmap_on_memory);
 
 static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size)
 {
@@ -1515,7 +1510,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	 * Self hosted memmap array
 	 */
 	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
-	    mhp_supports_memmap_on_memory(memory_block_size_bytes())) {
+	    mhp_supports_memmap_on_memory()) {
 		ret = create_altmaps_and_memory_blocks(nid, group, start, size);
 		if (ret)
 			goto error;

-- 
2.43.0


