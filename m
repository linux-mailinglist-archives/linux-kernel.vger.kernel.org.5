Return-Path: <linux-kernel+bounces-40873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 465CD83E75F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9267B276AF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA45BAF0;
	Fri, 26 Jan 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nN6cuJjH"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618AE2557A;
	Fri, 26 Jan 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313358; cv=none; b=QpkCwqmzS+zUdoJ1BjtUqifYQO+9wdIIT+CZcFb8NMXBhE2OldZ8+0kd202/GOeKsKGr4a/bmrcBaV/trSV7K4B4LcH9ubNY/oOqR5J5bxRebA+ULG/QXjVKl3v9296YWJP4sg7joRAs326ll6QwS2o2Oi9+/ij4iMAzuUENsMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313358; c=relaxed/simple;
	bh=JdoaIgHtzRRSJ9Y6M9IcdrolW5MG1cM6H487IZFDdMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CbVxq4RNmf6Jjer++IzlY/CEykM/o93RaLrwrf+mOaQBOKTE/jD+Ng2G2FocplixWmU4UIYuASPGEgmFz7x4DzjWw2USVUEleNOM/PDuso3BfuMFLp5o6Q9kiu2KcAXEQRMi/ljNZIHszBhLK1xNo9DJeaEwA5U0VmKycan5AUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nN6cuJjH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNnZbP027998;
	Fri, 26 Jan 2024 23:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=GQs+FJwVsA823rjqyLGR
	cinzYCeaIEqNRS4nUJ1K5mQ=; b=nN6cuJjHUxjIrloQjVh7Ipm2VfLMXv/5My1J
	c91boeGeg0PNzzRCsPkVv1MnZ4FFj4vR5E5Ef3rbtP0FI3TzNMMPcT+hfWu5X36m
	26SuSVtUvm/2V/CxrzYEoi4XsapDpE/6k4N/AyChzgdwNo8vVPZMgrYkFwrhfPuf
	YYeL4wNfOLuj8RTA9sHyqM2bYsCw4vlve7EQtaWdOtbizbQ4/kI6JXk2LoVJURgD
	Vl7O86gffKATpclkhJSy+8LcsWBSFpQnvnBBsBgp0Zwk0yC5dilfZTBv19Cgl0EE
	7XIlEHbVIRFUk0Asvf/el2OzuCQupu6Xc0sEBLG4Lmx6CxYzMA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvhxyrhya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtPhh009489
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:25 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:09 -0800
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
Subject: [PATCH 26/46] powerpc: resrved_mem: Move fdt_init_reserved_mem() below unflatten_device_tree()
Date: Fri, 26 Jan 2024 15:54:05 -0800
Message-ID: <20240126235425.12233-27-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: NllxamRcH2qFCdcEEfsv55660cYbKRqO
X-Proofpoint-ORIG-GUID: NllxamRcH2qFCdcEEfsv55660cYbKRqO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=769 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401260176

The unflattened devicetree structure is available to be used not long
after the page tables have been set up on most architectures, and is
available even before that on other architectures.

Hence, move the call to fdt_init_reserved_mem() to after
unflatten_device_tree() is called so that the reserved memory nodes can
be accessed using the unflattened device tree APIs.

Using the unflattened devicetree APIs is more efficient than using the
flattened devicetree APIs.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/powerpc/kernel/prom.c         | 2 --
 arch/powerpc/kernel/setup-common.c | 3 +++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 5f6307ea3069..3cf8213b114c 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -27,7 +27,6 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
-#include <linux/of_reserved_mem.h>
 #include <linux/libfdt.h>
 #include <linux/cpu.h>
 #include <linux/pgtable.h>
@@ -621,7 +620,6 @@ static void __init early_reserve_mem_dt(void)
 
 	early_init_fdt_reserve_self();
 	early_fdt_scan_reserved_mem();
-	fdt_init_reserved_mem();
 
 	dt_root = of_get_flat_dt_root();
 
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 9b142b9d5187..96bd4c964943 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -32,6 +32,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/of_irq.h>
 #include <linux/hugetlb.h>
 #include <linux/pgtable.h>
@@ -890,6 +891,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Unflatten the device-tree passed by prom_init or kexec */
 	unflatten_device_tree();
 
+	fdt_init_reserved_mem();
+
 	/*
 	 * Initialize cache line/block info from device-tree (on ppc64) or
 	 * just cputable (on ppc32).
-- 
2.17.1


