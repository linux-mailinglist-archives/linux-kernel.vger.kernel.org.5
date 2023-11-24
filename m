Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644097F7265
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 12:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbjKXLGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 06:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345606AbjKXLGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 06:06:22 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05943D5A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 03:06:28 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO6oCsq002993;
        Fri, 24 Nov 2023 11:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=J+LuJGeCVyBu3dlVJFr7/BB9Eb1zeMspyoB56KMLigA=;
 b=G+1CJK91OKIA8HhR3iFaDZChFXKUIx8sXvdOVFwyuggMWyLI2geCsxeOqV5rVMe5X2rV
 Wusf1NcqLP40dkG6Q54+HZ+aTQS/2fRZyxQEhiWUUnI8Vvs0dqgL9P0bBSX3olnZX/p3
 UUSghDKZUHroc0ks2WgNU9AFkl4mtqHXkaHrZR/iu3uSOlvXzqjwLHD0pOP8ypWocpr6
 aI+/KjhRuQnXAA6tPpcj+76iG8Hv4kInfRQRt8xmNCJuDRhneFmc2tva0XHO4nLGKVFm
 jSopL/3g9EBDyF4QrNZh2FXD/3KlhOKMriwHCRhSMFL7TfVpsL/fx2AZNS5PRDY3Hh8S XQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ujgqdsah3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:06:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOB6DYf004386
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 11:06:13 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 24 Nov 2023 03:06:10 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <hannes@cmpxchg.org>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V3 0/2] mm: page_alloc: fixes for high atomic reserve caluculations
Date:   Fri, 24 Nov 2023 16:35:51 +0530
Message-ID: <cover.1700821416.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ghGgIOe1QhYAgzNMuJUHKDWeKBInfhG2
X-Proofpoint-ORIG-GUID: ghGgIOe1QhYAgzNMuJUHKDWeKBInfhG2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 phishscore=0 mlxlogscore=615
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

The state of the system where the issue exposed shown in oom kill logs:
[  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
local_pcp:492kB free_cma:0kB
[  295.998656] lowmem_reserve[]: 0 32
[  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
0*4096kB = 7752kB

From the above, it is seen that ~16MB of memory reserved for high atomic
reserves against the expectation of 1% reserves which is fixed in the
1st patch.

Don't reserve the high atomic page blocks if 1% of zone memory size is
below a pageblock size.

Changes in V3:
 o Seperated the patch of unreserving the high atomic pageblock done from
   should reclaim retry.
 o Don't reserve high atomic page blocks for smaller zone sizes.

Changes in V2:
 o Unreserving the high atomic page blocks is done from should_reclaim_retry()
 o Reserve minimum and max memory for high atomic reserves as a pageblock and
   1% of the memory zone respectively.
 o drain the pcp lists before falling back to OOM.
 o https://lore.kernel.org/linux-mm/cover.1699104759.git.quic_charante@quicinc.com/

Changes in V1:
 o Unreserving the high atomic page blocks is tried to fix from
   the oom kill path rather than in should_reclaim_retry()
 o discussed why a lot more than 1% of managed memory is reserved
   for high atomic reserves.
 o https://lore.kernel.org/linux-mm/1698669590-3193-1-git-send-email-quic_charante@quicinc.com/

Charan Teja Kalla (2):
  mm: page_alloc: correct high atomic reserve calculations
  mm: pagealloc: enforce minimum zone size to do high atomic reserves

 mm/page_alloc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.7.4

