Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C287BDAA1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346430AbjJIMFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346308AbjJIMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:05:16 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A1DA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:05:11 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399BqMTn006664;
        Mon, 9 Oct 2023 12:05:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=06dSpSZxXR07VbbFIqBIzQpuBT3BvOOtnKrMUNjBk2E=;
 b=smNS8VqUD38Wz4DpIUtb6EMnI90JqYMerGGaOkzSUHKK7tsW5fzL4EPXB6A82Fjcncgo
 GgEhOJs5RaqINkXmM3hrJ0ai0V7plBXXhev9j0NfI4qVpqNomcycTL/d19e6s539pPPo
 EOXgglXqykWNB6vOTNN7gaVkQ4zEkzIlIOaScqzabKwCinodYea8JqXqFrVnA8B2sPqp
 95hA2B/26lZ4Ak0MkLL2B2txPajYyUZVazN13iqe5pTFdJme1ip0UVeR4PZBygrO36CT
 HG/0Qh5JW/iQm81YD+Gq/rPybCrtTbyv6yO5LWEPBFJxdZlNOcRmGCH6miE8aMJMMeiO bw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tmh198dqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 12:05:02 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 399BI40R024439;
        Mon, 9 Oct 2023 12:05:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkhns91sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 12:05:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 399C4xl425100894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 9 Oct 2023 12:04:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BEC72004B;
        Mon,  9 Oct 2023 12:04:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B62820040;
        Mon,  9 Oct 2023 12:04:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  9 Oct 2023 12:04:59 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 156B6E040D; Mon,  9 Oct 2023 14:04:59 +0200 (CEST)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tests: provide a word-at-a-time test implementation
Date:   Mon,  9 Oct 2023 14:04:55 +0200
Message-Id: <20231009120455.173862-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cxv9pQOwCe66oRUI4meEk7GLM0DnYZFh
X-Proofpoint-ORIG-GUID: cxv9pQOwCe66oRUI4meEk7GLM0DnYZFh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxscore=0 phishscore=0 adultscore=0 spamscore=0 impostorscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090098
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some basic tests to test the correctness of has_zero() and
find_zero().

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 lib/Kconfig.debug         | 11 +++++++
 lib/Makefile              |  1 +
 lib/test_word-at-a-time.c | 62 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 74 insertions(+)
 create mode 100644 lib/test_word-at-a-time.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fa307f93fa2e..f7a4df3054ac 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2791,6 +2791,17 @@ config SIPHASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config WORDATATIME_KUNIT_TEST
+	tristate "KUnit test word-at-a-time implementation at runtime" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the kernel's word-at-a-time (<asm/word-at-a-time.h>)
+	  functions on boot (or module load).
+
+	  This is intended to help people writing architecture-specific
+	  optimized versions.  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 740109b6e2c8..b3bc6a698896 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -402,6 +402,7 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_WORDATATIME_KUNIT_TEST) += test_word-at-a-time.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/test_word-at-a-time.c b/lib/test_word-at-a-time.c
new file mode 100644
index 000000000000..574303a4f913
--- /dev/null
+++ b/lib/test_word-at-a-time.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/module.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <kunit/test.h>
+#include <asm/word-at-a-time.h>
+
+static void test_wordatatime_has_zero(struct kunit *test)
+{
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	unsigned long val, data;
+
+	val = -1UL;
+	KUNIT_ASSERT_FALSE(test, has_zero(val, &data, &constants));
+
+	for (int i = 0; i < BITS_PER_LONG; i += 8) {
+		val = ~(0xffUL << i);
+		KUNIT_ASSERT_TRUE(test, has_zero(val, &data, &constants));
+	}
+
+	for (int i = 0; i < BITS_PER_LONG; i++) {
+		val = ~(0x1UL << i);
+		KUNIT_ASSERT_FALSE(test, has_zero(val, &data, &constants));
+	}
+
+	for (int i = 0; i < BITS_PER_LONG; i++) {
+		val = 0x1UL << i;
+		KUNIT_ASSERT_TRUE(test, has_zero(val, &data, &constants));
+	}
+}
+
+static void test_wordatatime_find_zero(struct kunit *test)
+{
+	const struct word_at_a_time constants = WORD_AT_A_TIME_CONSTANTS;
+	unsigned long val, data;
+
+	for (int i = 0; i < BITS_PER_LONG; i += 8) {
+		val = ~(0xffUL << i);
+		KUNIT_ASSERT_TRUE(test, has_zero(val, &data, &constants));
+		data = prep_zero_mask(val, data, &constants);
+		data = create_zero_mask(data);
+#ifdef CONFIG_CPU_BIG_ENDIAN
+		KUNIT_ASSERT_EQ(test, find_zero(data), (BITS_PER_LONG / 8 - 1) - (i / 8));
+#else
+		KUNIT_ASSERT_EQ(test, find_zero(data), i / 8);
+#endif
+	}
+}
+static struct kunit_case wordatatime_test_cases[] = {
+	KUNIT_CASE(test_wordatatime_has_zero),
+	KUNIT_CASE(test_wordatatime_find_zero),
+	{}
+};
+
+static struct kunit_suite wordatatime_test_suite = {
+	.name = "wordatatime_test",
+	.test_cases = wordatatime_test_cases,
+};
+
+kunit_test_suites(&wordatatime_test_suite);
+MODULE_LICENSE("GPL");
-- 
2.39.2

