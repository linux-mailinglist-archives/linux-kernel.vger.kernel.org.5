Return-Path: <linux-kernel+bounces-116587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3F0889EE5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FF91F37AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A9146D59;
	Mon, 25 Mar 2024 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ccf6e5TX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCF16131F;
	Mon, 25 Mar 2024 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348961; cv=none; b=GZplR6lTWEycOPWKtaSOaVZmc/kmWjXvd+hlCXqWa8d5zPBdCj6c390QdNKjCanNODDiTO5KeVw/PfBM8oGyOw/bQ8tt3iA7ir7jl4BxOpHGdwehXo0shI26sboSZDKvx4ZNbL4JMWN8O2SjdeY0WRndo6KaLfoGlO21QS+Ip5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348961; c=relaxed/simple;
	bh=qOOcsyBxpUsFxkAH1hi2UNpYCz2148dQEbBRMVKVw/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAvk1vyUzTjzbcQHFHntucgHdsemm2MLjTib9UItFITf6c1x5AAnZLF6YsClzbG9JFusen9REPTJyG+sc5+VJB0QBRGQYR7zJJ0lR8YD1/a+u/xT9ENhwL1xjhWhLeWqgDrt4XeUybCNIGVXl57ehWIlgPcHx4U37VQRX9OxHts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ccf6e5TX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348959; x=1742884959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qOOcsyBxpUsFxkAH1hi2UNpYCz2148dQEbBRMVKVw/4=;
  b=Ccf6e5TX60YVh3RAGKD3v7K8r7FMP6j0jRM+vq7+0d4MdzRYVxan1guz
   wjBg9bugYYqDetiF6mtAuSfZolfOphFky2rbAwxGjZcQTO2MGxfJjxllV
   tZ8AD+2EtZZX1TnIuC55tGvCkFaLRxlgjIxes2bLe2VqUtLaAAQS5JtHY
   HJFFtvI7h/4A6LoqnF5uXX8zVnbbe0C2Dn6nMtkDsrdR/BT+icAlOM54e
   FfLjaKi1AJiGWWoXVBtIjS2tKUY9xSu9mfPuur7Y/+eHnYxS8Y+vkJ+12
   8MnMGxkUoqxC48em02KDlKZW+Ub7CDlJrp/ElQOchg/RCOwjSKBlT2Yv9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6191594"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6191594"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629710"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:31 -0700
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
Subject: [PATCH V2 18/19] timekeeping: Let timekeeping_cycles_to_ns() handle both under and overflow
Date: Mon, 25 Mar 2024 08:40:22 +0200
Message-Id: <20240325064023.2997-19-adrian.hunter@intel.com>
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


