Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11087CBA16
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbjJQFZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjJQFZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:25:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205DCD7E;
        Mon, 16 Oct 2023 22:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697520311; x=1729056311;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=jjh/SQd4MKcrmxk2Fa2s9sU0ZxSrHMLhxc5ThbaVuPc=;
  b=UuJ/N1K0xGPfPqRXX8bzCpvgU1tOAzBuBp5rQMqscuYk7fM0lqhN4I9x
   fWtRPfkGm/zpJhBHvvMiUaFyh0NXg3C1wuelRwLqKK3uxJfBOTY4tscSN
   vDhiVVkO4WL1nwIBMiAW81YRxQie+TdObq1FFCivcdUpqjSRWoENX6j+R
   Kmo4LTyOWnlO6s5yrBva3gJ9TDmqcqXzZ4sQciW8kk2/5IZhRBxcmHtG1
   IM+fweb40tUuYdqfq3DosCNrZsRotOdAuHOaw8rUDS2IeoKX3xSU5Yb7k
   qrumuBRiDX/UnvEMzA4LhRL3HYuY3MqsMcIUJWOlTLRks2qJe54JJaoG6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388561735"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="388561735"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:25:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="1087357990"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="1087357990"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga005.fm.intel.com with ESMTP; 16 Oct 2023 22:25:06 -0700
From:   lakshmi.sowjanya.d@intel.com
To:     tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
        corbet@lwn.net, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, eddie.dong@intel.com,
        christopher.s.hall@intel.com, pandith.n@intel.com,
        mallikarjunappa.sangannavar@intel.com, thejesh.reddy.t.r@intel.com,
        lakshmi.sowjanya.d@intel.com
Subject: [PATCH v1 2/6] x86/tsc: Convert Time Stamp Counter (TSC) value to Always Running Timer (ART)
Date:   Tue, 17 Oct 2023 10:54:53 +0530
Message-Id: <20231017052457.25287-3-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017052457.25287-1-lakshmi.sowjanya.d@intel.com>
References: <20231017052457.25287-1-lakshmi.sowjanya.d@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

PPS generators trigger pulses according to system time/TSC.
Timed I/O hardware understands time in ART (Always Running Timer). There
is a need to convert TSC time to ART. The conversion is done using the
detected art_to_tsc_numerator and denominator.

ART = TSC * tsc_to_art_denominator / tsc_to_art_numerator

Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Eddie Dong <eddie.dong@intel.com>
---
 arch/x86/include/asm/tsc.h |  3 +++
 arch/x86/kernel/tsc.c      | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 594fce0ca744..f5cff8d4f61e 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -8,6 +8,8 @@
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
 
+struct system_counterval_t;
+
 /*
  * Standard way to access the cycle counter.
  */
@@ -27,6 +29,7 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
+extern int convert_tsc_to_art(const struct system_counterval_t *tsc, u64 *art);
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
 extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
 
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 15f97c0abc9d..92b800015d8f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -2,6 +2,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/init.h>
@@ -1294,6 +1295,37 @@ int unsynchronized_tsc(void)
 	return 0;
 }
 
+/*
+ * Converts input TSC to the corresponding ART value using conversion
+ * factors discovered by detect_art().
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int convert_tsc_to_art(const struct system_counterval_t *system_counter,
+		       u64 *art)
+{
+	u64 tmp, res, rem;
+	/* ART = TSC * tsc_to_art_denominator / tsc_to_art_numerator */
+	struct u32_fract tsc_to_art = {
+		.numerator = art_to_tsc_denominator,
+		.denominator = art_to_tsc_numerator,
+	};
+
+	if (system_counter->cs != art_related_clocksource)
+		return -EINVAL;
+
+	res = system_counter->cycles - art_to_tsc_offset;
+	rem = do_div(res, tsc_to_art.denominator);
+
+	tmp = rem * tsc_to_art.numerator;
+	do_div(tmp, tsc_to_art.denominator);
+
+	*art = res * tsc_to_art.numerator + tmp;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(convert_tsc_to_art);
+
 /*
  * Convert ART to TSC given numerator/denominator found in detect_art()
  */
-- 
2.17.1

