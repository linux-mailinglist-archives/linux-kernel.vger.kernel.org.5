Return-Path: <linux-kernel+bounces-97055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC28764EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4702B2811F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF45456742;
	Fri,  8 Mar 2024 13:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfUiGBOy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD24A38387;
	Fri,  8 Mar 2024 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903812; cv=none; b=sK6o7mmH6i2rkCydt+hlf5DVJi4H3x10EMGfTCSHH/tdR9Pq6UwSlQYOxNrtcDQueBiqqeFmdjg3oEKE04dC9DxJZPrSPEg3NQPVSD1wd526OfsXlWp3qsCeLCR04o1hixNZUcWmcgp+sjHk7xj0byktTju7Rd61218VKBEBSuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903812; c=relaxed/simple;
	bh=ul0hfPOmfS7i90s07MvVRoTCajL4zQDIAp9Wq9nGTHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k+Jneco8SpbXarMh1HENw/Me6kxPY8jAxv/2gFQPLdR3xsEPKWKXGQFt4aQEhqDA5TBgxfQyBSHccsJPF3R7JcE76pQQmiVh/Lh89crzr+QU47+WnUlCyrDOicuT+br90nuRcKF9S9ghv0s0DSYv6q0zxLzFP+10cMoNNPnSU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfUiGBOy; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903811; x=1741439811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ul0hfPOmfS7i90s07MvVRoTCajL4zQDIAp9Wq9nGTHo=;
  b=NfUiGBOyiZV4+jXBf/e9uiH+/EySwh1FZmreDK9GkWWEq4rgqQVd8MCL
   NwBcsFZXkX7TLM2INcgSYKcEk76Ie4Yx8B83OvWHwu2VNW0C5Ha637r4A
   H95pnJilJ+B93WCk4WSwH9sg0LollqX4pyasR0tRtzjR09IDeYcssiQPh
   3uOJhB4QPMsShEsJYPDcPg6M0bS4xGHy8aB0mSYSddIsV5JoMNBmpy58P
   ZFrLJwOzsTJq2TlvWMJ4v2ubrt70y+tC4YoK+L1rx4cpqPBtE/TN7SQzg
   BgQmjLlHujWuznMnoToNY52kSDC9477uepSZt9Lpm8bnUHi7iGBuWYI5A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342750"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342750"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161564"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:43 -0800
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
Subject: [PATCH 12/19] timekeeping: Reuse timekeeping_cycles_to_ns()
Date: Fri,  8 Mar 2024 15:15:05 +0200
Message-Id: <20240308131512.44324-13-adrian.hunter@intel.com>
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

Simplify __timekeeping_get_ns() by reusing timekeeping_cycles_to_ns().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 kernel/time/timekeeping.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c698219b152d..f81d675291e0 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -391,10 +391,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 
 static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
 {
-	u64 delta, cycles = tk_clock_read(tkr);
-
-	delta = clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
-	return timekeeping_delta_to_ns(tkr, delta);
+	return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
 }
 
 static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
-- 
2.34.1


