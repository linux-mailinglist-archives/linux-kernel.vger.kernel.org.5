Return-Path: <linux-kernel+bounces-40882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E57E983E770
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58694B28084
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5214360B83;
	Fri, 26 Jan 2024 23:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SNyeXf6R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5105C8FD;
	Fri, 26 Jan 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313360; cv=none; b=q6yYY4PSdywBnl1/OUEg6DvJIRxNeQXQzqq+WRfX8lpIT+cUqccZCQDvLUEvhf3YiWs4C7ovsmRcPNb/ZnGgS7Hl/tE72HMKKk46FydBnYh50w7apMaQQFxbothXhR++IOCm0W88QB6pm8gbuehkER2bawVgCHpT0NwMPKpQZQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313360; c=relaxed/simple;
	bh=V6Jfwdz7cfuw8xz0rOiPIfZC0VoGr7aTRGVEnL4nr9g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yp1wC9tLsvh2Fm8X9lGpm4q5AIQHILUhB1SWKKvOI3M7SWnu0lgFAdpcnqCU8RxWuM8UlkUE4wF89RZMvbPppzxXFthcUFLYycCn/JBqRrVRYi2F/rcf+POw87rHOM6e/4gYcOmBbxHf82fIHh9IOXwla4yX8HrBnWMPN9WmE6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SNyeXf6R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QNofxh032435;
	Fri, 26 Jan 2024 23:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=RlnfElnCLOGgkR/BB4Cz
	dA5j3vD5FsmMJ5CohK/Sl8M=; b=SNyeXf6ROn3tbOZF0JFukSBRevxqeDuBXnja
	YmUdDf+jByNPIccaRTBYaHWOVWaawruRk0B1i7ZW6z4btrxO8KbQDJEAmM5jgfnl
	o6idmLlYNCjrJMWA2zx5a94bj3eVpUo2Az2e7nmh4MBGhPBagfqhuwwh4lL1x8do
	JkqYSb715JlWaKP2Va1T8QgwEhggUbVp5J0aVPjgzfX5pPshEf+i4w2n+spYvrZu
	3j0en8rkqJXzkJuu8aQ1T4c2lWgv4znM69plR5Swbys5sXau0HS8owwytpjahBbr
	xxnA21o7ChruKXWNjrz9ZvvEFyFZSXBnxW38npKKK69RLPa8uw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv1q5aq5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:13 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtCt8009378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:12 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:03 -0800
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
Subject: [PATCH 17/46] of: reserved_mem: Delete the early_init_fdt_scan_reserved_mem() function
Date: Fri, 26 Jan 2024 15:53:56 -0800
Message-ID: <20240126235425.12233-18-quic_obabatun@quicinc.com>
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
X-Proofpoint-ORIG-GUID: u75yF4T-XBMIScbnN8Ykb2WGNs7x1ki5
X-Proofpoint-GUID: u75yF4T-XBMIScbnN8Ykb2WGNs7x1ki5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=447 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401260175

Delete the early_init_fdt_scan_reserved_mem() function definition since
this function is no longer being used anywhere in the kernel.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 drivers/of/fdt.c       | 29 -----------------------------
 include/linux/of_fdt.h |  2 --
 2 files changed, 31 deletions(-)

diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 6bda033936af..c6e8560946f4 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -682,35 +682,6 @@ static void __init fdt_reserve_elfcorehdr(void)
 		elfcorehdr_size >> 10, elfcorehdr_addr);
 }
 
-/**
- * early_init_fdt_scan_reserved_mem() - create reserved memory regions
- *
- * This function grabs memory from early allocator for device exclusive use
- * defined in device tree structures. It should be called by arch specific code
- * once the early allocator (i.e. memblock) has been fully activated.
- */
-void __init early_init_fdt_scan_reserved_mem(void)
-{
-	int n;
-	u64 base, size;
-
-	if (!initial_boot_params)
-		return;
-
-	fdt_scan_reserved_mem();
-	fdt_reserve_elfcorehdr();
-
-	/* Process header /memreserve/ fields */
-	for (n = 0; ; n++) {
-		fdt_get_mem_rsv(initial_boot_params, n, &base, &size);
-		if (!size)
-			break;
-		memblock_reserve(base, size);
-	}
-
-	fdt_init_reserved_mem();
-}
-
 /**
  * early_fdt_scan_reserved_mem() - create reserved memory regions
  *
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 9b849c5c3917..9b85bbc5d9f5 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -62,7 +62,6 @@ extern int early_init_dt_scan_chosen(char *cmdline);
 extern int early_init_dt_scan_memory(void);
 extern void early_init_dt_check_for_usable_mem_range(void);
 extern int early_init_dt_scan_chosen_stdout(void);
-extern void early_init_fdt_scan_reserved_mem(void);
 extern void early_fdt_scan_reserved_mem(void);
 extern void early_init_fdt_reserve_self(void);
 extern void early_init_dt_add_memory_arch(u64 base, u64 size);
@@ -88,7 +87,6 @@ extern void early_get_first_memblock_info(void *, phys_addr_t *);
 #else /* CONFIG_OF_EARLY_FLATTREE */
 static inline void early_init_dt_check_for_usable_mem_range(void) {}
 static inline int early_init_dt_scan_chosen_stdout(void) { return -ENODEV; }
-static inline void early_init_fdt_scan_reserved_mem(void) {}
 static inline void early_fdt_scan_reserved_mem(void) {}
 static inline void early_init_fdt_reserve_self(void) {}
 static inline const char *of_flat_dt_get_machine_name(void) { return NULL; }
-- 
2.17.1


