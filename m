Return-Path: <linux-kernel+bounces-116583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8537F88A0EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BCB2C3621
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528C144D1B;
	Mon, 25 Mar 2024 08:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KGKbAahb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54E15ECC4;
	Mon, 25 Mar 2024 06:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348847; cv=none; b=KI1I8WUf4WKZPSdZffNrBsbaw/yp+MY0uOjlknd4DJgI2W5jFO4Q8uTSfpDO8wYzXOoHE1PjmkaTi4A3w0jLjiSJFVu0m5oZjvdpPtN2Hg0YOqlwWiFzCiE+oX7WJir6qss02KsFmuPFbx7aeWq6rvtrWx9yKf6SlHQuABvgaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348847; c=relaxed/simple;
	bh=+W4K6lkGmf5ZfckuHCgiOpf7pq6FEiJVqi6VEtd9uvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rktLBeQbNy69mp6URDqkRJ4TvicxePJM219GZuiDtsqP+ecA2yAdSYncteaOPPugErakm6AbA+BlN7jEWtn8VuPelrl+EzUgmtW+rhtZSQzUr3KLTh21MKGXg8WCUushXJWsYSWDcKHqtqBMxYFmqUkwW3iUp6krJdXsJxdOzmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KGKbAahb; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348845; x=1742884845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+W4K6lkGmf5ZfckuHCgiOpf7pq6FEiJVqi6VEtd9uvE=;
  b=KGKbAahbFLATVQf1u4Ezo8PQ0p3VdtTfjfNCYeb4sLw8h7QV1lAlmVB7
   jW+46FLMtggeW6LioUmNXmKySMLavtCGyZrS3hW5BTL1WW23VlAXnxhY4
   wqn4zgZgzUMGJ2aB8HaeYvEJLsofMgm1en7Q7akDd+bqR3kCF5YU39qXx
   kK+AfWCI8b9h620b7C0eSsM+kXRKtheOz4J3OwUrNzlHYv3k0CCTUDbYt
   COvw1cnzIrNNDgw5yf0Yileb/Zfv8IFV0c/xPDXcyrOrTp4J5dmTaiGKu
   OJWikf4GtCsgR1fBRbbuLxs2B+A/IAJ6z6fxXxEUdFwWmX1yV9zRFlFUH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17065072"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17065072"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:40:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629565"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:40:38 -0700
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
Subject: [PATCH V2 01/19] vdso: Consolidate vdso_calc_delta()
Date: Mon, 25 Mar 2024 08:40:05 +0200
Message-Id: <20240325064023.2997-2-adrian.hunter@intel.com>
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

Consolidate vdso_calc_delta(), in preparation for further simplification.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:
	Keep powerpc comment about mask
	Move ifdef out of function


 arch/powerpc/include/asm/vdso/gettimeofday.h | 26 +++++++++-----------
 arch/s390/include/asm/vdso/gettimeofday.h    |  7 ++----
 lib/vdso/gettimeofday.c                      |  9 ++++++-
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index f0a4cf01e85c..ac21a2a0c2f9 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -14,6 +14,17 @@
 
 #define VDSO_HAS_TIME			1
 
+/*
+ * powerpc specific delta calculation.
+ *
+ * This variant removes the masking of the subtraction because the
+ * clocksource mask of all VDSO capable clocksources on powerpc is U64_MAX
+ * which would result in a pointless operation. The compiler cannot
+ * optimize it away as the mask comes from the vdso data and is not compile
+ * time constant.
+ */
+#define VDSO_DELTA_NOMASK		1
+
 static __always_inline int do_syscall_2(const unsigned long _r0, const unsigned long _r3,
 					const unsigned long _r4)
 {
@@ -105,21 +116,6 @@ static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
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
index ce2f69552003..faccf12f7c03 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -6,6 +6,13 @@
 #include <vdso/helpers.h>
 
 #ifndef vdso_calc_delta
+
+#ifdef VDSO_DELTA_NOMASK
+# define VDSO_DELTA_MASK(mask)	U64_MAX
+#else
+# define VDSO_DELTA_MASK(mask)	(mask)
+#endif
+
 /*
  * Default implementation which works for all sane clocksources. That
  * obviously excludes x86/TSC.
@@ -13,7 +20,7 @@
 static __always_inline
 u64 vdso_calc_delta(u64 cycles, u64 last, u64 mask, u32 mult)
 {
-	return ((cycles - last) & mask) * mult;
+	return ((cycles - last) & VDSO_DELTA_MASK(mask)) * mult;
 }
 #endif
 
-- 
2.34.1


