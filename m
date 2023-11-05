Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93FF7E135E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 13:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjKEMvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 07:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKEMvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 07:51:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725C7E0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 04:51:43 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A5CZlcl017538;
        Sun, 5 Nov 2023 12:51:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=12MQflBjL4Gqb+axG0wpE/BY/zW7nOj/OH6uPabUueU=;
 b=lgOUV9fg8MXUnJKK390DF9w4DEC3UYUf3R8T/5B0Yku5IaEQML0p+XHMpsdnIX5ou7gt
 zyrgzHIelzSz2D/TpmXKCzHryPjAMJeVZWO5+vi659QGPuC9GizMBK/YJMTW3bR1u5I3
 rqdMtL0s6eijef4oi0SMIisCkCsZThLTPEc4q4CNGHpE3cOAAnPdwLce7qqICnynGdZ6
 JDN/jz82MWxuBDTFEXoXoNHuCHj+WEkoK0QQCe+j2YcAUr4sGog7WhZcI0UIBMFUPnnA
 +I3dnlH7sKU3O+9EMpp6vMipafKW2ee0kKe3XzwjC0Zd+ByE1UHDM6SjtrMvwUQKSTwE rA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5ernhya0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Nov 2023 12:51:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A5CpUxM030773
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Nov 2023 12:51:30 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sun, 5 Nov 2023 04:51:27 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <hannes@cmpxchg.org>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V2 1/3] mm: page_alloc: unreserve highatomic page blocks before oom
Date:   Sun, 5 Nov 2023 18:20:48 +0530
Message-ID: <301b193fcc3e1f91ef30f19ceca06dd6e00b35e1.1699104759.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1699104759.git.quic_charante@quicinc.com>
References: <cover.1699104759.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: W1coWO3tY08OTjTt_w7lR7qf7TvlIyC7
X-Proofpoint-GUID: W1coWO3tY08OTjTt_w7lR7qf7TvlIyC7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=926 malwarescore=0 spamscore=0
 mlxscore=0 suspectscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311050112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__alloc_pages_direct_reclaim() is called from slowpath allocation where
high atomic reserves can be unreserved after there is a progress in
reclaim and yet no suitable page is found. Later should_reclaim_retry()
gets called from slow path allocation to decide if the reclaim needs to
be retried before OOM kill path is taken.

should_reclaim_retry() checks the available(reclaimable + free pages)
memory against the min wmark levels of a zone and returns:
a)  true, if it is above the min wmark so that slow path allocation will
do the reclaim retries.
b) false, thus slowpath allocation takes oom kill path.

should_reclaim_retry() can also unreserves the high atomic reserves
**but only after all the reclaim retries are exhausted.**

In a case where there are almost none reclaimable memory and free pages
contains mostly the high atomic reserves but allocation context can't
use these high atomic reserves, makes the available memory below min
wmark levels hence false is returned from should_reclaim_retry() leading
the allocation request to take OOM kill path. This can turn into a early
oom kill if high atomic reserves are holding lot of free memory and
unreserving of them is not attempted.

(early)OOM is encountered on a VM with the below state:
[  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
local_pcp:492kB free_cma:0kB
[  295.998656] lowmem_reserve[]: 0 32
[  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
0*4096kB = 7752kB

Per above log, the free memory of ~7MB exist in the high atomic
reserves is not freed up before falling back to oom kill path.

Fix it by trying to unreserve the high atomic reserves in
should_reclaim_retry() before __alloc_pages_direct_reclaim() can
fallback to oom kill path.

Fixes: 0aaa29a56e4f ("mm, page_alloc: reserve pageblocks for high-order atomic allocations on demand")
Reported-by: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/page_alloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 95546f3..e07a38f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3809,14 +3809,9 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	else
 		(*no_progress_loops)++;
 
-	/*
-	 * Make sure we converge to OOM if we cannot make any progress
-	 * several times in the row.
-	 */
-	if (*no_progress_loops > MAX_RECLAIM_RETRIES) {
-		/* Before OOM, exhaust highatomic_reserve */
-		return unreserve_highatomic_pageblock(ac, true);
-	}
+	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
+		goto out;
+
 
 	/*
 	 * Keep reclaiming pages while there is a chance this will lead
@@ -3859,6 +3854,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		schedule_timeout_uninterruptible(1);
 	else
 		cond_resched();
+out:
+	/* Before OOM, exhaust highatomic_reserve */
+	if (!ret)
+		return unreserve_highatomic_pageblock(ac, true);
+
 	return ret;
 }
 
-- 
2.7.4

