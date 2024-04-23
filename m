Return-Path: <linux-kernel+bounces-156012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156068AFC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B57028492C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209233E479;
	Tue, 23 Apr 2024 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ags+LoJm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066A44C86;
	Tue, 23 Apr 2024 23:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713915164; cv=none; b=p3YAPr9+mMgPGB8+7OC+TH4Hjz5aId9qzMJspdAo8Ht9XpA3dEGw73ndw7I4Gwo7M1DFnOA2mu5cjXzXxyifUig1y5zbqUSIUCtiKStK9s7ZhBi2bAzsHlHEDOQcg74Wskmrjg6QjQRWlstXjmDe6AZvWIHEh9nMI0nylAFfItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713915164; c=relaxed/simple;
	bh=PtODIwdNe+bcAg/fpYn1U2uSPxKWfe4QrTVb1dGFzYM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I24yKOQk3ivSNPvzZB+8AdGA2srBIw0HfyIfnbMCV1pV7Cqodo60N2T+yqf6bnatY/a+3zGQdvfQFxX652f12ivHyfu6IhN8yhqymmQj3lA9i/Zjpg3zMK7b6RR/JzWZLf66eOiqAnYKEw7jdeJRB2SfasOLs3OGI5Q2WYKGC3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ags+LoJm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NNRsZa023272;
	Tue, 23 Apr 2024 23:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=LJ1D41v
	sL9OuSiqmo9PlB5k3GVvlK5C768SPmzKMyzA=; b=Ags+LoJm6QAa4ItyxcMGkb4
	abFXFphIk16p7OTsrhdCdnCgeZW/kW83tOfMY2iLTZfvQY0Bp4/YPJgzrr6lHNgh
	951YVH4YyHjsxHXZn3Ixq4TArF4aDgJb0zdHG/ehihPz0X2j/Q3Dh+9LKocyg1GW
	VSfhuQM5gquiHcDbResn0zHkM5Fj3hJY3nj+7jG2qPZhL7bVuavzGyG0iMgEM8ge
	7WFMWZcFAAzxdL4Rrb9lbjPZs7rk10UWSYqKzSp8ZtMdSjR7v9qaHoSlV/A8x3jw
	RvyufP3N/xGBtWJfrCKL0FXWixXXDfhqaxgXIjuePZ7p7cqU5d72+6tREHIfHNQ=
	=
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp9aa2ptc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 23:32:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43NNWLcS032294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 23:32:21 GMT
Received: from hu-obabatun-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 16:32:18 -0700
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
To: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
        <glaubitz@physik.fu-berlin.de>
CC: <akpm@linux-foundation.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <kernel@quicinc.com>, Oreoluwa Babatunde <quic_obabatun@quicinc.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2] sh: Call paging_init() earlier in the init sequence
Date: Tue, 23 Apr 2024 16:31:50 -0700
Message-ID: <20240423233150.74302-1-quic_obabatun@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jsnF7tXTfziMa_uh5TBx30HVCn70jfiM
X-Proofpoint-ORIG-GUID: jsnF7tXTfziMa_uh5TBx30HVCn70jfiM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_18,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 bulkscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230065

The unflatten_device_tree() function contains a call to
memblock_alloc(). This is a problem because this allocation is done
before any of the reserved memory is set aside in paging_init().
This means that there is a possibility for memblock to allocate from
any of the memory regions that are supposed to be set aside as reserved.

Hence, move the call to paging_init() to be earlier in the init
sequence so that the reserved memory regions are set aside before any
allocations are done using memblock.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
---
v2:
- Added Rob Herrings Reviewed-by.
- cc Andrew Morton to assist with merging this for sh architecture.
  Similar change made for loongarch and openrisc in v1 have already
  been merged.

v1:
https://lore.kernel.org/all/1707524971-146908-4-git-send-email-quic_obabatun@quicinc.com/

 arch/sh/kernel/setup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 620e5cf8ae1e..98c8473e130d 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -322,6 +322,8 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
+	paging_init();
+
 #ifdef CONFIG_OF_EARLY_FLATTREE
 #ifdef CONFIG_USE_BUILTIN_DTB
 	unflatten_and_copy_device_tree();
@@ -330,8 +332,6 @@ void __init setup_arch(char **cmdline_p)
 #endif
 #endif
 
-	paging_init();
-
 	/* Perform the machine specific initialisation */
 	if (likely(sh_mv.mv_setup))
 		sh_mv.mv_setup(cmdline_p);
-- 
2.34.1


