Return-Path: <linux-kernel+bounces-161088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735238B46E1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 928D0B21B60
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4488223773;
	Sat, 27 Apr 2024 15:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ATOhBJnQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B6423754
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 15:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714232206; cv=none; b=rZfeWvnzOlipFTXb1dPhwhfGrsXo+oHIkLeDiKCfmqqoH+9u83QPoKSav8rhpk0h5Ko7oM1i3SJb0QkY5z43isHTRVC5ZGKJvB1KdtoJA6thi/T6FQzzMfG1Gm4IcvYXlxMRFMfZ79mfWte7nHPazJfrBKoRFYD/XGhsWmiU4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714232206; c=relaxed/simple;
	bh=QvvwWBNqoAXlcyc8Mrt+poDwsuRiznaC8ZjgxNmzvcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M378YXEMi3bzyuCUb6pjz+afjSBeaZFCeaIPsGOvH1J3gMkWkdXSIu+1f0Uzo44SRjPG5CU8ZRGhyMuIaYup5e2YJs28MoVGGej3Pama81dZjPuCR7urGu3npNagTDynM2RoTkvMmtZwO6mITC0OLxSAUq9KsDoNNo5huYMQD/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ATOhBJnQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714232205; x=1745768205;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QvvwWBNqoAXlcyc8Mrt+poDwsuRiznaC8ZjgxNmzvcw=;
  b=ATOhBJnQm00jHVRbpys5C6iMFC3ztAN/BDWpmTNyX9ABP89pe3osJoeo
   WRVIWxfEInWRnf3lfaNmksekFJpT4vOsCJjEPOFtw0aXAa/PB+0hx3a17
   nYMkeMEktazS2s7i2Ms7/aRdCDYrLy78z5NkhIdIX8/oHdUUUBbBHLXvA
   aK5ivJpmJNdQjHruG++ucCjToBDiWig2mhdf1zQtVYGRL3GlCf6SfIdpI
   d/0bprRN1tREzjkyTTobGtJWTa8bDwMu7h/gH59fmXHE8xApHY963ZbUT
   HwNDuQuaRIPXPG0GTx0dLTl/MCjkhCKKpWv3VW13TBoHl1EIyCPY5RdAn
   w==;
X-CSE-ConnectionGUID: BcvWLBcLTku9z0JtnjzwKA==
X-CSE-MsgGUID: //8I4i3wQBaQWx7UE1eeGw==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="20637465"
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="20637465"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2024 08:36:45 -0700
X-CSE-ConnectionGUID: QbKQmH1dQeitGx4Nz1VKcw==
X-CSE-MsgGUID: rRSYTyl5QHWqvEn/1L6Wxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,235,1708416000"; 
   d="scan'208";a="30505871"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 27 Apr 2024 08:36:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id C549A118; Sat, 27 Apr 2024 18:36:37 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: bp@alien8.de
Cc: adrian.hunter@intel.com,
	ashish.kalra@amd.com,
	bhe@redhat.com,
	dave.hansen@intel.com,
	dave.hansen@linux.intel.com,
	elena.reshetova@intel.com,
	jun.nakajima@intel.com,
	kai.huang@intel.com,
	kexec@lists.infradead.org,
	kirill.shutemov@linux.intel.com,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	ltao@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rafael@kernel.org,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	seanjc@google.com,
	tglx@linutronix.de,
	thomas.lendacky@amd.com,
	x86@kernel.org
Subject: [PATCHv10.1 04/18] cpu/hotplug, x86/acpi: Disable CPU offlining for ACPI MADT wakeup
Date: Sat, 27 Apr 2024 18:36:32 +0300
Message-ID: <20240427153633.2368480-1-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240424145122.GEZikcaiqFT_eG1KDo@fat_crate.local>
References: <20240424145122.GEZikcaiqFT_eG1KDo@fat_crate.local>
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
user of the wake up method. Any platform that uses ACPI MADT wakeup
method cannot offline CPU.

Disable CPU offlining on ACPI MADT wakeup enumeration.

The change has no visible effects for users: currently, TDX guest is the
only platform that uses the ACPI MADT wakeup method.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tao Liu <ltao@redhat.com>
---

  v10.1:
    - Update commit message.

---
 arch/x86/coco/core.c               |  1 -
 arch/x86/kernel/acpi/madt_wakeup.c |  3 +++
 include/linux/cc_platform.h        | 10 ----------
 kernel/cpu.c                       |  3 +--
 4 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index b31ef2424d19..0f81f70aca82 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -29,7 +29,6 @@ static bool noinstr intel_cc_platform_has(enum cc_attr attr)
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
index 60693a145894..caa4b4430634 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -81,16 +81,6 @@ enum cc_attr {
 	 */
 	CC_ATTR_GUEST_SEV_SNP,
 
-	/**
-	 * @CC_ATTR_HOTPLUG_DISABLED: Hotplug is not supported or disabled.
-	 *
-	 * The platform/OS is running as a guest/virtual machine does not
-	 * support CPU hotplug feature.
-	 *
-	 * Examples include TDX Guest.
-	 */
-	CC_ATTR_HOTPLUG_DISABLED,
-
 	/**
 	 * @CC_ATTR_HOST_SEV_SNP: AMD SNP enabled on the host.
 	 *
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6e1a9157d09c..09765f628b8b 100644
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


