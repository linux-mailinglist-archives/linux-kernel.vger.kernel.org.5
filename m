Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE167F2C7C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjKUMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233846AbjKUMDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:03:22 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634609C;
        Tue, 21 Nov 2023 04:03:19 -0800 (PST)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALBc2v1023436;
        Tue, 21 Nov 2023 12:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UbI3gRx2z11WJvUL9FqBRaWO2/YxaKCV9eYngKPduqY=;
 b=a3e0xRg0LtYV+rUXxM0fFf/nmsd9WAnKkD6Z/1WZ2zPez5g2YH1K9LXFkBJ/d1SQbkpI
 gNzZ3MirvbMIJoBdWcUdJLJrypKmosyJJSKIEyNY6u+yQGIBy1LRSUW2E5WOe0n2/0H0
 +FJ2LXtgHK9daJgcCFDl0Rd3COC5hKNpmoiohyiDhqnUTlFIE+fiBYPomkN5+Irk8z3t
 lJXk/utmJolm19/gIQ0QljqjekAcHXg3UVlBBNkt65as+0MLUb2tgQwgl8ZUQfSdzquT
 76BC3BkqrLyeXBmSxJ+zHr7zPiIdklEKhQ2+VhJI/LQJ8SSvWhyTHWOx6jF2O555Vmko lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uguuj0ns6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:03:15 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ALBugM3015000;
        Tue, 21 Nov 2023 12:03:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uguuj0nrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:03:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ALBnHvF015865;
        Tue, 21 Nov 2023 12:03:14 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf8knrd03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Nov 2023 12:03:13 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ALC3AA217564168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Nov 2023 12:03:10 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B050E200CC;
        Tue, 21 Nov 2023 12:03:10 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C2E200CB;
        Tue, 21 Nov 2023 12:03:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 21 Nov 2023 12:03:10 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
        id 65D3DE0320; Tue, 21 Nov 2023 13:03:10 +0100 (CET)
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Vishal Moola <vishal.moola@gmail.com>
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH] pgtable: do not expose _refcount field via ptdesc
Date:   Tue, 21 Nov 2023 13:03:10 +0100
Message-Id: <20231121120310.696335-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YznpofG2GbqLlI3z4KWXDiYITvyETh0y
X-Proofpoint-ORIG-GUID: hT0Li9jmuNkQcOhBZADPauH-OGkCMEb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_05,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 mlxlogscore=994 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311210094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit d08d4e7cd6bf ("s390/mm: use full 4KB page for 2KB PTE")
_refcount field is not used for fragmented page tracking on s390 and
there is no other code left that accesses this field explicitly.

Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 include/linux/mm_types.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 957ce38768b2..0330e0ddca11 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -401,11 +401,10 @@ FOLIO_MATCH(compound_head, _head_2a);
  * @pmd_huge_pte:     Protected by ptdesc->ptl, used for THPs.
  * @__page_mapping:   Aliases with page->mapping. Unused for page tables.
  * @pt_mm:            Used for x86 pgds.
- * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
+ * @pt_frag_refcount: For fragmented page table tracking. Powerpc only.
  * @_pt_pad_2:        Padding to ensure proper alignment.
  * @ptl:              Lock for the page table.
  * @__page_type:      Same as page->page_type. Unused for page tables.
- * @_refcount:        Same as page refcount. Used for s390 page tables.
  * @pt_memcg_data:    Memcg data. Tracked for page tables here.
  *
  * This struct overlays struct page for now. Do not modify without a good
@@ -438,7 +437,7 @@ struct ptdesc {
 #endif
 	};
 	unsigned int __page_type;
-	atomic_t _refcount;
+	unsigned int _pt_pad_3;
 #ifdef CONFIG_MEMCG
 	unsigned long pt_memcg_data;
 #endif
@@ -452,7 +451,6 @@ TABLE_MATCH(compound_head, _pt_pad_1);
 TABLE_MATCH(mapping, __page_mapping);
 TABLE_MATCH(rcu_head, pt_rcu_head);
 TABLE_MATCH(page_type, __page_type);
-TABLE_MATCH(_refcount, _refcount);
 #ifdef CONFIG_MEMCG
 TABLE_MATCH(memcg_data, pt_memcg_data);
 #endif
-- 
2.39.2

