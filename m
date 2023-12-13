Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4498123DA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbjLMXh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442759AbjLMXhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:37:05 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A104186;
        Wed, 13 Dec 2023 15:37:04 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDNWvNe008721;
        Wed, 13 Dec 2023 23:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0l5iE2aLZJPiZ5kg5yzJ1JpoP+UbHI6+msMolAdWlWU=;
 b=qsZ4KP1/0A03tQiz1OpxhzuNY16G04qB9wLpGfVC7inEyHnnHafFjBducukNVMI7x6k3
 ZQSUapacB/dM1t7+RfGFFOr5yVOispIhDw4BmbMZP9GpvqSLLyDbIf6M2YGroRZwMRji
 7RXHjyGb7cCcnNq+Kbb5AwJyhypLV8ZIjJAFDzqZQgjpNfl167N1SEY3nuyOFBs4+KWT
 Y3O0eJ7jFWXF2J7PxYmi+ZaaGI0LcZeBgs1tjJBhzE3B06aplc3fAN6pxhHOV5Zsb0Q5
 3LvPM8WAdJWz21yR4Y+DOI+1IM4/uxKUUwqQb8+Rr16fvi/iToclFbJnvsbIv1B5rj1f VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uypce81ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:49 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BDNYKtw012549;
        Wed, 13 Dec 2023 23:36:48 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uypce81wa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:48 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BDM1JcB012599;
        Wed, 13 Dec 2023 23:36:47 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jp4n9v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 23:36:47 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BDNaiKq19071496
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Dec 2023 23:36:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BC152004E;
        Wed, 13 Dec 2023 23:36:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD91F20043;
        Wed, 13 Dec 2023 23:36:42 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.171.70.156])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Dec 2023 23:36:42 +0000 (GMT)
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
Subject: [PATCH v3 22/34] s390/checksum: Add a KMSAN check
Date:   Thu, 14 Dec 2023 00:24:42 +0100
Message-ID: <20231213233605.661251-23-iii@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213233605.661251-1-iii@linux.ibm.com>
References: <20231213233605.661251-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MHKnPyW5x6icSzfPHJK27c1dMynNcUTN
X-Proofpoint-ORIG-GUID: na0tv6_fX2z243noK5Kk-h_zifB4EtHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-13_14,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=863
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312130167
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a KMSAN check to the CKSM inline assembly, similar to how it was
done for ASAN in commit e42ac7789df6 ("s390/checksum: always use cksm
instruction").

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/checksum.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/checksum.h b/arch/s390/include/asm/checksum.h
index 69837eec2ff5..55ba0ddd8eab 100644
--- a/arch/s390/include/asm/checksum.h
+++ b/arch/s390/include/asm/checksum.h
@@ -13,6 +13,7 @@
 #define _S390_CHECKSUM_H
 
 #include <linux/kasan-checks.h>
+#include <linux/kmsan-checks.h>
 #include <linux/in6.h>
 
 /*
@@ -35,6 +36,7 @@ static inline __wsum csum_partial(const void *buff, int len, __wsum sum)
 	};
 
 	kasan_check_read(buff, len);
+	kmsan_check_memory(buff, len);
 	asm volatile(
 		"0:	cksm	%[sum],%[rp]\n"
 		"	jo	0b\n"
-- 
2.43.0

