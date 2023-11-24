Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEB07F7267
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345813AbjKXLGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345762AbjKXLGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:06:41 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFA8D67
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:06:47 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO7jbLs014209;
        Fri, 24 Nov 2023 11:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=unZr2r09oe2gFwUjtlqIUkcLXTRXdidcdfMvMtUu+oI=;
 b=Yee6TmUtcPvEN+L5OUb/QQcawVX4DBg0hC1DrrjUBRE+13brZhRTvQ1QnHNG8LvMHQr7
 6/RdViuY0Z4nWje2BRUx+yM9I68ays1OtOMD5MsOXCj83JecYG5HorhjrITy0a+iiC2W
 VEJLJrs9KT95KF/g8uFeTDcQTZmLHCaS/fEXMXjFJ7VLulYQIm4Y+9thi5qtbe7iSUcL
 YGdCT7CIr2g13MWJhpkIQf4OfWa84ArDHck1x1lZJn2iELJ1TBBEzQXvFRhLAucSvSLM
 X2MkH/ufAJiS2ugfQ0wWbE2DnOr72ubBGHrt7lte4fsV0sxUs3yW+ZnuQMvNKB9EGSxq Ww== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ujp8x0ubf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:06:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOB6WIs001974
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:06:32 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 03:06:28 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <hannes@cmpxchg.org>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V3 2/2] mm: page_alloc: enforce minimum zone size to do high atomic reserves
Date:   Fri, 24 Nov 2023 16:35:53 +0530
Message-ID: <c3a2a48e2cfe08176a80eaf01c110deb9e918055.1700821416.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1700821416.git.quic_charante@quicinc.com>
References: <cover.1700821416.git.quic_charante@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J5qhlPbAejO_GA495peGrZm6GGDU2tQF
X-Proofpoint-ORIG-GUID: J5qhlPbAejO_GA495peGrZm6GGDU2tQF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=887 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Highatomic reserves are set to roughly 1% of zone for maximum and a
pageblock size for minimum.  Encountered a system with the below
configuration:
Normal free:7728kB boost:0kB min:804kB low:1004kB high:1204kB
reserved_highatomic:8192KB managed:49224kB

On such systems, even a single pageblock makes highatomic reserves are
set to ~8% of the zone memory. This high value can easily exert pressure
on the zone.

Per discussion with Michal and Mel, it is not much useful to reserve
the memory for highatomic allocations on such small systems[1]. Since
the minimum size for high atomic reserves is always going to be a
pageblock size and if 1% of zone managed pages is going to be below
pageblock size, don't reserve memory for high atomic allocations. Thanks
Michal for this suggestion[2].

Since no memory is being reserved for high atomic allocations and if
respective allocation failures are seen, this patch can be reverted.

[1] https://lore.kernel.org/linux-mm/20231117161956.d3yjdxhhm4rhl7h2@techsingularity.net/
[2] https://lore.kernel.org/linux-mm/ZVYRJMUitykepLRy@tiehlicka/

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/page_alloc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a789dfd..9f1b33e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1885,9 +1885,12 @@ static void reserve_highatomic_pageblock(struct page *page, struct zone *zone)
 
 	/*
 	 * The number reserved as: minimum is 1 pageblock, maximum is
-	 * roughly 1% of a zone.
+	 * roughly 1% of a zone. But if 1% of a zone falls below a
+	 * pageblock size, then don't reserve any pageblocks.
 	 * Check is race-prone but harmless.
 	 */
+	if ((zone_managed_pages(zone) / 100) < pageblock_nr_pages)
+		return;
 	max_managed = ALIGN((zone_managed_pages(zone) / 100), pageblock_nr_pages);
 	if (zone->nr_reserved_highatomic >= max_managed)
 		return;
-- 
2.7.4

