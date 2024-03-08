Return-Path: <linux-kernel+bounces-97044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8FA8764D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722D12814FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E2F39FD9;
	Fri,  8 Mar 2024 13:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NB7Jqa6v"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535A33612C;
	Fri,  8 Mar 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903744; cv=none; b=V57tXz+p4Qi5+XtH0yP2soaZ0MrJE3/wU+LWuym2gNdnLMVkZPWDMLRpgyunW7rFRrBvTns6mfbFf9tmfP0nzEhmZoU62szs6q6QqfhenxPdhzBIsfJtyUzDj0gMCqJsjbdXjmFwvPqe4mbxasfH+hVjjoXf2FjkqUXU7mKYEHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903744; c=relaxed/simple;
	bh=BicpP74oj5pt4/R+FPIitTPzD9PABJ1vfjH9IXWSi8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P/noxvMQ7mSgaHd8lI6DoQT6U4tPPSwnR+rm8j3xb2fV1IjhEPsne1f2dAr3SzxviB5BUFQGB+Idg11bi6LW1B6ko29uQCvq6z053Mubiivxpn5Ms8SCaLAS5LvBc/ydYUlJDpu8rZNN+DwFXQWtYzn2xW6A09EOLV2fcwdqQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NB7Jqa6v; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903742; x=1741439742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BicpP74oj5pt4/R+FPIitTPzD9PABJ1vfjH9IXWSi8g=;
  b=NB7Jqa6vewlLZE6RprqYTi60C2g2QnEDjHyn+1qsDOISGj2nT7lD8Flr
   i7CEQ8NNRxcpmMKAGPVS7lxED+0AWLKZQVU1zehSnkSpLCYL5yQge051/
   3sRIcxqyluZapj467NBa7ckRXXPb4uUkaTeIc0yhGroSTG6wHzn82NJvn
   K0wlQVpUX6IRmo/tETJ8LF/tDLwtbIEJaL/5iXoMDb7mCg+1TTUhCjzH9
   DC53T+2RXPi54OyI3IGfPkvmgUsYs5qb8p3axKRvqLr+zokvhFcZuQexZ
   /ouAD1cFJ/8HG2dAiEfSV5hzrMKu/sPkMLQf3AygOzZTROmROkTyVvVqk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342418"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342418"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161362"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:34 -0800
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
Subject: [PATCH 02/19] vdso: Consolidate nanoseconds calculation
Date: Fri,  8 Mar 2024 15:14:55 +0200
Message-Id: <20240308131512.44324-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308131512.44324-1-adrian.hunter@intel.com>
References: <20240308131512.44324-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Consolidate nanoseconds calculation to simplify and reduce code
duplication.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/x86/include/asm/vdso/gettimeofday.h | 17 +++++----
 lib/vdso/gettimeofday.c                  | 44 +++++++++++-------------
 2 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 8e048ca980df..5727dedd3549 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -300,7 +300,7 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
 #define vdso_cycles_ok arch_vdso_cycles_ok
 
 /*
- * x86 specific delta calculation.
+ * x86 specific calculation of nanoseconds for the current cycle count
  *
  * The regular implementation assumes that clocksource reads are globally
  * monotonic. The TSC can be slightly off across sockets which can cause
@@ -308,8 +308,8 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * jump.
  *
  * Therefore it needs to be verified that @cycles are greater than
- * @last. If not then use @last, which is the base time of the current
- * conversion period.
+ * @vd->cycles_last. If not then use @vd->cycles_last, which is the base
+ * time of the current conversion period.
  *
  * This variant also uses a custom mask because while the clocksource mask of
  * all the VDSO capable clocksources on x86 is U64_MAX, the above code uses
@@ -317,25 +317,24 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * declares everything with the MSB/Sign-bit set as invalid. Therefore the
  * effective mask is S64_MAX.
  */
-static __always_inline
-u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
+static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, u64 base)
 {
 	/*
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
 	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX.
 	 */
-	u64 delta = (cycles - last) & S64_MAX;
+	u64 delta = (cycles - vd->cycle_last) & S64_MAX;
 
 	/*
 	 * Due to the above mentioned TSC wobbles, filter out negative motion.
 	 * Per the above masking, the effective sign bit is now bit 62.
 	 */
 	if (unlikely(delta & (1ULL << 62)))
-		return 0;
+		return base >> vd->shift;
 
-	return delta * mult;
+	return ((delta * vd->mult) + base) >> vd->shift;
 }
-#define vdso_calc_delta vdso_calc_delta
+#define vdso_calc_ns vdso_calc_ns
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 042b95e8164d..9fa90e0794c9 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -5,20 +5,12 @@
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
 
-#ifndef vdso_calc_delta
-/*
- * Default implementation which works for all sane clocksources. That
- * obviously excludes x86/TSC.
- */
-static __always_inline
-u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
-{
+#ifndef vdso_calc_ns
+
 #ifdef VDSO_DELTA_NOMASK
-	return (cycles - last) * mult;
+# define VDSO_DELTA_MASK(vd)	U64_MAX
 #else
-	return ((cycles - last) & mask) * mult;
-#endif
-}
+# define VDSO_DELTA_MASK(vd)	(vd->mask)
 #endif
 
 #ifndef vdso_shift_ns
@@ -28,6 +20,18 @@ static __always_inline u64 vdso_shift_ns(u64 ns, u32 shift)
 }
 #endif
 
+/*
+ * Default implementation which works for all sane clocksources. That
+ * obviously excludes x86/TSC.
+ */
+static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, u64 base)
+{
+	u64 delta = (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
+
+	return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+}
+#endif /* vdso_calc_ns */
+
 #ifndef __arch_vdso_hres_capable
 static inline bool __arch_vdso_hres_capable(void)
 {
@@ -53,10 +57,10 @@ static inline bool vdso_cycles_ok(u64 cycles)
 static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_t clk,
 					  struct __kernel_timespec *ts)
 {
-	const struct vdso_data *vd;
 	const struct timens_offset *offs = &vdns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
-	u64 cycles, last, ns;
+	const struct vdso_data *vd;
+	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
 
@@ -77,10 +81,7 @@ static __always_inline int do_hres_timens(const struct vdso_data *vdns, clockid_
 		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns = vdso_ts->nsec;
-		last = vd->cycle_last;
-		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
-		ns = vdso_shift_ns(ns, vd->shift);
+		ns = vdso_calc_ns(vd, cycles, vdso_ts->nsec);
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 
@@ -115,7 +116,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 				   struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts = &vd->basetime[clk];
-	u64 cycles, last, sec, ns;
+	u64 cycles, sec, ns;
 	u32 seq;
 
 	/* Allows to compile the high resolution parts out */
@@ -148,10 +149,7 @@ static __always_inline int do_hres(const struct vdso_data *vd, clockid_t clk,
 		cycles = __arch_get_hw_counter(vd->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns = vdso_ts->nsec;
-		last = vd->cycle_last;
-		ns += vdso_calc_delta(cycles, last, vd->mask, vd->mult);
-		ns = vdso_shift_ns(ns, vd->shift);
+		ns = vdso_calc_ns(vd, cycles, vdso_ts->nsec);
 		sec = vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vd, seq)));
 
-- 
2.34.1


