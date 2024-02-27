Return-Path: <linux-kernel+bounces-84035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD286A19C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9142908C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE481534E2;
	Tue, 27 Feb 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEasphmp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F6414F991
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 21:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709069107; cv=none; b=FL+i8loLVlCLmSOWJhbXHwWt1z5lOtoEUgikpm6EL2uQ0yVzM35faFD4MDM0Z7Zdo+w1UtMo9yYjUqlMzN7xdHPHmUQYiRRp7+HDjklPfWznewRoFROQVaqlkp7s7T6siNUhH5N59HdSgxQXLZuH57WJKTpqG8pBwyNHUdr8wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709069107; c=relaxed/simple;
	bh=YLm/cL+dHPnuzS6G3vl9X6RCyiyNqBmXpbxGqPOhV1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7Rf9WaDBj4VUmO226/1Zu1P3gsnIIoovjc1LEhDFz4sKS8fWM/iHB6zrcamuKgZB35OsP3Y8d6fBlRwzQMXYVIaEKGem/slL864QwsmQxYTZXjGVA+RTlq6BFb++HVc8ktYJcFckI1Lnf23FYSTzMZsHUKgCIBRGrmRib/5kdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEasphmp; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709069107; x=1740605107;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YLm/cL+dHPnuzS6G3vl9X6RCyiyNqBmXpbxGqPOhV1s=;
  b=MEasphmpA6dV5qLkyxYnitimEcN3wqJ3Lsz7U6G2REvX1j+/Ht8XpcsM
   j3imYxV0v7jOq0rJ/5a+rmSrptWkvwk4y4Zrkikiwqjtr2/jqBPC6oqNB
   j+nDiBbxGnjFhyK5r8N/y26guTIWQaelpnjEHeZMSmKlwHH2PQEezXY1Y
   odRhIxil7nL9MEOXB2l7BsCLjYWEOJUScIcE5IyZDpnWFGcKQQ0wkDDDP
   ziGRqJWCaB2WEpR3EG4+hLR0tTPsqEHBEYvi7/V6PJgsP7h1brOY2sfRI
   w+UussrHbfztuKH73Q1VbVN+M8BfN4h0nihgN/ziaDeO31rmfeSJ86BiC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3566941"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3566941"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 13:25:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032892"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032892"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 13:24:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 0D322537; Tue, 27 Feb 2024 23:24:56 +0200 (EET)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv8 04/17] cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
Date: Tue, 27 Feb 2024 23:24:39 +0200
Message-ID: <20240227212452.3228893-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
References: <20240227212452.3228893-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ACPI MADT doesn't allow to offline CPU after it got woke up.

Currently CPU hotplug is prevented based on the confidential computing
attribute which is set for Intel TDX. But TDX is not the only possible
user of the wake up method.

Disable CPU offlining on ACPI MADT wakeup enumeration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/coco/core.c               |  1 -
 arch/x86/kernel/acpi/madt_wakeup.c |  3 +++
 include/linux/cc_platform.h        | 10 ----------
 kernel/cpu.c                       |  3 +--
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index d07be9d05cd0..19614302e0c4 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -20,7 +20,6 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
 {
 	switch (attr) {
 	case CC_ATTR_GUEST_UNROLL_STRING_IO:
-	case CC_ATTR_HOTPLUG_DISABLED:
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
 	case CC_ATTR_MEM_ENCRYPT:
 		return true;
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index cf79ea6f3007..d222be8d7a07 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 #include <linux/acpi.h>
+#include <linux/cpu.h>
 #include <linux/io.h>
 #include <asm/apic.h>
 #include <asm/barrier.h>
@@ -76,6 +77,8 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_mp_wake_mailbox_paddr = mp_wake->base_address;
 
+	cpu_hotplug_disable_offlining();
+
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 
 	return 0;
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..d08dd65b5c43 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -80,16 +80,6 @@ enum cc_attr {
 	 * using AMD SEV-SNP features.
 	 */
 	CC_ATTR_GUEST_SEV_SNP,
-
-	/**
-	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
-	 *
-	 * The platform/OS is running as a guest/virtual machine does not
-	 * support CPU hotplug feature.
-	 *
-	 * Examples include TDX Guest.
-	 */
-	CC_ATTR_HOTPLUG_DISABLED,
 };
 
 #ifdef CONFIG_ARCH_HAS_CC_PLATFORM
diff --git a/kernel/cpu.c b/kernel/cpu.c
index ac6af196c6f5..dde8e8472897 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1531,8 +1531,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
 	 */
-	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
-	    cpu_hotplug_offline_disabled)
+	if (cpu_hotplug_offline_disabled)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-- 
2.43.0


