Return-Path: <linux-kernel+bounces-77181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 044CA8601DD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6679328CC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DA14EFD7;
	Thu, 22 Feb 2024 18:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nYTRWxUA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FE14DFDD
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627204; cv=none; b=htOkfSd5kv8HgVVuB5jdhXyxRtms76e3flz/Lf51+HwGoXikIQUOZdmqeFo3uS6kjlnRtKvSZ4SW4ySnoMMzW+TZQHa/D96oXc7/tqMULLphHEUdDOyTCd0yU7RPvwN6GTmUPe+HnCSt5M0Ub8cK5j8Gt0seibd7m/rXCMW7Kq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627204; c=relaxed/simple;
	bh=M0K0p1YY8ZD9RWKhulCbsPvnuM9T8SM1JcaqD9ukN24=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=MB8XHhbi/TN9S1r6wzihN1Gi4QM+VKDcZSpZsofOAyfVO4oLnOoymLZSPbOqFqjunvTtoIyoQxIDHUsyn3uxFRw2cBApTZhRFqj9CYgBTYrmhBAWIX1BXd/HtH0TCzTAuIUahgAGHm6mDJxMQ1Ro98ZpJZXSzSibjn3KgyC5PeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nYTRWxUA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627203; x=1740163203;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=M0K0p1YY8ZD9RWKhulCbsPvnuM9T8SM1JcaqD9ukN24=;
  b=nYTRWxUAUZj67bdyj1gOL3IV5Y8q429vWrDRp1B6lc+iJEWHNBLVknj6
   Z8TYQ61UuZztv7zNmeE16CA+1MJ/LE5aDq3XeS/1d777wfOZSLq7/evOW
   AYdcT+B/Zt66VhGd2UM0j5bCceQ7zQBYE3mN5iDorDKlJlLJCtnVGHE6A
   7429yNpV+gIbAq0zM3a2lLfaq4DEi72kpDa+8XJQwPaQKRIUpcpROjV06
   2LoBgzT20tAR3vyYekdQajXRB9JpnVK3kWheOwhAh2Xhs7LYWrrZR//N8
   VwCPnhONtF5tXhLKjRrVDxDt4UrMNov0NvYYOB3EiVtZdQIyC2vLNuEKp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13584565"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13584565"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:40:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10265249"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa004.jf.intel.com with ESMTP; 22 Feb 2024 10:40:02 -0800
Subject: [RFC][PATCH 27/34] x86/cpu: Enforce read-only x86_config state (lightly)
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:40:02 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222184002.690F68EF@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

Part of the reason that this all turned into such a mess is that there
were no rules around when 'struct cpuinfo_x86' was written.  It was
(and is) just a free-for-all.

Establish that 'x86_config' has two phases of its lifetime: an
C_INITIALIZING phase where it can be written and a later C_FINALIZED
stage where it can only be read.  It is simple to audit the fact
that this state transition happens just where the comment says it
should be.

Check that the config is C_FINALIZED in each of the wrappers that
read a 'x86_config' value.  If something reads too early, stash
some information to the caller so that it can spit out a warning
later.

This goofy stash-then-warn construct is necessary here because any
hapless readers are likely to be in a spot where they can not easily
WARN() themselves, like the early Xen PV boot that's caused so many
problems.

This also moves one x86_clflush_size() reference over to the more
direct x86_config.cache_alignment because otherwise it would trip
the !C_FINALIZED check.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |   22 ++++++++++++++++++++++
 b/arch/x86/kernel/cpu/common.c     |    5 ++++-
 b/arch/x86/kernel/setup.c          |    7 +++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff -puN arch/x86/include/asm/processor.h~x86_config-finalize arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~x86_config-finalize	2024-02-22 10:09:01.772975960 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:09:01.780976274 -0800
@@ -183,6 +183,11 @@ struct x86_addr_config {
 	u8 min_cache_bits;
 };
 
+enum x86_sys_config_state {
+	C_INITIALIZING,
+	C_FINALIZED
+};
+
 /*
  * System-wide configuration that is shared by all processors.
  *
@@ -190,6 +195,9 @@ struct x86_addr_config {
  * modified after that.
  */
 struct x86_sys_config {
+	enum x86_sys_config_state conf_state;
+	void *early_reader;
+
 	/* Address bits supported by all processors */
 	u8	phys_bits;
 	u8	virt_bits;
@@ -805,23 +813,37 @@ static inline void weak_wrmsr_fence(void
 	alternative("mfence; lfence", "", ALT_NOT(X86_FEATURE_APIC_MSRS_FENCE));
 }
 
+static inline void read_x86_config(void)
+{
+	if (x86_config.conf_state == C_FINALIZED)
+		return;
+
+	/* Only record the first one: */
+	if (!x86_config.early_reader)
+		x86_config.early_reader = __builtin_return_address(0);
+}
+
 static inline u8 x86_phys_bits(void)
 {
+	read_x86_config();
 	return x86_config.phys_bits;
 }
 
 static inline u8 x86_virt_bits(void)
 {
+	read_x86_config();
 	return x86_config.virt_bits;
 }
 
 static inline u8 x86_cache_bits(void)
 {
+	read_x86_config();
 	return x86_config.cache_bits;
 }
 
 static inline u8 x86_clflush_size(void)
 {
+	read_x86_config();
 	return x86_config.clflush_size;
 }
 
diff -puN arch/x86/kernel/cpu/common.c~x86_config-finalize arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~x86_config-finalize	2024-02-22 10:09:01.776976117 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:09:01.780976274 -0800
@@ -1114,6 +1114,9 @@ void get_cpu_address_sizes(struct cpuinf
 	u32 eax, ebx, ecx, edx;
 	bool vp_bits_from_cpuid = true;
 
+	WARN_ON_ONCE(x86_config.conf_state > C_INITIALIZING);
+	x86_config.conf_state = C_INITIALIZING;
+
 	if (!cpu_has(c, X86_FEATURE_CPUID) ||
 	    (c->extended_cpuid_level < 0x80000008))
 		vp_bits_from_cpuid = false;
@@ -1142,7 +1145,7 @@ void get_cpu_address_sizes(struct cpuinf
 	if (x86_config.cache_bits < bsp_addr_config.min_cache_bits)
 		x86_config.cache_bits = bsp_addr_config.min_cache_bits;
 
-	x86_config.cache_alignment = x86_clflush_size();
+	x86_config.cache_alignment = x86_config.clflush_size;
 	if (bsp_addr_config.cache_align_mult)
 		x86_config.cache_alignment *= bsp_addr_config.cache_align_mult;
 
diff -puN arch/x86/kernel/setup.c~x86_config-finalize arch/x86/kernel/setup.c
--- a/arch/x86/kernel/setup.c~x86_config-finalize	2024-02-22 10:09:01.776976117 -0800
+++ b/arch/x86/kernel/setup.c	2024-02-22 10:09:01.780976274 -0800
@@ -762,7 +762,14 @@ void __init setup_arch(char **cmdline_p)
 	olpc_ofw_detect();
 
 	idt_setup_early_traps();
+
 	early_cpu_init();
+
+	/* Ensure no readers snuck in before the config was finished: */
+	WARN_ONCE(x86_config.early_reader, "x86_config.early_reader: %pS\n",
+		  x86_config.early_reader);
+	x86_config.conf_state = C_FINALIZED;
+
 	jump_label_init();
 	static_call_init();
 	early_ioremap_init();
_

