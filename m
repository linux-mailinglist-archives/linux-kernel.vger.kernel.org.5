Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D22B67F59B3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344933AbjKWH7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:59:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344904AbjKWH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:59:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42B41BE;
        Wed, 22 Nov 2023 23:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726371; x=1732262371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2OpMiIHy1rwUwpgqeA63R+mAPX/eG5N2QSzht7697gg=;
  b=CSZb5yyLbbFNKuYDXGmk/iKBNU7mvcebIbwWwmRP14C0pJ4sfJHwDu4y
   WcCzpO9GTuWtYO1AHFXnrS7KqDiiQ1cuXRExnn4KG4S36WwHDT5eoaLRC
   fmL8pzGImZn9J+efl8TN2lW78f5lJA52F+LW7E+ZoIPr0srKrP5jBrv2C
   Z06+TJBlAyxyydZ9LmzOTyHDiEIgwDPXRbpqPoOuC67ulVSbHWn1yxsrT
   3xbCUgkIsQT/ZEVyBl61kA3GXsLtNHnlKVAxgUYSTNi1RuqILsGzSMMw8
   QdHb3LTrBqh9EfWprlDuwn3vLJVWxxsSVTw12enzCxdAOxEUmI0sdRTIZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126434"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126434"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764990"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:20 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 6/8] perf tests: Skip branch stack sampling test if brstack_bench symbol is missing
Date:   Thu, 23 Nov 2023 09:58:46 +0200
Message-Id: <20231123075848.9652-7-adrian.hunter@intel.com>
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

The test "Check branch stack sampling" depends on finding symbol
brstack_bench (and several others) in perf, and fails if perf has been
stripped and no debug object is available. In that case, skip the test
instead.

Example:

 Before:

  $ strip tools/perf/perf
  $ tools/perf/perf buildid-cache -p `realpath tools/perf/perf`
  $ tools/perf/perf test -v 'branch stack sampling'
  112: Check branch stack sampling                                     :
  --- start ---
  test child forked, pid 123741
  Testing user branch stack sampling
  + grep -E -m1 ^brstack_bench\+[^ ]*/brstack_foo\+[^ ]*/IND_CALL/.*$ /tmp/__perf_test.program.5Dz1U/perf.script
  + cleanup
  + rm -rf /tmp/__perf_test.program.5Dz1U
  test child finished with -1
  ---- end ----
  Check branch stack sampling: FAILED!

 After:

  $ tools/perf/perf test -v 'branch stack sampling'
  112: Check branch stack sampling                                     :
  --- start ---
  test child forked, pid 125157
  perf does not have symbol 'brstack_bench'
  perf is missing symbols - skipping test
  test child finished with -2
  ---- end ----
  Check branch stack sampling: Skip

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_brstack.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/shell/test_brstack.sh
index 09908d71c994..5f14d0cb013f 100755
--- a/tools/perf/tests/shell/test_brstack.sh
+++ b/tools/perf/tests/shell/test_brstack.sh
@@ -4,6 +4,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # German Gomez <german.gomez@arm.com>, 2022
 
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
 # skip the test if the hardware doesn't support branch stack sampling
 # and if the architecture doesn't support filter types: any,save_type,u
 if ! perf record -o- --no-buildid --branch-filter any,save_type,u -- true > /dev/null 2>&1 ; then
@@ -11,6 +15,8 @@ if ! perf record -o- --no-buildid --branch-filter any,save_type,u -- true > /dev
 	exit 2
 fi
 
+skip_test_missing_symbol brstack_bench
+
 TMPDIR=$(mktemp -d /tmp/__perf_test.program.XXXXX)
 TESTPROG="perf test -w brstack"
 
-- 
2.34.1

