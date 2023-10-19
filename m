Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5668B7D020D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346421AbjJSStn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbjJSStc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:49:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EB4126;
        Thu, 19 Oct 2023 11:49:30 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JHJNx3032400;
        Thu, 19 Oct 2023 18:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=4ia+4nxmsHQx9Jbz7xvWrAWC2YfVIdfAYLgn9giqtLE=;
 b=FShygMnWUSwQEKnzo0/kul+km5u3rlkdypusfUKf4c2x9Sb7TBOdZxZo3K9VtkzRQBOj
 oEGxTj7KVeOYhCl9YndivDz6EetcoP9IVM9SLrDeNugGUyjzOxNXYXvBJOsi7WRmFMFF
 efIt67LeqmqlKNvdZZLDKC9yH6Qq+RWfiF2TaQdFWYA8/GiidLCcY2CA/BSxdF4hxU0v
 lPzyIGtsdAMdHICc44nF/xK1qp2QK+Dv5gu/LeJ0XfMEuurDugYUY1waQBEMliRZF91K
 7V2pu2uLOU6ZlhbYzzD0V0umWEepmp+LnzGEg2qQftq6cv9i1jGZbMbLikFKgx2TELLV aA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttcuv43h6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 18:49:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JInKNU003028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 18:49:20 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 11:49:17 -0700
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH 2/3] of: reserved_mem: Add code to dynamically allocate reserved_mem array
Date:   Thu, 19 Oct 2023 11:48:24 -0700
Message-ID: <20231019184825.9712-3-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231019184825.9712-1-quic_obabatun@quicinc.com>
References: <20231019184825.9712-1-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: SgtAyQpN_jUwKQXS_o-oDk0WL2Ew1m4w
X-Proofpoint-GUID: SgtAyQpN_jUwKQXS_o-oDk0WL2Ew1m4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_18,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=545 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved_mem array is statically allocated with a size of
MAX_RESERVED_REGIONS(64). Therefore, if the number of reserved_mem
regions exceeds this size, there will not be enough space to store
all the data.

To fix this, dynamically allocate memory for the reserved_mem array
based on the number of reserved memory regions speicified in the DT.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |  9 ++++--
 drivers/of/of_private.h      |  2 ++
 drivers/of/of_reserved_mem.c | 53 ++++++++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index d51a1176a7b9..408fd15b7db0 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -598,7 +598,7 @@ static void save_reserved_mem_reg_nodes(unsigned long node, const char *uname)
  */
 int __init fdt_scan_reserved_mem(bool save_only)
 {
-	int node, child;
+	int node, child, count = 0;
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
@@ -626,8 +626,13 @@ int __init fdt_scan_reserved_mem(bool save_only)
 
 		err = __reserved_mem_reserve_reg(child, uname);
 		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			__reserved_mem_alloc_size(child, uname);
+			err = __reserved_mem_alloc_size(child, uname);
+
+		if (err == 0)
+			count++;
 	}
+	if (!save_only)
+		update_reserved_mem_max_cnt(count);
 	return 0;
 }
 
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index e52b27b8392d..ca1ba9f06660 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -178,4 +178,6 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
 
+void update_reserved_mem_max_cnt(int max_count);
+
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 13e694f5e316..203828ca118e 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -27,7 +27,10 @@
 #include "of_private.h"
 
 #define MAX_RESERVED_REGIONS	64
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS];
+static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
+
+static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
@@ -55,6 +58,45 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	return err;
 }
 
+void __init update_reserved_mem_max_cnt(int max_count)
+{
+	total_reserved_mem_cnt = max_count;
+}
+
+static int alloc_reserved_mem_array(void)
+{
+	struct reserved_mem *new_array;
+	size_t alloc_size, copy_size, memset_size;
+
+	alloc_size = array_size(total_reserved_mem_cnt, sizeof(*new_array));
+	if (alloc_size == SIZE_MAX)
+		return -1;
+
+	new_array = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
+	if (!new_array)
+		return -ENOMEM;
+
+	copy_size = array_size(reserved_mem_count, sizeof(*new_array));
+	if (copy_size == SIZE_MAX)
+		goto overlow_err;
+
+	if (total_reserved_mem_cnt >= reserved_mem_count)
+		memset_size = alloc_size - copy_size;
+	else
+		memset_size = copy_size - alloc_size;
+
+	memcpy(new_array, reserved_mem, copy_size);
+	memset(new_array + reserved_mem_count, 0, memset_size);
+
+	reserved_mem = new_array;
+	return 0;
+
+overlow_err:
+	memblock_free(new_array, alloc_size);
+	total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
+	return -1;
+}
+
 /*
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -63,7 +105,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
-	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
+	if (reserved_mem_count == total_reserved_mem_cnt) {
 		pr_err("not enough space for all defined regions.\n");
 		return;
 	}
@@ -304,9 +346,14 @@ static void __init __rmem_check_for_overlap(void)
  */
 void __init fdt_init_reserved_mem(void)
 {
-	int i;
+	int i, ret = 0;
 	bool save_only = true;
 
+	ret = alloc_reserved_mem_array();
+	if (ret) {
+		pr_err("Failed to store reserved_mem nodes in array with err: %d", ret);
+		return;
+	}
 	fdt_scan_reserved_mem(save_only);
 
 	/* check for overlapping reserved regions */
-- 
2.17.1

