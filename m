Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB74761CDF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGYPFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjGYPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:05:39 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DEC1FD0;
        Tue, 25 Jul 2023 08:05:30 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PEeOF2015400;
        Tue, 25 Jul 2023 15:05:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kLzDcy4ecWaJwwS2YB6N0hQpFKia9ep41gE6zTjfEK4=;
 b=IezOmUPc741e64xuklgKoEgoP2Jq5bx9pXB3byquJBqHVxeTYXl8NY/6WILZK+8DWr2t
 IExdhEZ+Y3BnmKLq+RcOp6vDw4xlbFwhzYJV4JBoAPdzI6Yh/tyYg1fFL6n0PL/xpP7w
 mF+3NytSFuqRRYKMV6klCTfz4JV8VqrbQz9cvei/buxRc1TUDSY74hDhiTXvbPBDqYFC
 4TZ9S8NvTsz0fnmSEVQJrtfqrDxvwjVuUJRCQ3lQL01FCq8g1+milnEzNJPYR3kXGdgy
 8KJbTC4DeP9uLdCq/ubaScW1sa5hF9QddbiSHBnQKNnO2d1bNoGBougBKZITeiJufeG/ bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2942d92q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 15:05:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36PElCmY009078;
        Tue, 25 Jul 2023 15:04:14 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s2942d86t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 15:04:13 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36PEi488016601;
        Tue, 25 Jul 2023 15:04:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3s0v514aqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 15:04:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36PF3wpa45810292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 15:03:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13FDC20063;
        Tue, 25 Jul 2023 15:03:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2E732004B;
        Tue, 25 Jul 2023 15:03:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jul 2023 15:03:57 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, wangnan0@huawei.com,
        jolsa@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 2/2 Resend] perf build: Support llvm and clang support compiled in
Date:   Tue, 25 Jul 2023 17:03:47 +0200
Message-Id: <20230725150347.3479291-2-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725150347.3479291-1-tmricht@linux.ibm.com>
References: <20230725150347.3479291-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7xtt7o_nomsgr2w9fXPtGiZLuboXethw
X-Proofpoint-GUID: CpvmhBDvnN8JiE13lGsYWZlCbX-1_B72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_08,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250133
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf build suports llvm and clang support compiled in.
Test case 56 builtin clang support provides a test case
which is always skipped.

Link perf with the latest llvm and clang libraries and
enable this test case.

Use 'make LIBCLANGLLVM=1' to include this support.

V2: Add Library patch before -lclang-cpp

Output before:
 # ./perf test 56
 56: builtin clang support                  :
 56.1: builtin clang compile C source to IR : Skip (not compiled in)
 56.2: builtin clang compile C source to ELF object: \
	 				Skip (not compiled in)

Output after:
 # ./perf test 56
 56: builtin clang support                          :
 56.1: builtin clang compile C source to IR         : Ok
 56.2: builtin clang compile C source to ELF object : Ok
 #

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Jiri Olsa <jolsa@kernel.org>

From Ian Rogers
Build tested with LLVM 14 and 15 using:
BUILD_BPF_SKEL=1 LIBCLANGLLVM=1 LLVM_CONFIG=llvm-config-14
BUILD_BPF_SKEL=1 LIBCLANGLLVM=1 LLVM_CONFIG=llvm-config-15

Tested-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 +-
 tools/perf/Makefile.perf   | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index c5db0de49868..8e1d1fab9b4d 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -325,7 +325,7 @@ CORE_CFLAGS += -Wall
 CORE_CFLAGS += -Wextra
 CORE_CFLAGS += -std=gnu11
 
-CXXFLAGS += -std=gnu++14 -fno-exceptions -fno-rtti
+CXXFLAGS += -std=gnu++17 -fno-exceptions -fno-rtti
 CXXFLAGS += -Wall
 CXXFLAGS += -fno-omit-frame-pointer
 CXXFLAGS += -ggdb3
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 097316ef38e6..158a0733fc9d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -426,10 +426,7 @@ EXTLIBS := $(call filter-out,$(EXCLUDE_EXTLIBS),$(EXTLIBS))
 LIBS = -Wl,--whole-archive $(PERFLIBS) $(EXTRA_PERFLIBS) -Wl,--no-whole-archive -Wl,--start-group $(EXTLIBS) -Wl,--end-group
 
 ifeq ($(USE_CLANG), 1)
-  CLANGLIBS_LIST = AST Basic CodeGen Driver Frontend Lex Tooling Edit Sema Analysis Parse Serialization
-  CLANGLIBS_NOEXT_LIST = $(foreach l,$(CLANGLIBS_LIST),$(shell $(LLVM_CONFIG) --libdir)/libclang$(l))
-  LIBCLANG = $(foreach l,$(CLANGLIBS_NOEXT_LIST),$(wildcard $(l).a $(l).so))
-  LIBS += -Wl,--start-group $(LIBCLANG) -Wl,--end-group
+  LIBS += -L$(shell $(LLVM_CONFIG) --libdir) -lclang-cpp
 endif
 
 ifeq ($(USE_LLVM), 1)
-- 
2.41.0

