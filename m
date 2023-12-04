Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5461802AD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjLDEPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234499AbjLDEPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:15:01 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B096910E;
        Sun,  3 Dec 2023 20:14:47 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B42tYN9015981;
        Mon, 4 Dec 2023 04:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=68XQWt2ukXHAU7islNTLqvCEjilOcERTt9Qh8Q/Ie0U=;
 b=Lc6j53mQtxmBjm869hn95g7jDNEP2x/qMr1bVxIkgotSiEEdKyq48xmQw+6+UIMftE/2
 2zuL+UWj7uSNmXycmoKgmDfVvGE6YypWRdNX5UIQ6Cs4x206Ps0bQqGnQ2uWbleuaXCt
 5tqiYP1zNXt7uME4Jj5hLRM4Z8q3BSU7FLxWEHGj3irC/BO05a0jkYWDhNHrZJ7PWHL1
 Nvem1G7zAl0rwOWinTa8Uj2Jn+lq7SLSaZAie7KGJ+tS6dbulnOdVDFwH095srDAT3/V
 bhMBpcynnJqGoZFe4ldI9Ncl7lXZOZKr0dTNZSwsJOQBfbtAWrG/YMhApjXeaEIytyKu Rg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqwrvtrp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Dec 2023 04:14:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B44E0XW004714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 4 Dec 2023 04:14:00 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sun, 3 Dec 2023 20:13:57 -0800
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH v2 1/6] of: reserved_mem: Change the order that reserved_mem regions are stored
Date:   Sun, 3 Dec 2023 20:13:34 -0800
Message-ID: <20231204041339.9902-2-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 9QOo5EJW0eVhJNApmAfixljyAdyc76hs
X-Proofpoint-GUID: 9QOo5EJW0eVhJNApmAfixljyAdyc76hs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_02,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 priorityscore=1501 mlxscore=0 spamscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040031
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamic allocation of the reserved_mem array needs to be done after
paging_init() is called because memory allocated using memblock_alloc()
is not writeable before that.

Statically-placed reserved memory regions can wait until after
paging_init() to be stored in the array because the starting address and
size information is already specified in the DT.
Dynamically-placed regions on the other hand does not have its starting
address specified in the DT because it is allocated at runtime. Hence,
the starting address of these regions need to be stored somewhere.
The allocation of dynamically-placed regions cannot be done after
paging_init() either to avoid getting regions that are already added to
the page table mappings.

Hence, change the code to:
1. Before paging_init(), allocate and store information for the
   dynamically-placed reserved memory regions.
2. After paging_init(), store the information for the statically
   placed reserved memory regions in the array.

All the regions are also reserved or marked as nomap as needed before
paging_init().

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c                | 63 ++++++++++++++++++++++++++++-----
 drivers/of/of_reserved_mem.c    | 53 ++++++++++++---------------
 include/linux/of_fdt.h          |  1 +
 include/linux/of_reserved_mem.h |  6 ++++
 4 files changed, 84 insertions(+), 39 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..34223c249914 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -504,7 +504,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 	phys_addr_t base, size;
 	int len;
 	const __be32 *prop;
-	int first = 1;
 	bool nomap;
 
 	prop = of_get_flat_dt_prop(node, "reg", &len);
@@ -532,10 +531,6 @@ static int __init __reserved_mem_reserve_reg(unsigned long node,
 			       uname, &base, (unsigned long)(size / SZ_1M));
 
 		len -= t_len;
-		if (first) {
-			fdt_reserved_mem_save_node(node, uname, base, size);
-			first = 0;
-		}
 	}
 	return 0;
 }
@@ -564,7 +559,56 @@ static int __init __reserved_mem_check_root(unsigned long node)
 }
 
 /*
- * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
+ * Save the reserved_mem reg nodes in the reserved_mem array
+ */
+void __init fdt_scan_reserved_mem_reg_nodes(void)
+
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	const void *fdt = initial_boot_params;
+	phys_addr_t base, size;
+	const __be32 *prop;
+	int node, child;
+	int len;
+
+	node = fdt_path_offset(fdt, "/reserved-memory");
+	if (node < 0) {
+		pr_err("Reserved memory: Did not find reserved-memory node\n");
+		return;
+	}
+
+	if (__reserved_mem_check_root(node) != 0) {
+		pr_err("Reserved memory: unsupported node format, ignoring\n");
+		return;
+	}
+
+	fdt_for_each_subnode(child, fdt, node) {
+		const char *uname;
+
+		prop = of_get_flat_dt_prop(child, "reg", &len);
+		if (!prop)
+			continue;
+
+		if (!of_fdt_device_is_available(fdt, child))
+			continue;
+
+		uname = fdt_get_name(fdt, child, NULL);
+		if (len && len % t_len != 0) {
+			pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+			       uname);
+			continue;
+		}
+
+		base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+		size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+		if (size)
+			fdt_reserved_mem_save_node(child, uname, base, size);
+	}
+}
+
+/*
+ * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory.
  */
 static int __init fdt_scan_reserved_mem(void)
 {
@@ -591,7 +635,7 @@ static int __init fdt_scan_reserved_mem(void)
 
 		err = __reserved_mem_reserve_reg(child, uname);
 		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			fdt_reserved_mem_save_node(child, uname, 0, 0);
+			__reserved_mem_alloc_size(child, uname);
 	}
 	return 0;
 }
@@ -645,8 +689,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 			break;
 		memblock_reserve(base, size);
 	}
-
-	fdt_init_reserved_mem();
 }
 
 /**
@@ -1335,6 +1377,9 @@ void __init unflatten_device_tree(void)
 	of_alias_scan(early_init_dt_alloc_memory_arch);
 
 	unittest_unflatten_overlay_base();
+
+	/*Initialize the reserved_mem regions*/
+	fdt_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcbddb..8bd8bbc3aaec 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -132,8 +132,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
-static int __init __reserved_mem_alloc_size(unsigned long node,
-	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
+int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t start = 0, end = 0;
@@ -212,10 +211,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-
-	*res_base = base;
-	*res_size = size;
-
+	fdt_reserved_mem_save_node(node, uname, base, size);
 	return 0;
 }
 
@@ -310,6 +306,8 @@ void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
+	fdt_scan_reserved_mem_reg_nodes();
+
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
 
@@ -328,30 +326,25 @@ void __init fdt_init_reserved_mem(void)
 		if (prop)
 			rmem->phandle = of_read_number(prop, len/4);
 
-		if (rmem->size == 0)
-			err = __reserved_mem_alloc_size(node, rmem->name,
-						 &rmem->base, &rmem->size);
-		if (err == 0) {
-			err = __reserved_mem_init_node(rmem);
-			if (err != 0 && err != -ENOENT) {
-				pr_info("node %s compatible matching fail\n",
-					rmem->name);
-				if (nomap)
-					memblock_clear_nomap(rmem->base, rmem->size);
-				else
-					memblock_phys_free(rmem->base,
-							   rmem->size);
-			} else {
-				phys_addr_t end = rmem->base + rmem->size - 1;
-				bool reusable =
-					(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
-
-				pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
-					&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
-					nomap ? "nomap" : "map",
-					reusable ? "reusable" : "non-reusable",
-					rmem->name ? rmem->name : "unknown");
-			}
+		err = __reserved_mem_init_node(rmem);
+		if (err != 0 && err != -ENOENT) {
+			pr_info("node %s compatible matching fail\n",
+				rmem->name);
+			if (nomap)
+				memblock_clear_nomap(rmem->base, rmem->size);
+			else
+				memblock_phys_free(rmem->base,
+						   rmem->size);
+		} else {
+			phys_addr_t end = rmem->base + rmem->size - 1;
+			bool reusable =
+				(of_get_flat_dt_prop(node, "reusable", NULL)) != NULL;
+
+			pr_info("%pa..%pa (%lu KiB) %s %s %s\n",
+				&rmem->base, &end, (unsigned long)(rmem->size / SZ_1K),
+				nomap ? "nomap" : "map",
+				reusable ? "reusable" : "non-reusable",
+				rmem->name ? rmem->name : "unknown");
 		}
 	}
 }
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index d69ad5bb1eb1..7b2a5d93d719 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -73,6 +73,7 @@ extern int early_init_dt_scan_root(void);
 extern bool early_init_dt_scan(void *params);
 extern bool early_init_dt_verify(void *params);
 extern void early_init_dt_scan_nodes(void);
+extern void fdt_scan_reserved_mem_reg_nodes(void);
 
 extern const char *of_flat_dt_get_machine_name(void);
 extern const void *of_flat_dt_match_machine(const void *default_match,
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 4de2a24cadc9..dc13bcd04b12 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -38,6 +38,7 @@ int of_reserved_mem_device_init_by_name(struct device *dev,
 					struct device_node *np,
 					const char *name);
 void of_reserved_mem_device_release(struct device *dev);
+int __reserved_mem_alloc_size(unsigned long node, const char *uname);
 
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #else
@@ -60,6 +61,11 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
+static inline int __reserved_mem_alloc_size(unsigned long node, const char *uname)
+{
+	return -ENOSYS;
+}
+
 static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 {
 	return NULL;
-- 
2.17.1

