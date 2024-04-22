Return-Path: <linux-kernel+bounces-154217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1FB8AD965
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96DA21C212AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36294779D;
	Mon, 22 Apr 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HRhCKKII"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870746436;
	Mon, 22 Apr 2024 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829988; cv=none; b=PGz2+sWWSnUpp/n0AyVbkBwHW3C87ERsKByodygroCWVE+gNVf4QFM2nZ51wW+0eouMB0RzGxcNnGJllUghx99uAyqDZ2LdVbFObmorwgHp6sGCeMW3TrGSOB8ipGFtlDhwFYTjJRtYnBMfAdPzaLjg7WwZ1osdxHiqLZz1W8O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829988; c=relaxed/simple;
	bh=ReEUZRtSW1NtsWR44K1jxu43AC533vf5fFJ2VNxO5Ok=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AVvP6pbia3G9y+Cdz8LGDFSge/pj3XzgK420pT/aGQbnLdMoBpZRXo7tlPjWptdZhNKqvEJ1NKzDs/QO1Va5xKHn7tQwFauV0KZi8nQCsmZLNL9SQ2orK2YTq7KXgdi0dzY6y9/o2RH01IOzdqWwBl3KHhnkqK/oqEAtkqJVm90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HRhCKKII; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MLifbB016015;
	Mon, 22 Apr 2024 23:53:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=FOagD4X
	Nh0Xd0MMBJ0QnANM1e5Nwfj50Z0Ad7260JkQ=; b=HRhCKKIIHjxKdLcxn6i+lD5
	Sa28qbPtpxRY4XJedAm2aiKBY517ktm3Ap49JZtQoQeKTzUxJgwYg6YFJ34GlD5s
	Ui8xvQd4p9Qj7B3KfKB1t0BygVE/5zWSbEzbLLhksc2rjM2ab2dXKFe0Zna9fIRZ
	wAZ5ZSKNICTDa3IdciogVByLK9ONb9rFOH3pl499L+mifK1ZHociMR7GLiua8mlq
	AGwktpT7PKT5CgHfZE9R5VGi+PrAAzH0VrL56QqKUIWUXhpkXLjSnfrFn3/6o/N4
	lsR2eOFOt44G0ifgu6anKcaTdKpKTdFYuo28HwBIVf6sRdUn9szaLQkxhpE06ag=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82sw2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 23:53:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MNr2hB004483
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 23:53:02 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 16:52:58 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <robh@kernel.org>, <saravanak@google.com>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>
Subject: [PATCH] of: reserved_mem: Remove the use of phandle from the reserved_mem APIs
Date: Mon, 22 Apr 2024 16:52:43 -0700
Message-ID: <20240422235243.2878536-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
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
X-Proofpoint-GUID: A_IOoqzBMNY9_vF4UKugrP7LNjpPArZa
X-Proofpoint-ORIG-GUID: A_IOoqzBMNY9_vF4UKugrP7LNjpPArZa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=823
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220100

The __find_rmem() function is the only place that references the phandle
field of the reserved_mem struct. __find_rmem() is used to match a
device_node object to its corresponding entry in the reserved_mem array
using its phandle value. But, there is already a function called
of_reserved_mem_lookup() which carries out the same action using the
name of the node.

Using the of_reserved_mem_lookup() function is more reliable because
every node is gauranteed to have a name, but not all nodes will have a
phandle.

Nodes are only assigned a phandle if they are explicitly defined in the
DT using "phandle = <phandle_number>", or if they are referenced by
another node in the DT. Hence, If the phandle field is empty, then
__find_rmem() will return a false negative.

Hence, delete the __find_rmem() function and switch to using the
of_reserved_mem_lookup() function to find the corresponding entry of a
device_node in the reserved_mem array. Since the phandle field of the
reserved_mem struct is now unused, delete that as well.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/of_reserved_mem.c    | 26 +++-----------------------
 include/linux/of_reserved_mem.h |  1 -
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 8236ecae2953..bdf41b5b1ae5 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -437,18 +437,9 @@ void __init fdt_init_reserved_mem(void)
 	for (i = 0; i < reserved_mem_count; i++) {
 		struct reserved_mem *rmem = &reserved_mem[i];
 		unsigned long node = rmem->fdt_node;
-		int len;
-		const __be32 *prop;
 		int err = 0;
 		bool nomap;
 
-		nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
-		prop = of_get_flat_dt_prop(node, "phandle", &len);
-		if (!prop)
-			prop = of_get_flat_dt_prop(node, "linux,phandle", &len);
-		if (prop)
-			rmem->phandle = of_read_number(prop, len/4);
-
 		if (rmem->size == 0)
 			err = __reserved_mem_alloc_size(node, rmem->name,
 						 &rmem->base, &rmem->size);
@@ -457,6 +448,8 @@ void __init fdt_init_reserved_mem(void)
 			if (err != 0 && err != -ENOENT) {
 				pr_info("node %s compatible matching fail\n",
 					rmem->name);
+
+				nomap = of_get_flat_dt_prop(node, "no-map", NULL) != NULL;
 				if (nomap)
 					memblock_clear_nomap(rmem->base, rmem->size);
 				else
@@ -477,19 +470,6 @@ void __init fdt_init_reserved_mem(void)
 	}
 }
 
-static inline struct reserved_mem *__find_rmem(struct device_node *node)
-{
-	unsigned int i;
-
-	if (!node->phandle)
-		return NULL;
-
-	for (i = 0; i < reserved_mem_count; i++)
-		if (reserved_mem[i].phandle == node->phandle)
-			return &reserved_mem[i];
-	return NULL;
-}
-
 struct rmem_assigned_device {
 	struct device *dev;
 	struct reserved_mem *rmem;
@@ -534,7 +514,7 @@ int of_reserved_mem_device_init_by_idx(struct device *dev,
 		return 0;
 	}
 
-	rmem = __find_rmem(target);
+	rmem = of_reserved_mem_lookup(target);
 	of_node_put(target);
 
 	if (!rmem || !rmem->ops || !rmem->ops->device_init)
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 4de2a24cadc9..e338282da652 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -11,7 +11,6 @@ struct reserved_mem_ops;
 struct reserved_mem {
 	const char			*name;
 	unsigned long			fdt_node;
-	unsigned long			phandle;
 	const struct reserved_mem_ops	*ops;
 	phys_addr_t			base;
 	phys_addr_t			size;
-- 
2.34.1


