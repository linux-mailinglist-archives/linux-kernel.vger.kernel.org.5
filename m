Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250B676918F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGaJW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjGaJVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:21:55 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63813212E;
        Mon, 31 Jul 2023 02:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690795190; x=1722331190;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pcM1bEnTuzcmKdJzWlpFC9IzDJeyCGxon8kw5PhJVJg=;
  b=RKk4r6t1KKSoZNmJG1UcF08+kWwJvuW10nbjZcO8H8nICmUo6Fu4NDCr
   3m0kcEAGInXQ2E/qJ6XgeDPzNREH5OXtNKogfk3zDpjZws2eGmIympMV4
   q4sZQK7t8zk8MWuMWftPIS9NCjd5r4KNGJvq9ETLcak4dBzQ9SMJxfE5b
   ixPNX+f5yTWDPf2AH7w0wxS9yWH1jSfk6PxmIWEUzSZSvWoAH2vNwuhdz
   SgajoIU8TZ6Ej/ItkivC0qonzxwfQ2EHAZoVK9fjiE9l8Eke9o0UVOGbK
   nGG+tBF5MQpQTyrWsdtzMdVo1doTblI/srQ8WCRveYXOzyltMIlvuD+TX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435273428"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435273428"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:19:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="728232899"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="728232899"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.251.208.223])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 02:19:11 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf dlfilter: Initialize addr_location before passing it to thread__find_symbol_fb()
Date:   Mon, 31 Jul 2023 12:18:56 +0300
Message-Id: <20230731091857.10681-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091857.10681-1-adrian.hunter@intel.com>
References: <20230731091857.10681-1-adrian.hunter@intel.com>
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

From: Arnaldo Carvalho de Melo <acme@kernel.org>

As thread__find_symbol_fb() will end up calling thread__find_map() and
it in turn will call these on uninitialized memory:

        maps__zput(al->maps);
        map__zput(al->map);
        thread__zput(al->thread);

Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Disha Goel <disgoel@linux.vnet.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/util/dlfilter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index 46f74b2344db..798a53d7e6c9 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -166,6 +166,7 @@ static __s32 dlfilter__resolve_address(void *ctx, __u64 address, struct perf_dlf
 	if (!thread)
 		return -1;
 
+	addr_location__init(&al);
 	thread__find_symbol_fb(thread, d->sample->cpumode, address, &al);
 
 	al_to_d_al(&al, &d_al);
-- 
2.34.1

