Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679597F59B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 09:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbjKWH7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbjKWH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:59:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C12D40;
        Wed, 22 Nov 2023 23:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726372; x=1732262372;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6i1yfJdZ3uedWfOmXBTKC5wUpcQHqTQufb6AFjSj/ic=;
  b=e+0xxbMrv78teOAI1e5ReGpXPnq1x1NSlR0NLkjuzGWfCbYtHgDnPsgk
   Uu32rSxx/NFlHoIMBYcYEpM99GusyuCaOwaCC2woLH1+A4acZb4V8QJQg
   ybiI5h5qgIFe/7cQmo2dQmOUJl2YKHloOdxDkcnjki7QkGNAVy3IASNu/
   s2106uh6TTqxLjyRIiBMe07w6xG2KgKQaPNBDKxF+EJdYHJ753JjGsf0o
   v/3LnROm3dPxTXl/3F3kvQ/XkMJO7PJ5Cj8PCPd5bJeBgxWa32g1szUeZ
   59xTkCEe+Leo8kY7DFczvgHw7/qlizjHyXkNy3WlwafWcAdUSwCfCbfC1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126439"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126439"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764993"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:25 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 8/8] perf tests: Skip data symbol test if buf1 symbol is missing
Date:   Thu, 23 Nov 2023 09:58:48 +0200
Message-Id: <20231123075848.9652-9-adrian.hunter@intel.com>
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

perf data symbol test depends on finding symbol buf1 in perf, and fails if
perf has been stripped and no debug object is available. In that case, skip
the test instead.

Example:

 Before:

  $ strip tools/perf/perf
  $ tools/perf/perf buildid-cache -p `realpath tools/perf/perf`
  $ tools/perf/perf test -v 'data symbol'
  113: Test data symbol                                                :
  --- start ---
  test child forked, pid 125646
  Recording workload...
  [ perf record: Woken up 3 times to write data ]
  [ perf record: Captured and wrote 0.577 MB /tmp/__perf_test.perf.data.Jhbdp (7794 samples) ]
  Cleaning up files...
  test child finished with -1
  ---- end ----
  Test data symbol: FAILED!

 After:

  $ tools/perf/perf test -v 'data symbol'
  113: Test data symbol                                                :
  --- start ---
  test child forked, pid 125747
  perf does not have symbol 'buf1'
  perf is missing symbols - skipping test
  test child finished with -2
  ---- end ----
  Test data symbol: Skip

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_data_symbol.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/shell/test_data_symbol.sh b/tools/perf/tests/shell/test_data_symbol.sh
index e50e54e94f6f..3dfa91832aa8 100755
--- a/tools/perf/tests/shell/test_data_symbol.sh
+++ b/tools/perf/tests/shell/test_data_symbol.sh
@@ -8,6 +8,9 @@ shelldir=$(dirname "$0")
 # shellcheck source=lib/waiting.sh
 . "${shelldir}"/lib/waiting.sh
 
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
 skip_if_no_mem_event() {
 	perf mem record -e list 2>&1 | grep -E -q 'available' && return 0
 	return 2
@@ -15,6 +18,8 @@ skip_if_no_mem_event() {
 
 skip_if_no_mem_event || exit 2
 
+skip_test_missing_symbol buf1
+
 TEST_PROGRAM="perf test -w datasym"
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 ERR_FILE=$(mktemp /tmp/__perf_test.stderr.XXXXX)
-- 
2.34.1

