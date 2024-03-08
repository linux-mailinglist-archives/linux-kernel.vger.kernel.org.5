Return-Path: <linux-kernel+bounces-97057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F27F8764F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32C5E1C21BAA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38B440870;
	Fri,  8 Mar 2024 13:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TMKTYmab"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9F058AC5;
	Fri,  8 Mar 2024 13:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903826; cv=none; b=Wq429A5gVGa6TXS2rj5Hj8llqnz3CK0F1+41S60M/pM4ezDlx4L3soWUZsg0O77t7YsDcdVnmoKkMNbb61nrOjfFxfCAJNWCqj8jnT5gbp050GYKtKuWFaVQar3BNOfbKHE5/d4K/k976fVFDYAqQxuBhH8jBD06IGPq218pi1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903826; c=relaxed/simple;
	bh=I/EwrCmdvQfW3F1Dq8qT6GRyUT8dQLcc34j3rdWdn4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxcyQagdkq7cC/F5MFQxwpOm0apWKVAlpDdmGjpeszgXs6sSGK0HzeNj7OP9l15eMwK1eSgmM08WmMK8sIWygNq6sBxy+IG0xd1Y/H33HfDV0tG5Nk8814yyQ/oL1TCx2qW/Jcwbm3Ed7Vg2wvMNynGaqBNiE6TqQ1DshBu9Jd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TMKTYmab; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903825; x=1741439825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/EwrCmdvQfW3F1Dq8qT6GRyUT8dQLcc34j3rdWdn4M=;
  b=TMKTYmabi6SzTweRmMcK8UlmPkGn56vK9xHxKc3eO22gWVkT295tj64D
   Q8W7Pm9t37VncRetjZSJx9lRIrrv90B7dp2SqqBftx/7nOR67RI4QNLAF
   A3Fbz5ueTP133HJwoIoMfs3tR9sNkslcWspPr4+OZMh2ZgwiyizO1BsSV
   25NnOuMqFWi4zoUaVIpYLdEAwKEu3NmB6H7IcIGiKBgjCCirp9YnK5E4q
   RCf6nzpZ4+f+bwBvACy6MSJsl1IMR0XY5maoaGQK/hHUl8NKnFgfIotIt
   v6phDSIyBR9ZYtcez1VgDAD2fr08FxVDmWSR3qDZOrwtCV1UcGUw2KXg1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342824"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342824"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161581"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:57 -0800
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
Subject: [PATCH 14/19] timekeeping: Consolidate timekeeping helpers
Date: Fri,  8 Mar 2024 15:15:07 +0200
Message-Id: <20240308131512.44324-15-adrian.hunter@intel.com>
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

Consolidate timekeeping helpers, making use of timekeeping_cycles_to_ns()
in preference to directly using timekeeping_delta_to_ns().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 618328cd4bc4..1bbfe1ff8d24 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -237,7 +237,9 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 }
 
-static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles);
+
+static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 now, last, mask, max, delta;
@@ -266,22 +268,22 @@ static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
 	 */
 	if (unlikely((~delta & mask) < (mask >> 3))) {
 		tk->underflow_seen = 1;
-		delta = 0;
+		now = last;
 	}
 
 	/* Cap delta value to the max_cycles values to avoid mult overflows */
 	if (unlikely(delta > max)) {
 		tk->overflow_seen = 1;
-		delta = tkr->clock->max_cycles;
+		now = last + max;
 	}
 
-	return delta;
+	return timekeeping_cycles_to_ns(tkr, now);
 }
 #else
 static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 {
 }
-static inline u64 timekeeping_debug_get_delta(const struct tk_read_base *tkr)
+static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
 {
 	BUG();
 }
@@ -389,7 +391,7 @@ static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
 static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
-		return timekeeping_delta_to_ns(tkr, timekeeping_debug_get_delta(tkr));
+		return timekeeping_debug_get_ns(tkr);
 
 	return __timekeeping_get_ns(tkr);
 }
-- 
2.34.1


