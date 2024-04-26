Return-Path: <linux-kernel+bounces-160781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD92D8B42D3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD87283A27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A223BBF5;
	Fri, 26 Apr 2024 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gM0+Igd1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D1C3839C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 23:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714175296; cv=none; b=EesLm8YfM3UTzWc68T6MfXW6SVUvefjxOvDRnOPIq+JJLGkxa0F2IZhKa6hMpfDQr52gGwbGEaEv0U2+5hzX35uK8SiXtlPcxIUGEW8KxD/A/c1ZzcHGnxrps6hgCyq4oNZJMhTIl0ui5ghqlTzc6JBa/lQWM2W87shHmADq7jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714175296; c=relaxed/simple;
	bh=NNyC/ocExeAnmdu0PVGDKkIaUjlcpdhk8EKcizR/yhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dyrqh+mKNXO1uweH/9EoOf89C8XW9zfmICatUJ7+nDvTZ0xsjqHdlyNDK/7PpoXHtO60Sgz+3MohM8G5pJ7SYYapB/UoIvwroA+LeYm7awCd+iBGKmVTy3MF0BjoTsebW4PVWKX7xmPpwGOoYNBjd1dcp5yL+bOqykzDhIK02js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gM0+Igd1; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714175294; x=1745711294;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NNyC/ocExeAnmdu0PVGDKkIaUjlcpdhk8EKcizR/yhI=;
  b=gM0+Igd1zNd7uKFlhBBcSYcly+CCS3YGc+GHwdVLWix4dA+kt6fp/wt0
   Bg+ZXfwsnSjRXfER3bG/0Rd5rWQJ8bIUY9mg940EBD/GJrQtDWUQQB8E8
   Ns/ITNAfzGaI/QoAdnPYBWqKRzD359In53rUonz7RcYBsxbwdbc2u5jS1
   sSvwli6wjqnRUBAdfiSym+vH+jPNkNnpvvXQIy30wdhs8VIQvUResbdPn
   OF7OK6nPb5r+fBNZYhQDsAEwynW8/kiiOBlGP1m4Z1jP5O6xNVOZYZqS6
   MaxEomWzCwwfH3g9KgXL9nTPrqmu5N6ypACMZs7OZ4Dhx1eQ33oXc9TBh
   Q==;
X-CSE-ConnectionGUID: B0lj+v55QwCkqarGOLeqaQ==
X-CSE-MsgGUID: xiUcdg8qSBOQF+iqXBLGew==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10460112"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="10460112"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 16:48:13 -0700
X-CSE-ConnectionGUID: /itqjwcFRCK9q9NyBIs19A==
X-CSE-MsgGUID: A31K8/3GTxyN0raHk2FSkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="25631851"
Received: from sstrba-mobl1.amr.corp.intel.com (HELO desk) ([10.251.16.80])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 16:48:12 -0700
Date: Fri, 26 Apr 2024 16:48:11 -0700
From: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Robert Gill <rtgill82@gmail.com>,
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
	antonio.gomez.iglesias@linux.intel.com,
	daniel.sneddon@linux.intel.com
Subject: [PATCH] x86/entry_32: Move CLEAR_CPU_BUFFERS before CR3 switch
Message-ID: <20240426-fix-dosemu-vm86-v1-1-88c826a3f378@linux.intel.com>
X-B4-Tracking: v=1; b=H4sIAKw8LGYC/x2MQQqAIBAAvyJ7bsG10Ogr0SFyqz1YoSSB9Pek4
 8DMFEgchRMMqkDkLEnOowI1CpZ9PjZG8ZXBaNPpzlhc5UF/Jg435tBb9J6IZk2udQy1uiJX5T+
 O0/t+5gQ3wGEAAAA=
X-Mailer: b4 0.12.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

As the mitigation for MDS and RFDS, CLEAR_CPU_BUFFERS macro executes VERW
instruction that is used to clear the CPU buffers before returning to user
space. Currently, VERW is executed after the user CR3 is restored. This
leads to vm86() to fault because VERW takes a memory operand that is not
mapped in user page tables when vm86() syscall returns. This is an issue
with 32-bit kernels only, as 64-bit kernels do not support vm86().

Move the VERW before the CR3 switch for 32-bit kernels as a workaround.
This is slightly less secure because there is a possibility that the data
in the registers may be sensitive, and doesn't get cleared from CPU
buffers. As 32-bit kernels haven't received some of the other transient
execution mitigations, this is a reasonable trade-off to ensure that
vm86() syscall works.

Fixes: a0e2dab44d22 ("x86/entry_32: Add VERW just before userspace transition")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218707
Closes: https://lore.kernel.org/all/8c77ccfd-d561-45a1-8ed5-6b75212c7a58@leemhuis.info/
Reported-by: Robert Gill <rtgill82@gmail.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
---
 arch/x86/entry/entry_32.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index d3a814efbff6..1b9c1587f06e 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -837,6 +837,7 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	jz	.Lsyscall_32_done
 
 	STACKLEAK_ERASE
+	CLEAR_CPU_BUFFERS
 
 	/* Opportunistic SYSEXIT */
 
@@ -881,7 +882,6 @@ SYM_FUNC_START(entry_SYSENTER_32)
 	BUG_IF_WRONG_CR3 no_user_check=1
 	popfl
 	popl	%eax
-	CLEAR_CPU_BUFFERS
 
 	/*
 	 * Return back to the vDSO, which will pop ecx and edx.
@@ -941,6 +941,7 @@ SYM_FUNC_START(entry_INT80_32)
 	STACKLEAK_ERASE
 
 restore_all_switch_stack:
+	CLEAR_CPU_BUFFERS
 	SWITCH_TO_ENTRY_STACK
 	CHECK_AND_APPLY_ESPFIX
 
@@ -951,7 +952,6 @@ restore_all_switch_stack:
 
 	/* Restore user state */
 	RESTORE_REGS pop=4			# skip orig_eax/error_code
-	CLEAR_CPU_BUFFERS
 .Lirq_return:
 	/*
 	 * ARCH_HAS_MEMBARRIER_SYNC_CORE rely on IRET core serialization

---
base-commit: 0bbac3facb5d6cc0171c45c9873a2dc96bea9680
change-id: 20240426-fix-dosemu-vm86-dd111a01737e


