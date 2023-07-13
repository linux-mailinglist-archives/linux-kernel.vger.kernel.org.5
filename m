Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C05751FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbjGMLUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGMLUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:20:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 526AA26A1;
        Thu, 13 Jul 2023 04:20:04 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DBGP5B029087;
        Thu, 13 Jul 2023 11:19:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=WeQUdBYX4oH9A+RGhFG1aGqzmBTPgeTJskhiZlg5yy8=;
 b=ajGAO9CIpFQjQOn1eU0d7c3NP6gL37Py1Zq/tlkvp1/BEJh2nj0q0ga6+KrGE3edOb3R
 wownuVfqrQcLfEHpYTnreLQ987rEVQi+4bf2t7TyL68MPdV7++KLGXBqAYqW/BWZFqI2
 F1+H7QDp4eCxCY7XJwPoC1Wp5rgIUfTtNau6mTzvI0waX4bbE6+FQvn+c5fQFF6vBbh6
 hYd7nxblsBwXZQHepouoRHYkx16puWpE09FxXgaylDAdC2rX5cCRZv0vK7a3u7Sv3aHq
 FfHFImFZyHauu6ElNBpURMyMwRrQfiR8OUUETGJx4uXrvF1QLr+RYv3HnO3un4XD3ERl Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtg8j01n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:19:44 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36DBHUw3031579;
        Thu, 13 Jul 2023 11:19:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rtg8j01mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:19:44 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36D3JRuW031327;
        Thu, 13 Jul 2023 11:19:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3rpy2e37gc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 11:19:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36DBJdkc22086282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jul 2023 11:19:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E64432004D;
        Thu, 13 Jul 2023 11:19:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89CDD2004B;
        Thu, 13 Jul 2023 11:19:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jul 2023 11:19:38 +0000 (GMT)
From:   Thomas Richter <tmricht@linux.ibm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, irogers@google.com, wangnan0@huawei.com,
        jolsa@kernel.org
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH v2] perf build: Support llvm and clang support compiled in
Date:   Thu, 13 Jul 2023 13:19:30 +0200
Message-Id: <20230713111930.1636612-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9fuoG5gglUFQq318UC0FQCozZ2GcwgjC
X-Proofpoint-GUID: WURcoLFAw5trRMChsU4IRMpL_-eDGZ5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130097
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 tools/perf/Makefile.config | 2 +-
 tools/perf/Makefile.perf   | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0609c19caabd..a90af438261c 100644
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

