Return-Path: <linux-kernel+bounces-97056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796608764F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120F01F25E49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F47439FD9;
	Fri,  8 Mar 2024 13:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEyPtNHG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4690758201;
	Fri,  8 Mar 2024 13:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903819; cv=none; b=t9AKKrhlDzBytx+nC+StyMj9H3Vg1rYwmZu/lFmrQmxqs4Sx/2um/hnSvK5WknfBFMsoOgD3m3YxEH89ruWISx9Ttdg1MgaYFCd1EdI16oB+qOuKpuoM/x6pdAnR2qrI5R0qI3z/VMteDIPBI3M4eWoMBntaS+/WzWF0+0F5bDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903819; c=relaxed/simple;
	bh=16GQ0vc+mvjtkGYNmUSKlWdfc5Q8uWzvZ2NpVFo2g5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kYBTLups2TKgphcwpAtkD2AUxEh8dbmpx3/43JZBZZdzi/KMmdkf7ZMDgJIp91SUsfHP38nRIx8wYVbzoRTARbSE9Yz0De31pB9oh7dGq38ntDfZtAoaQvTjNMHjxTiDNTTEvbUJ2HDIWrS98u7951hs3A6pskydYJzintJQQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEyPtNHG; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903818; x=1741439818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=16GQ0vc+mvjtkGYNmUSKlWdfc5Q8uWzvZ2NpVFo2g5s=;
  b=PEyPtNHGAHMaQeIokG1H8Frt0SS5NHvLyECmGUCSWQRpJtfi03UH/f9f
   wUk8AUcMRXklr1dYUvnSRJQ9VsMIKJz3pbBEMTYtzcukAVlI2LUXHyl8q
   lyQqaFw4HLHfBkYGczB0dHR1Eh2HmFLOY35MFKfyhf2zzylLHjKeLEKW5
   M9LtHJmVTjegJb4dPJqKHaFiTSYXKjt73q9hn1R39O5wIjvV4k3igPPph
   WS53jrQ2Py79G7Nzxq5f87lbCKzMMvMnouG6phvhNu5EaLxxttiE93sil
   nAwgZSB7B6R/sw5Waj2lD15fyQwLd3tIUQpH3NENQwwWDjdCY6kwRz994
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342797"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342797"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161573"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:50 -0800
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
Subject: [PATCH 13/19] timekeeping: Refactor timekeeping helpers
Date: Fri,  8 Mar 2024 15:15:06 +0200
Message-Id: <20240308131512.44324-14-adrian.hunter@intel.com>
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

Simplify use of timekeeping sanity checking, in preparation for
consolidating timekeeping helpers. This works towards eliminating
timekeeping_delta_to_ns() in favour of timekeeping_cycles_to_ns().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index f81d675291e0..618328cd4bc4 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -237,7 +237,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 }
 
-static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 now, last, mask, max, delta;
@@ -281,17 +281,9 @@ static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 {
 }
-static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
 {
-	u64 cycle_now, delta;
-
-	/* read clocksource */
-	cycle_now = tk_clock_read(tkr);
-
-	/* calculate the delta since the last update_wall_time */
-	delta = clocksource_delta(cycle_now, tkr->cycle_last, tkr->mask);
-
-	return delta;
+	BUG();
 }
 #endif
 
@@ -396,10 +388,10 @@ static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
 
 static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
-	u64 delta;
+	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
+		return timekeeping_delta_to_ns(tkr, timekeeping_debug_get_delta(tkr));
 
-	delta = timekeeping_get_delta(tkr);
-	return timekeeping_delta_to_ns(tkr, delta);
+	return __timekeeping_get_ns(tkr);
 }
 
 /**
-- 
2.34.1


