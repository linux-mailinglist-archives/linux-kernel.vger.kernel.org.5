Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925987F722C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345706AbjKXK6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345362AbjKXK6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:58:07 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D23D44
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 02:58:12 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AOAvudk023244;
        Fri, 24 Nov 2023 10:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=qJYKCnY15MtyD1i2oBanNGX6llWbvyH4diC81pvBdwk=;
 b=Cud8PM6xctfq91vVrtzSwd8dX6Y2RP3auZu8NMWsNpRbIuFEBB30MGmDd2D+34+HMycD
 KtnMjPjrTZJ9REUmFs0lH5yf8nF3MxJpm5Aexyki5G3AmKDLpdvMLC6EX0Bslbq6OcIo
 1QB+47/pYVdzgxxY9Jx+bibRKUUoTogT1BRGOoMFJbs+B0YT2sv1KOFiJRGS+q2Ytq4P
 h7DIsFS/ZA5AlGBQzuvsgy3eQuGtyPwUHxOgosfz3Pbmfc7O99MeeR5C7whGkA08NlPI
 PwgMZPwJ+i0RVVuPurCSsKdAev4OHqQkcm+9f2W/HZtZjy68Mys/JvB09yDNkCSFksDK qw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj7gjt8n5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:57:56 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOAvtQG029675
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:57:55 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 02:57:50 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <hannes@cmpxchg.org>, <quic_pkondeti@quicinc.com>,
        <quic_cgoldswo@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [RESEND PATCH V2] mm: page_alloc: unreserve highatomic page blocks before oom
Date:   Fri, 24 Nov 2023 16:27:25 +0530
Message-ID: <1700823445-27531-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fNJKhlF92KjgzJCQvDGH27e7Lh6-7aum
X-Proofpoint-GUID: fNJKhlF92KjgzJCQvDGH27e7Lh6-7aum
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240086
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
Acked-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
Changes in V2 and RESEND: 
 o Unreserve the high atomic pageblock from should_reclaim_retry()
 o Collected the tags by Michal.
 o Start a separate discussion for high atomic reserves.
 o https://lore.kernel.org/linux-mm/cover.1699104759.git.quic_charante@quicinc.com/#r

Changes in V1:
 o Unreserving the high atomic page blocks is tried to fix from
   the oom kill path rather than in should_reclaim_retry()
 o https://lore.kernel.org/linux-mm/1698669590-3193-1-git-send-email-quic_charante@quicinc.com/

 mm/page_alloc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e..6d2a741 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3951,14 +3951,9 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
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
@@ -4001,6 +3996,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
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

