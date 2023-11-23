Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324C27F59B5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344960AbjKWH7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344903AbjKWH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:59:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E4201BF;
        Wed, 22 Nov 2023 23:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726372; x=1732262372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qwCi8/cRXyz2gskGyZ4nkWESSM864LSQWnYjItBPCos=;
  b=T+gUYuP3/+guSO5zChUKQfSEXJ62P5+md/lTbHdAsiTN44MJaQAQpnh2
   R+2VH+OfGlxVfLceiIdDOpRGekegNqTlVIiH/GHh4siK1C4ZBfxe1HpoH
   ksexi9yFpz9VP0S451ZSldiuzHqhExuxwJdlw0XJSGj9C2kq20mArr4sS
   Fdm0mCdcxcj/9IPFnSyHS+STx9VlkFhAQVTDFbUtL8YmDjsqWkpd4ppKU
   CHuZf2H00N24nshRxahDB8ha0zWD0tUGvQ1dIHZbdkiLtE0om/mO6RZJc
   L59XzGI7PzWibppUGA/1Ca+bcGPC2si9/w2MpzjTlbysaM0IF/ve7nTKP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126438"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126438"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764991"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:22 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 7/8] perf tests: Make data symbol test wait for perf to start
Date:   Thu, 23 Nov 2023 09:58:47 +0200
Message-Id: <20231123075848.9652-8-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123075848.9652-1-adrian.hunter@intel.com>
References: <20231123075848.9652-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf data symbol test waits 1 second for perf to run and collect data,
which may be too little if perf takes a long time to start up, which has
been noticed on systems with many CPUs. Use existing wait_for_perf_to_start
helper to wait for perf to start.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_data_symbol.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index 69bb6fe86c50..e50e54e94f6f 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -4,6 +4,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Leo Yan <leo.yan@linaro.org>, 2022
 
+shelldir=$(dirname "$0")
+# shellcheck source=lib/waiting.sh
+. "${shelldir}"/lib/waiting.sh
+
 skip_if_no_mem_event() {
 	perf mem record -e list 2>&1 | grep -E -q 'available' && return 0
 	return 2
@@ -13,6 +17,7 @@ skip_if_no_mem_event || exit 2
 
 TEST_PROGRAM="perf test -w datasym"
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+ERR_FILE=$(mktemp /tmp/__perf_test.stderr.XXXXX)
 
 check_result() {
 	# The memory report format is as below:
@@ -50,13 +55,15 @@ echo "Recording workload..."
 # specific CPU and test in per-CPU mode.
 is_amd=$(grep -E -c 'vendor_id.*AuthenticAMD' /proc/cpuinfo)
 if (($is_amd >= 1)); then
-	perf mem record -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM &
+	perf mem record -vvv -o ${PERF_DATA} -C 0 -- taskset -c 0 $TEST_PROGRAM 2>"${ERR_FILE}" &
 else
-	perf mem record --all-user -o ${PERF_DATA} -- $TEST_PROGRAM &
+	perf mem record -vvv --all-user -o ${PERF_DATA} -- $TEST_PROGRAM 2>"${ERR_FILE}" &
 fi
 
 PERFPID=$!
 
+wait_for_perf_to_start ${PERFPID} "${ERR_FILE}"
+
 sleep 1
 
 kill $PERFPID
-- 
2.34.1

