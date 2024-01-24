Return-Path: <linux-kernel+bounces-37029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EFE83AA70
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6F031C24441
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334F07A72F;
	Wed, 24 Jan 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIcDMby9"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9447A701
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706101016; cv=none; b=n9Qh7fltNlA1KcnFeiZ7cuu8tj4fFxGIHtLPJQA3O0SSFRw61Qn92Oe5/hi+DAGD02JqSkMDkmUJ+afChrp5hlhbQyonJqfHPjf4toJ9RNKDUSYYzSNX7YJ+xZtjKyFxl59XZMB+TPadzVAGuKImc6k6ZbvhM+qGmxbRVvoTYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706101016; c=relaxed/simple;
	bh=ihRAX/Eyt4LbMVM80nu0CT6hBURKtph1gZYnA+gKNPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHosPko4VgDYY8tvtpPp3r+Q0zyYhBGm9oGxvumoTgp5e3JB8R2kawiHYF4y0y/AHUzbqSQwfrqOj7gKCTfzDCWRd/KuFoMmn5Zv/XBbrqaIhdhySHWTCppcO5OIZnpEQdtqdgVqR3IdRhm2fu1f6LVU6Ss1HH4m6FK5wFCopcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIcDMby9; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706101015; x=1737637015;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ihRAX/Eyt4LbMVM80nu0CT6hBURKtph1gZYnA+gKNPw=;
  b=nIcDMby9lLwUPrmq1QZDnfZsajvs1MiMSURFZR+z1TmW0jeQpHxOke6N
   i3v1lZV9FYcGfmHKUvVLg+4cBoDbcbLiqTRiDuwuj+qS5Tssrb/VDTq+G
   uKmLLRFJkfJWAA7Wbfl2vN31OWOQctwcXmoUcdXhZoLiT+1uOlgIoNRbL
   fPU2ZyRid6ay84ze+zuXMCoX/a/xqZ0ALHY4XGx6dcz5Yh96rYMO+Fv8p
   DRyYil4eeOB7m8ONjkF32GFeGtsuqWFef33SNjhz4AWF/8cyk/O2e+3bE
   j7wb/DgPA1xuLbpH0cDxwW0YmCnS4hR/phPEs7WxjobwDAYHZog0Nc4JA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="466110127"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="466110127"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 04:56:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735924076"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735924076"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2024 04:56:47 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 3F1236A6; Wed, 24 Jan 2024 14:56:02 +0200 (EET)
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
Subject: [PATCHv6 04/16] cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
Date: Wed, 24 Jan 2024 14:55:45 +0200
Message-ID: <20240124125557.493675-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
References: <20240124125557.493675-1-kirill.shutemov@linux.intel.com>
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
index eeec9986570e..f07c3bb7deab 100644
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
index 7c28a07afe8b..3ffdbb1f7bb4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1532,8 +1532,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
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


