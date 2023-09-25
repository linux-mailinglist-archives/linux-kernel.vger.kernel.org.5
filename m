Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69107AD010
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjIYGVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjIYGUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BA513A;
        Sun, 24 Sep 2023 23:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622809; x=1727158809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I5V/buEAfvb6fu9N9WAFdvgwgtWYdT9HlyKiL8iOkic=;
  b=VpRD9ZYSFyZkzkQcpFUBxsTNixSB18VhhyuH/V0tpoL/VXMRwcYJU7Qq
   NX/UjXDAOySymQs2NaBt/Z9mqfpSDTxMpF/4oEVO3/bmizmS7vNl8oXM5
   cPc+04CNNfirckRap8j4iuG0UKsMuCYd1SvNV/5JfVB5DPOd8kJZdMicX
   YyL54Ky1h/HcmhQNj91pwUkC2Q512uRdysYWw6g6tMwADO+gRKAu/e8wE
   r2UGz+twgfEIFaEjdRji8cJ7tCYfkHafBo/TDJRFIJeKmWyVa2Hm83/bH
   eBsh091sIPWqqZEHPcU9OWJRmVGLvjcpFwHpVYsgbEZCgqBbaUcnBULN5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279563"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279563"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494442"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494442"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:24 -0700
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 23/25] perf stat: Fix a return error issue in hardware-grouping
Date:   Sun, 24 Sep 2023 23:18:22 -0700
Message-Id: <20230925061824.3818631-24-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230925061824.3818631-1-weilin.wang@intel.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Update the hw_aware_parse_ids() goto to improve error handling.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/metricgroup.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 07a82fa21..6a4404226 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -2196,11 +2196,11 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = NULL;
 	ret = hw_aware_build_grouping(ids, &grouping);
 	if (ret)
-		goto err_out;
+		goto out;
 	ret = hw_aware_metricgroup__build_event_string(&grouping_str, modifier,
 						      tool_events, &grouping);
 	if (ret)
-		goto err_out;
+		goto out;
 
 	parsed_evlist = evlist__new();
 	if (!parsed_evlist) {
@@ -2225,10 +2225,11 @@ static int hw_aware_parse_ids(struct perf_pmu *fake_pmu,
 	*out_evlist = parsed_evlist;
 	parsed_evlist = NULL;
 err_out:
-	metricgroup__free_group_list(&grouping);
-	metricgroup__free_grouping_strs(&grouping_str);
 	parse_events_error__exit(&parse_error);
 	evlist__delete(parsed_evlist);
+out:
+	metricgroup__free_group_list(&grouping);
+	metricgroup__free_grouping_strs(&grouping_str);
 	return ret;
 }
 
-- 
2.39.3

