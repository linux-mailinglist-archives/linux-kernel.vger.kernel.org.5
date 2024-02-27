Return-Path: <linux-kernel+bounces-83810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7334869ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45A311F23EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA78B149DEF;
	Tue, 27 Feb 2024 18:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HvBrCYbW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8401487DC
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057819; cv=none; b=pCSOpecwxVYbKTQDxQGOdWBmXXJ122SXhisq5kCXllKMbnsA+UlAwMawIaF1HGJsrbyHUikFuxRutubfpoaUeao2Fs83rrOmXzznofU+oc0NHO2CO+AIaeAYLq0GN/nvl3Aq53HyJcWaSCov2ee8uPoMoS7GPHB4xU3xSqfzvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057819; c=relaxed/simple;
	bh=yc+q4KsjIiSfEwY6TeHFKJsFn5r2uXtVujdyv1Did04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQWbGD7sBLaFrJiwIDRUh0t+p5QXeLR+qdDxjdWTdacPYJt/JlM4ig4sf4BFGhtwilWRMezMsAJvlt7p9b5rEuuhKT5R2zVesDU2e9IuJR0712xGdo8oZdwYQ6T2G+LIzbkma+LdZzMlh67EKKCWUOI9V4dvSgCr38FK6xGfQ8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HvBrCYbW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709057817; x=1740593817;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yc+q4KsjIiSfEwY6TeHFKJsFn5r2uXtVujdyv1Did04=;
  b=HvBrCYbW2VVHmRB2bee0lpx1XcOFj9Re3d3deFpAvsUP1UFGsnkqptFl
   8bCummoO31c8ANDVxVC9tw6/vsS/9EJ0MR4tmpE/fgAdC0NfD+y/zL6KD
   t2Nn8rT8tzyCZiROwLi/f16rHr/kFGozReowJi24OTwtELozV3Ct83jSx
   u1MZf9YQGOWASEkoyJwxmGZObpvnjI9UMB4cWX8SxrC1x7sKXSqDKHeLg
   1rceeMFOKGWCyconhV+F9iu5R1sI1O3xQlyyq8Wg6URA+98QcpdpDCNYG
   gMreoOQlNZSoUiygBQfgmJHy4I2F1D8LpgqbgTW4gkKaroWBik6UAyIqR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20966060"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20966060"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 10:16:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032709"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032709"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 10:16:20 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 5D3F8445; Tue, 27 Feb 2024 20:16:19 +0200 (EET)
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
Subject: [PATCHv8 03/16] cpu/hotplug: Add support for declaring CPU offlining not supported
Date: Tue, 27 Feb 2024 20:16:03 +0200
Message-ID: <20240227181616.3032032-4-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227181616.3032032-1-kirill.shutemov@linux.intel.com>
References: <20240227181616.3032032-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ACPI MADT mailbox wakeup method doesn't allow to offline CPU after
it got woke up.

Currently offlining hotplug is prevented based on the confidential
computing attribute which is set for Intel TDX. But TDX is not
the only possible user of the wake up method. The MADT wakeup can be
implemented outside of a confidential computing environment. Offline
support is a property of the wakeup method, not the CoCo implementation.

Introduce cpu_hotplug_disable_offlining() that can be called to indicate
that CPU offlining should be disabled.

This function is going to replace CC_ATTR_HOTPLUG_DISABLED for ACPI
MADT wakeup method.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/cpu.h |  2 ++
 kernel/cpu.c        | 13 ++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index dcb89c987164..aa89ef93a884 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -139,6 +139,7 @@ extern void cpus_read_lock(void);
 extern void cpus_read_unlock(void);
 extern int  cpus_read_trylock(void);
 extern void lockdep_assert_cpus_held(void);
+extern void cpu_hotplug_disable_offlining(void);
 extern void cpu_hotplug_disable(void);
 extern void cpu_hotplug_enable(void);
 void clear_tasks_mm_cpumask(int cpu);
@@ -154,6 +155,7 @@ static inline void cpus_read_lock(void) { }
 static inline void cpus_read_unlock(void) { }
 static inline int  cpus_read_trylock(void) { return true; }
 static inline void lockdep_assert_cpus_held(void) { }
+static inline void cpu_hotplug_disable_offlining(void) { }
 static inline void cpu_hotplug_disable(void) { }
 static inline void cpu_hotplug_enable(void) { }
 static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba4950b..7c28a07afe8b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -484,6 +484,8 @@ static int cpu_hotplug_disabled;
 
 DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
 
+static bool cpu_hotplug_offline_disabled __ro_after_init;
+
 void cpus_read_lock(void)
 {
 	percpu_down_read(&cpu_hotplug_lock);
@@ -543,6 +545,14 @@ static void lockdep_release_cpus_lock(void)
 	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
 }
 
+/* Declare CPU offlining not supported */
+void cpu_hotplug_disable_offlining(void)
+{
+	cpu_maps_update_begin();
+	cpu_hotplug_offline_disabled = true;
+	cpu_maps_update_done();
+}
+
 /*
  * Wait for currently running CPU hotplug operations to complete (if any) and
  * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
@@ -1522,7 +1532,8 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
 	 * If the platform does not support hotplug, report it explicitly to
 	 * differentiate it from a transient offlining failure.
 	 */
-	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
+	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) ||
+	    cpu_hotplug_offline_disabled)
 		return -EOPNOTSUPP;
 	if (cpu_hotplug_disabled)
 		return -EBUSY;
-- 
2.43.0


