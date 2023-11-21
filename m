Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2D27F38F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjKUWIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:08:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbjKUWIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:08:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D5171A;
        Tue, 21 Nov 2023 14:07:52 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLgdjh032016;
        Tue, 21 Nov 2023 22:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=JR4hU8usmRDdin50s82nkAgu6ZMVd3+rhBewhZJH1Ks=;
 b=fjfJvzVHIMBI8eVfnfCg6cOekF4f4bLVPhyjRXTpF0k95mtX2DsfbS8ZNhLAtDKuul1K
 rfJ4aAO1m+svQaxSTgy9829fo8UM/vEBtnfvUBOgl8fOTncZ0HzAQYq6J6bzB4pjUMLV
 r7BYANU4pw6uUhOGm/LYGIftOU/Az+M3oXX11N0kNhYwxiMWhooCla0ZS1uiDTygfchQ
 V6yBg3u0VvrpzaGXd9w5GIzY4gIApeywHtcKjQGk8KKsI6nuIznPD6ZklIevPJenHzjF
 dtHUkiCh0lPdSQUBgm+M4PkMqVHzbH1WFEcTRF4CEnHhcpZuWvK5P8mYL4lNj5Z0vy3w ag== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4pw8n01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:07:36 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALLrw9W029168;
        Tue, 21 Nov 2023 22:07:35 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4pw8mwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:07:35 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLnQTH022903;
        Tue, 21 Nov 2023 22:02:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf7kt402m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:42 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALM2dYD27197992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 22:02:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2955320067;
        Tue, 21 Nov 2023 22:02:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB05F20063;
        Tue, 21 Nov 2023 22:02:37 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.23.98])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Nov 2023 22:02:37 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Marco Elver <elver@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Pekka Enberg <penberg@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 19/33] lib/zlib: Unpoison DFLTCC output buffers
Date:   Tue, 21 Nov 2023 23:01:13 +0100
Message-ID: <20231121220155.1217090-20-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121220155.1217090-1-iii@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ruTC5AuaPKwZQpHq948qdO8nDc1ULPad
X-Proofpoint-ORIG-GUID: JcaizAaJdkvAFfBmibrb_MXa3cUIbOnh
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_12,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210172
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constraints of the DFLTCC inline assembly are not precise: they
do not communicate the size of the output buffers to the compiler, so
it cannot automatically instrument it.

Add the manual kmsan_unpoison_memory() calls for the output buffers.
The logic is the same as in [1].

[1] https://github.com/zlib-ng/zlib-ng/commit/1f5ddcc009ac3511e99fc88736a9e1a6381168c5

Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/zlib_dfltcc/dfltcc.h      |  1 +
 lib/zlib_dfltcc/dfltcc_util.h | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/lib/zlib_dfltcc/dfltcc.h b/lib/zlib_dfltcc/dfltcc.h
index b96232bdd44d..0f2a16d7a48a 100644
--- a/lib/zlib_dfltcc/dfltcc.h
+++ b/lib/zlib_dfltcc/dfltcc.h
@@ -80,6 +80,7 @@ struct dfltcc_param_v0 {
     uint8_t csb[1152];
 };
 
+static_assert(offsetof(struct dfltcc_param_v0, csb) == 384);
 static_assert(sizeof(struct dfltcc_param_v0) == 1536);
 
 #define CVT_CRC32 0
diff --git a/lib/zlib_dfltcc/dfltcc_util.h b/lib/zlib_dfltcc/dfltcc_util.h
index 4a46b5009f0d..ce2e039a55b5 100644
--- a/lib/zlib_dfltcc/dfltcc_util.h
+++ b/lib/zlib_dfltcc/dfltcc_util.h
@@ -2,6 +2,7 @@
 #ifndef DFLTCC_UTIL_H
 #define DFLTCC_UTIL_H
 
+#include "dfltcc.h"
 #include <linux/zutil.h>
 
 /*
@@ -20,6 +21,7 @@ typedef enum {
 #define DFLTCC_CMPR 2
 #define DFLTCC_XPND 4
 #define HBT_CIRCULAR (1 << 7)
+#define DFLTCC_FN_MASK ((1 << 7) - 1)
 #define HB_BITS 15
 #define HB_SIZE (1 << HB_BITS)
 
@@ -34,6 +36,7 @@ static inline dfltcc_cc dfltcc(
 )
 {
     Byte *t2 = op1 ? *op1 : NULL;
+    unsigned char *orig_t2 = t2;
     size_t t3 = len1 ? *len1 : 0;
     const Byte *t4 = op2 ? *op2 : NULL;
     size_t t5 = len2 ? *len2 : 0;
@@ -59,6 +62,26 @@ static inline dfltcc_cc dfltcc(
                      : "cc", "memory");
     t2 = r2; t3 = r3; t4 = r4; t5 = r5;
 
+    switch (fn & DFLTCC_FN_MASK) {
+    case DFLTCC_QAF:
+        kmsan_unpoison_memory(param, sizeof(struct dfltcc_qaf_param));
+        break;
+    case DFLTCC_GDHT:
+        kmsan_unpoison_memory(param, offsetof(struct dfltcc_param_v0, csb));
+        break;
+    case DFLTCC_CMPR:
+        kmsan_unpoison_memory(param, sizeof(struct dfltcc_param_v0));
+        kmsan_unpoison_memory(
+                orig_t2,
+                t2 - orig_t2 +
+                    (((struct dfltcc_param_v0 *)param)->sbb == 0 ? 0 : 1));
+        break;
+    case DFLTCC_XPND:
+        kmsan_unpoison_memory(param, sizeof(struct dfltcc_param_v0));
+        kmsan_unpoison_memory(orig_t2, t2 - orig_t2);
+        break;
+    }
+
     if (op1)
         *op1 = t2;
     if (len1)
-- 
2.41.0

