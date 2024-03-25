Return-Path: <linux-kernel+bounces-116601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35388A8D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16B43B433D0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE3A1581E7;
	Mon, 25 Mar 2024 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a2v8Ujy0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1A815F417;
	Mon, 25 Mar 2024 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348901; cv=none; b=mohslj15zagYyKq+a7CtKUPGPm4L/CZCu8JwrGxx7OH3PJvxECPZh1d5zTNC26o9FqGzoBiczBnDjGbdCAR1jPBxxm8As5G7h74zYH+pJTPlATnCb4ClSt/5/tpSFHMDwNUNaCKyA0SI2sCCGUaNGWyJflta6qY3cCmc87i01Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348901; c=relaxed/simple;
	bh=zboSVI3HgVZXbpDBNnsTotqgGm69H9hHwUY1hZ67rA8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xl9tQ5d4Pn+3ewuxKsayb4b5emAOWhNgvKydTwhC5KbikgEWM6rL8Huu+Is6sMgBuoPZybBP+/pHw9uW8vsqWjofrS3VSXIMRewHWVAdmqwMvWH1YcIEcLSK1JMHHvUxLiZUzP0ZcYIDlKb2Zy8YtPaDuTdJFRmgA52RXQZJ+oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a2v8Ujy0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348899; x=1742884899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zboSVI3HgVZXbpDBNnsTotqgGm69H9hHwUY1hZ67rA8=;
  b=a2v8Ujy0sQ+IDOD9pVB2CMc/Jh0i+4V3YJqsJGXnddv7kTrDgxiRVM+l
   CnIaUQnNIoYKWi1z11gbB/+zdprGVb7j4PkZnywCdOIitt/tUz8WgbDC5
   sh/v+jHy+IyUbD7kYeQgedV2zHCP2uT557QzVDImuQ1YM6lwbHy/i6Rxc
   Y0cLTVn6Mq1lFxtlY4uDd3Kxc09+tmzCAmFUk4k7CkpimyNdmLJP4Qxk/
   vQCHSBDvSLV4mbOGPjtCAWbZ0aEnyj0/56oBmw5cIWCYINWUNDTRNvARo
   CYAYDQSstyiiHSysQuvOdGcX3JBGjPJysdyU6El041idJ0T6Txmj5D0lN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17065255"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17065255"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629609"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:41:31 -0700
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
Subject: [PATCH V2 09/19] timekeeping: Move timekeeping helper functions
Date: Mon, 25 Mar 2024 08:40:13 +0200
Message-Id: <20240325064023.2997-10-adrian.hunter@intel.com>
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

Move timekeeping helper functions to prepare for their reuse.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index b58dffc58a8f..3375f0a6400f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -381,6 +381,23 @@ static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 de
 	return nsec;
 }
 
+static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
+{
+	u64 delta;
+
+	/* calculate the delta since the last update_wall_time */
+	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
+	return timekeeping_delta_to_ns(tkr, delta);
+}
+
+static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
+{
+	u64 delta, cycles = tk_clock_read(tkr);
+
+	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
+	return timekeeping_delta_to_ns(tkr, delta);
+}
+
 static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	u64 delta;
@@ -389,15 +406,6 @@ static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
-static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
-{
-	u64 delta;
-
-	/* calculate the delta since the last update_wall_time */
-	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
-	return timekeeping_delta_to_ns(tkr, delta);
-}
-
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
  * @tkr: Timekeeping readout base from which we take the update
@@ -431,14 +439,6 @@ static void update_fast_timekeeper(const struct tk_read_base *tkr,
 	memcpy(base + 1, base, sizeof(*base));
 }
 
-static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
-{
-	u64 delta, cycles = tk_clock_read(tkr);
-
-	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
-	return timekeeping_delta_to_ns(tkr, delta);
-}
-
 static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;
-- 
2.34.1


