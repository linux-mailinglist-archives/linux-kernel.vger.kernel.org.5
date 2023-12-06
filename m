Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1EC80738C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 16:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442448AbjLFPQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 10:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379162AbjLFPQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 10:16:25 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99CD66;
        Wed,  6 Dec 2023 07:16:32 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6Emdux015892;
        Wed, 6 Dec 2023 15:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jeL3QT7o0mBxKNPJeUdUZqEhxWca9D1K5PSNHaGGlqE=;
 b=TbTj+H0YrH8CJvfVXOaZCn4V8K4SgoIdPIDmqjcTwfxjgpbpaaB74suikR1eYjVLd1GH
 2Ug7fgzzPMVs6bb8eZN2qvlGAPndfy91omGmdNc4cwXx49RWhi1vKgZPsGem/ZR0Oiaf
 P0SzA78LdIlOx45KBqFSho1hWH7UPzXmEQaxJMMIYyWDBZ7s9NjE8L1ZsAXDstlliEHv
 B7p49X0Hho61WDYdehuMs6nxNOcnAil+rruk+17R4KP86pqEKCtRM26rzg/oJ5rcyNDU
 oQZiwXUE0JQr0O4Vmkx4pHApmbKSQi6LYI3KNc1zwCMn/2Y7qMvRTrepJxpl77cxnR4K Zw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utd51267e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 15:16:25 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6FGP2K023959
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Dec 2023 15:16:25 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 6 Dec 2023 07:16:22 -0800
From:   Pintu Kumar <quic_pintu@quicinc.com>
To:     <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <devicetree@vger.kernel.org>
CC:     <quic_pintu@quicinc.com>, <pintu.ping@gmail.com>
Subject: [PATCH] of: reserved_mem: fix error log for reserved mem init failure
Date:   Wed, 6 Dec 2023 20:46:00 +0530
Message-ID: <20231206151600.26833-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z48NGZs03K_8xD7IbWBylQ_-5fXUs4Gz
X-Proofpoint-GUID: z48NGZs03K_8xD7IbWBylQ_-5fXUs4Gz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_13,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=473 spamscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312060123
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During fdt_init_reserved_mem() when __reserved_mem_init_node()
fail we are using pr_info to print error.

So, if we change the loglevel to 4 (or below), this error
message will be missed.

Thus, change the pr_info to pr_err for fail case.

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 drivers/of/of_reserved_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcbddb..473665e76b6f 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -334,7 +334,7 @@ void __init fdt_init_reserved_mem(void)
 		if (err == 0) {
 			err = __reserved_mem_init_node(rmem);
 			if (err != 0 && err != -ENOENT) {
-				pr_info("node %s compatible matching fail\n",
+				pr_err("node %s compatible matching fail\n",
 					rmem->name);
 				if (nomap)
 					memblock_clear_nomap(rmem->base, rmem->size);
-- 
2.17.1

