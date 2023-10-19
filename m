Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 139C77D020F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 20:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346413AbjJSStk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjJSStb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 14:49:31 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F7124;
        Thu, 19 Oct 2023 11:49:29 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39JHNJlJ011978;
        Thu, 19 Oct 2023 18:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=BuGkhetOWBMZsLhq7p+n+W0+ctX7hrXVi9MFFhPhWo8=;
 b=OnBDNqAaG6AH2FeWrbuVq9HQ1dPG7t9aeXfFZXvmFBLWV8NNm1SwkQtiHjOyTsgM0hNq
 g7k/LvkU91ZyMJ0wE4i1ld7t7YpIA47IQq0vnXi0f84KtT2SGRDe3xhlhT2C3vmqCc8s
 z1Ic343EVQJei1dwh4GCYSc6I+UvWTrjng+vkz9TfD9etXqMj8X8D6mj0LO1p7BrRdwL
 MzuQMqUrPWmPuU75Txx5FkI9+D0TsO+/0V+fp7eB6JJB+gNbo7lNuCAKD8pnT5skEXBH
 T9MmZUD9om8+2ih5xS4KpT6pn9j9FCqDM8H2JghygMGir1XmIr4cgjSStb7GlXZIIN22 pA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tu67jrnn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 18:49:19 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39JInI61004022
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 18:49:18 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 11:49:16 -0700
From:   Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <kernel@quicinc.com>,
        Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [RFC PATCH 1/3] of: reserved_mem: Change the order that reserved_mem regions are stored
Date:   Thu, 19 Oct 2023 11:48:23 -0700
Message-ID: <20231019184825.9712-2-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: nAx3qDmCD_nL9cB6XIRMWvLJ2WWl2Oqs
X-Proofpoint-ORIG-GUID: nAx3qDmCD_nL9cB6XIRMWvLJ2WWl2Oqs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_17,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190160
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dynamic allocation of the reserved_mem array needs to be done after
paging_init() is called because memory allocated using memblock_alloc()
is not writeable before that.

Nodes that already have their starting address specified in the DT
(i.e. nodes that are defined using the "reg" property) can wait until
after paging_init() to be stored in the array.
But nodes that are dynamically placed need to be reserved and saved in
the array before paging_init() so that page table entries are not
created for these regions.

Hence, change the code to:
1. Before paging_init(), allocate and store information for the
   dynamically placed reserved memory regions.
2. After paging_init(), store the rest of the reserved memory regions
   which are defined with the "reg" property.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/arm64/kernel/setup.c       |  4 +++
 drivers/of/fdt.c                | 56 ++++++++++++++++++++++++++-------
 drivers/of/of_private.h         |  1 -
 drivers/of/of_reserved_mem.c    | 54 ++++++++++++++-----------------
 include/linux/of_fdt.h          |  1 +
 include/linux/of_reserved_mem.h |  9 ++++++
 6 files changed, 83 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 417a8a86b2db..6002d3ad0b19 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -27,6 +27,8 @@
 #include <linux/proc_fs.h>
 #include <linux/memblock.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
+
 #include <linux/efi.h>
 #include <linux/psci.h>
 #include <linux/sched/task.h>
@@ -346,6 +348,8 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 
 	paging_init();
 
+	fdt_init_reserved_mem();
+
 	acpi_table_upgrade();
 
 	/* Parse the ACPI tables for possible boot-time configuration */
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..d51a1176a7b9 100644
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
@@ -564,9 +559,44 @@ static int __init __reserved_mem_check_root(unsigned long node)
 }
 
 /*
- * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
+ * Save the reserved_mem reg nodes in the reserved_mem array
  */
-static int __init fdt_scan_reserved_mem(void)
+static void save_reserved_mem_reg_nodes(unsigned long node, const char *uname)
+
+{
+	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
+	phys_addr_t base, size;
+	int len;
+	const __be32 *prop;
+
+	prop = of_get_flat_dt_prop(node, "reg", &len);
+	if (!prop)
+		return;
+
+	if (len && len % t_len != 0) {
+		pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
+		       uname);
+		return;
+	}
+	base = dt_mem_next_cell(dt_root_addr_cells, &prop);
+	size = dt_mem_next_cell(dt_root_size_cells, &prop);
+
+	if (size)
+		fdt_reserved_mem_save_node(node, uname, base, size);
+}
+
+/*
+ * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory.
+ * @save_only: Option to determine what kind of fdt scan the caller is
+ * requesting.
+ *
+ * The fdt is scanned twice here during device bootup. The first scan
+ * is used to save the dynamically allocated reserved memory regions to
+ * the reserved_mem array. The second scan is used to save the 'reg'
+ * defined regions to the array. @save_only indicates which of the scans
+ * the caller is requesting.
+ */
+int __init fdt_scan_reserved_mem(bool save_only)
 {
 	int node, child;
 	const void *fdt = initial_boot_params;
@@ -589,9 +619,14 @@ static int __init fdt_scan_reserved_mem(void)
 
 		uname = fdt_get_name(fdt, child, NULL);
 
+		if (save_only) {
+			save_reserved_mem_reg_nodes(child, uname);
+			continue;
+		}
+
 		err = __reserved_mem_reserve_reg(child, uname);
 		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			fdt_reserved_mem_save_node(child, uname, 0, 0);
+			__reserved_mem_alloc_size(child, uname);
 	}
 	return 0;
 }
@@ -631,11 +666,12 @@ void __init early_init_fdt_scan_reserved_mem(void)
 {
 	int n;
 	u64 base, size;
+	bool save_only = false;
 
 	if (!initial_boot_params)
 		return;
 
-	fdt_scan_reserved_mem();
+	fdt_scan_reserved_mem(save_only);
 	fdt_reserve_elfcorehdr();
 
 	/* Process header /memreserve/ fields */
@@ -645,8 +681,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 			break;
 		memblock_reserve(base, size);
 	}
-
-	fdt_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index f38397c7b582..e52b27b8392d 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -175,7 +175,6 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 }
 #endif
 
-void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcbddb..13e694f5e316 100644
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
 
@@ -309,6 +305,9 @@ static void __init __rmem_check_for_overlap(void)
 void __init fdt_init_reserved_mem(void)
 {
 	int i;
+	bool save_only = true;
+
+	fdt_scan_reserved_mem(save_only);
 
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
@@ -328,30 +327,25 @@ void __init fdt_init_reserved_mem(void)
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
index d69ad5bb1eb1..a9a9f70dabea 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -77,6 +77,7 @@ extern void early_init_dt_scan_nodes(void);
 extern const char *of_flat_dt_get_machine_name(void);
 extern const void *of_flat_dt_match_machine(const void *default_match,
 		const void * (*get_next_compat)(const char * const**));
+extern int fdt_scan_reserved_mem(bool save_only);
 
 /* Other Prototypes */
 extern void unflatten_device_tree(void);
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 4de2a24cadc9..e310336cef37 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -38,6 +38,8 @@ int of_reserved_mem_device_init_by_name(struct device *dev,
 					struct device_node *np,
 					const char *name);
 void of_reserved_mem_device_release(struct device *dev);
+void fdt_init_reserved_mem(void);
+int __reserved_mem_alloc_size(unsigned long node, const char *uname);
 
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #else
@@ -60,6 +62,13 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 
 static inline void of_reserved_mem_device_release(struct device *pdev) { }
 
+static inline int __reserved_mem_alloc_size(unsigned long node, const char *uname)
+{
+	return -ENOSYS;
+}
+
+static inline void fdt_init_reserved_mem(void) { }
+
 static inline struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 {
 	return NULL;
-- 
2.17.1

