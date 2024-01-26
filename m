Return-Path: <linux-kernel+bounces-40880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2FE83E775
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520AE1C21724
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E63860DCD;
	Fri, 26 Jan 2024 23:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y0JDkIMt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F255914E;
	Fri, 26 Jan 2024 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313359; cv=none; b=JFYqb7RLVK5Oi3ul6bxC9EhrNKLs1s87REgyWvweT2EE48w9FwLb6OMTZmz+eBsxp9es/S2HsMWz4gOULfFlhyn12YTaa0KyR6gvLBWvYTGLu6G/aOEXr4LTcOqMGw7IDB6+d/08kd8qyiRlym47Ar45jBxYkOEFhrQhR61yJhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313359; c=relaxed/simple;
	bh=+dLXzKA3GHsTNHgH7evQv80RkHciu+n+ZaSAz/AR0/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJQAvosZJ6IMTFHIvlBuuQPmLXDZOAphYrhQsj2Oe2+ldQtDkgIP9I1Iu4HNpr1vbh4d2oDaXQQ8huYXvCT0Ym1NEBv/GWYbepGTXLYUpC6Nqn51pfiYh7U5FEoEnrHrZA7Mn/doH9mLcnOIW8b9k2Zw9aFwtBgKIQ1s8iJLI2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y0JDkIMt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNf8t2022118;
	Fri, 26 Jan 2024 23:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=yHkSFlkLJD2JCjneLpD2
	tGeP0zrZRJG5TSxIZCtLSpU=; b=Y0JDkIMtaYC79/V7DC96ZtZEioCLG+Pt7de/
	JXSIEQHYMBBRwrL8DmsZZEIIi+6Rtwbl+fELpq5ZB+DAtfpJRvTCRdVp5X89UiSe
	KpCF6+0Efad0OXMdXtKuHwy2Zd1kZN29w/O1lEdAC4VtjMHX17UTedy48b7w/pac
	5EzAuF2Bi43P9lxLhbI4RH5R0F4gfr8LbV/YM54AoXuLWQZvjzWPMpr8G7rDiICm
	lYZGPcDJYPWar/PI/2owSJuQs4HHXEAbowfi69L4FnoIGBWO5pySeBFcRKkohQIB
	qtwRfjzSCTEELSvZ9iIX8adw5Os01Y06QF1XoQxVwN6PSdMAeg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv4nrad0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:02 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNt1JU009985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:01 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:54:57 -0800
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <robh+dt@kernel.org>,
        <frowand.list@gmail.com>, <vgupta@kernel.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <soc@kernel.org>, <guoren@kernel.org>,
        <monstr@monstr.eu>, <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <dinguyen@kernel.org>, <chenhuacai@kernel.org>,
        <tsbogend@alpha.franken.de>, <jonas@southpole.se>,
        <stefan.kristiansson@saunalahti.fi>, <shorne@gmail.com>,
        <mpe@ellerman.id.au>, <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
        <chris@zankel.net>, <jcmvbkbc@gmail.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH 01/46] of: reserved_mem: Change the order that reserved_mem regions are stored
Date: Fri, 26 Jan 2024 15:53:40 -0800
Message-ID: <20240126235425.12233-2-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240126235425.12233-1-quic_obabatun@quicinc.com>
References: <20240126235425.12233-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Dj5TYbGUioxz3V2ly4mHhjQfPVNWhSRr
X-Proofpoint-GUID: Dj5TYbGUioxz3V2ly4mHhjQfPVNWhSRr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

Some architectures such as arm64 require the page tables to be setup
before memblock allocated memory is writable.
Therefore, the dynamic allocation of the reserved_mem array will need to
be done after the page tables have been setup on these architectures. In
most cases this will be after paging_init().

Reserved memory regions can be divided into 2 groups.
i) Statically-placed reserved memory regions
i.e. regions defined in the DT using the @reg property.
ii) Dynamically-placed reserved memory regions.
i.e. regions specified in the DT using the @alloc_ranges
    and @size properties.

It is possible to call memblock_reserve() and memblock_mark_nomap() on
the statically-placed reserved memory regions and not need to save them
to the reserved_mem array until memory is allocated for it using
memblock, which will be after the page tables have been setup.
For the dynamically-placed reserved memory regions, it is not possible
to wait to store its information because the starting address is
allocated only at run time, and hence they need to be stored somewhere
after they are allocated.
Waiting until after the page tables have been setup to allocate memory
for the dynamically-placed regions is also not an option because the
allocations will come from memory that have already been added to the
page tables, which is not good for memory that is supposed to be
reserved and/or marked as nomap.

Therefore, the processing of the reserved memory regions is split up
into two stages, of which the first stage is carried out by
early_init_fdt_scan_reserved_mem() and the second is carried out by
fdt_init_reserved_mem().

The early_init_fdt_scan_reserved_mem(), which is called before the page
tables are setup is used to:
1. Call memblock_reserve() and memblock_mark_nomap() on all the
   statically-placed reserved memory regions as needed.
2. Allocate memory from memblock for the dynamically-placed reserved
   memory regions and store them in the static array for reserved_mem.
   memblock_reserve() and memblock_mark_nomap() are also called as
   needed on all the memory allocated for the dynamically-placed
   regions.

fdt_init_reserved_mem() is now used to carry out the following:
1. Add the information for the statically-placed reserved memory into
   reserved_mem array.
2. Run the region specific init functions for each of the reserve memory
   regions saved in the reserved_mem array.

Since fdt_init_reserved_mem() is called from within
early_init_fdt_scan_reserved_mem(), subsequent patches will make
changes to separate both functions and call fdt_init_reserved_mem()
after the page tables have been setup were needed.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c                | 78 +++++++++++++++++++++++++++++----
 drivers/of/of_private.h         |  2 +-
 drivers/of/of_reserved_mem.c    | 54 ++++++++++-------------
 include/linux/of_fdt.h          |  1 +
 include/linux/of_reserved_mem.h |  9 ++++
 5 files changed, 104 insertions(+), 40 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index bf502ba8da95..d02884ec0b6b 100644
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
@@ -564,11 +559,62 @@ static int __init __reserved_mem_check_root(unsigned long node)
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
 	int node, child;
+	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
 	node = fdt_path_offset(fdt, "/reserved-memory");
@@ -590,8 +636,24 @@ static int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
-		if (err == -ENOENT && of_get_flat_dt_prop(child, "size", NULL))
-			fdt_reserved_mem_save_node(child, uname, 0, 0);
+
+		/* Delay allocation of the dynamically-placed regions
+		 * until after all other statically-placed regions have
+		 * been reserved or marked as nomap
+		 */
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
index f38397c7b582..542e37a37a24 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -36,6 +36,7 @@ struct alias_prop {
 #endif
 
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
+#define MAX_RESERVED_REGIONS    64
 
 extern struct mutex of_mutex;
 extern raw_spinlock_t devtree_lock;
@@ -175,7 +176,6 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 }
 #endif
 
-void fdt_init_reserved_mem(void);
 void fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 			       phys_addr_t base, phys_addr_t size);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 7ec94cfcbddb..d62f1956024c 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,7 +26,6 @@
 
 #include "of_private.h"
 
-#define MAX_RESERVED_REGIONS	64
 static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
 static int reserved_mem_count;
 
@@ -132,8 +131,7 @@ static int __init __reserved_mem_alloc_in_range(phys_addr_t size,
  * __reserved_mem_alloc_size() - allocate reserved memory described by
  *	'size', 'alignment'  and 'alloc-ranges' properties.
  */
-static int __init __reserved_mem_alloc_size(unsigned long node,
-	const char *uname, phys_addr_t *res_base, phys_addr_t *res_size)
+int __init __reserved_mem_alloc_size(unsigned long node, const char *uname)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	phys_addr_t start = 0, end = 0;
@@ -212,10 +210,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node,
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
 
@@ -310,6 +305,8 @@ void __init fdt_init_reserved_mem(void)
 {
 	int i;
 
+	fdt_scan_reserved_mem_reg_nodes();
+
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
 
@@ -328,30 +325,25 @@ void __init fdt_init_reserved_mem(void)
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
index 4de2a24cadc9..2a3178920bae 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -32,12 +32,14 @@ typedef int (*reservedmem_of_init_fn)(struct reserved_mem *rmem);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
+void fdt_init_reserved_mem(void);
 int of_reserved_mem_device_init_by_idx(struct device *dev,
 				       struct device_node *np, int idx);
 int of_reserved_mem_device_init_by_name(struct device *dev,
 					struct device_node *np,
 					const char *name);
 void of_reserved_mem_device_release(struct device *dev);
+int __reserved_mem_alloc_size(unsigned long node, const char *uname);
 
 struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #else
@@ -45,6 +47,8 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np);
 #define RESERVEDMEM_OF_DECLARE(name, compat, init)			\
 	_OF_DECLARE_STUB(reservedmem, name, compat, init, reservedmem_of_init_fn)
 
+static inline void fdt_init_reserved_mem(void) { }
+
 static inline int of_reserved_mem_device_init_by_idx(struct device *dev,
 					struct device_node *np, int idx)
 {
@@ -60,6 +64,11 @@ static inline int of_reserved_mem_device_init_by_name(struct device *dev,
 
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


