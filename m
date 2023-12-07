Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA1D8082CF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378200AbjLGIUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbjLGIUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:20:18 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26A10DE;
        Thu,  7 Dec 2023 00:20:22 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Sm6X82K1wz14LrL;
        Thu,  7 Dec 2023 16:15:20 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 16:20:19 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <hejunhao3@huawei.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH 1/2] perf header: Fix one memory leakage in perf_event__fprintf_event_update()
Date:   Thu, 7 Dec 2023 16:16:34 +0800
Message-ID: <20231207081635.8427-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231207081635.8427-1-yangyicong@huawei.com>
References: <20231207081635.8427-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

When dump the raw trace by `perf report -D` ASan reports a memory
leakage in perf_event__fprintf_event_update(). It shows that we
allocated a temporary cpumap for dumping the CPUs but doesn't
release it and it's not used elsewhere. Fix this by free the
cpumap after the dumping.

Fixes: c853f9394b7b ("perf tools: Add perf_event__fprintf_event_update function")
Cc: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 tools/perf/util/header.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e86b9439ffee..7190f39ccd13 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4369,9 +4369,10 @@ size_t perf_event__fprintf_event_update(union perf_event *event, FILE *fp)
 		ret += fprintf(fp, "... ");
 
 		map = cpu_map__new_data(&ev->cpus.cpus);
-		if (map)
+		if (map) {
 			ret += cpu_map__fprintf(map, fp);
-		else
+			perf_cpu_map__put(map);
+		} else
 			ret += fprintf(fp, "failed to get cpus\n");
 		break;
 	default:
-- 
2.24.0

