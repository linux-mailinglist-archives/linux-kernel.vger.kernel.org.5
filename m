Return-Path: <linux-kernel+bounces-116600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0871D88A0FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80D51C37F62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C278C157A51;
	Mon, 25 Mar 2024 08:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ckqX5eEn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8415FD0F;
	Mon, 25 Mar 2024 06:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711348940; cv=none; b=hWIj8TH68KIcimqqb24eij+fXz7nq3eZ+/cJbg3J86bBXaixDasF/PdmXcgLY+LajlDzbpQqlm2yt8Yl8WBIkumJsrRW7zF7ws1BGFklfrgHttIOFnwKmmnRCbtWfEDfoHfl3x70xZdNK5603NUa12oSHdNTh0VnjBL91SEEBtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711348940; c=relaxed/simple;
	bh=XagHsKZy0o0b/SfCKSGfthtDX1F7t80ikEGTTX3TaPM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eEpEZiOEnr6Quqnldh66MGafCyPmlGhtFW8b7foHZSBCt1GPxM96jBUJ7AeJPGwTzDU0wdXl2ghS29nZWiXV6vJDgi0Rck4fqgcI4DITGYLwDX0pj9ioTlN0Z9bjXNPYILi2P4uR4p0sdM61wSqaKrrZPjTa7dCQPWvAnDmgfpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ckqX5eEn; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711348939; x=1742884939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XagHsKZy0o0b/SfCKSGfthtDX1F7t80ikEGTTX3TaPM=;
  b=ckqX5eEniHY+A6sK/F41fC5asgkog6yJ0hGbXmo1RNw3f8lqLii86HlO
   6UviiCgfDFKMhGw7rZ9Ni0DMvVT7BzDGhw0TfjXFp14tS3BAcgYUFRaZ1
   xPWF0tUMSgZLmkq9DX6PP3jzqoCk+aA5QMLsHfaQE0kaLEEFcVxsefziE
   vMXgNDZ889wHbsdj5eR+8mH6ER7G3Cy5Fkkrka6E0DnYlaTePjkQMnOVT
   PyXYJj3jF22TmwrVdLLdG3G7/a5IRp7T29MfVTeGy6TboaGE5Krs3zM7I
   Si1L1YWBuwQMurEJSde9ghqFhu17noba7FII2sWx5DJlNwEPL+SBJeQXR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6191550"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6191550"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="38629691"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.211.155])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2024 23:42:11 -0700
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
Subject: [PATCH V2 15/19] timekeeping: Fold in timekeeping_delta_to_ns()
Date: Mon, 25 Mar 2024 08:40:19 +0200
Message-Id: <20240325064023.2997-16-adrian.hunter@intel.com>
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


