Return-Path: <linux-kernel+bounces-116850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE12E88A492
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689A12E0A29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0D814A094;
	Mon, 25 Mar 2024 11:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCMpHjJt"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BD4149C73
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363213; cv=none; b=hYaCD0iZiq+tQjiNOE6I+Dig5h/gEyLOz7qGTajc5Zk+SKCznvkx2Ktlv5Oj1Ke7pRBMXUs0lvyEFYpDqcYFTJw00kq4xEiLkFo9Tont+ullg9thHIKjGmHAjjenkpy0M4V7ZZQxLPdMa5CsFURndXBfxTJOMDKk2Ea31TmE75c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363213; c=relaxed/simple;
	bh=hh1ZFNCawXsWZU17nvbUwHOUKoxz/TVwWlfNy5iz5SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A74MOMiFZdi4BX88yPFvsIzu8FMg9QvZJhabGXn1+DvtGhvysB1CyGvXvn8bxG7NuN548wdHh1EC8ocE8YKMV71bhviCetrPL1vO8u+yVZfO/gu8tAjzVFMVv76r8mE286F5sDcGCNYVTuYgrZYrvdYZJIAaHt4qp103h5jGgJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCMpHjJt; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363212; x=1742899212;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hh1ZFNCawXsWZU17nvbUwHOUKoxz/TVwWlfNy5iz5SE=;
  b=iCMpHjJt9k/zIHI+gIDcz7kbOLtQzhLNXGHnFGhXTvsUKdh8UM9hEBTP
   EJAQHzfhZnMqKmqHVKksI6VYSENECpHZXROeSy89RecQtB6h/TizYAPr+
   IFAUwOUfOdJKk5lPx8L7gBqRU4lw77IzHwaiYuKj2SGpVVydJKBTQ95gi
   V8heSUaStmVN2f0+kiolcStmGsyLOxrB++Bj+q8WH/AgCeU8P1bEB1nZj
   dMJrzQ1fU0v3tazcg+Q8oNNeGEdAR3rwv2G2uJDXqFwWwoopHXhj2ZRMM
   UTZkNlePsQDUwUhtWN3Pq8PYh3Dt2hPyoVcE9G+JiCJwXgHM+o4zaEV/k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6561300"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6561300"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070129"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070129"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:40:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 082DB524; Mon, 25 Mar 2024 12:40:05 +0200 (EET)
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
Subject: [PATCHv9 04/17] cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
Date: Mon, 25 Mar 2024 12:38:58 +0200
Message-ID: <20240325103911.2651793-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
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
index 08860baa6ce0..a70767aee9d0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1528,8 +1528,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
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


