Return-Path: <linux-kernel+bounces-111897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BB2887253
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6ABC1C23022
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5AC60DEB;
	Fri, 22 Mar 2024 17:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCpArUNq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E360BA7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711130196; cv=none; b=sP4xDPqg7XYUB3kUYro4PHIKs0MZSFvWXDz4OcJTfxYO8nn97jg7uT82dIp2n6DLbya0rBlfIJuFdF2XZTZBP3eNkOh32bEPgJ/L+a5Cf+EACEvhP8qkH0gnnE+VdOWkaw/wHJN0S2NJLWC/TXj7V6VuPYvM9PIDS+WCqC9AqR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711130196; c=relaxed/simple;
	bh=R39FNwAEvPrsTrN8h1zduBan957TEM8t3B4Ef3RYhjk=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=S/wjkz4j8iQ5E7Cq2dBEfdArmN7gmzKSs1+mkYFmu0xlLZB6+7cXg/VTbKDUuEMdm0vdMu9wINcdmibyD2P8jTLw4IgGdL5NjXL4BLQLE6KnZ+PpMkOfLM+G0t1BIO/mF3Lgdxhu8SfI32ERizmJD+WvRPHNGP9ay4nh0S/U8zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCpArUNq; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711130195; x=1742666195;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=R39FNwAEvPrsTrN8h1zduBan957TEM8t3B4Ef3RYhjk=;
  b=RCpArUNqIHcpJusg6vT1mP/0XSho8C7dxfE4OZ7k2OkeFOD/3feCiDJX
   qWEmNllSwbh0TEr9Ci3/CprAp2zGyEQsoPnVrXJb6uhKtSTLjAgYcjw2j
   zPp8sQN4K4H9/wVgNpn3o3p83vvWNZoGShvNaBuip3Qqh/phfvzPErrJg
   T9EJpBcC5soMyFRh44Dcyl1HhoFLjd7QrSsaZ40bpN4+52YrWhWrzzdlm
   cx1jIAo8FzAMuBJtjQFl4eSCPmPShdNDCeH+GdgBR1LgkNnpjsQr0gJql
   9YA4Z5uAM4aHpe0BUoRgsoFX/egaZGALONCMPwGBG6I6ty+oGVX3m1phb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="28669703"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="28669703"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 10:56:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="15425575"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa006.jf.intel.com with ESMTP; 22 Mar 2024 10:56:34 -0700
Subject: [PATCH 3/4] x86/boot: Explicitly pass NX enabling status
To: linux-kernel@vger.kernel.org
Cc: jgross@suse.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 22 Mar 2024 10:56:33 -0700
References: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
In-Reply-To: <20240322175629.01E8B39D@davehans-spike.ostc.intel.com>
Message-Id: <20240322175633.1CF5EB0E@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

The kernel sometimes needs to mask unsupported bits out of page
table entries.  It does that with a mask: '__supported_pte_mask'.

That mask can obviously only contain the No-eXecute bit ( _PAGE_NX)
on hardware where NX is supported.  x86_configure_nx() checks the
boot CPU's NX support and adjusts the mask appropriately.

But it doesn't check support directly.  It uses the venerable
'boot_cpu_data' which is a software approximation of the actual CPU
support.  Unfortunately, Xen wants to set up '__supported_pte_mask'
before 'boot_cpu_data' has been initialized.  It hacks around this
problem by repeating some of the 'boot_cpu_data' setup *just* for
NX.

Have x86_configure_nx() stop consulting 'boot_cpu_data' and move
the NX detection to the caller.

No functional change.  That will come later.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/proto.h |    2 +-
 b/arch/x86/kernel/setup.c      |    6 +++---
 b/arch/x86/xen/enlighten_pv.c  |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/proto.h~x86_configure_nx-arg arch/x86/include/asm/proto.h
--- a/arch/x86/include/asm/proto.h~x86_configure_nx-arg	2024-03-18 15:12:21.704343388 -0700
+++ b/arch/x86/include/asm/proto.h	2024-03-18 15:12:21.708343524 -0700
@@ -37,7 +37,7 @@ void entry_SYSRETL_compat_end(void);
 #define entry_SYSENTER_compat NULL
 #endif
 
-void x86_configure_nx(void);
+void x86_configure_nx(bool nx_supported);
 
 extern int reboot_force;
 
diff -puN arch/x86/kernel/setup.c~x86_configure_nx-arg arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~x86_configure_nx-arg	2024-03-18 15:12:21.704343388 -0700
+++ b/arch/x86/kernel/setup.c	2024-03-18 15:12:21.708343524 -0700
@@ -687,9 +687,9 @@ dump_kernel_offset(struct notifier_block
 	return 0;
 }
 
-void x86_configure_nx(void)
+void x86_configure_nx(bool nx_supported)
 {
-	if (boot_cpu_has(X86_FEATURE_NX))
+	if (nx_supported)
 		__supported_pte_mask |= _PAGE_NX;
 	else
 		__supported_pte_mask &= ~_PAGE_NX;
@@ -853,7 +853,7 @@ void __init setup_arch(char **cmdline_p)
 	 * whether hardware doesn't support NX (so that the early EHCI debug
 	 * console setup can safely call set_fixmap()).
 	 */
-	x86_configure_nx();
+	x86_configure_nx(boot_cpu_has(X86_FEATURE_NX));
 
 	parse_early_param();
 
diff -puN arch/x86/xen/enlighten_pv.c~x86_configure_nx-arg arch/x86/xen/enlighten_pv.c
--- a/arch/x86/xen/enlighten_pv.c~x86_configure_nx-arg	2024-03-18 15:12:21.704343388 -0700
+++ b/arch/x86/xen/enlighten_pv.c	2024-03-18 15:12:21.708343524 -0700
@@ -1371,7 +1371,7 @@ asmlinkage __visible void __init xen_sta
 
 	/* Work out if we support NX */
 	get_cpu_cap(&boot_cpu_data);
-	x86_configure_nx();
+	x86_configure_nx(boot_cpu_has(X86_FEATURE_NX));
 
 	/*
 	 * Set up kernel GDT and segment registers, mainly so that
_

