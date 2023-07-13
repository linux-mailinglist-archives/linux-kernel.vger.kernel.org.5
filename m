Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C333751999
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjGMHQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbjGMHQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:16:07 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DBA119
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:16:06 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36D6pjgD021569;
        Thu, 13 Jul 2023 07:15:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=G+SM0xlJQlGGJ7O5RMFvi7gmhLdB2QSrfaYUMEEoKoI=;
 b=apIiJSozVuJwlTs5ltZW63qEKCRTcZV1+3AxxBJf1z4YiinryfsT4yuudwTmFaHCWueZ
 IQJo4gfOaLYwytsjeLWGJGmsv8bwpCEz7NbP78IzDo/j2eoIq4h1DCilczd0Nxz5dgKJ
 vqymTzJvQ/4WHLzd0Km0cTHYhPgtHBzfxvZLa3DWXr4f0zqUOKW+VW+cR92Vjb1W+unK
 tcfaW5uvUIPJLQN3xyZo27g1Cx9uPiNp1/TVaD0Ny6FEbFyR/gzEcrBajKhHD0WJ/Xwn
 CXPe3+rEXzApfh9kq5o+cf9W0y1ucjbYe9xTc2tLa9UdlECty/akgz9P0B84HEeKYIn/ PQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtbmur3wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:15:59 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36D7Fwr2027102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 07:15:58 GMT
Received: from hu-nprakash-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 00:09:31 -0700
From:   Nikhil V <quic_nprakash@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>
CC:     Nikhil V <quic_nprakash@quicinc.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_guptap@quicinc.com>, <quic_charante@quicinc.com>
Subject: [PATCH] arm64: mm: Make hibernation aware of KFENCE
Date:   Thu, 13 Jul 2023 12:37:57 +0530
Message-ID: <20230713070757.4093-1-quic_nprakash@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ArvbgUGmIseak7PaXnMRBnZo-9DyaCfi
X-Proofpoint-ORIG-GUID: ArvbgUGmIseak7PaXnMRBnZo-9DyaCfi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_04,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=765 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130062
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the restore path, swsusp_arch_suspend_exit uses copy_page() to
over-write memory. However, with features like KFENCE enabled, there could
be situations where it may have marked some pages as not valid, due to
which it could be reported as invalid accesses.

Consider a situation where page 'P' was part of the hibernation image.
Now, when the resume kernel tries to restore the pages, the same page 'P'
is already in use in the resume kernel and is kfence protected, due to
which its mapping is removed from linear map. Since restoring pages happens
with the resume kernel page tables, we would end up accessing 'P' during
copy and results in kernel pagefault.

The proposed fix tries to solve this issue by marking PTE as valid for such
kfence protected pages.

Co-developed-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Signed-off-by: Nikhil V <quic_nprakash@quicinc.com>
---
 arch/arm64/mm/trans_pgd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index 4ea2eefbc053..e9ad391fc8ea 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -24,6 +24,7 @@
 #include <linux/bug.h>
 #include <linux/mm.h>
 #include <linux/mmzone.h>
+#include <linux/kfence.h>
 
 static void *trans_alloc(struct trans_pgd_info *info)
 {
@@ -41,7 +42,8 @@ static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 		 * the temporary mappings we use during restore.
 		 */
 		set_pte(dst_ptep, pte_mkwrite(pte));
-	} else if (debug_pagealloc_enabled() && !pte_none(pte)) {
+	} else if ((debug_pagealloc_enabled() ||
+		   is_kfence_address((void *)addr)) && !pte_none(pte)) {
 		/*
 		 * debug_pagealloc will removed the PTE_VALID bit if
 		 * the page isn't in use by the resume kernel. It may have
-- 
2.17.1

