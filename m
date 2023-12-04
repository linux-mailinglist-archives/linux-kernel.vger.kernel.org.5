Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E2803DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjLDS5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjLDS4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:56:40 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA18107;
        Mon,  4 Dec 2023 10:56:46 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4FjgwX024184;
        Mon, 4 Dec 2023 18:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=tS6apyrTUM2UpfFkK9FWe2t5HNwAaHbTSnhZYJs1TBE=;
 b=SZs6VYquS+RgATEpjCVdCyV1F1jdhnjNt7iOWnOUmlKp8IF7G8eW5bWL6q159USkOzvr
 RiOOhbh7Hc8zg1yTc5ZSDpX+u8mFewir0492Q1ZkVByw5W57ZnRwYlj/3FB98b7d0Chf
 2L3Xxn6hC6YqKeB5Fz9B05ppZywHG2nYeTJEBkOwWy/6iqsRrn+/c/Yu9ho5MEagyIH5
 0geCpyNo7UE4DQd1UpcC7++NrYrYHOP5KwgqDqOX8IPA0p5QBHtb4Dqr37nYkqWwvOTw
 gR319Efc3JtUkawMR5uvDlj8nfkFpCxiucqMyeRA9jjtHzHIGRnWQu1CdQGjKAGJKCo1 /A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3usgfmrpnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 18:54:49 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B4Isme4013393
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 18:54:48 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Dec 2023 10:54:45 -0800
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
Subject: [RFC PATCH v2 5/6] of: reserved_mem: Add code to dynamically allocate reserved_mem array
Date:   Mon, 4 Dec 2023 10:54:08 -0800
Message-ID: <20231204185409.19615-6-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: 8xbm48r6qn8thC0re3s_UqANDMySnxAE
X-Proofpoint-ORIG-GUID: 8xbm48r6qn8thC0re3s_UqANDMySnxAE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=684 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

