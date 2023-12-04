Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA50803D9E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjLDS4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjLDS4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:56:38 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99732B2;
        Mon,  4 Dec 2023 10:56:42 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4Fap4b014942;
        Mon, 4 Dec 2023 18:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=n6Lojg+3L7EfygQUx0vRNm4ETKLDPxcnSDHlrIicw7Y=;
 b=dSL2X98XzMxJYEk7uH3+GxrxCZReZnQ7ONhqD0Y4eYBjfMhyiE4BblqQa7V1XzwRtvhg
 yRn3mw+mDBiV+M3xEhib6gh2g3RoNLsFVLuX9HzFmVITupJacvXkRBLcrNpmbo4ZOksW
 q4RC5coC9XX0WoFjfwm89PxapnfQiPBBUZS8bbn/YlfkUVgBGNzZgVX5Bfu+53t8oL3Q
 pJqb5npRT53xix0+hMXM0QqTwIJxouJ1ZR4iLVLBjDcfMnjvqH7N/dLSeGQwTt3psgLi
 WFWuwt+14KxXME7WaCCnroCMwRImkErarPzFnSyMIDM70SBMQ5YJaNlr8QGDYXkLFYdy YQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usgs7gmyb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 18:54:47 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4IskL2026195
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 18:54:46 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 10:54:43 -0800
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <dinguyen@kernel.org>,
        <chenhuacai@kernel.org>, <tsbogend@alpha.franken.de>,
        <jonas@southpole.se>, <stefan.kristiansson@saunalahti.fi>,
        <shorne@gmail.com>, <mpe@ellerman.id.au>,
        <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH v2 3/6] of: resevred_mem: Delay allocation of memory for dynamic regions
Date:   Mon, 4 Dec 2023 10:54:06 -0800
Message-ID: <20231204185409.19615-4-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204185409.19615-1-quic_obabatun@quicinc.com>
References: <20231204185409.19615-1-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SkKP7LrC-_D4wSWBBd1gO9AUleDBVVA3
X-Proofpoint-GUID: SkKP7LrC-_D4wSWBBd1gO9AUleDBVVA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=857 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040146
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defer the allocation of memory for the dynamically-placed reserved
memory regions until after the statically-placed reserved memory
regions have been reserved or marked as nomap in memblock.
This is to avoid allocating from regions that will later turn out to
have been reserved by other nodes.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             | 18 ++++++++++++++++--
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c |  1 -
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 34223c249914..46adce306bbd 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -613,6 +613,8 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 static int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
+	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
@@ -634,8 +636,20 @@ static int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
-		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			__reserved_mem_alloc_size(child, uname);
+
+		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
+			dynamic_nodes[dynamic_nodes_cnt] = child;
+			dynamic_nodes_cnt++;
+		}
+	}
+
+	for (int i = 0; i < dynamic_nodes_cnt; i++) {
+		const char *uname;
+
+		child = dynamic_nodes[i];
+		uname = fdt_get_name(fdt, child, NULL);
+
+		__reserved_mem_alloc_size(child, uname);
 	}
 	return 0;
 }
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f38397c7b582..57694a704b00 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -36,6 +36,7 @@ struct alias_prop {
 #endif
 
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
+#define MAX_RESERVED_REGIONS    64
 
 extern struct mutex of_mutex;
 extern raw_spinlock_t devtree_lock;
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8bd8bbc3aaec..d62f1956024c 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,7 +26,6 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
-- 
2.17.1

