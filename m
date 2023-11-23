Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9E47F59AD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 08:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344898AbjKWH7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 02:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjKWH7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 02:59:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB0E7;
        Wed, 22 Nov 2023 23:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700726369; x=1732262369;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAnIkSe8vCJEmntCGcCtC+pX9E9tP0IPB7jfTlctgwE=;
  b=DfG/7v0LOOL2NTc0v7h4tgHZiVaIbUEICzprqVoDw04Ic9Ydaiy95lLv
   LUxunpxb1lz4sXo0zZyV5w5UpDUyzP+46+bumYDn5fUHwwrG9l+U55upP
   LvFu7KTN0WilgYUx0XyPfE5QIi//wbl5xDHb5DpC+55JM9Zst/G5y6o2E
   aNpAu5COWknkvOCrL1XiuWqZ5vJwDeSga+MbjpfhoB7FXZLfa9cQ3vJnO
   OdcLAMiqGYai1EL8IO+xEnkhjFyw9BiflHzpE3RpgyVHtZLwseBUFyJFf
   UM7jE+5ACh/DDpCvBvKq6kEjt1Nmz8FpynE0iJAMppDASnrs5HxjHw5zW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396126398"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="396126398"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="8764979"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.41.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 23:59:06 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 1/8] perf header: Fix segfault on build_mem_topology() error path
Date:   Thu, 23 Nov 2023 09:58:41 +0200
Message-Id: <20231123075848.9652-2-adrian.hunter@intel.com>
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

Do not increase the node count unless a node has been successfully read,
because it can lead to a segfault if an error occurs.

For example, if perf exceeds the open file limit in memory_node__read(),
which, on a test system, could be made to happen by setting the file limit
to exactly 32:

 Before:

  $ ulimit -n 32
  $ perf mem record --all-user -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  failed: can't open memory sysfs data
  perf: Segmentation fault
  Obtained 14 stack frames.
  perf(sighandler_dump_stack+0x48) [0x55f4b1f59558]
  /lib/x86_64-linux-gnu/libc.so.6(+0x42520) [0x7f4ba1c42520]
  /lib/x86_64-linux-gnu/libc.so.6(free+0x1e) [0x7f4ba1ca53fe]
  perf(+0x178ff4) [0x55f4b1f48ff4]
  perf(+0x179a70) [0x55f4b1f49a70]
  perf(+0x17ef5d) [0x55f4b1f4ef5d]
  perf(+0x85c0b) [0x55f4b1e55c0b]
  perf(cmd_record+0xe1d) [0x55f4b1e5920d]
  perf(cmd_mem+0xc96) [0x55f4b1e80e56]
  perf(+0x130460) [0x55f4b1f00460]
  perf(main+0x689) [0x55f4b1e427d9]
  /lib/x86_64-linux-gnu/libc.so.6(+0x29d90) [0x7f4ba1c29d90]
  /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0x80) [0x7f4ba1c29e40]
  perf(_start+0x25) [0x55f4b1e42a25]
  Segmentation fault (core dumped)
  $

After:

  $ ulimit -n 32
  $ perf mem record --all-user -- sleep 1
  [ perf record: Woken up 1 times to write data ]
  failed: can't open memory sysfs data
  [ perf record: Captured and wrote 0.005 MB perf.data (11 samples) ]
  $

Fixes: f8e502b9d1b3 ("perf header: Ensure bitmaps are freed")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/header.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1c687b5789c0..08cc2febabde 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1444,7 +1444,9 @@ static int build_mem_topology(struct memory_node **nodesp, u64 *cntp)
 			nodes = new_nodes;
 			size += 4;
 		}
-		ret = memory_node__read(&nodes[cnt++], idx);
+		ret = memory_node__read(&nodes[cnt], idx);
+		if (!ret)
+			cnt += 1;
 	}
 out:
 	closedir(dir);
-- 
2.34.1

