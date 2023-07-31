Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D291876918E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjGaJWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbjGaJVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:21:54 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACE3212A;
        Mon, 31 Jul 2023 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690795190; x=1722331190;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M2PCAu0m+56F5IHFQZlXkdD0yF1c9t4/NzwenQcRKM0=;
  b=D354Qgvf9jn8uJzYmc03tPgAW9PMHZkscNvhTr9suSfptBmAuFRRn2X3
   HX29ML0in33WQKh8GMS4Lh0G/S8pqlrat8jmVty1ZbhE7HyXHxagUZ2EU
   oyyUomOuXj4+hTLTBkYkhb38nD3abCKXVdroA82tq6OHgE9fkYEO+K0jH
   WjS3GC+goH67RKGaXuW775F3ER09FBtztRMPZOpd3a/iyZ1PnFgznTz55
   3/13Vg6j2YM9Fc++Hc8Huo5FaT37askwaVAyMnL7gdKCOpGH3lHtFLGIJ
   vlhGZbgNnR3VF5Y/O9xUhqIheL3MH958grEJXG+Oj7qzWkZwFacYZljgv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435273422"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435273422"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:19:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="728232893"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="728232893"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.223])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:19:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/3] perf dlfilter: Add a test for resolve_address()
Date:   Mon, 31 Jul 2023 12:18:55 +0300
Message-Id: <20230731091857.10681-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the "dlfilter C API" test to test
perf_dlfilter_fns.resolve_address(). The test currently fails, but passes
after a subsequent patch.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/dlfilters/dlfilter-test-api-v0.c | 26 ++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/perf/dlfilters/dlfilter-test-api-v0.c b/tools/perf/dlfilters/dlfilter-test-api-v0.c
index b1f51efd67d6..72f263d49121 100644
--- a/tools/perf/dlfilters/dlfilter-test-api-v0.c
+++ b/tools/perf/dlfilters/dlfilter-test-api-v0.c
@@ -254,6 +254,30 @@ static int check_addr_al(void *ctx)
 	return 0;
 }
 
+static int check_address_al(void *ctx, const struct perf_dlfilter_sample *sample)
+{
+	struct perf_dlfilter_al address_al;
+	const struct perf_dlfilter_al *al;
+
+	al = perf_dlfilter_fns.resolve_ip(ctx);
+	if (!al)
+		return test_fail("resolve_ip() failed");
+
+	address_al.size = sizeof(address_al);
+	if (perf_dlfilter_fns.resolve_address(ctx, sample->ip, &address_al))
+		return test_fail("resolve_address() failed");
+
+	CHECK(address_al.sym && al->sym);
+	CHECK(!strcmp(address_al.sym, al->sym));
+	CHECK(address_al.addr == al->addr);
+	CHECK(address_al.sym_start == al->sym_start);
+	CHECK(address_al.sym_end == al->sym_end);
+	CHECK(address_al.dso && al->dso);
+	CHECK(!strcmp(address_al.dso, al->dso));
+
+	return 0;
+}
+
 static int check_attr(void *ctx)
 {
 	struct perf_event_attr *attr = perf_dlfilter_fns.attr(ctx);
@@ -290,7 +314,7 @@ static int do_checks(void *data, const struct perf_dlfilter_sample *sample, void
 	if (early && !d->do_early)
 		return 0;
 
-	if (check_al(ctx) || check_addr_al(ctx))
+	if (check_al(ctx) || check_addr_al(ctx) || check_address_al(ctx, sample))
 		return -1;
 
 	if (early)
-- 
2.34.1

