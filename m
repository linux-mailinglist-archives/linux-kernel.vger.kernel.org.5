Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAE97B16DB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjI1JKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjI1JKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:10:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9DEC194;
        Thu, 28 Sep 2023 02:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695892248; x=1727428248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3DmYCdj9rDpzb950+X8flSrseHZqV9/9+OWeCGl4lCo=;
  b=ayAqwZBLwc3nuaYIx3qwfN/0s2UXPo4uKlfuW/nGEpcFEUe7EV5hmu84
   FuUQIJ9ttqy2bpLLVAJEGlyMambx5At0MEAEqXttLtCFGXCrOfcq6l/rP
   S6SlDFd6pLVAouTgGhdtDPEiP/YDnWmd09Y0XUyh562Kde+QjD5C+YCYs
   ZTadMA/FXrniU7F82GZcI1oP62Y6OEJ2MvAwla+xXPPJEVKoD4+YcVu6Q
   XsOMhkSJtEQsuEuTap8wPAhBCBpulLNn05HvE5ABjuXg/F88vwasxJRNa
   pxr2Blfu8vfV3E+AXSoJAfSWk3Fd4Mjw1ViE3Uzw1nWTsGCXR9jMU2E+H
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="625001"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="625001"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="726166133"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="726166133"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.53.62])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 02:10:44 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf dlfilter: Add a test for object_code()
Date:   Thu, 28 Sep 2023 12:10:33 +0300
Message-Id: <20230928091033.33998-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the "dlfilter C API" test to test
perf_dlfilter_fns.object_code().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/dlfilters/dlfilter-test-api-v0.c | 12 +++++++++++-
 tools/perf/dlfilters/dlfilter-test-api-v2.c | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
index 72f263d49121..4083b1abeaab 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
@@ -289,6 +289,15 @@ static int check_attr(void *ctx)
 	return 0;
 }
 
+static int check_object_code(void *ctx, const struct perf_dlfilter_sample *sample)
+{
+	__u8 buf[15];
+
+	CHECK(perf_dlfilter_fns.object_code(ctx, sample->ip, buf, sizeof(buf)) > 0);
+
+	return 0;
+}
+
 static int do_checks(void *data, const struct perf_dlfilter_sample *sample, void *ctx, bool early)
 {
 	struct filter_data *d = data;
@@ -314,7 +323,8 @@ static int do_checks(void *data, const struct perf_dlfilter_sample *sample, void
 	if (early && !d->do_early)
 		return 0;
 
-	if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, sample))
+	if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, sample) ||
+	    check_object_code(ctx, sample))
 		return -1;
 
 	if (early)
diff --git a/tools/perf/dlfilters/dlfilter-test-api-v2.c b/tools/perf/dlfilters/dlfilter-test-api-v2.c
index 38e593d92920..32ff619e881c 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v2.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v2.c
@@ -308,6 +308,15 @@ static int check_attr(void *ctx)
 	return 0;
 }
 
+static int check_object_code(void *ctx, const struct perf_dlfilter_sample *sample)
+{
+	__u8 buf[15];
+
+	CHECK(perf_dlfilter_fns.object_code(ctx, sample->ip, buf, sizeof(buf)) > 0);
+
+	return 0;
+}
+
 static int do_checks(void *data, const struct perf_dlfilter_sample *sample, void *ctx, bool early)
 {
 	struct filter_data *d = data;
@@ -333,7 +342,8 @@ static int do_checks(void *data, const struct perf_dlfilter_sample *sample, void
 	if (early && !d->do_early)
 		return 0;
 
-	if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, sample))
+	if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, sample) ||
+	    check_object_code(ctx, sample))
 		return -1;
 
 	if (early)
-- 
2.34.1

