Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712EE7E1360
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjKEMwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 07:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjKEMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 07:52:02 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E11DD45
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 04:51:54 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A5CoBU8015431;
        Sun, 5 Nov 2023 12:51:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=L7T8n6YctyotXTtcQwgsAPEnOMWU1sAeWRbOtIyFLJc=;
 b=kYZutI9dgILFSgSbTs+KKpLizroDx766+HIgl9KQTLIyYh9Ej/kMvLdg0P0EehgyqicR
 wrJ6NbbIUo4MJ5h2f0Y3+eAFsHf8Ap/sAApc4tkX02yXKSw5Sl7FozftEqPtCFimOHcW
 fHlPe4xDeFPDverK0tTlWIQ9l7p4E8LAFbv2KPU/P9i+W4gT5PfKsHtH5W7hMRpkG57p
 jaAu71CdPf1C8tQe6qDQ72dY0o1oEu8OYL8N0QcFkYTVz1fuMJ3BsyECVciX+5Ps6OY3
 DOLcgdaoJa+MmzSUZUC84s/DqHOz7sX4FNox0sBTJW4qEWWuewVIZh46CzpcYtxbieCu pQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5efyj0k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Nov 2023 12:51:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A5CpYtL021095
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Nov 2023 12:51:34 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sun, 5 Nov 2023 04:51:30 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <hannes@cmpxchg.org>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V2 2/3] mm: page_alloc: correct high atomic reserve calculations
Date:   Sun, 5 Nov 2023 18:20:49 +0530
Message-ID: <905d99651423ee85aeb7a71982b95ee9bb05ee99.1699104759.git.quic_charante@quicinc.com>
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
X-Proofpoint-GUID: DZYnG6HqyGY33Ef0z35NJ3u-Y8Sot20S
X-Proofpoint-ORIG-GUID: DZYnG6HqyGY33Ef0z35NJ3u-Y8Sot20S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=565 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311050112
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reserve_highatomic_pageblock() aims to reserve the 1% of the managed
pages of a zone, which is used for the high order atomic allocations.

It uses the below calculation to reserve:
static void reserve_highatomic_pageblock(struct page *page, ....) {

   .......
   max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;

   if (zone->nr_reserved_highatomic >= max_managed)
       goto out;

   zone->nr_reserved_highatomic += pageblock_nr_pages;
   set_pageblock_migratetype(page, MIGRATE_HIGHATOMIC);
   move_freepages_block(zone, page, MIGRATE_HIGHATOMIC, NULL);

out:
   ....
}

Since we are always appending the 1% of zone managed pages count to
pageblock_nr_pages, the minimum it is turning into 2 pageblocks as the
nr_reserved_highatomic is incremented/decremented in pageblock sizes.

Encountered a system(actually a VM running on the Linux kernel) with the
below zone configuration:
Normal free:7728kB boost:0kB min:804kB low:1004kB high:1204kB
reserved_highatomic:8192KB managed:49224kB

The existing calculations making it to reserve the 8MB(with pageblock
size of 4MB) i.e. 16% of the zone managed memory.  Reserving such high
amount of memory can easily exert memory pressure in the system thus may
lead into unnecessary reclaims till unreserving of high atomic reserves.

Since high atomic reserves are managed in pageblock size granules, as
MIGRATE_HIGHATOMIC is set for such pageblock, fix the calculations for
high atomic reserves as,  minimum is pageblock size , maximum is
approximately 1% of the zone managed pages.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/page_alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e07a38f..b91c99e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1883,10 +1883,11 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone)
 	unsigned long max_managed, flags;
 
 	/*
-	 * Limit the number reserved to 1 pageblock or roughly 1% of a zone.
+	 * The number reserved as: minimum is 1 pageblock, maximum is
+	 * roughly 1% of a zone.
 	 * Check is race-prone but harmless.
 	 */
-	max_managed = (zone_managed_pages(zone) / 100) + pageblock_nr_pages;
+	max_managed = ALIGN((zone_managed_pages(zone) / 100), pageblock_nr_pages);
 	if (zone->nr_reserved_highatomic >= max_managed)
 		return;
 
-- 
2.7.4

