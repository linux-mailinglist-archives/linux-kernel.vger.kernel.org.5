Return-Path: <linux-kernel+bounces-46352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A3E843E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219E81C24996
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B547762C;
	Wed, 31 Jan 2024 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7Jz/XYa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FEB77F2C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706700740; cv=none; b=iONQAaSdkgpEBQIDxJDdAjw0vISHebSe9rYhPHNmyVXnqQypVsrToe7m6/s4M6CQtVyUfFryKtlD7+QDr71O+nzI2WpC+sMyIqtvR47pdmLMUUxVBT4UTnTqHpMLimg+qEBPgwViLIvdgica2iJf5sm1C94JmkrGDG2gPeQ4jTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706700740; c=relaxed/simple;
	bh=3ayy1GCfAP4s1+4FRo5mCAe8slIxZjOZp22vN+iG2s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDhovmJIGyLJ+k7qRgGheGdsSSJES+Z4XevF3I02vzscfEYO+hEvZPp1OvLBF5yppXN8I3fgrzV87zCJVls6ZFK7fbxSi0VEsO9JWQhmSMdtMrZUeHEzWexSSALny5FQd0O0qqf9sXmXeHMw/b/5nYuNB62MRwUTrhvA93JZrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7Jz/XYa; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706700732; x=1738236732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ayy1GCfAP4s1+4FRo5mCAe8slIxZjOZp22vN+iG2s8=;
  b=G7Jz/XYadVTwCVWPk8W01x6k/ZxuyEkD8kkZYUirj5zOy2Bx+9zpkdQS
   U+U+Tunp/V7rJWE88qo3LmunydS1gtV9lKW45+zo5XvgbrL/DW7L684yb
   TeWjCflePJDJ7yR4dX4PiT0+o00PbZaWWYlaKjHKyBTzJVECAnBRQGEww
   njIlB8BLVXBPQ5Jg0QinL0tfh7oHIaCyOpvIbjtmXuSHclE1O8jK2G48o
   ZCbXbWZUaPZFhZqYe8NCxwDjvxRxo+ZXxgZUtbkbsnB4KwsDtsn2JfzQv
   GPk1hTb2BBw2QWgYKNqWce2VrxpyOwqJIvESiHpTejKVeAfaz75NE+JWz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3414163"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3414163"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878764791"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="878764791"
Received: from server.sh.intel.com ([10.239.53.117])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 03:32:06 -0800
From: "Huang, Kai" <kai.huang@intel.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	dave.hansen@intel.com,
	kirill.shutemov@linux.intel.com,
	tglx@linutronix.de,
	bp@alien8.de,
	mingo@redhat.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	thomas.lendacky@amd.com,
	chao.gao@intel.com,
	bhe@redhat.com,
	nik.borisov@suse.com,
	pbonzini@redhat.com
Subject: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush during kexec
Date: Wed, 31 Jan 2024 11:31:53 +0000
Message-Id: <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706698706.git.kai.huang@intel.com>
References: <cover.1706698706.git.kai.huang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kai Huang <kai.huang@intel.com>

Currently on AMD SME platforms, during kexec() caches are flushed
manually before jumping to the new kernel due to memory encryption.
Intel TDX needs to flush cachelines of TDX private memory before
jumping to the second kernel too, otherwise they may silently corrupt
the new kernel.

Instead of sprinkling both AMD and Intel's specific checks around,
introduce a new CC_ATTR_HOST_MEM_INCOHERENT attribute to unify both
Intel and AMD, and simplify the logic:

	Could the old kernel leave incoherent caches around?
	If so, do WBINVD.

Convert the AMD SME to use this new CC attribute.  A later patch will
utilize this new attribute for Intel TDX too.

Specifically, AMD SME flushes caches at two places: 1) stop_this_cpu();
2) relocate_kernel().  stop_this_cpu() checks the CPUID directly to do
WBINVD for the reason that the current kernel's SME enabling status may
not match the new kernel's choice.  However the relocate_kernel() only
does the WBINVD when the current kernel has enabled SME for the reason
that the new kernel is always placed in an "unencrypted" area.

To simplify the logic, for AMD SME change to always use the way that is
done in stop_this_cpu().  This will cause an additional WBINVD in
relocate_kernel() when the current kernel hasn't enabled SME (e.g.,
disabled by kernel command line), but this is acceptable for the sake of
having less complicated code (see [1] for the relevant discussion).

Note currently the kernel only advertises CC vendor for AMD SME when SME
is actually enabled by the kernel.  To always advertise the new
CC_ATTR_HOST_MEM_INCOHERENT regardless of the kernel's SME enabling
status, change to set CC vendor as long as the hardware has enabled SME.

Note "advertising CC_ATTR_HOST_MEM_INCOHERENT when the hardware has
enabled SME" is still different from "checking the CPUID" (the way that
is done in stop_this_cpu()), but technically the former also serves the
purpose and is actually more accurate.

Such change allows sme_me_mask to be 0 while CC vendor reports as AMD.
But this doesn't impact other CC attributes on AMD platforms, nor does
it impact the cc_mkdec()/cc_mkenc().

[1] https://lore.kernel.org/lkml/cbc9c527-17e5-4a63-80fe-85451394cc7c@amd.com/

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Kai Huang <kai.huang@intel.com>
---
 arch/x86/coco/core.c               | 13 +++++++++++++
 arch/x86/kernel/machine_kexec_64.c |  2 +-
 arch/x86/kernel/process.c          | 14 +++-----------
 arch/x86/mm/mem_encrypt_identity.c | 11 ++++++++++-
 include/linux/cc_platform.h        | 15 +++++++++++++++
 5 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/arch/x86/coco/core.c b/arch/x86/coco/core.c
index eeec9986570e..8d6d727e6e18 100644
--- a/arch/x86/coco/core.c
+++ b/arch/x86/coco/core.c
@@ -72,6 +72,19 @@ static bool noinstr amd_cc_platform_has(enum cc_attr attr)
 	case CC_ATTR_HOST_MEM_ENCRYPT:
 		return sme_me_mask && !(sev_status & MSR_AMD64_SEV_ENABLED);
 
+	case CC_ATTR_HOST_MEM_INCOHERENT:
+		/*
+		 * CC_ATTR_HOST_MEM_INCOHERENT represents whether SME has
+		 * enabled on the platform regardless whether the kernel
+		 * has actually enabled the SME.
+		 */
+		return !(sev_status & MSR_AMD64_SEV_ENABLED);
+
+	/*
+	 * For all CC_ATTR_GUEST_* there's no need to check sme_me_mask
+	 * as it must be true when there's any SEV enable bit set in
+	 * sev_status.
+	 */
 	case CC_ATTR_GUEST_MEM_ENCRYPT:
 		return sev_status & MSR_AMD64_SEV_ENABLED;
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index bc0a5348b4a6..c9c6974e2e9c 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -358,7 +358,7 @@ void machine_kexec(struct kimage *image)
 				       (unsigned long)page_list,
 				       image->start,
 				       image->preserve_context,
-				       cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT));
+				       cc_platform_has(CC_ATTR_HOST_MEM_INCOHERENT));
 
 #ifdef CONFIG_KEXEC_JUMP
 	if (image->preserve_context)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index ab49ade31b0d..2c7e8d9889c0 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -813,18 +813,10 @@ void __noreturn stop_this_cpu(void *dummy)
 	mcheck_cpu_clear(c);
 
 	/*
-	 * Use wbinvd on processors that support SME. This provides support
-	 * for performing a successful kexec when going from SME inactive
-	 * to SME active (or vice-versa). The cache must be cleared so that
-	 * if there are entries with the same physical address, both with and
-	 * without the encryption bit, they don't race each other when flushed
-	 * and potentially end up with the wrong entry being committed to
-	 * memory.
-	 *
-	 * Test the CPUID bit directly because the machine might've cleared
-	 * X86_FEATURE_SME due to cmdline options.
+	 * Use wbinvd on processors that the first kernel *could*
+	 * potentially leave incoherent cachelines.
 	 */
-	if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
+	if (cc_platform_has(CC_ATTR_HOST_MEM_INCOHERENT))
 		native_wbinvd();
 
 	/*
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7f72472a34d6..87e4fddab770 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -570,9 +570,19 @@ void __init sme_enable(struct boot_params *bp)
 		msr = __rdmsr(MSR_AMD64_SYSCFG);
 		if (!(msr & MSR_AMD64_SYSCFG_MEM_ENCRYPT))
 			return;
+
+		/*
+		 * Always set CC vendor when the platform has SME enabled
+		 * regardless whether the kernel will actually activates the
+		 * SME or not.  This reports the CC_ATTR_HOST_MEM_INCOHERENT
+		 * being true as long as the platform has SME enabled so that
+		 * stop_this_cpu() can do necessary WBINVD during kexec().
+		 */
+		cc_vendor = CC_VENDOR_AMD;
 	} else {
 		/* SEV state cannot be controlled by a command line option */
 		sme_me_mask = me_mask;
+		cc_vendor = CC_VENDOR_AMD;
 		goto out;
 	}
 
@@ -608,7 +618,6 @@ void __init sme_enable(struct boot_params *bp)
 out:
 	if (sme_me_mask) {
 		physical_mask &= ~sme_me_mask;
-		cc_vendor = CC_VENDOR_AMD;
 		cc_set_mask(sme_me_mask);
 	}
 }
diff --git a/include/linux/cc_platform.h b/include/linux/cc_platform.h
index cb0d6cd1c12f..2f7273596102 100644
--- a/include/linux/cc_platform.h
+++ b/include/linux/cc_platform.h
@@ -42,6 +42,21 @@ enum cc_attr {
 	 */
 	CC_ATTR_HOST_MEM_ENCRYPT,
 
+	/**
+	 * @CC_ATTR_HOST_MEM_INCOHERENT: Host memory encryption can be
+	 * incoherent
+	 *
+	 * The platform/OS is running as a bare-metal system or a hypervisor.
+	 * The memory encryption engine might have left non-cache-coherent
+	 * data in the caches that needs to be flushed.
+	 *
+	 * Use this in places where the cache coherency of the memory matters
+	 * but the encryption status does not.
+	 *
+	 * Includes all systems that set CC_ATTR_HOST_MEM_ENCRYPT.
+	 */
+	CC_ATTR_HOST_MEM_INCOHERENT,
+
 	/**
 	 * @CC_ATTR_GUEST_MEM_ENCRYPT: Guest memory encryption is active
 	 *
-- 
2.34.1


