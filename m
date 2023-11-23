Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6695E7F59AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344913AbjKWH7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjKWH7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:59:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9EB5DD;
        Wed, 22 Nov 2023 23:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726370; x=1732262370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kUUFMnMOTmqXLUn2vId7q0QVssfMrP3gOX/sAt3Ulg0=;
  b=K9oRkGKnWGnRD3VVQBccxpNVBHIBEFDV7gSazu/dRLskV58/MNu/Hvhx
   zYpnnwqhTl6zLIvu5dbrtbquLNTpKpEG2dTMn+Sxc27dmu29+t2l/QyBP
   vFoj6fM5iQcxvDwQbHB7Z+3VVYZY5sVnyvA/EhG5+jjdHZu4JFnyYEGnO
   NdiJyZBBd7Uo7Up0UmOQSWRPqrn/Y7Zd8pD8zjwvpYNZrVWRm4roZq40f
   ZRquMC7tarPubZvTHs96CFrl9wh5ZKJk56xIrSIQ3nEYbSxyMiDveS//8
   L+EkSLr8DH3XT8VrN0IwqcUtJBkzKn3EBJL0ozG93a7gD8LWwFNoBISg1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126413"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126413"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764981"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:09 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/8] perf tests lib: Add perf_has_symbol.sh
Date:   Thu, 23 Nov 2023 09:58:42 +0200
Message-Id: <20231123075848.9652-3-adrian.hunter@intel.com>
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

Some shell tests depend on finding symbols for perf itself, and fail if
perf has been stripped and no debug object is available. Add helper
functions to check if perf has a needed symbol. This is preparation for
amending the tests themselves to be skipped if a needed symbol is not
found.

The functions make use of the "Symbols" test which reads and checks symbols
from a dso, perf itself by default. Note the "Symbols" test will find
symbols using the same method as other perf tests, including, for example,
looking in the buildid cache.

An alternative would be to prevent the needed symbols from being stripped,
which seems to work with gcc's externally_visible attribute, but that
attribute is not supported by clang.

Another alternative would be to use option -Wl,-E (which is already used
when perf is built with perl support) which causes the linker to add all
(global) symbols to the dynamic symbol table. Then the required symbols
need only be made global in scope to avoid being strippable. However that
goes beyond what is needed.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/tests/shell/lib/perf_has_symbol.sh | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 tools/perf/tests/shell/lib/perf_has_symbol.sh

diff --git a/tools/perf/tests/shell/lib/perf_has_symbol.sh b/tools/perf/tests/shell/lib/perf_has_symbol.sh
new file mode 100644
index 000000000000..5d59c32ae3e7
--- /dev/null
+++ b/tools/perf/tests/shell/lib/perf_has_symbol.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+perf_has_symbol()
+{
+	if perf test -vv "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
+		echo "perf does have symbol '$1'"
+		return 0
+	fi
+	echo "perf does not have symbol '$1'"
+	return 1
+}
+
+skip_test_missing_symbol()
+{
+	if ! perf_has_symbol "$1" ; then
+		echo "perf is missing symbols - skipping test"
+		exit 2
+	fi
+	return 0
+}
-- 
2.34.1

