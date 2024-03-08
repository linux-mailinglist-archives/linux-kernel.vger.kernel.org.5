Return-Path: <linux-kernel+bounces-97042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038928764D1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 631C3B212FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2510A1F61C;
	Fri,  8 Mar 2024 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1qUcPK/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABFC10A34;
	Fri,  8 Mar 2024 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903739; cv=none; b=dR7Rl+Rj9WrXIHjzYmK4641kE0ltKoN0m0T358HjjAnaIkqFNlG/6Hwr1AyVXa7h1mdadLuDvLRl/9u/elZ+zbboxWjb5GP0kG5YwF+xaA01GbnEWNTkHPKkKRak+RI1SP1cw4rsjzXXxSQzHpE5NxDf0c1gqQyjs7ATAeqOabE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903739; c=relaxed/simple;
	bh=2lv2DSARDuw3tSavxV9vS0kFJqwJfAopismVczk0YdI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AtDG+atmSuAcbwpRPmsRvHJ0aXinJuWcWyCV9QEJnYHYCWzDML4RnL9OzlvI23dYYtE1ZNUQbaeHiNGJmvoC+yAOBYWuiR4WR1D9KpQRfZLZmzx1Mrx5xnyETwloq1qMbHQK45UUVcLv+2u8VXsV2EW3cUETmTe6Qp3YrnFigqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1qUcPK/; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903738; x=1741439738;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2lv2DSARDuw3tSavxV9vS0kFJqwJfAopismVczk0YdI=;
  b=J1qUcPK/FUyAMDMA+hcfhfeSTmcgixouhnOwdzLUdXP6TO3FHzEsNcKJ
   zzeajFyVeWnTcjcobvbJD0WCniNzi00vPfbCtytllS3E+h87ZcyAo1vcK
   hL/w2PqSXeFNeP6Px2YRgDdZ2VGXfSIqltpnFOAZLO93Yg30SMCU5IgNe
   OAA3LdCoikSq2sCOjTGvnKyj+hAnFPQrkTD7VrP4wCWPi0oR2MYMGwIOl
   GqKMczhzBExDAoapqLs4w1MxgTdMAowFdYzxcZD2IHDGMXhsuUClI226G
   DVvi6cqqmRNbDLMcrzPk04C9EyXhc7FF8eX0J5yOjFbpL6nQwmmaNSt4o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342335"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342335"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161335"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:15:20 -0800
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
Subject: [PATCH 00/19] timekeeping: Handle potential multiplication overflow
Date: Fri,  8 Mar 2024 15:14:53 +0200
Message-Id: <20240308131512.44324-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Hi

Kernel timekeeping calculates a clock value by keeping a base value and
adding the number of nanoseconds since that time. Those nanoseconds are
calculated from the clocksource delta. Then periodically, the base value is
moved forwards (refer timekeeping_advance()) which is done by the local
timer interrupt handler. It is designed such that there will always be a
timer interrupt before the delta becomes big enough to overflow the 64-bit
multiplication used in the conversion of delta to nanoseconds (refer
timekeeping_delta_to_ns()). Obviously if timer interrupts are stopped, then
the multiplication does eventually overflow.

Timekeeping multiplication overflow results in a "time loop", typically
cycling about every 15 minutes with x86 TSC, for example starting at 10:00:

  10:00, 10:01, 10:02 ... 10:15, 10:00, 10:01, ... 10:15, 10:00, 10:01 ...

Because a VMM can deliberately stop timer interrupts for a guest, a virtual
machine can be exposed to this issue.

TDX maintains a monotonically increasing virtual TSC for a TDX guest, so
the overflow is allowing a backwards movement of timekeeping that would not
happen otherwise.

It is considered this could break security of cryptographic protocols that
rely on the timestamps for freshness / replay protection, and consequently
the kernel should prevent such a time loop.

Handle multiplication overflows by falling back to higher precision
calculation when the possibility of an overflow is detected.

Extend the facility also to VDSO, dependent on new config option
GENERIC_VDSO_OVERFLOW_PROTECT which is selected by x86 only, so other
architectures are not affected. The result is a calculation that has
similar performance as before. Most machines showed performance benefit,
except Skylake-based hardware such as Intel Kaby Lake which was seen <1%
worse.


Adrian Hunter (19):
      vdso: Consolidate vdso_calc_delta()
      vdso: Consolidate nanoseconds calculation
      vdso: Add CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
      math64: Tidy mul_u64_u32_shr()
      vdso: math64: Provide mul_u64_u32_add_u64_shr()
      vdso: Add vdso_data::max_cycles
      vdso: Make delta calculation overflow safe
      x86/vdso: Make delta calculation overflow safe
      timekeeping: Move timekeeping helper functions
      timekeeping: Rename fast_tk_get_delta_ns() to __timekeeping_get_ns()
      timekeeping: Tidy timekeeping_cycles_to_ns() slightly
      timekeeping: Reuse timekeeping_cycles_to_ns()
      timekeeping: Refactor timekeeping helpers
      timekeeping: Consolidate timekeeping helpers
      timekeeping: Fold in timekeeping_delta_to_ns()
      timekeeping: Prepare timekeeping_cycles_to_ns() for overflow safety
      timekeeping: Make delta calculation overflow safe
      timekeeping: Let timekeeping_cycles_to_ns() handle both under and overflow
      clocksource: Make watchdog and suspend-timing multiplication overflow safe

 arch/powerpc/include/asm/vdso/gettimeofday.h |  17 +----
 arch/s390/include/asm/vdso/gettimeofday.h    |   7 +-
 arch/x86/Kconfig                             |   1 +
 arch/x86/include/asm/vdso/gettimeofday.h     |  42 +++++++----
 include/linux/math64.h                       |   8 +-
 include/vdso/datapage.h                      |   4 +
 include/vdso/math64.h                        |  38 ++++++++++
 kernel/time/clocksource.c                    |  42 +++++------
 kernel/time/timekeeping.c                    | 106 ++++++++++++++-------------
 kernel/time/vsyscall.c                       |   6 ++
 lib/vdso/Kconfig                             |   7 ++
 lib/vdso/gettimeofday.c                      |  55 +++++++++-----
 12 files changed, 199 insertions(+), 134 deletions(-)


Regards
Adrian

