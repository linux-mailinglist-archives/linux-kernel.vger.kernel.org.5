Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E437754C1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjHIIG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjHIIGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:06:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E31736
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 01:06:53 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3795Ol5i019476;
        Wed, 9 Aug 2023 08:06:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=n6oO/Zyg5u9mi3NEeRs+7NvOb9/aJP4ApSLJNLlmAck=;
 b=AlYueKLla5tihr7t6p7d3NlYQXOUkzYj+1hE6DfRD3LyHHG2eivtW6b+LinWtZmJzTOR
 bOWHdQXSxhaYTcuL+AJu6j/x9jCmTUvueIrEucfLvnKx8vZa3ednxtOm7eRa4Z8sJM6w
 LbZCCWuYDlXNqiq94sp7IrYbp+kgZKPVU4J3k+L3lneYWVetmMRDD6ughWw4HbS0DQEH
 x3wqycwkntt1rl06dZIQ4ht8OhBq7+MRt9xY2NoN98LLeM9pyaTbhB2iPt2p6ND/obHq
 tFKSgu2BMuPz/tVDzDtxGDHwvgftzrmOQbDPFx/TGNwty0tGsKkKtghEwwerfip+PX3K 3g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sbcacu5bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 08:06:30 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37986Tba019764
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 08:06:29 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 9 Aug 2023 01:06:26 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <zhaoyang.huang@unisoc.com>,
        <yuzhao@google.com>, <surenb@google.com>, <kaleshsingh@google.com>,
        <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH] Multi-gen LRU: skip CMA pages when they are not eligible
Date:   Wed, 9 Aug 2023 13:35:44 +0530
Message-ID: <1691568344-13475-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jDrU7E3CGU_j3ij3oL6NkCrYo3gwc6hq
X-Proofpoint-ORIG-GUID: jDrU7E3CGU_j3ij3oL6NkCrYo3gwc6hq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_06,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=956 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308090070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on the commit 5da226dbfce3("mm: skip CMA pages when
they are not available") which skips cma pages reclaim when they are not
eligible for the current allocation context. In mglru, such pages are
added to the tail of the immediate generation to maintain better LRU
order, which is unlike the case of conventional LRU where such pages are
directly added to the head of the LRU list(akin to adding to head of the
youngest generation in mglru).

No observable issue without this patch on MGLRU, but logically it make
sense to skip the CMA page reclaim when those pages can't be satisfied
for the current allocation context.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index b4329f9..6cbe921 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4943,7 +4943,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* ineligible */
-	if (zone > sc->reclaim_idx) {
+	if (zone > sc->reclaim_idx || skip_cma(folio, sc)) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
-- 
2.7.4

