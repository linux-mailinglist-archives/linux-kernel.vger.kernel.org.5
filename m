Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8527F38B3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjKUWDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjKUWDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:03:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A98610EC;
        Tue, 21 Nov 2023 14:03:00 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLv9hG004965;
        Tue, 21 Nov 2023 22:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=FBHiR0R3HqDameObtBi5tDwt9B6xgR+xiaoV3r5rhIA=;
 b=R7uyF5QNom6pN6IBd3nildZSrtcZliHChhJ/GeIJvUNF+EipxafiIvS97SB8gwPwhdi7
 wfnA8CtypmGthqq3L4NW+88Q0PBQJ1mSVw32lPxW57ZZMBbP3zvKmuAtrOO7+5xn/a4D
 iLWQRKyodtiCZVlMfIRIUjy/YfQgvps/nI80Hl1LKR81OLAVhccTQCKdWdTudtf2y1AH
 vchLVJfuB9tEyQLgC/9nOPrdId99eWWSwwnqyvg2mkZ2bSDCei0H1jFDCgTm/3W0poQq
 6Ntf+KEnufdnj23SLQqIe85hUUrUaPw1XGde+Jm3PnGl4gaZ0cNYvPHhrVUF90ZPX9Wb 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4wn85ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:42 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALLwvpK009496;
        Tue, 21 Nov 2023 22:02:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh4wn85aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:41 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLnWGn004713;
        Tue, 21 Nov 2023 22:02:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf7yykvj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALM2bBa15597856
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 22:02:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31E082005A;
        Tue, 21 Nov 2023 22:02:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA2DB20063;
        Tue, 21 Nov 2023 22:02:35 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.23.98])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Nov 2023 22:02:35 +0000 (GMT)
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
Subject: [PATCH v2 18/33] lib/string: Add KMSAN support to strlcpy() and strlcat()
Date:   Tue, 21 Nov 2023 23:01:12 +0100
Message-ID: <20231121220155.1217090-19-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121220155.1217090-1-iii@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: b6FO-wjNpOLbu-pXCF5KwWPZydmy0FRF
X-Proofpoint-ORIG-GUID: BYbwoAtxv4M2QJEIoKEhTF2ta84U2GAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_12,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
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

Currently KMSAN does not fully propagate metadata in strlcpy() and
strlcat(), because they are built with -ffreestanding and call
memcpy(). In this combination memcpy() calls are not instrumented.

Fix by copying the metadata manually. Add the __STDC_HOSTED__ #ifdef in
case the code is compiled with different flags in the future.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 lib/string.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/string.c b/lib/string.c
index be26623953d2..e83c6dd77ec6 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -111,6 +111,9 @@ size_t strlcpy(char *dest, const char *src, size_t size)
 	if (size) {
 		size_t len = (ret >= size) ? size - 1 : ret;
 		__builtin_memcpy(dest, src, len);
+#if __STDC_HOSTED__ == 0
+		kmsan_memmove_metadata(dest, src, len);
+#endif
 		dest[len] = '\0';
 	}
 	return ret;
@@ -261,6 +264,9 @@ size_t strlcat(char *dest, const char *src, size_t count)
 	if (len >= count)
 		len = count-1;
 	__builtin_memcpy(dest, src, len);
+#if __STDC_HOSTED__ == 0
+	kmsan_memmove_metadata(dest, src, len);
+#endif
 	dest[len] = 0;
 	return res;
 }
-- 
2.41.0

