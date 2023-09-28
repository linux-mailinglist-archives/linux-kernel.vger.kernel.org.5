Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF57B148D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjI1HRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjI1HQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:16:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542311706;
        Thu, 28 Sep 2023 00:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695885378; x=1727421378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c+tVD3/2QI+wf5ggVRUpUIlYuu1vUEYAa5GfXh/vdhU=;
  b=MhF8NNAAbu/kvAgmfFqZdN55FCycbZgXdGZA3b2pmHKlad1JRdWwUjgZ
   HBGLDmrdAONULqmpxZ+HMhezW3R3ellTveuIZMttMwodo/hZL/FsuaMEL
   0pnlvGfX2ALLJU5zpplzLU4eIiuVFi9Wji3zcA3hMpf5dPJLjW//nGg7q
   KHPKNICLcrUVg6P0jaN78R/YjXXrfV+WAhP/S7V7tu3pvOS3IsabTCyti
   Ess6IbrVdvNbjDz26Na2bvQ81fYB3zTsYdmqb+78Ok1JRLyPGlaIhhAK7
   E2aX8b+Y9ghHCi+yMUvaHA1JOHTv12trS938QfVY2sP4UgwpixcCFigv/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361374281"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="361374281"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:16:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="752868629"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="752868629"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.53.62])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 00:16:15 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_code()
Date:   Thu, 28 Sep 2023 10:16:05 +0300
Message-Id: <20230928071605.17624-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop calling addr_location__exit() when addr_location__init() was not
called.

Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/dlfilter.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 1dbf27822ee2..4a1dc21b0450 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -282,13 +282,21 @@ static struct perf_event_attr *dlfilter__attr(void *ctx)
 	return &d->evsel->core.attr;
 }
 
+static __s32 code_read(__u64 ip, struct map *map, struct machine *machine, void *buf, __u32 len)
+{
+	u64 offset = map__map_ip(map, ip);
+
+	if (ip + len >= map__end(map))
+		len = map__end(map) - ip;
+
+	return dso__data_read_offset(map__dso(map), machine, offset, buf, len);
+}
+
 static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 {
 	struct dlfilter *d = (struct dlfilter *)ctx;
 	struct addr_location *al;
 	struct addr_location a;
-	struct map *map;
-	u64 offset;
 	__s32 ret;
 
 	if (!d->ctx_valid)
@@ -298,27 +306,17 @@ static __s32 dlfilter__object_code(void *ctx, __u64 ip, void *buf, __u32 len)
 	if (!al)
 		return -1;
 
-	map = al->map;
-
-	if (map && ip >= map__start(map) && ip < map__end(map) &&
+	if (al->map && ip >= map__start(al->map) && ip < map__end(al->map) &&
 	    machine__kernel_ip(d->machine, ip) == machine__kernel_ip(d->machine, d->sample->ip))
-		goto have_map;
+		return code_read(ip, al->map, d->machine, buf, len);
 
 	addr_location__init(&a);
+
 	thread__find_map_fb(al->thread, d->sample->cpumode, ip, &a);
-	if (!a.map) {
-		ret = -1;
-		goto out;
-	}
+	ret = a.map ? code_read(ip, a.map, d->machine, buf, len) : -1;
 
-	map = a.map;
-have_map:
-	offset = map__map_ip(map, ip);
-	if (ip + len >= map__end(map))
-		len = map__end(map) - ip;
-	ret = dso__data_read_offset(map__dso(map), d->machine, offset, buf, len);
-out:
 	addr_location__exit(&a);
+
 	return ret;
 }
 
-- 
2.34.1

