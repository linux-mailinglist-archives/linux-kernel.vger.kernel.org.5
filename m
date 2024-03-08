Return-Path: <linux-kernel+bounces-97061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C878764FC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B165B21210
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D59E219FC;
	Fri,  8 Mar 2024 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMIScr6W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485205427E;
	Fri,  8 Mar 2024 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903853; cv=none; b=pv4uzQWoJ4ojrGPaEIpzz+4k3L2LaFTHA0t/Yvvjp8lvJvFm0zXNMDog5Uvl7trpMNEmUGyJ12UHbUl+MaeDce4CN6sxLK+7doRgAnnLGEVX7xynvv7m+g15l0vZNKY10PnYHCjX+9kmbHwpgXP5gK+95DT+K0eb9kyn0kXAXhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903853; c=relaxed/simple;
	bh=qOOcsyBxpUsFxkAH1hi2UNpYCz2148dQEbBRMVKVw/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=njVPUfjSqqgOT1ucmk1KKv8I9NewZdeHbnVMt84qE+FwWS0fUa89umMN+snQl5VoJ6uA4l1ZmPeDICER7lQZhvV+BVmFMf+QUl2rkBX4aFiUX6q3sBiCen3tNkXEyTO2MJMxZPlaQagQjlcs7aiMfeyoNG0qN5zl7YskdWtB6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMIScr6W; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903852; x=1741439852;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qOOcsyBxpUsFxkAH1hi2UNpYCz2148dQEbBRMVKVw/4=;
  b=JMIScr6WEWbd9C6QngGhKDh3rKzNdpKf+t3DmDH3TXi73/csFH6nu19i
   g/nvvPpyVaVzcye5UjqVqgN6a/K1YQWgDFi2lUc5AqzrnH5tq5pUemB9+
   Y8AHaLmmcdXV2N5voWCQYNv0ky1TQGnXcf3zEXISVVNz3qdOh6AnWxqqv
   dW4SIt3qMVxEC09lkk798rOb8KBPQYKHndtT8LGAxvu23qs6mqnRe1XS4
   dF4OdRkLDw3GKylkCICinzE6PyNF8fYy8jhbXF06UYj4lHqsqM98VrdKM
   vjHRT31INNUqm2d/NvADqIbr7zWk8mNx8qJZ4axtDnqmLkK0WPXPSx6u5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342936"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342936"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161611"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:25 -0800
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
Subject: [PATCH 18/19] timekeeping: Let timekeeping_cycles_to_ns() handle both under and overflow
Date: Fri,  8 Mar 2024 15:15:11 +0200
Message-Id: <20240308131512.44324-19-adrian.hunter@intel.com>
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

For the case !CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE, forego overflow
protection in the range (mask << 1) < delta <= mask, and interpret it
always as an inconsistency between CPU clock values. That allows
slightly neater code, and it is on a slow path so has no effect on
performance.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 31 +++++++++++++------------------
 1 file changed, 13 insertions(+), 18 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 111dfdbd488f..4e18db1819f8 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -266,17 +266,14 @@ static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
 	 * Try to catch underflows by checking if we are seeing small
 	 * mask-relative negative values.
 	 */
-	if (unlikely((~delta & mask) < (mask >> 3))) {
+	if (unlikely((~delta & mask) < (mask >> 3)))
 		tk->underflow_seen = 1;
-		now = last;
-	}
 
-	/* Cap delta value to the max_cycles values to avoid mult overflows */
-	if (unlikely(delta > max)) {
+	/* Check for multiplication overflows */
+	if (unlikely(delta > max))
 		tk->overflow_seen = 1;
-		now = last + max;
-	}
 
+	/* timekeeping_cycles_to_ns() handles both under and overflow */
 	return timekeeping_cycles_to_ns(tkr, now);
 }
 #else
@@ -375,19 +372,17 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 	u64 mask = tkr->mask, delta = (cycles - tkr->cycle_last) & mask;
 
 	/*
-	 * This detects the case where the delta overflows the multiplication
-	 * with tkr->mult.
+	 * This detects both negative motion and the case where the delta
+	 * overflows the multiplication with tkr->mult.
 	 */
 	if (unlikely(delta > tkr->clock->max_cycles)) {
-		if (IS_ENABLED(CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE)) {
-			/*
-			 * Handle clocksource inconsistency between CPUs to prevent
-			 * time from going backwards by checking for the MSB of the
-			 * mask being set in the delta.
-			 */
-			if (unlikely(delta & ~(mask >> 1)))
-				return tkr->xtime_nsec >> tkr->shift;
-		}
+		/*
+		 * Handle clocksource inconsistency between CPUs to prevent
+		 * time from going backwards by checking for the MSB of the
+		 * mask being set in the delta.
+		 */
+		if (delta & ~(mask >> 1))
+			return tkr->xtime_nsec >> tkr->shift;
 
 		return delta_to_ns_safe(tkr, delta);
 	}
-- 
2.34.1


