Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2067B7F59B2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjKWH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbjKWH7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:59:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9724D1B9;
        Wed, 22 Nov 2023 23:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726371; x=1732262371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G9oYg+Iq1Wk/nZE1kDxs2u68i2GAXss0BmqbCygDxi0=;
  b=T2pKSbPbcYycOK870hKqSrbLRh8Wpj64v5D42DkUM8qt0XQozSl+xp3R
   JezXtjtV6syf4C9uO7iNtpdasfeNr7mVQrKrCuc+jmR+m/Vvh1NuLt35y
   BnZrLFSz9ZLx3O8SdsXax5gtr6r6nJK7lr457KpbAncU7c/gCVEOekS5e
   1hWL4QQr0JDkEvimntztVAn7pT+zt10LtiHz6lzUOjyi4sQNhTZQ3m4t7
   xBS2tKJAeWGvbTBLHPMkyjXiNGWf3gfqpwkkykYWCUlgg51bc3070ijsT
   kZTpy3dGZMt1FFZVkTH40CQtII7wuoHd6BENjOVmlnfqC5hQxZoUYYQyG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126433"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126433"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764989"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:17 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 5/8] perf tests: Skip Arm64 callgraphs test if leafloop symbol is missing
Date:   Thu, 23 Nov 2023 09:58:45 +0200
Message-Id: <20231123075848.9652-6-adrian.hunter@intel.com>
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

The test "Check Arm64 callgraphs are complete in fp mode" depends on
finding symbol leafloop in perf, and fails if perf has been stripped and no
debug object is available. In that case, skip the test instead.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/test_arm_callgraph_fp.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_callgraph_fp.sh b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
index 66dfdfdad553..e342e6c8aa50 100755
--- a/tools/perf/tests/shell/test_arm_callgraph_fp.sh
+++ b/tools/perf/tests/shell/test_arm_callgraph_fp.sh
@@ -2,8 +2,14 @@
 # Check Arm64 callgraphs are complete in fp mode
 # SPDX-License-Identifier: GPL-2.0
 
+shelldir=$(dirname "$0")
+# shellcheck source=lib/perf_has_symbol.sh
+. "${shelldir}"/lib/perf_has_symbol.sh
+
 lscpu | grep -q "aarch64" || exit 2
 
+skip_test_missing_symbol leafloop
+
 PERF_DATA=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
 TEST_PROGRAM="perf test -w leafloop"
 
-- 
2.34.1

