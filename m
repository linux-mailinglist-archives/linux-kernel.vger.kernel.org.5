Return-Path: <linux-kernel+bounces-97501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4166876B1B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6E0C1C21031
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476F5D486;
	Fri,  8 Mar 2024 19:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e+FwMCxm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7B759140;
	Fri,  8 Mar 2024 19:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709925221; cv=none; b=qh0xSysOWf9ore22zd6qNM4hzeBJQ7RKSd3IooW15JgPg0PM2DzyhM6wb5VIAN1RZbLiP+OCZf8V/zlYhLA7yAlop6AokvCuXmlTosKMSQmVS/p7OsG4GOZ0Nn4vwZSLcvVVHeZhoykMuzsWTWuXzMfmVLJzWyv7XW5X8mCdRdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709925221; c=relaxed/simple;
	bh=EEWRqnckj6L/MwLLcjtKQsKii3o90ApEFsvFnZCxLh4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSdvWuJhwvl+n6gKGQF1I5FMLwT4QMW5EKYgZ2txzVGogHIbGfgmGoyCmWBaQKY8qOYWzfVXelln0n0sGXr3sfLwcH9irFTRVhW2P0iwaBa7uD9Jx4NJbV9aMfgF+/KVVc1EybDirrKczDKPRsNYzX0N1L6eEEGfgZKqqe3QyzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e+FwMCxm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428G0cJK031810;
	Fri, 8 Mar 2024 19:12:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=xxJBg9yZECTNYiCyc4c5tPz6/u1+f7/IvjC9u9bNKLI=; b=e+
	FwMCxmcDWqqiUxkiSNfOCgp31nR4ELwLaxSumqx9aV3blMLzanBy6NiMz6gwjeQL
	161o19AyXzJfefCv0Ki829ZOWBEDypf/SHBb0c4R0oVjsfSQUXlfpVGRP6aIZSuc
	ytnIghztwXXbMWeJJwl7GG8nmR460ysppArTAyLkgzFmNIstNSr3jjMWEFfU3V6O
	3kkSugnH7SGEeRZiQXNPr+Gh6l3jzMKTKhTCDGwafiQKDxXDy583u6FIKmWzDuXV
	3hutvwG9kw8hMzAGSYKCxxCK8/PaI+RH1uAyV7pngRts6fU6FqeqCsTgDIiz00Lv
	BTW8aM+UTSHz8QrvCcbA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wr5trgdrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 19:12:30 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 428JCT1v005678
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Mar 2024 19:12:29 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 8 Mar 2024 11:12:25 -0800
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
Subject: [PATCH v4 2/4] of: reserved_mem: Add code to dynamically allocate reserved_mem array
Date: Fri, 8 Mar 2024 11:12:02 -0800
Message-ID: <20240308191204.819487-3-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240308191204.819487-1-quic_obabatun@quicinc.com>
References: <20240308191204.819487-1-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RKZxkti-v3qancOR96h9UC7zqzeuim-p
X-Proofpoint-ORIG-GUID: RKZxkti-v3qancOR96h9UC7zqzeuim-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403080152

The reserved_mem array is statically allocated with a size of
MAX_RESERVED_REGIONS(64). Therefore, if the number of reserved_mem
regions exceeds this size, there will not be enough space to store
all the data.

Hence, extend the use of the static array by introducing a
dynamically allocated array based on the number of reserved memory
regions specified in the DT.

On architectures such as arm64, memblock allocated memory is not
writable until after the page tables have been setup. Hence, the
dynamic allocation of the reserved_mem array will need to be done only
after the page tables have been setup.

As a result, a temporary static array is still needed in the initial
stages to store the information of the dynamically-placed reserved memory
regions because the start address is selected only at run-time and is not
stored anywhere else.
It is not possible to wait until the reserved_mem array is allocated
because this is done after the page tables are setup and the reserved
memory regions need to be initialized before then.

After the reserved_mem array is allocated, all entries from the static
array is copied over to the new array, and the rest of the information
for the statically-placed reserved memory regions are read in from the
DT and stored in the new array as well.

Once the init process is completed, the temporary static array is
released back to the system because it is no longer needed. This is
achieved by marking it as __initdata.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             | 15 +++++++---
 drivers/of/of_private.h      |  1 +
 drivers/of/of_reserved_mem.c | 53 ++++++++++++++++++++++++++++++++++--
 3 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index fe6c75c5a8c0..2468360d6053 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -614,13 +614,15 @@ void __init fdt_scan_reserved_mem_reg_nodes(void)
 	}
 }
 
+int total_reserved_mem_cnt = MAX_RESERVED_REGIONS;
+
 /*
  * fdt_scan_reserved_mem() - scan a single FDT node for reserved memory
  */
 static int __init fdt_scan_reserved_mem(void)
 {
 	int node, child;
-	int dynamic_nodes_cnt = 0;
+	int dynamic_nodes_cnt = 0, count = 0;
 	int dynamic_nodes[MAX_RESERVED_REGIONS];
 	const void *fdt = initial_boot_params;
 
@@ -643,6 +645,8 @@ static int __init fdt_scan_reserved_mem(void)
 		uname = fdt_get_name(fdt, child, NULL);
 
 		err = __reserved_mem_reserve_reg(child, uname);
+		if (!err)
+			count++;
 
 		/*
 		 * Delay allocation of the dynamically-placed regions
@@ -657,12 +661,16 @@ static int __init fdt_scan_reserved_mem(void)
 
 	for (int i = 0; i < dynamic_nodes_cnt; i++) {
 		const char *uname;
+		int err;
 
 		child = dynamic_nodes[i];
 		uname = fdt_get_name(fdt, child, NULL);
 
-		__reserved_mem_alloc_size(child, uname);
+		err = __reserved_mem_alloc_size(child, uname);
+		if (!err)
+			count++;
 	}
+	total_reserved_mem_cnt = count;
 	return 0;
 }
 
@@ -715,8 +723,6 @@ void __init early_init_fdt_scan_reserved_mem(void)
 			break;
 		memblock_reserve(base, size);
 	}
-
-	fdt_init_reserved_mem();
 }
 
 /**
@@ -1405,6 +1411,7 @@ void __init unflatten_device_tree(void)
 	of_alias_scan(early_init_dt_alloc_memory_arch);
 
 	unittest_unflatten_overlay_base();
+	fdt_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 542e37a37a24..447b63413b39 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -42,6 +42,7 @@ extern struct mutex of_mutex;
 extern raw_spinlock_t devtree_lock;
 extern struct list_head aliases_lookup;
 extern struct kset *of_kset;
+extern int total_reserved_mem_cnt;
 
 #if defined(CONFIG_OF_DYNAMIC)
 extern int of_property_notify(int action, struct device_node *np,
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index d62f1956024c..3c4373b021be 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -26,7 +26,8 @@
 
 #include "of_private.h"
 
-static struct reserved_mem reserved_mem[MAX_RESERVED_REGIONS];
+static struct reserved_mem reserved_mem_array[MAX_RESERVED_REGIONS] __initdata;
+static struct reserved_mem *reserved_mem __refdata = reserved_mem_array;
 static int reserved_mem_count;
 
 static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
@@ -54,6 +55,48 @@ static int __init early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	return err;
 }
 
+/**
+ * alloc_reserved_mem_array() - allocate memory for the reserved_mem
+ * array using memblock
+ *
+ * This function is used to allocate memory for the reserved_mem array
+ * according to the total number of reserved memory regions defined in
+ * the DT.
+ * After the new array is allocated, the information stored in the
+ * initial static array is copied over to this new array and the
+ * new array is used from this point on.
+ */
+static int __init alloc_reserved_mem_array(void)
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
  * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
  */
@@ -62,7 +105,7 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
-	if (reserved_mem_count == ARRAY_SIZE(reserved_mem)) {
+	if (reserved_mem_count == total_reserved_mem_cnt) {
 		pr_err("not enough space for all defined regions.\n");
 		return;
 	}
@@ -303,7 +346,11 @@ static void __init __rmem_check_for_overlap(void)
  */
 void __init fdt_init_reserved_mem(void)
 {
-	int i;
+	int i, ret;
+
+	ret = alloc_reserved_mem_array();
+	if (ret)
+		pr_err("Failed to allocate memory for reserved_mem array with err: %d", ret);
 
 	fdt_scan_reserved_mem_reg_nodes();
 
-- 
2.34.1


