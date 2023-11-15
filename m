Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699307ED258
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344487AbjKOUgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjKOUf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:35:29 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A51BC5;
        Wed, 15 Nov 2023 12:35:00 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKXdxP001484;
        Wed, 15 Nov 2023 20:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TskbhcdErPcFfha1b/s0fcuykpiIcbkPzbroc8ZK1SI=;
 b=MKmcWWarJyHYTi8ujhRAoBImQJlnNvjIW5NXFdOCWwrgCjU4Y6aPXpp48XNsEBhToLDY
 zddeK/mwzvHQNZdRZ4CEKekbT1YOZnQlG3TLMrEOxb+EiLFLb95VWHA//rSppiFGmndd
 pIubiWBmWh8CjUH81vDNMpJ9oOtg5T3+WPtlkwC6RFso0Pn+CiHKkQdHwuec3of84LPe
 QcSOx5x85W9ZwCk4qAfd3WKCCY0STTsEyQBf32Knuai5SIYe0ySKvmlzbepfvPocgYuE
 SL2Ym5Ij2uDPB3oOy/ADK6OcbOmyAfOElVYsAQCnks2SIk6vbzBjws2rVTmuVUDLI3+Q gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud4v2rb8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:45 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AFKYj4B005400;
        Wed, 15 Nov 2023 20:34:45 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ud4v2rb8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFKIvQS014607;
        Wed, 15 Nov 2023 20:34:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uaneksvut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 20:34:44 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AFKYfsg31523398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 20:34:41 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12F612004B;
        Wed, 15 Nov 2023 20:34:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B854A20040;
        Wed, 15 Nov 2023 20:34:39 +0000 (GMT)
Received: from heavy.boeblingen.de.ibm.com (unknown [9.179.9.51])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Nov 2023 20:34:39 +0000 (GMT)
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
Subject: [PATCH 19/32] kmsan: Accept ranges starting with 0 on s390
Date:   Wed, 15 Nov 2023 21:30:51 +0100
Message-ID: <20231115203401.2495875-20-iii@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231115203401.2495875-1-iii@linux.ibm.com>
References: <20231115203401.2495875-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NqSGEOhYCvXYjJ2gmAhd8EZAV9lDeRqN
X-Proofpoint-GUID: fI9InjhahjWpUFvyF7-N6n0DC7cim79b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_20,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=981 suspectscore=0 classifier=spam adjust=0 reason=mlx
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

On s390 the virtual address 0 is valid (current CPU's lowcore is mapped
there), therefore KMSAN should not complain about it.

Disable the respective check on s390. There doesn't seem to be a
Kconfig option to describe this situation, so explicitly check for
s390.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 mm/kmsan/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
index ffedf4dbc49d..14f4a432fddd 100644
--- a/mm/kmsan/init.c
+++ b/mm/kmsan/init.c
@@ -33,7 +33,9 @@ static void __init kmsan_record_future_shadow_range(void *start, void *end)
 	bool merged = false;
 
 	KMSAN_WARN_ON(future_index == NUM_FUTURE_RANGES);
-	KMSAN_WARN_ON((nstart >= nend) || !nstart || !nend);
+	KMSAN_WARN_ON((nstart >= nend) ||
+		      (!IS_ENABLED(CONFIG_S390) && !nstart) ||
+		      !nend);
 	nstart = ALIGN_DOWN(nstart, PAGE_SIZE);
 	nend = ALIGN(nend, PAGE_SIZE);
 
-- 
2.41.0

