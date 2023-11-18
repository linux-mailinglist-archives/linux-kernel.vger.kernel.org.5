Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D377EFD42
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 03:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232898AbjKRCvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 21:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjKRCvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 21:51:51 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17A710D0;
        Fri, 17 Nov 2023 18:51:43 -0800 (PST)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SXJ9Y1ChyzsR5m;
        Sat, 18 Nov 2023 10:48:17 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 18 Nov 2023 10:51:40 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <avagin@google.com>,
        <daniel.diaz@linaro.org>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 2/3] perf lock contention: Fix a build error on 32-bit
Date:   Sat, 18 Nov 2023 02:48:57 +0000
Message-ID: <20231118024858.1567039-3-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231118024858.1567039-1-yangjihong1@huawei.com>
References: <20231118024858.1567039-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build error on 32-bit system:

  util/bpf_lock_contention.c: In function 'lock_contention_get_name':
  util/bpf_lock_contention.c:253:50: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'u64 {aka long long unsigned int}' [-Werror=format=]
     snprintf(name_buf, sizeof(name_buf), "cgroup:%lu", cgrp_id);
                                                  ~~^
                                                  %llu
  cc1: all warnings being treated as errors

Fixes: d0c502e46e97 ("perf lock contention: Prepare to handle cgroups")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/bpf_lock_contention.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bpf_lock_contention.c
index e105245eb905..f1716c089c99 100644
--- a/tools/perf/util/bpf_lock_contention.c
+++ b/tools/perf/util/bpf_lock_contention.c
@@ -12,6 +12,7 @@
 #include <linux/zalloc.h>
 #include <linux/string.h>
 #include <bpf/bpf.h>
+#include <inttypes.h>
 
 #include "bpf_skel/lock_contention.skel.h"
 #include "bpf_skel/lock_data.h"
@@ -250,7 +251,7 @@ static const char *lock_contention_get_name(struct lock_contention *con,
 		if (cgrp)
 			return cgrp->name;
 
-		snprintf(name_buf, sizeof(name_buf), "cgroup:%lu", cgrp_id);
+		snprintf(name_buf, sizeof(name_buf), "cgroup:%" PRIu64 "", cgrp_id);
 		return name_buf;
 	}
 
-- 
2.34.1

