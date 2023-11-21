Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 982857F390E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjKUWRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbjKUWQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:16:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90785D40;
        Tue, 21 Nov 2023 14:07:51 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLv7vA004924;
        Tue, 21 Nov 2023 22:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4RaOA/Sg5LiWRu5GILmoDX/dU/kL5d44emuuC2WIH+4=;
 b=ezLj3E1531aCoaLE8HnCZ0/F2vEk9oFc+LITitJO5QE8MtoLC+5le9S90yUi9PtQHFXm
 Dar7byBJxch2ogLsiykcvsY4044zmhvDbTQAqN0sBrm9W3CPqX3ldFGx0BZ2IIAHF/uV
 TrOVWXZ3QMBlHM9Wg13+976DsO902f4isvq6NtRoVEJvfqOht05bJl7Kg7lXM8MwEK+s
 uCAfjf5gsw421uDMFWjpqDp+8OWYI6Q1SROge7+azS3Fe0MqvRPBWIeioAYGBQa8JeU/
 HSaWeRAWcF9iY9aNe+2YOqidoPPL3db6zOz/0muIsVLne77+Py6wqhGxrh15Eu/RfYh8 8g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4wn8b0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:07:35 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALM0GER015220;
        Tue, 21 Nov 2023 22:07:35 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4wn8axk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:07:35 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLnbtg011094;
        Tue, 21 Nov 2023 22:02:58 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uf9tkbbnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:58 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALM2tvA17629900
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 22:02:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BA7020065;
        Tue, 21 Nov 2023 22:02:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A76DA2005A;
        Tue, 21 Nov 2023 22:02:53 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.23.98])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Nov 2023 22:02:53 +0000 (GMT)
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
Subject: [PATCH v2 27/33] s390/mm: Define KMSAN metadata for vmalloc and modules
Date:   Tue, 21 Nov 2023 23:01:21 +0100
Message-ID: <20231121220155.1217090-28-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121220155.1217090-1-iii@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jEnlnvjW__i_LbTWx-W7S62a6qYl7uUJ
X-Proofpoint-ORIG-GUID: HljdlJiOL-60qRArOlIXIwpUORUdqkXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_12,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=840 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2311210172
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pages for the KMSAN metadata associated with most kernel mappings
are taken from memblock by the common code. However, vmalloc and module
metadata needs to be defined by the architectures.

Be a little bit more careful than x86: allocate exactly MODULES_LEN
for the module shadow and origins, and then take 2/3 of vmalloc for
the vmalloc shadow and origins. This ensures that users passing small
vmalloc= values on the command line do not cause module metadata
collisions.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/boot/startup.c        |  8 ++++++++
 arch/s390/include/asm/pgtable.h | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 8104e0e3d188..e37e7ffda430 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -253,9 +253,17 @@ static unsigned long setup_kernel_memory_layout(void)
 	MODULES_END = round_down(__abs_lowcore, _SEGMENT_SIZE);
 	MODULES_VADDR = MODULES_END - MODULES_LEN;
 	VMALLOC_END = MODULES_VADDR;
+#ifdef CONFIG_KMSAN
+	VMALLOC_END -= MODULES_LEN * 2;
+#endif
 
 	/* allow vmalloc area to occupy up to about 1/2 of the rest virtual space left */
 	vmalloc_size = min(vmalloc_size, round_down(VMALLOC_END / 2, _REGION3_SIZE));
+#ifdef CONFIG_KMSAN
+	/* take 2/3 of vmalloc area for KMSAN shadow and origins */
+	vmalloc_size = round_down(vmalloc_size / 3, _REGION3_SIZE);
+	VMALLOC_END -= vmalloc_size * 2;
+#endif
 	VMALLOC_START = VMALLOC_END - vmalloc_size;
 
 	/* split remaining virtual space between 1:1 mapping & vmemmap array */
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 601e87fa8a9a..d764abeb9e6d 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -107,6 +107,16 @@ static inline int is_module_addr(void *addr)
 	return 1;
 }
 
+#ifdef CONFIG_KMSAN
+#define KMSAN_VMALLOC_SIZE (VMALLOC_END - VMALLOC_START)
+#define KMSAN_VMALLOC_SHADOW_START VMALLOC_END
+#define KMSAN_VMALLOC_ORIGIN_START (KMSAN_VMALLOC_SHADOW_START + \
+				    KMSAN_VMALLOC_SIZE)
+#define KMSAN_MODULES_SHADOW_START (KMSAN_VMALLOC_ORIGIN_START + \
+				    KMSAN_VMALLOC_SIZE)
+#define KMSAN_MODULES_ORIGIN_START (KMSAN_MODULES_SHADOW_START + MODULES_LEN)
+#endif
+
 /*
  * A 64 bit pagetable entry of S390 has following format:
  * |			 PFRA			      |0IPC|  OS  |
-- 
2.41.0

