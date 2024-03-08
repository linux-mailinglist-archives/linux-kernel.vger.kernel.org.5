Return-Path: <linux-kernel+bounces-97058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0346B8764F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A78031F26356
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AA448CC6;
	Fri,  8 Mar 2024 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bHR9MvAj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E240856;
	Fri,  8 Mar 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903833; cv=none; b=fe9C1uawRmX85BlFeKCwJy2VINgR+TYfof1fd//IZVLjRZIu1JK3/rmAxR4PZPHVg/6qoDbqqRq5QsBzhxm/jyejO7FMvtLXo5CeAJSjn6Z/+lSwLz8vbPb2YFZdxVBjsnuCRzyjo6A0iLtZKwrgbUzAnFmZHnlJKkfUPiulPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903833; c=relaxed/simple;
	bh=XagHsKZy0o0b/SfCKSGfthtDX1F7t80ikEGTTX3TaPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oW45qaC/QhfoCM/AVbzjHzNA8ySRngyyH2HZu+Kyqy3chCPe6CpGidAsoYgAR2xbfeH2/+9gXpIYFuqfal53STnFLBwRk7ITUIiNbAJwqA3pHFVJpMhVmx3ZW0zVGS3Ua601WFjOsUMTANnPcsYHYLfultkptuQKH6XnQ6b3k4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bHR9MvAj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903832; x=1741439832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XagHsKZy0o0b/SfCKSGfthtDX1F7t80ikEGTTX3TaPM=;
  b=bHR9MvAjaqnQxkyg2Gsn3BDEvOde6jql6Vk/hG2/5BNMgzCSIqz08zrs
   O9UbyRuoU0BW7aeBQ26CZtENnWrOjO5E+kvaDlWFhDbm7XvvzN6+NqGqF
   /dHDhnjfXPvhvh33suQkh47xtDrG/a4YcB9uhGDz0m+qzujQQBUS+/46U
   yh8mSdnV0dcKIbNMiDcOyvn/5Co0u46GPCukl9deg01rvbKlvJDInK8o9
   Et/bfPjjvmZPe/Kff7xezDBOvMRLhv9BkqcZqXUikb9blbjNWTaPHiV9r
   aMsIEQYLR+c0q2aXLPFf0LkouZK4dw+JHxMMn3WTuz5dBGJv2GiLcOzbb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342855"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342855"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161586"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:17:04 -0800
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
Subject: [PATCH 15/19] timekeeping: Fold in timekeeping_delta_to_ns()
Date: Fri,  8 Mar 2024 15:15:08 +0200
Message-Id: <20240308131512.44324-16-adrian.hunter@intel.com>
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

timekeeping_delta_to_ns() is now called only from
timekeeping_cycles_to_ns(), and it is not useful otherwise. Simplify by
folding it into timekeeping_cycles_to_ns().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1bbfe1ff8d24..749387f22f0f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -364,23 +364,12 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 }
 
 /* Timekeeper helper functions. */
-
-static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 delta)
-{
-	u64 nsec;
-
-	nsec = delta * tkr->mult + tkr->xtime_nsec;
-	nsec >>= tkr->shift;
-
-	return nsec;
-}
-
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	/* Calculate the delta since the last update_wall_time() */
 	u64 delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 
-	return timekeeping_delta_to_ns(tkr, delta);
+	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
 
 static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
-- 
2.34.1


