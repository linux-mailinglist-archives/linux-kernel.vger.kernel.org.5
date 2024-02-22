Return-Path: <linux-kernel+bounces-77177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C76288601DC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:49:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BB52B2B22B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD9114CAD2;
	Thu, 22 Feb 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyjAmDxK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE714CAAA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708627198; cv=none; b=LOCgvPOy/FO7U2F62vYuBWYGEkIUwr0rMIyntbwZC86UNT5ACYDDSDwWlWTCZmSQX0OIrhrYi/9/PGDiF4ZdCTB0TacGuxzoxVrnFAho9OQftrG9VXXbI2D81W2Qep2dK5E1Rp55xU41UCmsBXuLfU4a2T7EslHIVKmIclgx69I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708627198; c=relaxed/simple;
	bh=n3sFMUZ3X1KUCYEgfoDu2y2gB7wcsAKIFaZGgsgC84Y=;
	h=Subject:To:Cc:From:Date:References:In-Reply-To:Message-Id; b=oRCtjiAihyg/OsZ9W8hJEW3U6kuea/d88Wy5GN4/UCbWZ7dR+bknrTBzIKfUZJlLNJq1bgvEtqcJcGV5WkfHFy/BYlzwflJNd0lYgGKC3cmtHlUelvoLoACwD8XF0vvl9ejfggEWhgGTQuo926UpnI4MJU/Ho65LsLOoMVHnslo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyjAmDxK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708627198; x=1740163198;
  h=subject:to:cc:from:date:references:in-reply-to:
   message-id;
  bh=n3sFMUZ3X1KUCYEgfoDu2y2gB7wcsAKIFaZGgsgC84Y=;
  b=eyjAmDxKK0w2jJYRy35H/Uh19bb91FVJOeEC1SWWjl22GxpDC01gqpu+
   E08uXaUSLt0ULiAbVNRFnOQb4l0OZ3ZHYlt64LaCC6tLiybW7NWS3VXSf
   64rJqbZ2T82ZZwTbSjgi2pd2XPs1cqyUD19d5Ih4EQoXiVICUD1+27YKF
   kkUY0SDjjtC0Cm6aHbLomBWykeoPn8L8tuVUBK3hJPPOwDZsE5+R70vgF
   MThEztI4UK6OV4W+c00+fcwFb5AfVxvUmpQt8YOl19+1JLvxU0Nj3/UzL
   VJVhH3r3p7bgMv2rQi6a7Tehc5URX5Qo6pQoZiarmZt15mz8dp29jFpIK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3031861"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3031861"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 10:39:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5975614"
Received: from davehans-spike.ostc.intel.com (HELO localhost.localdomain) ([10.165.164.11])
  by orviesa008.jf.intel.com with ESMTP; 22 Feb 2024 10:39:57 -0800
Subject: [RFC][PATCH 23/34] x86/cpu: Move cache alignment configuration to global struct
To: linux-kernel@vger.kernel.org
Cc: kirill.shutemov@linux.intel.com,pbonzini@redhat.com,tglx@linutronix.de,x86@kernel.org,bp@alien8.de,Dave Hansen <dave.hansen@linux.intel.com>
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Thu, 22 Feb 2024 10:39:56 -0800
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
Message-Id: <20240222183956.CA91A140@davehans-spike.ostc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>


From: Dave Hansen <dave.hansen@linux.intel.com>

It is a tale as old as time: x86_cache_alignment is established and
stored per-cpu despite being system-wide.  Move it to the global
configuration structure.

The other values have received _new_ wrappers.  But this one already
had cache_line_size().  Just use that wrapper.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/x86/include/asm/processor.h |    4 ++--
 b/arch/x86/kernel/cpu/common.c     |    4 ++--
 b/arch/x86/kernel/cpu/proc.c       |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff -puN arch/x86/include/asm/processor.h~x86_config-x86_cache_alignment arch/x86/include/asm/processor.h
--- a/arch/x86/include/asm/processor.h~x86_config-x86_cache_alignment	2024-02-22 10:08:59.700894617 -0800
+++ b/arch/x86/include/asm/processor.h	2024-02-22 10:08:59.708894931 -0800
@@ -137,7 +137,6 @@ struct cpuinfo_x86 {
 	struct cpuinfo_topology	topo;
 	/* in KB - valid for CPUS which support this call: */
 	unsigned int		x86_cache_size;
-	int			x86_cache_alignment;	/* In bytes */
 	/* Cache QoS architectural values, valid only on the BSP: */
 	int			x86_cache_max_rmid;	/* max index */
 	int			x86_cache_occ_scale;	/* scale to bytes */
@@ -191,6 +190,7 @@ struct x86_sys_config {
 	u8	phys_bits;
 	u8	virt_bits;
 	u16	clflush_size;
+	int	cache_alignment; /* in bytes */
 };
 
 extern struct x86_sys_config x86_config;
@@ -229,7 +229,7 @@ DECLARE_PER_CPU_READ_MOSTLY(struct cpuin
 
 extern const struct seq_operations cpuinfo_op;
 
-#define cache_line_size()	(boot_cpu_data.x86_cache_alignment)
+#define cache_line_size()	(x86_config.cache_alignment)
 
 extern void cpu_detect(struct cpuinfo_x86 *c);
 
diff -puN arch/x86/kernel/cpu/common.c~x86_config-x86_cache_alignment arch/x86/kernel/cpu/common.c
--- a/arch/x86/kernel/cpu/common.c~x86_config-x86_cache_alignment	2024-02-22 10:08:59.704894774 -0800
+++ b/arch/x86/kernel/cpu/common.c	2024-02-22 10:08:59.708894931 -0800
@@ -1140,9 +1140,9 @@ void get_cpu_address_sizes(struct cpuinf
 
 	c->x86_cache_bits = x86_config.phys_bits;
 
-	c->x86_cache_alignment = x86_clflush_size();
+	x86_config.cache_alignment = x86_clflush_size();
 	if (bsp_addr_config.cache_align_mult)
-		c->x86_cache_alignment *= bsp_addr_config.cache_align_mult;
+		x86_config.cache_alignment *= bsp_addr_config.cache_align_mult;
 
 	/* Do this last to avoid affecting ->x86_cache_bits. */
 	x86_config.phys_bits -= bsp_addr_config.phys_addr_reduction_bits;
diff -puN arch/x86/kernel/cpu/proc.c~x86_config-x86_cache_alignment arch/x86/kernel/cpu/proc.c
--- a/arch/x86/kernel/cpu/proc.c~x86_config-x86_cache_alignment	2024-02-22 10:08:59.704894774 -0800
+++ b/arch/x86/kernel/cpu/proc.c	2024-02-22 10:08:59.708894931 -0800
@@ -131,7 +131,7 @@ static int show_cpuinfo(struct seq_file
 		seq_printf(m, "TLB size\t: %d 4K pages\n", c->x86_tlbsize);
 #endif
 	seq_printf(m, "clflush size\t: %u\n", x86_clflush_size());
-	seq_printf(m, "cache_alignment\t: %d\n", c->x86_cache_alignment);
+	seq_printf(m, "cache_alignment\t: %d\n", x86_config.cache_alignment);
 	seq_printf(m, "address sizes\t: %u bits physical, %u bits virtual\n",
 		   x86_phys_bits(), x86_virt_bits());
 
_

