Return-Path: <linux-kernel+bounces-116592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAEF88A0F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B99B1F3A2B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C0E14AD07;
	Mon, 25 Mar 2024 08:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZedpXBTo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFED15FA84;
	Mon, 25 Mar 2024 06:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348913; cv=none; b=rHfSodhmCvGI5R8dMRuUXN3o6X6ftDMHgvy3N7WnXUvT6rcc4zboBm8qvFcaZyAVrDC6eeEN6EVZf1aeOEvD8IndHNUp3bHqCzJaAaow/JSjNXVzt0OZ+SPR1roiVPioKaTEiVvfT4vrAdnn5IVS/EKwXXH31Tbb6sIZ/7LyEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348913; c=relaxed/simple;
	bh=EgUgzUoucqqDqOU2t7gKumIS3qm9Toh3D3HqJIoc9lY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HzcSeeZRLydl2iH7T23mYB4QzM4x63aWkpjb5lxL55zquB0eAjiWpSVQP2vzc9R8wFoJIqM/K4Y3VWsZgPNnEPHvMGvAWPcLQ+tWfLuXcWQJM72foJr+pw4E1+Iefq/uuknLj6PQ++Qi2ZLhVn0Vki/wnmVIxQNoyTzK6ICTIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZedpXBTo; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348912; x=1742884912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EgUgzUoucqqDqOU2t7gKumIS3qm9Toh3D3HqJIoc9lY=;
  b=ZedpXBToNbQxuBmTYxz2khw+RLO14UlpptIQnSBqowq6QkIUPcafPRG5
   6VmtzfMV4yW0bnXVF/cu+OmPw5IumhCjkKSAl7gbc0OotQJz3pIhFs6KE
   Wmz12j3g6oNv4x11IK7Hk1uw+6yES9k5h+Nv5uVo+YM8EDvjgHTLvAn/3
   czaS+/XZRnH8XqQGri8We/DAVuC5QGaTwg7+/5yfQg5X1Aq8+5+KVrJSW
   Use67OcpXIo1+a+s4pGE4+UvzOT9E+jmtBbWkvPj+ecxytriEjjjQh2De
   zB2fZGlPLveIizGQG1X7vRIYPdhtmQkPporrhNvkXQJkNTNB3Oeug4L2k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17065310"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17065310"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629637"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:44 -0700
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
Subject: [PATCH V2 11/19] timekeeping: Tidy timekeeping_cycles_to_ns() slightly
Date: Mon, 25 Mar 2024 08:40:15 +0200
Message-Id: <20240325064023.2997-12-adrian.hunter@intel.com>
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


