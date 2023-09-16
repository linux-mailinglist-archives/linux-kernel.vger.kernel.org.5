Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411967A2EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 11:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbjIPJS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 05:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjIPJS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 05:18:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E092173C;
        Sat, 16 Sep 2023 02:18:17 -0700 (PDT)
Received: from kwepemm600003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RnljX4Rj2ztS5B;
        Sat, 16 Sep 2023 17:13:52 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 16 Sep 2023 17:18:02 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf test: Fix test-record-dummy-C0 failure for supported PERF_FORMAT_LOST feature kernel
Date:   Sat, 16 Sep 2023 09:16:41 +0000
Message-ID: <20230916091641.776031-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernel that supports PERF_FORMAT_LOST, attr->read_format has
PERF_FORMAT_LOST bit. Update expected value of
attr->read_format of test-record-dummy-C0 for this scenario.

Before:

  # ./perf test 17 -vv
   17: Setup struct perf_event_attr                                    :
  --- start ---
  test child forked, pid 1609441
  <SNIP>
  running './tests/attr/test-record-dummy-C0'
    'PERF_TEST_ATTR=/tmp/tmpm3s60aji ./perf record -o /tmp/tmpm3s60aji/perf.data --no-bpf-event -e dummy -C 0 kill >/dev/null 2>&1' ret '1', expected '1'
  expected read_format=4, got 20
  FAILED './tests/attr/test-record-dummy-C0' - match failure
  test child finished with -1
  ---- end ----
  Setup struct perf_event_attr: FAILED!

After:

  # ./perf test 17 -vv
   17: Setup struct perf_event_attr                                    :
  --- start ---
  test child forked, pid 1609441
  <SNIP>
  running './tests/attr/test-record-dummy-C0'
    'PERF_TEST_ATTR=/tmp/tmppa9vxcb7 ./perf record -o /tmp/tmppa9vxcb7/perf.data --no-bpf-event -e dummy -C 0 kill >/dev/null 2>&1' ret '1', expected '1'
  <SNIP>
  test child finished with 0
  ---- end ----
  Setup struct perf_event_attr: Ok

Reported-by: Namhyung Kim <namhyung@kernel.org>
Closes: https://lore.kernel.org/all/CAM9d7cgNH2+zhSAmA3en_6as915UsF25MoLbfjE350tAP43Bog@mail.gmail.com/
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/tests/attr/test-record-dummy-C0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr/test-record-dummy-C0 b/tools/perf/tests/attr/test-record-dummy-C0
index 83ca4e373acd..576ec48b3aaf 100644
--- a/tools/perf/tests/attr/test-record-dummy-C0
+++ b/tools/perf/tests/attr/test-record-dummy-C0
@@ -17,7 +17,7 @@ sample_period=4000
 # PERF_SAMPLE_PERIOD
 # + PERF_SAMPLE_CPU added by -C 0
 sample_type=391
-read_format=4
+read_format=4|20
 disabled=0
 inherit=1
 pinned=0
-- 
2.34.1

