Return-Path: <linux-kernel+bounces-38165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBCD83BBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 877EB28830C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED701AADC;
	Thu, 25 Jan 2024 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlR3DaiA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1C0175B9;
	Thu, 25 Jan 2024 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706171008; cv=none; b=B+m+6bVqJvq2e3Z18xu6qntlYXS2qneC+EIOdFvhQyhSeBtN7F1qFpdjKmxXjKXvWJModSENc9gLEd50sCqNWqUxbtL1sOO5NfWEL3DtQ2ZeIE2ZjK0m21408AMiDGeRPBrMeqnY5lUOY6tLOh6Dvl2SxcXVgHAGDPErRfYCK+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706171008; c=relaxed/simple;
	bh=Ym5ZXbQlJdyEqtBYOvsursmkKZcSXkI8IFQ9feaQTG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RD66IfqWHF1D7qxPMY3IxRwC2nJe+HLfRTcpy8PjxT/07C+Laf6CQk/u+/uhWGEymoA9NPcD+7ep0jxPpKdopRA4ldpguUVpRN0IaXNR/HX3cHKRccvU/7HIXRFWzPtpde0pKIHCp7e2hRdk3sQA76oCD7Qhjta9oIMSIgDodtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YlR3DaiA; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706171007; x=1737707007;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ym5ZXbQlJdyEqtBYOvsursmkKZcSXkI8IFQ9feaQTG8=;
  b=YlR3DaiAi05ASlxOh6NutaEUyTRoma88M/sMi9MdBKXtjB5jDk5xqNko
   dpfygkjBDs/fRJ9F4ADsOiW1gegG+0nmb7ObQmolQvrKQmwwDpEPPGFUQ
   xQUrnjTx3XZZxiZOwnAv/s19e5RIS0PX/xW5IWF0jBFhBng2oV+DMLQWM
   Y8aJ7Njwd/z5Fz22en+qvDC9sgd+RDKTnPLOgQg4h3P8cDb8SsETWF8/4
   XlDecIVw0NsoDXZXy2v8NtOAHtoH13243saDf3/i6bJI90ycU+QU5SE2F
   IPJAr9FVV1AArAUasqRlW7SzLU0jD2DqqwvtCof2lVTCPHLRV3C+06euR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1987185"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1987185"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:23:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="876975932"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="876975932"
Received: from araj-ucode.jf.intel.com ([10.23.0.11])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 00:23:23 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Hans de Goede <hdegoede@redhat.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	markgross@kernel.org
Cc: Jithu Joseph <jithu.joseph@intel.com>,
	rostedt@goodmis.org,
	ashok.raj@intel.com,
	tony.luck@intel.com,
	LKML <linux-kernel@vger.kernel.org>,
	platform-driver-x86@vger.kernel.org,
	patches@lists.linux.dev,
	pengfei.xu@intel.com
Subject: [PATCH 4/5] platform/x86/intel/ifs: Replace the exit rendezvous with an entry rendezvous for ARRAY_BIST
Date: Thu, 25 Jan 2024 00:22:53 -0800
Message-Id: <20240125082254.424859-5-ashok.raj@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240125082254.424859-1-ashok.raj@intel.com>
References: <20240125082254.424859-1-ashok.raj@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARRAY_BIST requires the test to be invoked only from one of the HT
siblings of a core.  If the other sibling was in mwait(), that didn't permit
the test to complete and resulted in several retries before the test could
finish.

The exit rendezvous was introduced to keep the HT sibling busy until the primary
CPU completed the test to avoid those retries. What is actually needed is
to ensure that both the threads rendezvous *before* the wrmsr to trigger the
test to give good chance to complete the test.

The `stop_machine()` function returns only after all the CPUs complete
running the function, and provides an exit rendezvous implicitly.

In kernel/stop_machine.c::multi_cpu_stop(), every CPU in the mask
needs to complete reaching MULTI_STOP_RUN. When all CPUs complete, the
state machine moves to next state, i.e MULTI_STOP_EXIT. Thus the underlying API
stop_core_cpuslocked() already provides an exit rendezvous.

Add the rendezvous earlier in order to  ensure the wrmsr is triggered after all
CPUs reach the do_array_test(). Remove the exit rendezvous since
stop_core_cpuslocked() already gaurantees that.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/runtest.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 21dc0046fd9b..e3307dd8e3c4 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -271,7 +271,7 @@ static void ifs_test_core(int cpu, struct device *dev)
 }
 
 #define SPINUNIT 100 /* 100 nsec */
-static atomic_t array_cpus_out;
+static atomic_t array_cpus_in;
 
 /*
  * Simplified cpu sibling rendezvous loop based on microcode loader __wait_for_cpus()
@@ -298,6 +298,8 @@ static int do_array_test(void *data)
 	int cpu = smp_processor_id();
 	int first;
 
+	wait_for_sibling_cpu(&array_cpus_in, NSEC_PER_SEC);
+
 	/*
 	 * Only one logical CPU on a core needs to trigger the Array test via MSR write.
 	 */
@@ -309,9 +311,6 @@ static int do_array_test(void *data)
 		rdmsrl(MSR_ARRAY_BIST, command->data);
 	}
 
-	/* Tests complete faster if the sibling is spinning here */
-	wait_for_sibling_cpu(&array_cpus_out, NSEC_PER_SEC);
-
 	return 0;
 }
 
@@ -332,7 +331,7 @@ static void ifs_array_test_core(int cpu, struct device *dev)
 			timed_out = true;
 			break;
 		}
-		atomic_set(&array_cpus_out, 0);
+		atomic_set(&array_cpus_in, 0);
 		stop_core_cpuslocked(cpu, do_array_test, &command);
 
 		if (command.ctrl_result)
-- 
2.39.2


