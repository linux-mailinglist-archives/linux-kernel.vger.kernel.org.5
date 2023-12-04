Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25700802AC7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjLDEO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:14:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234444AbjLDEOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:14:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD08D5;
        Sun,  3 Dec 2023 20:14:30 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B41lTrQ021618;
        Mon, 4 Dec 2023 04:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tS6apyrTUM2UpfFkK9FWe2t5HNwAaHbTSnhZYJs1TBE=;
 b=VZQJgduZ84HbASKD4Pl1j4WhYG9QKpmmn3OZvqLGxZr9/5yPLwsFlUr3rzdR085ClezV
 8wkejFBunVRQJVnooOgLeb6lk89HxlV4DO8d5HaQuC48fbOpVx0SOCNIi3zdsmqiU0px
 AtxVKjQfo0qTll4d9mcO0OFuLW78vs0q017x6TZWuxofWP/QM/Ubwu7S3bcZkmhU5eKs
 dWlS6BziwCG1XZhMqy20o2IR2HBt7KhCQkz+pb5PMn4IKK2mLbq2VYrr8IOtpt/LOgrs
 TeCLH1yA/nRuDheVCqEIKYxQITYtno3sWoZlKwbpxWpfU/Nnu9XpZslIDBNHb+pZULUL iw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqsxw357w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 04:14:06 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B44E55B026344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 04:14:05 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 3 Dec 2023 20:14:02 -0800
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH v2 5/6] of: reserved_mem: Add code to dynamically allocate reserved_mem array
Date:   Sun, 3 Dec 2023 20:13:38 -0800
Message-ID: <20231204041339.9902-6-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204041339.9902-1-quic_obabatun@quicinc.com>
References: <20231204041339.9902-1-quic_obabatun@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A8SsO6wWn22noIW1LxRR94xcAmw0O5LG
X-Proofpoint-GUID: A8SsO6wWn22noIW1LxRR94xcAmw0O5LG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_01,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=633 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040029
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved_mem array is statically allocated with a size of
MAX_RESERVED_REGIONS(64). Therefore, if the number of reserved_mem
regions exceeds this size, there will not be enough space to store
all the data.

Therefore, extend the use of the static array by introducing a
dynamically allocated array based on the number of reserved memory
regions specified in the DT.

Before paging_init() runs, the static array is used to store the
dynamically-placed regions.
After paging_init(), memory is dynamically allocated for the
reserved_mem array, and all entries from the static array is copied
over to the new array, and all other statically-placed regions are
added in as well.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             | 13 +++++++---
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 48 +++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 12769dd53c34..2f1eabbd6869 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -563,8 +563,8 @@ static int __init __reserved_mem_check_root(unsigned long node)
  */
 static int __init fdt_scan_reserved_mem(void)
 {
-	int node, child;
-	int dynamic_nodes_cnt = 0;
+	int node, child, err = 0;
+	int dynamic_nodes_cnt = 0, count = 0;
 	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
@@ -579,7 +579,6 @@ static int __init fdt_scan_reserved_mem(void)
 
 	fdt_for_each_subnode(child, fdt, node) {
 		const char *uname;
-		int err;
 
 		if (!of_fdt_device_is_available(fdt, child))
 			continue;
@@ -587,6 +586,8 @@ static int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
+		if (!err)
+			count++;
 
 		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL)) {
 			dynamic_nodes[dynamic_nodes_cnt] = child;
@@ -600,8 +601,12 @@ static int __init fdt_scan_reserved_mem(void)
 		child = dynamic_nodes[i];
 		uname = fdt_get_name(fdt, child, NULL);
 
-		__reserved_mem_alloc_size(child, uname);
+		err = __reserved_mem_alloc_size(child, uname);
+		if (!err)
+			count++;
 	}
+	update_reserved_mem_max_cnt(count);
+
 	return 0;
 }
 
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 575e2b4119e0..ef56b2ea185c 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -179,5 +179,6 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 void init_reserved_mem(void);
 void dt_reserved_mem_save_node(struct device_node *node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
+void update_reserved_mem_max_cnt(int max_count);
 
 #endif /* _LINUX_OF_PRIVATE_H */
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 2ef9edcb8c93..01cd6a571dc2 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,7 +26,9 @@
 
 #include "of_private.h"
 
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS];
+static struct reserved_mem *reserved_mem = reserved_mem_array;
+static int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
@@ -54,6 +56,42 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
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
+	memset_size = alloc_size - copy_size;
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
  * dt_reserved_mem_save_node() - save dt node for second pass initialization
  */
@@ -62,7 +100,7 @@ void __init dt_reserved_mem_save_node(struct device_node *node, const char *unam
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
-	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
+	if (reserved_mem_count == total_reserved_mem_cnt) {
 		pr_err("not enough space for all defined regions.\n");
 		return;
 	}
@@ -346,7 +384,11 @@ static void __init __rmem_check_for_overlap(void)
  */
 void __init init_reserved_mem(void)
 {
-	int i;
+	int i, ret;
+
+	ret = alloc_reserved_mem_array();
+	if (ret)
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", ret);
 
 	scan_reserved_mem_reg_nodes();
 
-- 
2.17.1

