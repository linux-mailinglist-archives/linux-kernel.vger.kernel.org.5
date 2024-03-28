Return-Path: <linux-kernel+bounces-123665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E4890C60
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B14FC1C2901D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB4513AD2D;
	Thu, 28 Mar 2024 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pVGmHZDG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E2141A80;
	Thu, 28 Mar 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660666; cv=none; b=iEARIy2Tsi8+DNRXThmcTB3FxpChlgasSJfay4aTcYrXmm0g6XZ/SbluouhooPTvFWqNcEocDSEJ6ZL8VS5IwZqzoO7EoRRSDwxFMYEm8dtrcEBNIx0WR353IJeSGeTN9ONarXZrHxgDKagJRQUz6flNAWsRos6J+/qEulNUeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660666; c=relaxed/simple;
	bh=7Tk4v9rU4cp8O26lvJbATJhcSQxE9d5DNyvx1SOGOLE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HXosH1JjSZ9/Re6MFu6aHGAVORKiZRNVMA8A7iWNARWWfsXxRaZK4tedGYSAA0+8+Hnz6cu25l5iAwlolNMTmNzv3sLw2NvV0jJXk2hsc2U9x4HmECo/uv8s5fK3Anj5LE7GrvR+O852RKTQvtCdJZrbMdjQop7lqOSTb2qgd3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pVGmHZDG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SIJ2KR003277;
	Thu, 28 Mar 2024 21:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=zvJ0vhX7wfZ6zdugc4E4PLPb1HUs3ONWnc6z4J9p1ZY=; b=pV
	GmHZDG1mADpzP6mjW9TW14aC2Ikm38r0SAtkaiCiGc9aSkjLonitPlQOoWA5yxBL
	I2gFEH3qZwrLnthVKH5XFNonlEAID01uX4HL2six6Q6a/+B2GyAJjZ07Zf0Z7EdY
	BOGY6D/k+Ds2fEIEebL6B6t7o9vu4m4o65Zv2JKEPlHOjCPqyY59sH4w+LIV8hxo
	/khQvkD+1V2bCu3XwXRQ9/0gF3Jtx+p9dIRgqUxiihEEt0qTWU35PvlGTxzOsyci
	WK2wGPO6cpbxnA9OOLAQTgHWtMfKsR7rLGJ9SJwDG78moMh6xqV34GpXDZ3Umk7I
	Nh3WH3r8DUmZtM4NRoGw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x53nxjg6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SLGZO4012363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 21:16:36 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 28 Mar 2024 14:16:32 -0700
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
Subject: [PATCH v5 4/4] of: reserved_mem: Rename fdt_* functions to refelct use of unflatten_devicetree APIs
Date: Thu, 28 Mar 2024 14:15:43 -0700
Message-ID: <20240328211543.191876-5-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328211543.191876-1-quic_obabatun@quicinc.com>
References: <20240328211543.191876-1-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: EoxbyCpQiIhXCrV0MxNXBG7mGSeJY2OE
X-Proofpoint-ORIG-GUID: EoxbyCpQiIhXCrV0MxNXBG7mGSeJY2OE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280152

Rename the relevant fdt_* functions to a new naming scheme, dt_*, to
reflect the use of the unflatten_devicetree APIs to scan through the
reserved memory regions defined in the DT.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c             |  2 +-
 drivers/of/of_private.h      |  2 +-
 drivers/of/of_reserved_mem.c | 22 +++++++++++-----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 527e6bc1c096..7e1baf443286 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -1259,7 +1259,7 @@ void __init unflatten_device_tree(void)
 	unittest_unflatten_overlay_base();
 
 	/* initialize the reserved memory regions */
-	fdt_init_reserved_mem();
+	dt_init_reserved_mem();
 }
 
 /**
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index 9ea250b80657..75726feac881 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -177,7 +177,7 @@ static inline struct device_node *__of_get_dma_parent(const struct device_node *
 #endif
 
 int fdt_scan_reserved_mem(void);
-void fdt_init_reserved_mem(void);
+void dt_init_reserved_mem(void);
 
 bool of_fdt_device_is_available(const void *blob, unsigned long node);
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 68d1f4cca4bb..3ae5918a0024 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -97,10 +97,10 @@ static void __init alloc_reserved_mem_array(void)
 }
 
 /*
- * fdt_reserved_mem_save_node() - save fdt node for second pass initialization
+ * dt_reserved_mem_save_node() - save the device_node for second pass initialization
  */
-static void __init fdt_reserved_mem_save_node(struct device_node *node, const char *uname,
-					      phys_addr_t base, phys_addr_t size)
+static void __init dt_reserved_mem_save_node(struct device_node *node, const char *uname,
+					     phys_addr_t base, phys_addr_t size)
 {
 	struct reserved_mem *rmem = &reserved_mem[reserved_mem_count];
 
@@ -224,16 +224,16 @@ static int __init __dt_reserved_mem_check_root(struct device_node *node)
 }
 
 /**
- * fdt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
+ * dt_scan_reserved_mem_reg_nodes() - Store info for the "reg" defined
  * reserved memory regions.
  *
  * This function is used to scan through the DT and store the
  * information for the reserved memory regions that are defined using
  * the "reg" property. The region node number, name, base address, and
  * size are all stored in the reserved_mem array by calling the
- * fdt_reserved_mem_save_node() function.
+ * dt_reserved_mem_save_node() function.
  */
-static void __init fdt_scan_reserved_mem_reg_nodes(void)
+static void __init dt_scan_reserved_mem_reg_nodes(void)
 {
 	int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
 	struct device_node *node, *child;
@@ -277,7 +277,7 @@ static void __init fdt_scan_reserved_mem_reg_nodes(void)
 		size = dt_mem_next_cell(dt_root_size_cells, &prop);
 
 		if (size)
-			fdt_reserved_mem_save_node(child, uname, base, size);
+			dt_reserved_mem_save_node(child, uname, base, size);
 	}
 }
 
@@ -475,7 +475,7 @@ static int __init __reserved_mem_alloc_size(unsigned long node, const char *unam
 		       uname, (unsigned long)(size / SZ_1M));
 		return -ENOMEM;
 	}
-	fdt_reserved_mem_save_node(NULL, uname, base, size);
+	dt_reserved_mem_save_node(NULL, uname, base, size);
 	return 0;
 }
 
@@ -559,15 +559,15 @@ static void __init __rmem_check_for_overlap(void)
 }
 
 /**
- * fdt_init_reserved_mem() - allocate and init all saved reserved memory regions
+ * dt_init_reserved_mem() - allocate and init all saved reserved memory regions
  */
-void __init fdt_init_reserved_mem(void)
+void __init dt_init_reserved_mem(void)
 {
 	int i;
 
 	alloc_reserved_mem_array();
 
-	fdt_scan_reserved_mem_reg_nodes();
+	dt_scan_reserved_mem_reg_nodes();
 
 	/* check for overlapping reserved regions */
 	__rmem_check_for_overlap();
-- 
2.34.1


