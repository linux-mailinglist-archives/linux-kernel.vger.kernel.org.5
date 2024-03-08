Return-Path: <linux-kernel+bounces-97049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D891D8764DF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0B11C20382
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441514503D;
	Fri,  8 Mar 2024 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OYhgJIC1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B8E3BBD4;
	Fri,  8 Mar 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903772; cv=none; b=pircRuc4KJSBe8hMvYe0S9fBBngSHEAKqalL0IBBIB+7TQCVbkkBEciIMHkXhMjvW4AbvhSZws51xZdGUQnDujL3KyOF1K9f+CnbCZPlcquZGntCVkTP2QKcvZHvQ4Nq/4RddWQ8cxXGH+BdxUoo5Bqsyxp/92aMZjLRzL1zXjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903772; c=relaxed/simple;
	bh=Exf/ex05wg/ZdHrQtagsjpQZFoomRp7dCTSrSntMNmc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KMKFLY1MVV0vGxdOpyuE5KYnEChCxfhJFUrXoWuyDPBDQFG4gd6597xzl1CgnOKH2Kbcf4gUuwBTi8ZGu8CIL8OoY7qwZozP0atKfFa++oD69u15pcpvClQJQqV/qLluUCzgC7pVA9VUSWfYpcYFQS1mwcMjryNMOFkYUjy8Fk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OYhgJIC1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709903771; x=1741439771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Exf/ex05wg/ZdHrQtagsjpQZFoomRp7dCTSrSntMNmc=;
  b=OYhgJIC1etTv9J1TYIuQSauCnvt9vh4Bl+wecQFvcVd8ndT6qVN4KYGn
   z8nD2VSe9/hRizhPvHvbg77VgTjwiipgWCfR8p5dc0ycfkIdSseqmM2YU
   0hWnZ2oAbAgSI0d8mQ7az8HmuJJ3fcB8CdatWWICZ9WDU/PBaaJqOHjit
   wGD/26H10F4odAGnwc8SEr/AvdnsOpdwhwAaUTiN1YJs9XjOVaSCqVKup
   sfabu/kNQyK1kIgU2AlC1FSUoMQVcmaGrk/iuJ6E3zIDaA3EM88ww7zjR
   pzYQlAxxl4Fk8RQVSMFalTaSoucyi/+z0qEbASlRTChrkbshu/I2run83
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15342539"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15342539"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="15161409"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.249.46.63])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:16:02 -0800
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
Subject: [PATCH 06/19] vdso: Add vdso_data::max_cycles
Date: Fri,  8 Mar 2024 15:14:59 +0200
Message-Id: <20240308131512.44324-7-adrian.hunter@intel.com>
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

Add vdso_data::max_cycles in preparation to use it to detect potential
multiplication overflow.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 include/vdso/datapage.h | 4 ++++
 kernel/time/vsyscall.c  | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5d5c0b8efff2..6c3d67d6b758 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -67,6 +67,7 @@ struct vdso_timestamp {
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
+ * @max_cycles:		maximum cycles which won't overflow 64bit multiplication
  * @mask:		clocksource mask
  * @mult:		clocksource multiplier
  * @shift:		clocksource shift
@@ -98,6 +99,9 @@ struct vdso_data {
 
 	s32			clock_mode;
 	u64			cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	u64			max_cycles;
+#endif
 	u64			mask;
 	u32			mult;
 	u32			shift;
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index f0d5062d9cbc..9193d6133e5d 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -22,10 +22,16 @@ static inline void update_vdso_data(struct vdso_data *vdata,
 	u64 nsec, sec;
 
 	vdata[CS_HRES_COARSE].cycle_last	= tk->tkr_mono.cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vdata[CS_HRES_COARSE].max_cycles	= tk->tkr_mono.clock->max_cycles;
+#endif
 	vdata[CS_HRES_COARSE].mask		= tk->tkr_mono.mask;
 	vdata[CS_HRES_COARSE].mult		= tk->tkr_mono.mult;
 	vdata[CS_HRES_COARSE].shift		= tk->tkr_mono.shift;
 	vdata[CS_RAW].cycle_last		= tk->tkr_raw.cycle_last;
+#ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
+	vdata[CS_RAW].max_cycles		= tk->tkr_raw.clock->max_cycles;
+#endif
 	vdata[CS_RAW].mask			= tk->tkr_raw.mask;
 	vdata[CS_RAW].mult			= tk->tkr_raw.mult;
 	vdata[CS_RAW].shift			= tk->tkr_raw.shift;
-- 
2.34.1


