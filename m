Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64627F38CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234838AbjKUWD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234731AbjKUWD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:03:26 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16B31711;
        Tue, 21 Nov 2023 14:03:04 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALKekZm011151;
        Tue, 21 Nov 2023 22:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CK3CSFhKHiUxb3M2GZk8QRFPFYlA6+i6yOOL0Bh28Bg=;
 b=W/CF/I1EX6biMLOKc9PUQRAalGor/8oSut7ySySGNTNa4a8x5PNV8FSF8CLRDVNBlTmi
 GlgJnHfMnpbju7kaInn0IqkNAVnTxKM7MMVtdp8k/WIxdFRwDzzO/NvjxKFanK2xG9JH
 mpXBB8439wXZB8FdsKiF2ow/OWEG3WChBUlEb0M+9T7QUqnULSegINy6SBVQro6jQsnL
 M5GLuxl6Vqtve/OvqaneWOUQmwK+EoV624y/S2M1uyxbaD6CB39T+3soEVeaFGRG75YB
 XCJB1PdWYuUVgvYnDf2wOQO8bW/FaMalWhMZCsU1oSprj1j0jyDdE6Wsi6l9Pn1Y+I8F tw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh11we714-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:39 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALL31Hj002005;
        Tue, 21 Nov 2023 22:02:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uh11we70q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:38 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALLnbrP007085;
        Tue, 21 Nov 2023 22:02:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa236g9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 22:02:38 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALM2ZH943909796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 22:02:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 490F82005A;
        Tue, 21 Nov 2023 22:02:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFA4420063;
        Tue, 21 Nov 2023 22:02:33 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.23.98])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 21 Nov 2023 22:02:33 +0000 (GMT)
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
Subject: [PATCH v2 17/33] mm: kfence: Disable KMSAN when checking the canary
Date:   Tue, 21 Nov 2023 23:01:11 +0100
Message-ID: <20231121220155.1217090-18-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231121220155.1217090-1-iii@linux.ibm.com>
References: <20231121220155.1217090-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iUsqkWYyrhNADZGpwnA5Io58eqlH7Hnh
X-Proofpoint-ORIG-GUID: CgIeml__PbROJN7brRp4YdQnBlj9DIyx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_12,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210172
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMSAN warns about check_canary() accessing the canary.

The reason is that, even though set_canary() is properly instrumented
and sets shadow, slub explicitly poisons the canary's address range
afterwards.

Unpoisoning the canary is not the right thing to do: only
check_canary() is supposed to ever touch it. Instead, disable KMSAN
checks around canary read accesses.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kfence/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 3872528d0963..a2ea8e5a1ad9 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -306,7 +306,7 @@ metadata_update_state(struct kfence_metadata *meta, enum kfence_object_state nex
 }
 
 /* Check canary byte at @addr. */
-static inline bool check_canary_byte(u8 *addr)
+__no_kmsan_checks static inline bool check_canary_byte(u8 *addr)
 {
 	struct kfence_metadata *meta;
 	unsigned long flags;
@@ -341,7 +341,8 @@ static inline void set_canary(const struct kfence_metadata *meta)
 		*((u64 *)addr) = KFENCE_CANARY_PATTERN_U64;
 }
 
-static inline void check_canary(const struct kfence_metadata *meta)
+__no_kmsan_checks static inline void
+check_canary(const struct kfence_metadata *meta)
 {
 	const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
 	unsigned long addr = pageaddr;
-- 
2.41.0

