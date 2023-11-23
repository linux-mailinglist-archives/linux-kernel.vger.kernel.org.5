Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8137F59B1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344928AbjKWH7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjKWH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:59:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9B1B3;
        Wed, 22 Nov 2023 23:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726371; x=1732262371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nk3gCy6p2GL7PvwIZ2K6eYMQde7iUIS5gU74LC1oz/E=;
  b=YE3/DL8f4MkfppPNYFWCg3tS1Vbf4/cYmAHuV/acTtsthUhh2uOn8cr7
   3u6vWLQ3qS97VPkUpuc08I/9fZP0qsBQ94gM9qy3oGFnEBPe3lgIbSLBd
   si70Vmdo3/AhqimHPx4uOZq600cwKEJl3gtj0yMaq06fgACDO7SwEe35U
   P1WzkCWQUVdcjieGVmN8WL+uLj4/K1yGsj/Ffj6uSlajZw/7Tw9n57rmR
   pIHuLUMFtUdvL/NkwP0gDccIN3vmqPg1Tzc1VoC1q3H4aPeXkl2uKyME8
   eLLVKJUYtrUGarTV+OXHqaylu0acOWKTr+DZt3jHfoORtRfD47LMR0lTB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126427"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126427"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764987"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:11 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/8] perf tests: Skip pipe test if noploop symbol is missing
Date:   Thu, 23 Nov 2023 09:58:43 +0200
Message-Id: <20231123075848.9652-4-adrian.hunter@intel.com>
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

perf pipe recording and injection test depends on finding symbol noploop in
perf, and fails if perf has been stripped and no debug object is available.
In that case, skip the test instead.

Example:

 Before:

  $ strip tools/perf/perf
  $ tools/perf/perf buildid-cache -p `realpath tools/perf/perf`
  $ tools/perf/perf test -v pipe
   86: perf pipe recording and injection test                          :
  --- start ---
  test child forked, pid 47734
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
       47741    47741       -1 |perf
  [ perf record: Woken up 1 times to write data ]
  [ perf record: Captured and wrote 0.000 MB - ]
  cannot find noploop function in pipe #1
  test child finished with -1
  ---- end ----
  perf pipe recording and injection test: FAILED!

After:

  $ tools/perf/perf test -v pipe
   86: perf pipe recording and injection test                          :
  --- start ---
  test child forked, pid 48996
  perf does not have symbol 'noploop'
  perf is missing symbols - skipping test
  test child finished with -2
  ---- end ----
  perf pipe recording and injection test: Skip

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/pipe_test.sh | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/pipe_test.sh b/tools/perf/tests/shell/pipe_test.sh
index 8dd115dd35a7..a78d35d2cff0 100755
--- a/tools/perf/tests/shell/pipe_test.sh
+++ b/tools/perf/tests/shell/pipe_test.sh
@@ -2,10 +2,17 @@
 # perf pipe recording and injection test
 # SPDX-License-Identifier: GPL-2.0
 
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
+sym="noploop"
+
+skip_test_missing_symbol ${sym}
+
 data=$(mktemp /tmp/perf.data.XXXXXX)
 prog="perf test -w noploop"
 task="perf"
-sym="noploop"
 
 if ! perf record -e task-clock:u -o - ${prog} | perf report -i - --task | grep ${task}; then
 	echo "cannot find the test file in the perf report"
-- 
2.34.1

