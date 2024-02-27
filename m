Return-Path: <linux-kernel+bounces-83819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0D4869EDD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBF791F2B8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039C4150994;
	Tue, 27 Feb 2024 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iv/t1Yqr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF514E2C8
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057826; cv=none; b=o+gKiUBBIL4037CcsTmSLz7l0eVtncKzmm42fcsSz9LYvmFioZwNgW48nIgWctgqnyePrA32A7pnTOIY87x1shxpwIZ2TEopPjHEZQzpb2aN2LGucBLBCr9CxAG5RH1ZEKBc8ZAPw2zcDifKtuccENxDxY8knJ3QNM4NwIimhmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057826; c=relaxed/simple;
	bh=urUcJtKDz0udsDAvAz2j1S+q/fX/vhzTd+7x3OIZGzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cqg2V+AlFHUbZd4FoDbqu27yloI7j3hQSqbOtcdZvKcqj8rhk7AiKGoTAudQ3IykomPD/lPpNcLotSP3KKV8CiXo+IJALQSDToqCsjFJo8s5H1ITDl29tbCnNFmzJN+EisBQj3DhqNz30U5le9iYVSjT1JS7oc1kqZHNows6yHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iv/t1Yqr; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709057824; x=1740593824;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=urUcJtKDz0udsDAvAz2j1S+q/fX/vhzTd+7x3OIZGzI=;
  b=iv/t1Yqr8vjqwHXgbP6YiVZvWoocZbti5avJSr6vgrjvPWjYW3YAdzmn
   HoDPl9Jailvai/ltb0RI6Ou2fJ3S9fVmsWD7UKqalWr/GPJHAFe8KXw0V
   VNPEvBUVr9Fp5FWyJPANCik50vOQ3mi5pzpfJsjUy6vNV+jf0IABs+/NW
   LPOrpHVWKu5E1eslfrRbH7wwX5TcZpXBjy+6O3OfTZZC/akDdlxy7dMIE
   +2cowM/yNBbhHqPf6ftN3nTJzpNQudRjT2FKrgewdm+QVPkFMDvnVIFGY
   a5moE6S1XVD8wqNzHOpKRb7HAQC7SHBfIj0/7af/dm9SOaLYlgvuAdZmd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20966170"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="20966170"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 10:16:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="937032740"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="937032740"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Feb 2024 10:16:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id EE59BA97; Tue, 27 Feb 2024 20:16:19 +0200 (EET)
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
Subject: [PATCHv8 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Date: Tue, 27 Feb 2024 20:16:14 +0200
Message-ID: <20240227181616.3032032-15-kirill.shutemov@linux.intel.com>
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

If the helper is defined, it is called instead of halt() to stop the CPU
at the end of stop_this_cpu() and on crash CPU shutdown.

ACPI MADT will use it to hand over the CPU to BIOS in order to be able
to wake it up again after kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/include/asm/smp.h | 1 +
 arch/x86/kernel/process.c  | 7 +++++++
 arch/x86/kernel/reboot.c   | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 4fab2ed454f3..390d53fd34f9 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -38,6 +38,7 @@ struct smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
+	void (*stop_this_cpu)(void);
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade31b0d..00c1b957476d 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -835,6 +835,13 @@ void __noreturn stop_this_cpu(void *dummy)
 	 */
 	cpumask_clear_cpu(cpu, &cpus_stop_mask);
 
+#ifdef CONFIG_SMP
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+#endif
+
 	for (;;) {
 		/*
 		 * Use native_halt() so that memory contents don't change
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0574d4ad6b41..0a75efe579c0 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -880,6 +880,12 @@ static int crash_nmi_callback(unsigned int val, struct pt_regs *regs)
 	cpu_emergency_disable_virtualization();
 
 	atomic_dec(&waiting_for_crash_ipi);
+
+	if (smp_ops.stop_this_cpu) {
+		smp_ops.stop_this_cpu();
+		unreachable();
+	}
+
 	/* Assume hlt works */
 	halt();
 	for (;;)
-- 
2.43.0


