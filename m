Return-Path: <linux-kernel+bounces-116578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5688A60F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC022BC56C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1522313D50B;
	Mon, 25 Mar 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mE13p/MM"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688C61607A8;
	Mon, 25 Mar 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348938; cv=none; b=NJmunuLwrk5asK+cfFDPjPeB02ItgKdzOmTuVHKmLmItfL/Ym01nPaYDBnmg8dwKR7P5/D+wDqTQIChnZbGqyavkjZOFZVkR5W0wRrzdFC1M2Gi20EnsKin4kKwTIBk9HK/WFr9Efk0MMIoIZ25nDq4tg+M5mj3T6BpJapP/sTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348938; c=relaxed/simple;
	bh=I/EwrCmdvQfW3F1Dq8qT6GRyUT8dQLcc34j3rdWdn4M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ely7px65MhMkmqMkyWutyHuxxVSor1JnwQZfTuC7sA1Wk4II8ojecNjDUVgueMeK2c8wihSDiE+B78GvuSP7PckrCacP52XR55oGronj6AFX9aH/ry5D+P6941kSh0C+Rrer+AqIQcbAX0KFB8QGAlA9sMSVedyDrT839FRY/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mE13p/MM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348937; x=1742884937;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I/EwrCmdvQfW3F1Dq8qT6GRyUT8dQLcc34j3rdWdn4M=;
  b=mE13p/MM7yPeotba7fz8QdXsEs13TycvCiaJm1eGYiWn4HHsxjFBKmHA
   WkBRHvkwKWNa8+pyRs+D7A5TXd5B4KGWxjB8Ga9VlulKKZtVXWbHBKLjv
   72udsjtT4KjWc+oTN1/1R8ddhaU4c0qp/Tf0mtx7P40KrsnE1cal4Q8DK
   Fox9War5vxx+KLSraVPnEyD+siFKVKllV41QyhPoUd3LqCuKOiLMp5kbf
   EyxdufrYG2auz1rzcot4R9p8g9KWZPs+AlQJAtjwdOx8EQxGUixVHwfal
   gE3yjoNPKE2b2K2SRQriiDxc3n4+QObhb3JFFwqfaYpijrsRMFrN8N2Um
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6191517"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6191517"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629681"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:04 -0700
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
Subject: [PATCH V2 14/19] timekeeping: Consolidate timekeeping helpers
Date: Mon, 25 Mar 2024 08:40:18 +0200
Message-Id: <20240325064023.2997-15-adrian.hunter@intel.com>
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


