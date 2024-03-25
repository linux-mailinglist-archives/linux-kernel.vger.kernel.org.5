Return-Path: <linux-kernel+bounces-116859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D58988AB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45609C01CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAD01BDB95;
	Mon, 25 Mar 2024 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YvXNPEFI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FD5149C7D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363220; cv=none; b=NspWBxkvi72lVVwf0NbOc9V5qLu9uTbqi80AteNnBgack820LD2gOIkXgyI7kCUP0sYKoo43ce52zCiwnRxR7X10duNXPZar8G5/Dvf1XxQvNTI2Lc9KHT1uqWgwELoo9oPsjgc2IpzDeQsbBpe/pl/9Ue4vjvv98yTOQ6SRjTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363220; c=relaxed/simple;
	bh=afEHAj6Ona/U1R3Hzh9Y6aqHqs5rMx6ECTCC4WyRrfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr0etIqh4GC60rnrD51lBjIklwWAM9WlmhkKDqQAUTN/ftBIFI24UqO3EZhfmgoWzRwTybpTVS0nLl8ne+IzCsZ9G4ZQYE0xSOx6kApuEiIStCLz2A/H5w2tQAmdzdovTTl+VgAnSYI0suibxg2eDAqXnXNe3QFybObuJDh99P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YvXNPEFI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711363218; x=1742899218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=afEHAj6Ona/U1R3Hzh9Y6aqHqs5rMx6ECTCC4WyRrfQ=;
  b=YvXNPEFIidDlKBr1pu6fAXOLEgtu0Hmw3x26P4nClEU/E+w2FMnhpYej
   k/snlZQHg/Zo2RqpK/LXpPaBVjV0MqgLwWLSfzv1UL7XK2A5IG9dwm6oV
   BBMIx/GVu3I4APgXACacvY+4TND2w4MPZQ0xH4LJswOafzrL8owvhg9ac
   jeZXixOGrhlQfiE8a6eCnPwpPQ+qtE1banM0Cn4yIlbCNIFPSflcHP6gj
   nL6esOzOzO7ca3a5m0aRKSmdXvJX9jedq6i8yO60VWWYLLb47pfA+vuHU
   mz4au6QEyjhhHuKTJo72dLPvlvSPXRwrHJKwglRcQn1sWpbF09Af40R5s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6561397"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6561397"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 03:40:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="937070157"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="937070157"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2024 03:40:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id A40251026; Mon, 25 Mar 2024 12:40:05 +0200 (EET)
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
Subject: [PATCHv9 14/17] x86/smp: Add smp_ops.stop_this_cpu() callback
Date: Mon, 25 Mar 2024 12:39:08 +0200
Message-ID: <20240325103911.2651793-15-kirill.shutemov@linux.intel.com>
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

If the helper is defined, it is called instead of halt() to stop the CPU
at the end of stop_this_cpu() and on crash CPU shutdown.

ACPI MADT will use it to hand over the CPU to BIOS in order to be able
to wake it up again after kexec.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/smp.h | 1 +
 arch/x86/kernel/process.c  | 7 +++++++
 arch/x86/kernel/reboot.c   | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index a35936b512fe..ca073f40698f 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -35,6 +35,7 @@ struct smp_ops {
 	int (*cpu_disable)(void);
 	void (*cpu_die)(unsigned int cpu);
 	void (*play_dead)(void);
+	void (*stop_this_cpu)(void);
 
 	void (*send_call_func_ipi)(const struct cpumask *mask);
 	void (*send_call_func_single_ipi)(int cpu);
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b8441147eb5e..f63f8fd00a91 100644
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
index 1ec478f40963..293ded05a4b0 100644
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


