Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB47D8D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345145AbjJ0Cck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0Cci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:32:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CD41AA;
        Thu, 26 Oct 2023 19:32:35 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SGmmd6wCHzMmJg;
        Fri, 27 Oct 2023 10:28:17 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 27 Oct 2023 10:32:32 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH] perf python: Add missing util/rlimit.c file to the python binding linkage list
Date:   Fri, 27 Oct 2023 02:30:28 +0000
Message-ID: <20231027023028.1106441-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c4a852635edd ("perf data: Increase RLIMIT_NOFILE limit when open
too many files in perf_data__create_dir()") we started using the
evsel__increase_rlimit() function from util/rlimit.c used
in the python binding, which caused this entry in 'perf test' to fail:

  $ ./perf test python
   19: 'import perf' in python                                         : FAILED!

After:

  $ ./perf test -v python
  Couldn't bump rlimit(MEMLOCK), failures may take place when creating BPF maps, etc
   19: 'import perf' in python                                         :
  --- start ---
  test child forked, pid 1100249
  python usage test: "echo "import sys ; sys.path.insert(0, 'python'); import perf" | '/usr/bin/python3' "
  test child finished with 0
  ---- end ----
  'import perf' in python: Ok

Fixes: c4a852635edd ("perf data: Increase RLIMIT_NOFILE limit when open too many files in perf_data__create_dir()")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/util/python-ext-sources | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 26e1c8d973ea..593b660ec75e 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -40,6 +40,7 @@ util/rwsem.c
 util/hashmap.c
 util/perf_regs.c
 util/fncache.c
+util/rlimit.c
 util/perf-regs-arch/perf_regs_aarch64.c
 util/perf-regs-arch/perf_regs_arm.c
 util/perf-regs-arch/perf_regs_csky.c
-- 
2.34.1

