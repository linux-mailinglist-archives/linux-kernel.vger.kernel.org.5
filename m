Return-Path: <linux-kernel+bounces-97043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E43D8764D3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5A51C21A7F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31D936AF8;
	Fri,  8 Mar 2024 13:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzutiNMX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D881F944;
	Fri,  8 Mar 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903742; cv=none; b=b5T211ePj12IP6rSz3DQuaf5iKjM3yS7tyJ74DHgTC6S6ERGUr1IWdfx38pCbxehqCRVLrA6fG18nmvK8Sz4QBP/JXVRVRk+mA3fPk53z5JEy9p62wLgusb/rFthxpwZq0mxLEXUyZ3lfcnIvU+OvH9AVgB5La5OorHBlXS3lNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903742; c=relaxed/simple;
	bh=Iuin2TLNITc+qEDBj9pIL7Ct7NIGQ3DNopSaa0alFbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s0IWNwfVwzuhd7OUvt6s49H3tiIi4gXEj1QzwyaG5s4/v00dbkM+4vnGnOiLbK/Xm47/v7XQlTW90UPK7iuXCorMKEdnIqNi7W7yNRahi18KTKMT4bjdoob9zZXj/wQ+YE86RcWwRRz/aTzerJ2BoICJByjhcInEPsc+caffNfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzutiNMX; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903740; x=1741439740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iuin2TLNITc+qEDBj9pIL7Ct7NIGQ3DNopSaa0alFbU=;
  b=jzutiNMX99aq5E9FQ4oXdAGS/TeSRWAVR0gYCQ5XQXbl1XE5hCMSI9gy
   ZbI6TyyK5pTFsQGGoRF6xBXUlkSEC1l8Wx5WN9yoyIVCcMYohg5O6kjVm
   RZlHI0a423r5vlbUhyUmEgGM4fM4DTiK7Rdjc34I3KLim33gf9IoAZQl7
   vyU+t11P/2Kx2xhS3bFoNL6WWGIvOpXT7mWb7kcsVB5GFQ67MnmP5FWvt
   0YdXuWG+Pxch0JdoDnXUb9UfcBcj+uLaVVpYr/ShkM7eYTv6KHhWOg3HH
   5hvIkg1rMIiP2bXq9ps7hWWDQNuFFL/xpVp46b06+86dqqpphjFbTSZ6c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342392"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342392"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161352"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:27 -0800
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
Subject: [PATCH 01/19] vdso: Consolidate vdso_calc_delta()
Date: Fri,  8 Mar 2024 15:14:54 +0200
Message-Id: <20240308131512.44324-2-adrian.hunter@intel.com>
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

Consolidate vdso_calc_delta(), in preparation for further simplification.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 17 ++---------------
 arch/s390/include/asm/vdso/gettimeofday.h    |  7 ++-----
 lib/vdso/gettimeofday.c                      |  4 ++++
 3 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index f0a4cf01e85c..f4da8e18cdf3 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -14,6 +14,8 @@
 
 #define VDSO_HAS_TIME			1
 
+#define VDSO_DELTA_NOMASK		1
+
 static __always_inline int do_syscall_2(const unsigned long _r0, const unsigned long _r3,
 					const unsigned long _r4)
 {
@@ -105,21 +107,6 @@ static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
 }
 #define vdso_clocksource_ok vdso_clocksource_ok
 
-/*
- * powerpc specific delta calculation.
- *
- * This variant removes the masking of the subtraction because the
- * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
- * which would result in a pointless operation. The compiler cannot
- * optimize it away as the mask comes from the vdso data and is not compile
- * time constant.
- */
-static __always_inline u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
-{
-	return (cycles - last) * mult;
-}
-#define vdso_calc_delta vdso_calc_delta
-
 #ifndef __powerpc64__
 static __always_inline u64 vdso_shift_ns(u64 ns, unsigned long shift)
 {
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/asm/vdso/gettimeofday.h
index db84942eb78f..7937765ccfa5 100644
--- a/arch/s390/include/asm/vdso/gettimeofday.h
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -6,16 +6,13 @@
 
 #define VDSO_HAS_CLOCK_GETRES 1
 
+#define VDSO_DELTA_NOMASK 1
+
 #include <asm/syscall.h>
 #include <asm/timex.h>
 #include <asm/unistd.h>
 #include <linux/compiler.h>
 
-#define vdso_calc_delta __arch_vdso_calc_delta
-static __always_inline u64 __arch_vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
-{
-	return (cycles - last) * mult;
-}
 
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index ce2f69552003..042b95e8164d 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -13,7 +13,11 @@
 static __always_inline
 u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
+#ifdef VDSO_DELTA_NOMASK
+	return (cycles - last) * mult;
+#else
 	return ((cycles - last) & mask) * mult;
+#endif
 }
 #endif
 
-- 
2.34.1


