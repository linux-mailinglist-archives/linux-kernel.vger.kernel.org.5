Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4A7ED252
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbjKOUfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjKOUfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:35:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40511731;
        Wed, 15 Nov 2023 12:34:53 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKCEZD020041;
        Wed, 15 Nov 2023 20:34:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CdLKZ8qn4zwP446RCUpjk9jgcaOUrqtk3L/VG0jpav4=;
 b=L4vfRnZw+uGxcpOsqqjyq5CRN5624Kzp2tNN8n4PxBcJ/OAfJ841PgRUGX2S6CtWH6iX
 TOzamQWSIylWufoTf4R348IeH9/fLgWdt6BnH6Rke8ieYwA0wDY2q2iTQDn5QkxXPzop
 1RKGcNey8ZSXARkJEXjgkTTPVr/cvTNAm9J2lV+EJZEDJ7egUr1K7S/a5aNgC+S+Mop4
 7cWNldlkSe1URRejUSF/DlPIl4rPL7iFsqHrr04DJZ03BdVNTr+g4lceMePlcPn2ztBR
 k9JKwUmbCsRVqVK0/B9H9NsUSKmZjtinmipZ3/8Ap64vTAwc0xw39sVO/5GraNnv43su lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud4thgk2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:39 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFKCZk7021216;
        Wed, 15 Nov 2023 20:34:39 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud4thgk2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:39 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKJ36R017548;
        Wed, 15 Nov 2023 20:34:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamayj7ae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:37 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFKYYHx44434164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 20:34:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 415CC20043;
        Wed, 15 Nov 2023 20:34:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EC1D520040;
        Wed, 15 Nov 2023 20:34:32 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.9.51])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 20:34:32 +0000 (GMT)
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
Subject: [PATCH 15/32] mm: slub: Let KMSAN access metadata
Date:   Wed, 15 Nov 2023 21:30:47 +0100
Message-ID: <20231115203401.2495875-16-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115203401.2495875-1-iii@linux.ibm.com>
References: <20231115203401.2495875-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CXyK3LQ24vo0EH6joaIYozyRUtTOEyS8
X-Proofpoint-ORIG-GUID: qdS6d-wEuyX6_5mdxK25IrNeVjaBw2Cq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150163
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the kernel with CONFIG_SLUB_DEBUG and CONFIG_KMSAN causes
KMSAN to complain about touching redzones in kfree().

Fix by extending the existing KASAN-related metadata_access_enable()
and metadata_access_disable() functions to KMSAN.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 8d9aa4d7cb7e..0b52bff99326 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -700,10 +700,12 @@ static int disable_higher_order_debug;
 static inline void metadata_access_enable(void)
 {
 	kasan_disable_current();
+	kmsan_disable_current();
 }
 
 static inline void metadata_access_disable(void)
 {
+	kmsan_enable_current();
 	kasan_enable_current();
 }
 
-- 
2.41.0

