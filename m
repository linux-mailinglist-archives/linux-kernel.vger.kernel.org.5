Return-Path: <linux-kernel+bounces-107556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB51787FE12
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885C6282D7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D521C8061C;
	Tue, 19 Mar 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1IRijaY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A94F4085D;
	Tue, 19 Mar 2024 13:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853565; cv=none; b=MgYsVnXzotip71BgwUn+BPqTJJs6VFvZVUFHrl6h1IkPpbjKa+2/TrYbEPWKcmkTdolk01QgMbFRsoQVF1Losk3v4xfZRgSj8RPWptZhYp76NCTDlwjdusIM0FX0nGLJQbc3KoK2tfOGSK4wobZElYEKoAoOdAWQMsEG8jDBY2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853565; c=relaxed/simple;
	bh=+S2MewHLlenRx3Semp3QRkK4+r3hJzwDF86OL9/JXV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c23qfSzzEuNqVRbRcTnGhzvA+6jAChm47l0GO/IZMjXuK7K5vGuYV+YywpJJ4IdUYYnV2e/MY7FP3sAcY2ZJB6n2xuiJ/sJzmacYa7cwQhds8pWXmNLi3x+1Aevdffa8yXhZQEXDTrWvx6i43tEOsV4BqEyWeSdPJd02FmftplA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1IRijaY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710853563; x=1742389563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+S2MewHLlenRx3Semp3QRkK4+r3hJzwDF86OL9/JXV4=;
  b=H1IRijaYziPgzjUGPmsNqmJjaBwYjMq8Ljf/7pCAKW6H4ESta6Xa15qq
   mF6Vx1PxHuBXaMiEDXQKiKK0fVXC7en0Sc/uzt82yDKGk7iEMqySxuyC0
   a/sNZvFYq5c+i6m9mdRdP+M5X4LebzTC+PxyGbYK31x2khiltcVNjcBcE
   2l9yiODn0tAAW9J7f3sY02FHTh0UOudi0dkAB20h978Nn/OXkx8nGlJXf
   Tsxc2YJSWp4U3vAbFSAt34pJycikqAhr7rp9soWSX2tzipNni0GGVUovV
   y6g92PlLoZ/xbkR7wQ4XrpMRmRbOlUiiUh5ukydNzcXmARUI7vWtrtMGE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5842882"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5842882"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 06:06:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="44883169"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 06:05:55 -0700
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
Subject: [PATCH v5 01/11] x86/tsc: Add base clock properties in clocksource structure
Date: Tue, 19 Mar 2024 18:35:37 +0530
Message-Id: <20240319130547.4195-2-lakshmi.sowjanya.d@intel.com>
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

Add base clock hardware abstraction in clocksource structure.

Add clocksource ID for x86 ART(Always Running Timer).

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
---
 arch/x86/kernel/tsc.c           | 42 +++++++++++++++++++--------------
 include/linux/clocksource.h     | 27 +++++++++++++++++++++
 include/linux/clocksource_ids.h |  1 +
 3 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 5a69a49acc96..45bf2f6d0ffa 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -50,9 +50,9 @@ int tsc_clocksource_reliable;
 
 static int __read_mostly tsc_force_recalibrate;
 
-static u32 art_to_tsc_numerator;
-static u32 art_to_tsc_denominator;
-static u64 art_to_tsc_offset;
+static struct clocksource_base art_base_clk = {
+	.id    = CSID_X86_ART,
+};
 static bool have_art;
 
 struct cyc2ns {
@@ -1074,7 +1074,7 @@ core_initcall(cpufreq_register_tsc_scaling);
  */
 static void __init detect_art(void)
 {
-	unsigned int unused[2];
+	unsigned int unused;
 
 	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
 		return;
@@ -1089,13 +1089,14 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
-	      &art_to_tsc_numerator, unused, unused+1);
+	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
+	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
 
-	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
+	art_base_clk.freq_khz /= KHZ;
+	if (art_base_clk.denominator < ART_MIN_DENOMINATOR)
 		return;
 
-	rdmsrl(MSR_IA32_TSC_ADJUST, art_to_tsc_offset);
+	rdmsrl(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
 
 	/* Make this sticky over multiple CPU init calls */
 	setup_force_cpu_cap(X86_FEATURE_ART);
@@ -1303,13 +1304,13 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 {
 	u64 tmp, res, rem;
 
-	rem = do_div(art, art_to_tsc_denominator);
+	rem = do_div(art, art_base_clk.denominator);
 
-	res = art * art_to_tsc_numerator;
-	tmp = rem * art_to_tsc_numerator;
+	res = art * art_base_clk.numerator;
+	tmp = rem * art_base_clk.numerator;
 
-	do_div(tmp, art_to_tsc_denominator);
-	res += tmp + art_to_tsc_offset;
+	do_div(tmp, art_base_clk.denominator);
+	res += tmp + art_base_clk.offset;
 
 	return (struct system_counterval_t) {
 		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
@@ -1356,7 +1357,6 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
 }
 EXPORT_SYMBOL(convert_art_ns_to_tsc);
 
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
@@ -1458,8 +1458,10 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	if (tsc_unstable)
 		goto unreg;
 
-	if (boot_cpu_has(X86_FEATURE_ART))
+	if (boot_cpu_has(X86_FEATURE_ART)) {
 		have_art = true;
+		clocksource_tsc.base = &art_base_clk;
+	}
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
@@ -1484,8 +1486,10 @@ static int __init init_tsc_clocksource(void)
 	 * the refined calibration and directly register it as a clocksource.
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
-		if (boot_cpu_has(X86_FEATURE_ART))
+		if (boot_cpu_has(X86_FEATURE_ART)) {
 			have_art = true;
+			clocksource_tsc.base = &art_base_clk;
+		}
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
 
@@ -1509,10 +1513,12 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 
 	if (early) {
 		cpu_khz = x86_platform.calibrate_cpu();
-		if (tsc_early_khz)
+		if (tsc_early_khz) {
 			tsc_khz = tsc_early_khz;
-		else
+		} else {
 			tsc_khz = x86_platform.calibrate_tsc();
+			clocksource_tsc.freq_khz = tsc_khz;
+		}
 	} else {
 		/* We should not be here with non-native cpu calibration */
 		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 0ad8b550bb4b..66a033bff17c 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -21,6 +21,7 @@
 #include <asm/div64.h>
 #include <asm/io.h>
 
+struct clocksource_base;
 struct clocksource;
 struct module;
 
@@ -48,6 +49,7 @@ struct module;
  * @archdata:		Optional arch-specific data
  * @max_cycles:		Maximum safe cycle value which won't overflow on
  *			multiplication
+ * @freq_khz:		Clocksource frequency in khz.
  * @name:		Pointer to clocksource name
  * @list:		List head for registration (internal)
  * @rating:		Rating value for selection (higher is better)
@@ -70,6 +72,8 @@ struct module;
  *			validate the clocksource from which the snapshot was
  *			taken.
  * @flags:		Flags describing special properties
+ * @base:		Hardware abstraction for clock on which a clocksource
+ *			is based
  * @enable:		Optional function to enable the clocksource
  * @disable:		Optional function to disable the clocksource
  * @suspend:		Optional suspend function for the clocksource
@@ -105,12 +109,14 @@ struct clocksource {
 	struct arch_clocksource_data archdata;
 #endif
 	u64			max_cycles;
+	u32			freq_khz;
 	const char		*name;
 	struct list_head	list;
 	int			rating;
 	enum clocksource_ids	id;
 	enum vdso_clock_mode	vdso_clock_mode;
 	unsigned long		flags;
+	struct clocksource_base *base;
 
 	int			(*enable)(struct clocksource *cs);
 	void			(*disable)(struct clocksource *cs);
@@ -306,4 +312,25 @@ static inline unsigned int clocksource_get_max_watchdog_retry(void)
 
 void clocksource_verify_percpu(struct clocksource *cs);
 
+/**
+ * struct clocksource_base - hardware abstraction for clock on which a clocksource
+ *			is based
+ * @id:			Defaults to CSID_GENERIC. The id value is used for conversion
+ *			functions which require that the current clocksource is based
+ *			on a clocksource_base with a particular ID in certain snapshot
+ *			functions to allow callers to validate the clocksource from
+ *			which the snapshot was taken.
+ * @freq_khz:		Nominal frequency of the base clock in kHz
+ * @offset:		Offset between the base clock and the clocksource
+ * @numerator:		Numerator of the clock ratio between base clock and the clocksource
+ * @denominator:	Denominator of the clock ratio between base clock and the clocksource
+ */
+struct clocksource_base {
+	enum clocksource_ids	id;
+	u32			freq_khz;
+	u64			offset;
+	u32			numerator;
+	u32			denominator;
+};
+
 #endif /* _LINUX_CLOCKSOURCE_H */
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index a4fa3436940c..2bb4d8c2f1b0 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -9,6 +9,7 @@ enum clocksource_ids {
 	CSID_X86_TSC_EARLY,
 	CSID_X86_TSC,
 	CSID_X86_KVM_CLK,
+	CSID_X86_ART,
 	CSID_MAX,
 };
 
-- 
2.35.3


