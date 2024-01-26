Return-Path: <linux-kernel+bounces-40891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D62F83E7A9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 01:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E851828D053
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1FB65BAD;
	Fri, 26 Jan 2024 23:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hZz07JCj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237460888;
	Fri, 26 Jan 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313366; cv=none; b=WKuGkmyY4T/qzbSsKnxzHM0ahesLzpy4TXFdUA2RjObuJwaJUDiMq84afiLLadhDrt04AK4y/MhfuvQlBQsyraTo2K8w+PLR8jEWI/S+98wt1+JcTPzk9MO94zylanKEoBTC2V51Nsj3J7ZKN0bsvboazvT3EnxYfj0Duyy7kpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313366; c=relaxed/simple;
	bh=IvXl42prVu4MmfDVrGBT0dLUIOOiJ7h1Q8FhLVi0uLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqygtL+AYKgP+bA03aEGBh3uzSwJD/XNX/sv1aK3EKswPJ3whPgDolH70Bb/AlsPO3546DP1T/L6S04BydBMbP8CMpY2EIOhn7f7Xfq6F4IOCOmWCtiDJGLf1XF+IcQfEp+Q06IDGJj8td4WXhW08KMUmmBk9fnIU0+JIdo5J+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hZz07JCj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QMNT1x023758;
	Fri, 26 Jan 2024 23:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=LZ6BeFYwTyGA42JiJKTJ
	7xVnip2wtZSVAMFXMR+jBT4=; b=hZz07JCj5MIpnp3+eIuQ0YROpZbT2jxEcDOv
	1b6EE+YmskBh0liJsumy4zR9E0XxgPGZyhaIW5BLNInGMV4MWMpzeDEkPI0VKVlm
	0RK/7WNYQsDRhb32yVW/0uCxxQlCR0bgSNRDsGDcfa9UDsUYM+L4FzwuoUEq0cqu
	2L+kvJBTgwAlZB2GeUzaMBvK7tk1EwPVENsDGSUfLocdOI1f5RpdVR/zQR2wOvTx
	V4GeZ9cuz7rChO1FLj0XvNpTQxcD/ei3SBcWh+pgG+L7/rAO7h8OHcdKrfAWkM9s
	4cnRfx3+BXyrDvokEjSCVwd2vV10cfI6bu4LSALFCeAYELQfgg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vvmmmg7wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:23 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtMRU009460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:23 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:08 -0800
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
Subject: [PATCH 24/46] mips: resrved_mem: Move fdt_init_reserved_mem() below unflatten_device_tree()
Date: Fri, 26 Jan 2024 15:54:03 -0800
Message-ID: <20240126235425.12233-25-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: b5dZeBXAhbIMB9BYSz51qaTKW95eS3J2
X-Proofpoint-ORIG-GUID: b5dZeBXAhbIMB9BYSz51qaTKW95eS3J2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=919
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 clxscore=1015
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
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 13e862151d5f..eeafc3abcb96 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -651,7 +651,6 @@ static void __init arch_mem_init(char **cmdline_p)
 
 	early_init_fdt_reserve_self();
 	early_fdt_scan_reserved_mem();
-	fdt_init_reserved_mem();
 
 #ifndef CONFIG_NUMA
 	memblock_set_node(0, PHYS_ADDR_MAX, &memblock.memory, 0);
@@ -672,6 +671,7 @@ static void __init arch_mem_init(char **cmdline_p)
 	mips_parse_crashkernel();
 	device_tree_init();
 
+	fdt_init_reserved_mem();
 	/*
 	 * In order to reduce the possibility of kernel panic when failed to
 	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
-- 
2.17.1


