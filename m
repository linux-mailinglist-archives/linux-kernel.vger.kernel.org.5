Return-Path: <linux-kernel+bounces-116602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3906388A119
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78668B32490
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC37158D63;
	Mon, 25 Mar 2024 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KyfdVzKA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E8E15FA6B;
	Mon, 25 Mar 2024 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348906; cv=none; b=VEOBm23YoE9aQp9R7hA9RYfckUd7JVdW8L5Dg11pZh0F62dgPTJAl4K5w6Q86UtkWazqd70NqbNlH7SrkimU8Srd76htn+vU9HWLjl18PWxrwT8myvQjXUSdvB7SJe0/uh+ttRWak5iKSejMBjXXEG+/lROD2oTEIirrHZe3jBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348906; c=relaxed/simple;
	bh=qTxeGZya5tNrF+OulKJd9BaTzgUsvcEDLjRYcSx3zxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XwrAFMfeotmgKTHTwhQ+TGPckM5M8uMnUQdLRn/M53Snjdaa3ROqUmIfl6/ML0f+ajCRyVzpzoqknujpzBTiT0EQi2Vq4TQcEULEXIWkYO8SquOZ3raGA0EFlkHjAgSSg8HMzUOk1XTKJDrAEj0K/C1M8XIc8NZJLdaNMFUHGKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KyfdVzKA; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348904; x=1742884904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qTxeGZya5tNrF+OulKJd9BaTzgUsvcEDLjRYcSx3zxw=;
  b=KyfdVzKA2s5LNA6XOx/QJjp5EVFFa5tHytycZznjyGLYetPwC1yYsH5z
   iazY84CZnioFJ/Cfj9VEnaLJ5YJu97gqPxJovMOLsZyNbHnFOrE3vaUMj
   P0kpCcE8epnToPWEqCLVDFZK5RkrLxe7U4GEdyql/AtO1e0rVK7t39HsT
   uSOt895YxqM0mou8zC+9yusH8MjJw9VhPI7EEfL03LlaP+R+NKVX4UPqe
   LN0dEFEJwOeDD6ccscGrkefuF4eMmtaKuaBCNdyWNdgF+WoOUWDUPA4zU
   75clAGEnfQ5M7uuxNhKr71Lchz50VuxeXRwRvFRJ0hP6yAXNhE3Ga4rEu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17065285"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17065285"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629624"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:38 -0700
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
Subject: [PATCH V2 10/19] timekeeping: Rename fast_tk_get_delta_ns() to __timekeeping_get_ns()
Date: Mon, 25 Mar 2024 08:40:14 +0200
Message-Id: <20240325064023.2997-11-adrian.hunter@intel.com>
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

Rename fast_tk_get_delta_ns() to __timekeeping_get_ns() to prepare for its
reuse as a general timekeeping helper function.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 3375f0a6400f..63061332a75c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -390,7 +390,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
-static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
+static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	u64 delta, cycles = tk_clock_read(tkr);
 
@@ -449,7 +449,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
 		now = ktime_to_ns(tkr->base);
-		now += fast_tk_get_delta_ns(tkr);
+		now += __timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
@@ -565,7 +565,7 @@ static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *mono)
 		tkr = tkf->base + (seq & 0x01);
 		basem = ktime_to_ns(tkr->base);
 		baser = ktime_to_ns(tkr->base_real);
-		delta = fast_tk_get_delta_ns(tkr);
+		delta = __timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	if (mono)
-- 
2.34.1


