Return-Path: <linux-kernel+bounces-97054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2028764EC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9DE2814CA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789FD381B8;
	Fri,  8 Mar 2024 13:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n0+LTGFA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4333FBB3;
	Fri,  8 Mar 2024 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903805; cv=none; b=Gcp+LVraJ4PK30I6xMM8CZ46zUS2lvZsRvP2YnVMxwqf/bDSNPvN9eUEa7vKT1imlzNyuu7SfAtQ3/+dbEZKCKgIUO+2RcojCoZG9gF4C5uuJPmzHzk1gzGUuRZQq2WOCoCllmPzLXAhlZ828AUd+5pIzS7S/CQ+zSI4N34Tbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903805; c=relaxed/simple;
	bh=EgUgzUoucqqDqOU2t7gKumIS3qm9Toh3D3HqJIoc9lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QvYDegdH8S4vVQUnlzS206a3PnoARFUb9dEM564ogZtRFq2Qlz+Y5jMKp74Xc9mQjQglcW3EJjsob9EfuqwW1fovRCYPJiQBveBZ8a7/3xZ/jGDONlZkXVWAt/99EpnwDyVXnmu4rbJJhdA4micRWCQo21je+lJNMKUaAVYuiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n0+LTGFA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903804; x=1741439804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EgUgzUoucqqDqOU2t7gKumIS3qm9Toh3D3HqJIoc9lY=;
  b=n0+LTGFA7aFM3U8UwzwvDUpQ5sTjVH+/guIJD9bbgzGPG6ILukLswQrO
   OvY0PkgSXTpNRDgvmM89PUhK1gRXCSi1pIUcrw4+x80ri74LD3WblXhWk
   JSqcQDuMpBjFrCuVDhiy9sAFkyZyZ4B5YfeT9onYmdBFSulnlQ6pZBNjJ
   i4gYEdIieyFYium16cgVbmFEEGapVXGxwahsS2H6ALvkwmowMnofLWQiS
   HL0UD43TPH/14KJ6a5btKTFissWklcLgfcHzahtjs9p3VelIqmXuJAPWB
   NWi1axYxwnIKmOc7vQkKH0EBHVURrYWa0/JNntMZO/ccTv2cQOGe50wQH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342715"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342715"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161559"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:36 -0800
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
Subject: [PATCH 11/19] timekeeping: Tidy timekeeping_cycles_to_ns() slightly
Date: Fri,  8 Mar 2024 15:15:04 +0200
Message-Id: <20240308131512.44324-12-adrian.hunter@intel.com>
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

Put together declaration and initialization of the local variable 'delta'.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 63061332a75c..c698219b152d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -383,10 +383,9 @@ static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 de
 
 static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
-	u64 delta;
+	/* Calculate the delta since the last update_wall_time() */
+	u64 delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 
-	/* calculate the delta since the last update_wall_time */
-	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
-- 
2.34.1


