Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3CB7ED269
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbjKOUhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344604AbjKOUgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:36:38 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284532108;
        Wed, 15 Nov 2023 12:35:15 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKKGTF020216;
        Wed, 15 Nov 2023 20:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nq9e5Kh1g7nUcH6hHoYLD2BDAEyO/grN3klBejPwfzM=;
 b=Um1Q9Qholsw0ojBN6dlk7AT6jZ6hU1TGcl9R0e2Pzr0R4Sr1cTfoFznAb6kOACesvz9P
 pE5ItJ2GD3cWNrOMSlPSpQlWX/UGHivgwQVS71xIgVX+3qxj+4D6HDxqLWC5mgYx3Db+
 /3VARMtbx7BW0+xDGLvueDZ3l3vgA75iW/oufkHI8iQXQcQJduEazYnXeYwjNFf51cmv
 eKwt/HptZV9/jttbT0tpVOCwOtzrVkoomnrDCoyWzufLjy14QPn9tFr+ioProi+NvAfT
 qfv47VzXcCzJXyZcbAc8Dc8lntbalZc1g3fJ+UXUTzYtALSgIFsPhM2RPubXHJbtYFg7 zQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud4xc8cje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:35:00 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFKMA2V026068;
        Wed, 15 Nov 2023 20:34:59 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud4xc8cj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:59 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKIusa015453;
        Wed, 15 Nov 2023 20:34:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnj0qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFKYtlr42074872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 20:34:55 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC46F2004B;
        Wed, 15 Nov 2023 20:34:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A57520040;
        Wed, 15 Nov 2023 20:34:53 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.9.51])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 20:34:53 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
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
Subject: [PATCH 27/32] s390/string: Add KMSAN support
Date:   Wed, 15 Nov 2023 21:30:59 +0100
Message-ID: <20231115203401.2495875-28-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115203401.2495875-1-iii@linux.ibm.com>
References: <20231115203401.2495875-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ui8k3Y8VmDpWZcOWLfPqxXUDgEJ41dXf
X-Proofpoint-GUID: UXrJJp2IUCZ86lgkxA4hnMPl1rgWzyiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311150163
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add KMSAN support for the s390 implementations of the string functions.
Do this similar to how it's already done for KASAN, except that the
optimized memset{16,32,64}() functions need to be disabled: it's
important for KMSAN to know that they initialized something.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/boot/string.c        | 15 +++++++++++
 arch/s390/include/asm/string.h | 49 ++++++++++++++++++++--------------
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/arch/s390/boot/string.c b/arch/s390/boot/string.c
index faccb33b462c..6d886c84075b 100644
--- a/arch/s390/boot/string.c
+++ b/arch/s390/boot/string.c
@@ -4,8 +4,14 @@
 #include <linux/errno.h>
 #undef CONFIG_KASAN
 #undef CONFIG_KASAN_GENERIC
+#undef CONFIG_KMSAN
 #include "../lib/string.c"
 
+/*
+ * Duplicate some functions from the common lib/string.c
+ * instead of fully including it.
+ */
+
 int strncmp(const char *cs, const char *ct, size_t count)
 {
 	unsigned char c1, c2;
@@ -22,6 +28,15 @@ int strncmp(const char *cs, const char *ct, size_t count)
 	return 0;
 }
 
+void *memset64(uint64_t *s, uint64_t v, size_t count)
+{
+	uint64_t *xs = s;
+
+	while (count--)
+		*xs++ = v;
+	return s;
+}
+
 char *skip_spaces(const char *str)
 {
 	while (isspace(*str))
diff --git a/arch/s390/include/asm/string.h b/arch/s390/include/asm/string.h
index 351685de53d2..94925024cb26 100644
--- a/arch/s390/include/asm/string.h
+++ b/arch/s390/include/asm/string.h
@@ -15,15 +15,12 @@
 #define __HAVE_ARCH_MEMCPY	/* gcc builtin & arch function */
 #define __HAVE_ARCH_MEMMOVE	/* gcc builtin & arch function */
 #define __HAVE_ARCH_MEMSET	/* gcc builtin & arch function */
-#define __HAVE_ARCH_MEMSET16	/* arch function */
-#define __HAVE_ARCH_MEMSET32	/* arch function */
-#define __HAVE_ARCH_MEMSET64	/* arch function */
 
 void *memcpy(void *dest, const void *src, size_t n);
 void *memset(void *s, int c, size_t n);
 void *memmove(void *dest, const void *src, size_t n);
 
-#ifndef CONFIG_KASAN
+#if !defined(CONFIG_KASAN) && !defined(CONFIG_KMSAN)
 #define __HAVE_ARCH_MEMCHR	/* inline & arch function */
 #define __HAVE_ARCH_MEMCMP	/* arch function */
 #define __HAVE_ARCH_MEMSCAN	/* inline & arch function */
@@ -36,6 +33,9 @@ void *memmove(void *dest, const void *src, size_t n);
 #define __HAVE_ARCH_STRNCPY	/* arch function */
 #define __HAVE_ARCH_STRNLEN	/* inline & arch function */
 #define __HAVE_ARCH_STRSTR	/* arch function */
+#define __HAVE_ARCH_MEMSET16	/* arch function */
+#define __HAVE_ARCH_MEMSET32	/* arch function */
+#define __HAVE_ARCH_MEMSET64	/* arch function */
 
 /* Prototypes for non-inlined arch strings functions. */
 int memcmp(const void *s1, const void *s2, size_t n);
@@ -44,7 +44,7 @@ size_t strlcat(char *dest, const char *src, size_t n);
 char *strncat(char *dest, const char *src, size_t n);
 char *strncpy(char *dest, const char *src, size_t n);
 char *strstr(const char *s1, const char *s2);
-#endif /* !CONFIG_KASAN */
+#endif /* !defined(CONFIG_KASAN) && !defined(CONFIG_KMSAN) */
 
 #undef __HAVE_ARCH_STRCHR
 #undef __HAVE_ARCH_STRNCHR
@@ -74,21 +74,6 @@ void *__memset16(uint16_t *s, uint16_t v, size_t count);
 void *__memset32(uint32_t *s, uint32_t v, size_t count);
 void *__memset64(uint64_t *s, uint64_t v, size_t count);
 
-static inline void *memset16(uint16_t *s, uint16_t v, size_t count)
-{
-	return __memset16(s, v, count * sizeof(v));
-}
-
-static inline void *memset32(uint32_t *s, uint32_t v, size_t count)
-{
-	return __memset32(s, v, count * sizeof(v));
-}
-
-static inline void *memset64(uint64_t *s, uint64_t v, size_t count)
-{
-	return __memset64(s, v, count * sizeof(v));
-}
-
 #if !defined(IN_ARCH_STRING_C) && (!defined(CONFIG_FORTIFY_SOURCE) || defined(__NO_FORTIFY))
 
 #ifdef __HAVE_ARCH_MEMCHR
@@ -194,6 +179,27 @@ static inline size_t strnlen(const char * s, size_t n)
 	return end - s;
 }
 #endif
+
+#ifdef __HAVE_ARCH_MEMSET16
+static inline void *memset16(uint16_t *s, uint16_t v, size_t count)
+{
+	return __memset16(s, v, count * sizeof(v));
+}
+#endif
+
+#ifdef __HAVE_ARCH_MEMSET32
+static inline void *memset32(uint32_t *s, uint32_t v, size_t count)
+{
+	return __memset32(s, v, count * sizeof(v));
+}
+#endif
+
+#ifdef __HAVE_ARCH_MEMSET64
+static inline void *memset64(uint64_t *s, uint64_t v, size_t count)
+{
+	return __memset64(s, v, count * sizeof(v));
+}
+#endif
 #else /* IN_ARCH_STRING_C */
 void *memchr(const void * s, int c, size_t n);
 void *memscan(void *s, int c, size_t n);
@@ -201,6 +207,9 @@ char *strcat(char *dst, const char *src);
 char *strcpy(char *dst, const char *src);
 size_t strlen(const char *s);
 size_t strnlen(const char * s, size_t n);
+void *memset16(uint16_t *s, uint16_t v, size_t count);
+void *memset32(uint32_t *s, uint32_t v, size_t count);
+void *memset64(uint64_t *s, uint64_t v, size_t count);
 #endif /* !IN_ARCH_STRING_C */
 
 #endif /* __S390_STRING_H_ */
-- 
2.41.0

