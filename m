Return-Path: <linux-kernel+bounces-107564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B3487FE2C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62AB8B22F80
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FA28287E;
	Tue, 19 Mar 2024 13:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J9R/1vyZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EC782871;
	Tue, 19 Mar 2024 13:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853614; cv=none; b=nCH4NcyHAHjEp/R80qc8saTO9oCAsqMnXCO0FS3nQ/eY6EMSPovM5JOhwtFQ/Umw0qNcfJl6D3g7T3+sVa1lkNcwBXmcOWxIO74b7IyTE8cIHIdue8+Nn+Cv69mjB0ZYh3tcRgKLGqgkFluvsFcnucF/J2KJ7A5UXzZjoi4y/V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853614; c=relaxed/simple;
	bh=KlV5CDUrB1wYm3hhtjGk3UkaNzeKBnXpOQYydmU3iM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aTt/CsDY5PqNN4oT24zlvX91+3MvHw8s64Do6mgsiRIovGkPnj1GkiI5azszbSLf+9iSZarG1nh2pbj5Zv6kxKNZ56FNoaBitifQv/9OQG7+NES+d5sEBm95Lcil/zGTmBW6BGFlgC5U+1zPXxqjrACp6Gzg9dpeM+Ntz5Nd3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J9R/1vyZ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710853613; x=1742389613;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KlV5CDUrB1wYm3hhtjGk3UkaNzeKBnXpOQYydmU3iM4=;
  b=J9R/1vyZrgoqQRS3+N2UJgiW1a/ecIE7iCKHYA64+42yvaXv5dlneRSp
   g9xDkEnO4vHw+zlpgo8KLuGTPS2Enay06E05NBpptrqMykLS7lTTbAhjl
   xdohJUbjIO3b/b9nBTgnNRhxZ0u9tqcAFL5AynMJ3zbuZjtzbqAuo30tH
   pHnlAaIMv5RgTw0FyF3JpUF1gyJDLOvyTWogULSa13QqQPCFzRqafDSGp
   LccIxkjzumLl2UcZlXh34T9TI48D4mwlIFYnn69nfg+VaM8lC4Ol0ZL47
   d+UaWlV5xtSZ/Ddi9Ne7W+3fywBcLXUmoscVL8a72+lwhJRwdEtPTY8V3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5843047"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5843047"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 06:06:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="44883246"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 06:06:45 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	subramanian.mohan@intel.com,
	basavaraj.goudar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v5 08/11] x86/tsc: Remove art to tsc conversion functions which are obsolete
Date: Tue, 19 Mar 2024 18:35:44 +0530
Message-Id: <20240319130547.4195-9-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The convert_art_to_tsc() and convert_art_ns_to_tsc() interfaces are no
longer required. This conversion is internally done in
get_device_system_crosststamp() using convert_base_to_cs().

Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 arch/x86/include/asm/tsc.h |  3 --
 arch/x86/kernel/tsc.c      | 60 --------------------------------------
 2 files changed, 63 deletions(-)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 405efb3e4996..94408a784c8e 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -28,9 +28,6 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
-extern struct system_counterval_t convert_art_to_tsc(u64 art);
-extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
-
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 45bf2f6d0ffa..5f0bd441ed4d 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1297,66 +1297,6 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
-/*
- * Convert ART to TSC given numerator/denominator found in detect_art()
- */
-struct system_counterval_t convert_art_to_tsc(u64 art)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art, art_base_clk.denominator);
-
-	res = art * art_base_clk.numerator;
-	tmp = rem * art_base_clk.numerator;
-
-	do_div(tmp, art_base_clk.denominator);
-	res += tmp + art_base_clk.offset;
-
-	return (struct system_counterval_t) {
-		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	= res,
-	};
-}
-EXPORT_SYMBOL(convert_art_to_tsc);
-
-/**
- * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
- * @art_ns: ART (Always Running Timer) in unit of nanoseconds
- *
- * PTM requires all timestamps to be in units of nanoseconds. When user
- * software requests a cross-timestamp, this function converts system timestamp
- * to TSC.
- *
- * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
- * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
- * that this flag is set before conversion to TSC is attempted.
- *
- * Return:
- * struct system_counterval_t - system counter value with the ID of the
- *	corresponding clocksource:
- *	cycles:		System counter value
- *	cs_id:		The clocksource ID for validating comparability
- */
-
-struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
-{
-	u64 tmp, res, rem;
-
-	rem = do_div(art_ns, USEC_PER_SEC);
-
-	res = art_ns * tsc_khz;
-	tmp = rem * tsc_khz;
-
-	do_div(tmp, USEC_PER_SEC);
-	res += tmp;
-
-	return (struct system_counterval_t) {
-		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
-		.cycles	= res,
-	};
-}
-EXPORT_SYMBOL(convert_art_ns_to_tsc);
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
-- 
2.35.3


