Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C267DB8DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 12:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232924AbjJ3LQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 07:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjJ3LQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 07:16:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1764B3;
        Mon, 30 Oct 2023 04:16:50 -0700 (PDT)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SJrHd2sNqzrTsK;
        Mon, 30 Oct 2023 19:13:49 +0800 (CST)
Received: from ubuntu2204.huawei.com (10.67.174.22) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 30 Oct 2023 19:16:48 +0800
From:   Yang Jihong <yangjihong1@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yangjihong1@huawei.com>
Subject: [PATCH 1/2] perf build: Add loading python binding check to python.so build
Date:   Mon, 30 Oct 2023 11:14:37 +0000
Message-ID: <20231030111438.1357962-1-yangjihong1@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.22]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Add loading python binding check to python.so build so that problem can be
detected in advance in the build phase instead of being left to `perf test`
phase.

In normal scenarios, the original build is not affected:

  $ cd tools/perf
  $ rm -rf /tmp/perf; mkdir /tmp/perf; make O=/tmp/perf
  $ echo $?
  0
  $ cd /tmp/perf
  $ ./perf test python
   19: 'import perf' in python                    : Ok

Create an error scenario, for example, delete util/rlimit.c from
util/python-ext-sources:

  $ cd tools/perf
  $ sed -i 's@util/rlimit.c@#util/rlimit.c@g' util/python-ext-sources
  $ grep rlimit util/python-ext-sources
  #util/rlimit.c
  $ rm -rf /tmp/perf; mkdir /tmp/perf; make JOBS=1 O=/tmp/perf
  <SNIP>
    GEN     /tmp/perf/python/perf.cpython-310-x86_64-linux-gnu.so
  Error: Load python binding failed. See /tmp/perf/python_ext_build/lib//build.log for more details
  make[2]: *** [Makefile.perf:644: /tmp/perf/python/perf.cpython-310-x86_64-linux-gnu.so] Error 1
  make[1]: *** [Makefile.perf:242: sub-make] Error 2
  make: *** [Makefile:70: all] Error 2
  $ cat /tmp/perf/python_ext_build/lib//build.log
  Traceback (most recent call last):
    File "<string>", line 1, in <module>
  ImportError: /tmp/perf/python_ext_build/lib/perf.cpython-310-x86_64-linux-gnu.so: undefined symbol: rlimit__increase_nofile

Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
---
 tools/perf/Makefile.perf | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index d80dcaa5a1e3..a2449c4890ad 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -645,7 +645,13 @@ $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS)' \
 	  $(PYTHON_WORD) util/setup.py \
 	  --quiet build_ext; \
-	cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/
+	$(PYTHON_WORD) -c 'import sys; sys.path.insert(0, "$(PYTHON_EXTBUILD_LIB)"); import perf' 2>$(PYTHON_EXTBUILD_LIB)/build.log; \
+	if [ $$? -ne 0 ]; then \
+		echo "Error: Load python binding failed. See $(PYTHON_EXTBUILD_LIB)/build.log for more details"; \
+		exit 1; \
+	else \
+		cp $(PYTHON_EXTBUILD_LIB)perf*.so $(OUTPUT)python/; \
+	fi
 
 python_perf_target:
 	@echo "Target is: $(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX)"
-- 
2.34.1

