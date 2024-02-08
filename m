Return-Path: <linux-kernel+bounces-57972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B143A84DFCF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EB07281C7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF1178B46;
	Thu,  8 Feb 2024 11:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EkO1fpun"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6178B49;
	Thu,  8 Feb 2024 11:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391977; cv=none; b=bWM/vVSMPtbYWZosnVOHohrwnTOPly8BUwIoGisCE8QuLJhq5KLieMHXDQXFS6MRfpMoMTDLUg7rGEH1Kd1IlP9IGt20FJMA+XH0kbrlW5S0fvzKLdgHIz/PdrvcpLvHvkL0/cMlCdinsp4rfZkJzIL4D7HrsIC7FyHsIUt9UzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391977; c=relaxed/simple;
	bh=z/v40T43ha2hX1e8ZimPBiWM40ccC7SzSxwOXcvZwoA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sG1P5PrHXXTW5UMt0/gcLF9jtYmdrEttCx0BeKNef24hVoE3LO8XzYUgM0jar/6zUusRKA47coqPTnyV3tOkvw+GWtTyfFCVZASczlZUg2tUx0dYWtqwJQ2q969PsHC+WOqNjNQN/pdtvqiLZhi9pV7de5gN0+UmJECSmPXcRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EkO1fpun; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707391976; x=1738927976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z/v40T43ha2hX1e8ZimPBiWM40ccC7SzSxwOXcvZwoA=;
  b=EkO1fpunqnrk9NBrQ1Tw5QA47SX4ICesqZYz2m5pSZtzPWaW6ppjw9pn
   XzzDXHhRZwxLu05c/SQCngpyQ7bswb8q6FkgJint9lguBuL4vOlwUtatX
   m3I/YG68DIyN2z7Nf5lxqp3cnj5CPhIY1j0wHoV5x/3R4iWIT/n7VDClv
   Z6kihpieUEQmjMXynEMBBif2xMQX+67fl7DJD565+69eCvrCfJhkxO6Jr
   j+5Fyzr+f5XaOCiXM6miB3VRFXEFpM6Hoh3B8VoILYN/VXzpN7LhgnTq2
   kpRx3McM5l4lmUBp6w9CCBoHrirqvZ2OiMcfalsNS9uhqTmWiHzWQvFOT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1345804"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1345804"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1957927"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.219.88])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 03:32:50 -0800
From: Adrian Hunter <adrian.hunter@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	Yicong Yang <yangyicong@hisilicon.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Will Deacon <will@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Andi Kleen <ak@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V5 12/12] perf intel-pt: Add a test for pause / resume
Date: Thu,  8 Feb 2024 13:31:27 +0200
Message-Id: <20240208113127.22216-13-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240208113127.22216-1-adrian.hunter@intel.com>
References: <20240208113127.22216-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

Add a simple sub-test to the "Miscellaneous Intel PT testing" test to
check pause / resume.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/test_intel_pt.sh | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
index 723ec501f99a..e359db0d0ff2 100755
--- a/tools/perf/tests/shell/test_intel_pt.sh
+++ b/tools/perf/tests/shell/test_intel_pt.sh
@@ -644,6 +644,33 @@ test_pipe()
 	return 0
 }
 
+test_pause_resume()
+{
+	echo "--- Test with pause / resume ---"
+	if ! perf_record_no_decode -o "${perfdatafile}" -e intel_pt/aux-action=start-paused/u uname ; then
+		echo "SKIP: pause / resume is not supported"
+		return 2
+	fi
+	if ! perf_record_no_bpf -o "${perfdatafile}" \
+			-e intel_pt/aux-action=start-paused/u \
+			-e instructions/period=50000,aux-action=resume,name=Resume/u \
+			-e instructions/period=100000,aux-action=pause,name=Pause/u uname  ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	if ! perf script -i "${perfdatafile}" --itrace=b -Fperiod,event | \
+			awk 'BEGIN {paused=1;branches=0}
+			     /Resume/ {paused=0}
+			     /branches/ {if (paused) exit 1;branches=1}
+			     /Pause/ {paused=1}
+			     END {if (!branches) exit 1}' ; then
+		echo "perf record with pause / resume failed"
+		return 1
+	fi
+	echo OK
+	return 0
+}
+
 count_result()
 {
 	if [ "$1" -eq 2 ] ; then
@@ -672,6 +699,7 @@ test_power_event			|| ret=$? ; count_result $ret ; ret=0
 test_no_tnt				|| ret=$? ; count_result $ret ; ret=0
 test_event_trace			|| ret=$? ; count_result $ret ; ret=0
 test_pipe				|| ret=$? ; count_result $ret ; ret=0
+test_pause_resume			|| ret=$? ; count_result $ret ; ret=0
 
 cleanup
 
-- 
2.34.1


