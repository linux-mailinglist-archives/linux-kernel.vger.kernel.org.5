Return-Path: <linux-kernel+bounces-116596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DD388A3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814A4B29022
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3015156F3F;
	Mon, 25 Mar 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d2HRW4RJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4815F3E2;
	Mon, 25 Mar 2024 06:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348888; cv=none; b=p0yL1ZHw9sxfAeOSn/hjVJi2IXh5Z9iBOpaqS1j4uL9uECJzpi4Om2/hgHZ/zww/FsvvkUBsR2NobdAfZ26kPcGqY4wUEu56iuY5xMDr5NdDH6KnxaeKWrX0sfI7HIbov7wzwH2dtv0QZo9ChzuOyTCco5bWxnweGgYoesJx/eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348888; c=relaxed/simple;
	bh=Zjh6IUndlImHk90vhCoelXOI1d7rMagiowI5tzl77NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nI59wntMQwHShCXljF/y9H0PtnTBJo93RYSVIWo3D0vOuGK3lw6CYgLX5ZzfS56dT668gVPb50GxzjmwRtQBPUb6PGbhvBLLKfLi38DvPjj12J0GI1M5jiEg5bNcOnkBP83RbrvxZEl4UOfxQoR7UYY614AR3auXtOcBhyn8Zbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d2HRW4RJ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348886; x=1742884886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zjh6IUndlImHk90vhCoelXOI1d7rMagiowI5tzl77NQ=;
  b=d2HRW4RJ+Whp0NALxuEas08Z+GpG7vgYUH0VRQzlWPQq9HbPC0k4bN6A
   0kJcy6Jrvhn6cwVCPLaxIXxitFfkdcTSGbuevtu5QcKHIf9vCYufhnOSg
   +WJfdRqxOvbZM+VQIH1qoPxQzAQYztrotZ6aNvMminNzuemJMlT4ooJRK
   1SnsQYtfqCzqgK6lKnpi2xVmwcLwthVJCLa/Qrf7YHkcvb5WKKDjJoeKx
   de9gHSzCdP2tSAs+GTPWMhdfVH35Jx5hJfjPFatMx42I8rWTJ7XqfqRzY
   tbpRag46J17Gym4ftdr1IpxzraYdehNh664IVNnFiMBwzsHUVgiAMQVi5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17065197"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17065197"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629597"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:18 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH V2 07/19] vdso: Make delta calculation overflow safe
Date: Mon, 25 Mar 2024 08:40:11 +0200
Message-Id: <20240325064023.2997-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325064023.2997-1-adrian.hunter@intel.com>
References: <20240325064023.2997-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Kernel timekeeping is designed to keep the change in cycles (since the last
timer interrupt) below max_cycles, which prevents multiplication overflow
when converting cycles to nanoseconds. However, if timer interrupts stop,
the calculation will eventually overflow.

Add protection against that, enabled by config option
CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT. Check against max_cycles, falling
back to a slower higher precision calculation.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 lib/vdso/gettimeofday.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9fa90e0794c9..9c3a8d2440c9 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -13,6 +13,18 @@
 # define VDSO_DELTA_MASK(vd)	(vd->mask)
 #endif
 
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 delta)
+{
+	return delta < vd->max_cycles;
+}
+#else
+static __always_inline bool vdso_delta_ok(const struct vdso_data *vd, u64 delta)
+{
+	return true;
+}
+#endif
+
 #ifndef vdso_shift_ns
 static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
 {
@@ -28,7 +40,10 @@ static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles,
 {
 	u64 delta = (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
 
-	return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+	if (likely(vdso_delta_ok(vd, delta)))
+		return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+
+	return mul_u64_u32_add_u64_shr(delta, vd->mult, base, vd->shift);
 }
 #endif /* vdso_calc_ns */
 
-- 
2.34.1


