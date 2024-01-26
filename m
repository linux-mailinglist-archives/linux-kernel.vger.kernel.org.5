Return-Path: <linux-kernel+bounces-40878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1977B83E76A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 00:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9461C22FE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D222860885;
	Fri, 26 Jan 2024 23:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Bdf+Zr9t"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6197354FA7;
	Fri, 26 Jan 2024 23:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706313358; cv=none; b=WVxFCkmS9RQCeptPOgLyeVAuM9fXVklY4bqUEuDX5cRIpsgpfym1Yte0c6TdQgYLSbRb347FfHrfI3rSuEQzi+xaOKhHDP+pIsOnkVB3Adua6xwp7kYjyb+YBJ6r0us+U3kLeAmlfWyXOcz5idDBsGGQVzKAI8F9RS+DREFCq3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706313358; c=relaxed/simple;
	bh=Pr/2dw3NNQzn+eavSLaFBPYnK/RIlj3Um9xBPV5ZSzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojc1jSxMYGRbR/wDtDf40d4vnwA2eV8Blr9qnBqB4kGmMCwzY8T4blaNxJB1XLT+SQA3fxC3Tuq5O0UtspsKV3WrDnpUkaMMTKmx3ugl5NL4ooGsva4EBsVepDEuhM3Ubl+WaFzwpx80l5vtK2gAHiOtXQEE/j1MK2GvcJW3v/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Bdf+Zr9t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40QND1Cd010380;
	Fri, 26 Jan 2024 23:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=XHojE8I4UoGhN8L8CD1q
	TmSQB9PfOL1bfEmbuePPtGE=; b=Bdf+Zr9tzpVxmUZEDqkPk6BSSPwPO3B5PeIy
	Hyt/id2HAk9UH0n7kh81sFPkWXVuqWCIE02yMYHmDwp63diX4maAQDCS11I8ekMp
	DGQagjOHg5L47S5hyQPbZfSy7HK42QpH8FrhJ1QCeM/vKxSs6qZI2ldXt6Li7C5F
	yFmO7EwNcJmB/HunViV3oTW6gI24mgDl8PGR0WXh6cwNNAozs8OZ6OXxrIiA7eZx
	CZTarzkteJ6OT8N199g9L2vHzeFd9l2bScXGqRScadqXek/DDaRdp3JIU5EnpzhA
	nJ6dEAT+aJhRw3uQ0ApaSGtCI9MgCcaAdqTgnRELMGDcQwq7gQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vv6c8j5x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:11 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40QNtAhQ009370
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Jan 2024 23:55:10 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Jan 2024 15:55:02 -0800
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
Subject: [PATCH 15/46] um: reserved_mem: Implement the new processing order for reserved memory
Date: Fri, 26 Jan 2024 15:53:54 -0800
Message-ID: <20240126235425.12233-16-quic_obabatun@quicinc.com>
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
X-Proofpoint-GUID: uMbJo1Fa0UGEPMJzo1jpXqVqEdpyLG5I
X-Proofpoint-ORIG-GUID: uMbJo1Fa0UGEPMJzo1jpXqVqEdpyLG5I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_14,2024-01-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=501
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2401190000
 definitions=main-2401260176

Call early_fdt_scan_reserved_mem() in place of
early_init_fdt_scan_reserved_mem() to carry out the first stage of the
reserved memory processing only.

The early_fdt_scan_reserved_mem() function is used to scan through the
DT and mark all the reserved memory regions as reserved or nomap as
needed, as well as allocate the memory required by the
dynamically-placed
reserved memory regions.

The second stage of the reserved memory processing is done by
fdt_init_reserved_mem(). This function is used to store the information
of the statically-placed reserved memory nodes in the reserved_mem
array as well as call the region specific initialization function on all
the stored reserved memory regions.

The call to fdt_init_reserved_mem() is placed right after
early_fdt_scan_reserved_mem() because memblock allocated memory should
already be writable at this point.

Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
 arch/um/kernel/dtb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
index 484141b06938..3ecee151a083 100644
--- a/arch/um/kernel/dtb.c
+++ b/arch/um/kernel/dtb.c
@@ -2,6 +2,7 @@
 
 #include <linux/init.h>
 #include <linux/of_fdt.h>
+#include <linux/of_reserved_mem.h>
 #include <linux/printk.h>
 #include <linux/memblock.h>
 #include <init.h>
@@ -25,7 +26,8 @@ void uml_dtb_init(void)
 		return;
 	}
 
-	early_init_fdt_scan_reserved_mem();
+	early_fdt_scan_reserved_mem();
+	fdt_init_reserved_mem();
 	unflatten_device_tree();
 }
 
-- 
2.17.1


