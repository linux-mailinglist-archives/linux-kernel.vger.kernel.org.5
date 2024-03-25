Return-Path: <linux-kernel+bounces-116577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EAB88A0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731C12C1C4B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D20D73177;
	Mon, 25 Mar 2024 08:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kacXCTsG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039391607A9;
	Mon, 25 Mar 2024 06:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348936; cv=none; b=CpvxMsFVcak5N43K6gx2TmQR4bH6gI/iIvBn+1G95YxuHuYohDbJ2B/qQFU1dWUALwDrGpirdSyZSk3cS03bLZQmKZdYS0pBPqb//drjkg/EW/cGmJCuu3x7y1X61GxKj+RrDGju5OFhZI+yfzzYFYuvF/r3ntsd79Njp1zEu2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348936; c=relaxed/simple;
	bh=16GQ0vc+mvjtkGYNmUSKlWdfc5Q8uWzvZ2NpVFo2g5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p08Nnba5CYMaatFqWY9C/1uT9n0CaBGu1cK5AOuM/TZI/LqP/9eE6+zEJBaX3Hj6vRcMDCHB/zXLUUV9N4BQy16z0orK2IC9jh8qMgWsTkRbClMGFgdIjGRgnFFPg+IRUOAhKGUFOuIi7b2FyEhLHWcUP93cSTsU+qLpgRLe1qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kacXCTsG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348935; x=1742884935;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=16GQ0vc+mvjtkGYNmUSKlWdfc5Q8uWzvZ2NpVFo2g5s=;
  b=kacXCTsGv4OpHRPuTJrcg6HgzlpoQXPEGWjLDeYr8GcjKPFx1yYrrZGp
   n/cSY714LqlZGpKjqYkRp+MIMZNv0vPBqeoSi/L2K8Pc1qYpn1lWbBqeb
   sB43kHwjXHxWLITOHq5h5jykb0Ccd+UrWY2hizkMFj1ifyGHemoEF21bX
   etXVgkQJiybwSp6UyvjhQpdokIwWnl/TlGTqD48DD70+vO6NblqwZF9ne
   GlBR7wmfmLMSMSTiSWV/T/XFqpAgrDno+UVHGUlvFpbgWUP8iJVxfj+Bt
   VPtq/cm2ee/NcqBhAnVJmAEEnFHFCeOSPEAi7yvRexcfOxwX74jWBFHgY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6191502"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6191502"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629669"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:58 -0700
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
Subject: [PATCH V2 13/19] timekeeping: Refactor timekeeping helpers
Date: Mon, 25 Mar 2024 08:40:17 +0200
Message-Id: <20240325064023.2997-14-adrian.hunter@intel.com>
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


