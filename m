Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A87E135F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 13:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjKEMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 07:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKEMvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 07:51:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6FCDD
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 04:51:35 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A5CeWQo025850;
        Sun, 5 Nov 2023 12:51:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=ws0E3IMpr8r7oxbhnMYpQbr9QAYBBcg1XfkZGoPEQxM=;
 b=cL2CfozNXXHGjtyOcf0O1qJy03LsucahBs548E0Nb1ddPbdcMoWLQHZSwyOb//jvrv8h
 AVyAoCYNyeYktTY8/BEayjqcswBBGi7bHhaWE/QtGtVDSFt0MgcPAgU2beuB7x0x+LKB
 1YTjDJD5Ad0zq6b2Z06M/PthQVkYyBXzb2za0Y4FZ/eprqlx5REiftnQ/Sdo9mJ3xpvb
 F6EgEGVxyGUgRoiuFOZhZfYtK3FwC4KH+u5WE/RdZjRPzQkHDC3j7V0ENTSkQg897DKf
 sQoHB8N4EXmr+/4NPUFgEJOX94BtxQ8GSq5y5hnbN7O7BzGCWvrxtGChy8GB1aWCfaxq /A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5euysy21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 05 Nov 2023 12:51:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A5CpKe6011725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 5 Nov 2023 12:51:20 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Sun, 5 Nov 2023 04:51:16 -0800
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <akpm@linux-foundation.org>, <mgorman@techsingularity.net>,
        <mhocko@suse.com>, <david@redhat.com>, <vbabka@suse.cz>,
        <hannes@cmpxchg.org>, <quic_pkondeti@quicinc.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla <quic_charante@quicinc.com>
Subject: [PATCH V2 0/3] mm: page_alloc: fixes for early oom kills
Date:   Sun, 5 Nov 2023 18:20:47 +0530
Message-ID: <cover.1699104759.git.quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xsydmYasiE48f48Qk0xVDsXXH6yJuyM_
X-Proofpoint-ORIG-GUID: xsydmYasiE48f48Qk0xVDsXXH6yJuyM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-05_10,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 mlxlogscore=613
 phishscore=0 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Ealry OOM is happened on a system with out unreserving the highatomic
page blocks and draining of pcp lists for an allocation request.

The state of the system where this issue exposed shown in oom kill logs:
[  295.998653] Normal free:7728kB boost:0kB min:804kB low:1004kB
high:1204kB reserved_highatomic:8192KB active_anon:4kB inactive_anon:0kB
active_file:24kB inactive_file:24kB unevictable:1220kB writepending:0kB
present:70732kB managed:49224kB mlocked:0kB bounce:0kB free_pcp:688kB
local_pcp:492kB free_cma:0kB
[  295.998656] lowmem_reserve[]: 0 32
[  295.998659] Normal: 508*4kB (UMEH) 241*8kB (UMEH) 143*16kB (UMEH)
33*32kB (UH) 7*64kB (UH) 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB
0*4096kB = 7752kB

From the above log:
a) OOM is occurred with out unreserving the high atomic page blocks.
b) ~16MB of memory reserved for high atomic reserves against the 
expectation of 1% reserves.

These 2 issues are tried to be fixed in 1st and 2nd patch.

Another excerpt from the oom kill message:
Normal free:760kB boost:0kB min:768kB low:960kB high:1152kB
reserved_highatomic:0KB managed:49152kB free_pcp:460kB

In the above, pcp lists too aren't drained before entering into
oom kill path. This is tried to be fixed in 3rd patch.

Changes in V1:
 o Unreserving the high atomic page blocks is tried to fix from
   the oom kill path rather than in should_reclaim_retry()
 o discussed why a lot more than 1% of managed memory is reserved
   for high atomic reserves.
 o https://lore.kernel.org/linux-mm/1698669590-3193-1-git-send-email-quic_charante@quicinc.com/

Charan Teja Kalla (3):
  mm: page_alloc: unreserve highatomic page blocks before oom
  mm: page_alloc: correct high atomic reserve calculations
  mm: page_alloc: drain pcp lists before oom kill

 mm/page_alloc.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

-- 
2.7.4

