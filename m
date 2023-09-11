Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0077079B196
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347910AbjIKVZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242567AbjIKPuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 11:50:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4D121
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694447430; x=1725983430;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OyKPNhRoXHCMy1Q27SfkblCl7ccMMEKKhLj4ca17UTo=;
  b=K7Hv3avI/NvfbiVupgDPXV6dZHw/hSCLT9GnpFQQfag0d2CyyvTZaomZ
   e8U6jHS26erHCKUr3CvaXGzckHhZk/v17U26ZAXqeiU3oQIGTyvBdAk+p
   z/dnUp7Nfd6+OtucD7d7pMTE/hQgMQTYF6CI7cwDHh1ZCpNEtsp3X3PA9
   qSB54AnxkA52ArlkTdQpUN8t44kwhXHGC7de3c3oGjM7Ftbd9HT9z/TU+
   LgIS1FR2/oJRt4SYFaHMsvqYPy918YHUDKmYxBSbkJD4PUK/bVv9DTPBB
   LhUJueEsY14SVQlnxZQeBAQkmLt3IL5P5+/HYvFeoiD3rsPyGF2kP3PKm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="444541620"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="444541620"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 08:48:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917062278"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="917062278"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 11 Sep 2023 08:48:13 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND PATCH V3 3/6] perf: Add branch_sample_call_stack
Date:   Mon, 11 Sep 2023 08:48:19 -0700
Message-Id: <20230911154822.2559213-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230911154822.2559213-1-kan.liang@linux.intel.com>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add a helper function to check call stack sample type.

The later patch will invoke the function in several places.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch

 arch/x86/events/core.c     | 2 +-
 include/linux/perf_event.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2919bb5a53a0..b56e9c3a0cc8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -601,7 +601,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
-	if (event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK)
+	if (branch_sample_call_stack(event))
 		event->attach_state |= PERF_ATTACH_TASK_DATA;
 
 	/*
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c4877924d43c..58ad6745cdda 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1147,6 +1147,11 @@ static inline bool branch_sample_evt_cntrs(const struct perf_event *event)
 	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_EVT_CNTRS;
 }
 
+static inline bool branch_sample_call_stack(const struct perf_event *event)
+{
+	return event->attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
+}
+
 struct perf_sample_data {
 	/*
 	 * Fields set by perf_sample_data_init() unconditionally,
-- 
2.35.1

