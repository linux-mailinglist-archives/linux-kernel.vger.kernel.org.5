Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBFE760E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjGYJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjGYJYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:24:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185F1A3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:24:14 -0700 (PDT)
Received: from canpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9BN229vQzNmjC;
        Tue, 25 Jul 2023 17:20:50 +0800 (CST)
Received: from localhost.localdomain (10.175.103.91) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 17:24:12 +0800
From:   Xie XiuQi <xiexiuqi@huawei.com>
To:     <akpm@linux-foundation.org>, <irogers@google.com>,
        <acme@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <weiyongjun1@huawei.com>, <xiexiuqi@huawei.com>
Subject: [PATCH] tools/mm: fix undefined reference to pthread_once
Date:   Tue, 25 Jul 2023 17:21:49 +0800
Message-ID: <20230725092149.443119-1-xiexiuqi@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500001.china.huawei.com (7.192.104.163)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 97d5f2e9ee12 ("tools api fs: More thread safety for global
filesystem variables") introduces pthread_once, so the libpthread
should be added at link time, or we'll meet the following compile
error when 'make -C tools/mm':

  gcc -Wall -Wextra -I../lib/ -o page-types page-types.c ../lib/api/libapi.a
  ~/linux/tools/lib/api/fs/fs.c:146: undefined reference to `pthread_once'
  ~/linux/tools/lib/api/fs/fs.c:147: undefined reference to `pthread_once'
  ~/linux/tools/lib/api/fs/fs.c:148: undefined reference to `pthread_once'
  ~/linux/tools/lib/api/fs/fs.c:149: undefined reference to `pthread_once'
  ~/linux/tools/lib/api/fs/fs.c:150: undefined reference to `pthread_once'
  /usr/bin/ld: ../lib/api/libapi.a(libapi-in.o):~/linux/tools/lib/api/fs/fs.c:151:
  more undefined references to `pthread_once' follow
  collect2: error: ld returned 1 exit status
  make: *** [Makefile:22: page-types] Error 1

Fixes: 97d5f2e9ee12 ("tools api fs: More thread safety for global filesystem variables")
Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
---
 tools/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mm/Makefile b/tools/mm/Makefile
index 6c1da51f4177..9997b2e401ae 100644
--- a/tools/mm/Makefile
+++ b/tools/mm/Makefile
@@ -9,7 +9,7 @@ LIB_DIR = ../lib/api
 LIBS = $(LIB_DIR)/libapi.a
 
 CFLAGS += -Wall -Wextra -I../lib/
-LDFLAGS += $(LIBS)
+LDFLAGS += $(LIBS) -lpthread
 
 all: $(TARGETS)
 
-- 
2.25.1

