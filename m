Return-Path: <linux-kernel+bounces-116580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A598188A0EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254AC1F3B116
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF23C13E3E7;
	Mon, 25 Mar 2024 08:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOEeOJN8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5A1607AB;
	Mon, 25 Mar 2024 06:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348946; cv=none; b=H5hyoFRMqCV8HGi8nJZMSvVuUGjUvqxpfsAp7u4NZaPkHftGQVztT88aiOHeDuSNMrcIFnJl7ajt2wmvHD+VmvM2Wa1uLO0atb58X2QMcROr6ZF6c5CVAJvnVDn++UqWwSkUVxqk8fiMa2n2al3Z/bTdEatPcx7bCeuM+hZyRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348946; c=relaxed/simple;
	bh=DWUH05pMFGBZtgh8QTM1fOtl5JuwFtwudYwKfS+CudI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOfeaW7s/FePoBegQgL62/f/7RCGgt1pQHspHOinp+kQ5DGF/oJjaUd4Ne0n9nWnwGyFELWvutuCoxaDEVbqCOU2+TSffLKxlzEjPaFdl2vcWFp3Aq/ArvLuxmco5tg3cruYEPFmMNidklECBhmZ/mSNoQ+3TdxVM4jNJLJ7sTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOEeOJN8; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348945; x=1742884945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DWUH05pMFGBZtgh8QTM1fOtl5JuwFtwudYwKfS+CudI=;
  b=GOEeOJN8Se0rzdnqooiTSNgPIv3jrJHcOdQeU8VbVlHlyPn+ZvUHGw8H
   JqLPNNlNd0BUDVH/HTsjmqoi6cO3rVX6b3d3ehaCuCClAKyd7868HquKS
   IDQqnjkn96TK7D1lKq9NhCtMx6Jaes90ayzl5LmeFkoXeN0DeT0HMX7iK
   QC1K+zuxHFDil83Bc1bobYe4m8zbUyp1EyFoLmf4vgZHV4KIKdQJfdw5B
   0ceqEBJkw0wHh2KQD229rgQ6uekzLB729eyrSx/qaQWGwEMSevEPTNkhI
   d+mD9GKK0kj1swlvABC/6Hge9JJ4BtnsrgYdYGF89Ph4F/YTU0Wc3pLzV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6191558"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6191558"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629701"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:18 -0700
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
Subject: [PATCH V2 16/19] timekeeping: Prepare timekeeping_cycles_to_ns() for overflow safety
Date: Mon, 25 Mar 2024 08:40:20 +0200
Message-Id: <20240325064023.2997-17-adrian.hunter@intel.com>
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

Open code clocksource_delta() in timekeeping_cycles_to_ns() so that
overflow safety can be added efficiently.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 749387f22f0f..d17484082e2c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -367,7 +367,17 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	/* Calculate the delta since the last update_wall_time() */
-	u64 delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
+	u64 mask = tkr->mask, delta = (cycles - tkr->cycle_last) & mask;
+
+	if (IS_ENABLED(CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE)) {
+		/*
+		 * Handle clocksource inconsistency between CPUs to prevent
+		 * time from going backwards by checking for the MSB of the
+		 * mask being set in the delta.
+		 */
+		if (unlikely(delta & ~(mask >> 1)))
+			return tkr->xtime_nsec >> tkr->shift;
+	}
 
 	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
-- 
2.34.1


