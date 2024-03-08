Return-Path: <linux-kernel+bounces-97059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6530E8764F7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19B201F26670
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894AD5A4E3;
	Fri,  8 Mar 2024 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rlh/Hufe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5438240856;
	Fri,  8 Mar 2024 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903839; cv=none; b=cmd19LWbEqoZD9BnVZtvMTGm9SnU/CvtWtsVUHYhtWlMIA3N/PbjLCBqb0wQfx/vZbqB04kl1rWyPbbuo+plYingMcF4buMD0YJ4/jaoSe1rJtOAsjdbu7IZfly2MyVJciwVSRw8MuKoR9o2h+b+uAnKqUJOKv0f3CvLOTRXDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903839; c=relaxed/simple;
	bh=DWUH05pMFGBZtgh8QTM1fOtl5JuwFtwudYwKfS+CudI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnjjgtykDRn9D6djKyLPfVdQNK1c3LyDnP3pfdRtWS474gd9iQQdjsMLqiGNDo/RUUBO6Alvg5MJT59J+XrLmLI6Lld8RqH5m2cUITo58aZynOowU74KIVtnUDWfwIyqGeBTHWTjmlBvCxql0kPSAFWzHRvW988o3bPVQn5i+wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rlh/Hufe; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903838; x=1741439838;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DWUH05pMFGBZtgh8QTM1fOtl5JuwFtwudYwKfS+CudI=;
  b=Rlh/HufegFvRLv5oAj4aJNd+EEh/Xfl36NqoNDiDO5Wj873wZhJz8X8h
   0Ev7/NhVhiqqN/6GVKQZmsXKuKpM/Jvbm1TbCpAgzAZ+IUcuwaNNXlHkk
   fV2fzClrqTRuB0ZjpIvf06EPmzc16NaaNFa3uH33vfeq/zk+MMyzX8gr2
   lcFHHowllXGZyns5qnPBN/RygdzAQr5LZssIwVfYq2/MVDPp1/3/LsW4r
   eYeGPZ9Ki3f+JwXi8voObU4J7abNwPnIAOxOoNq/FRQ4yBfPeiQJ9zgC4
   YN/+CfUPqHSNs3ZHWlO1eL95KhVhu9oMQaccx/7jJ9JdQ6MpuSUo4kJuk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342880"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342880"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161597"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:11 -0800
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
Subject: [PATCH 16/19] timekeeping: Prepare timekeeping_cycles_to_ns() for overflow safety
Date: Fri,  8 Mar 2024 15:15:09 +0200
Message-Id: <20240308131512.44324-17-adrian.hunter@intel.com>
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


