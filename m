Return-Path: <linux-kernel+bounces-100492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E6987988B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F1C1C21388
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C327CF09;
	Tue, 12 Mar 2024 16:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Jy9B1xZK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75A7D082
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259698; cv=none; b=sY9KNb44tHx033bK+8WgIIG2IYCIZHYRQ9k8s91/hLiczHPpreUlCep3Z4DwU4FZNtKcKDSlH14DYyU+zNHOIDbxK6YZwgNGlzyNLwPzMdcMay3Kaccpcnb0/3uU62muOu8wqc+4Gaj2aJA67bzEn4O/XAF5UQFH43SllyPgnT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259698; c=relaxed/simple;
	bh=imxA4nPUfikFjsSKbUjFthkL/dgXzrsW+jBqIZgMcdQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pv75cg41u6CDfxV0NGpRZ0lOIEdYrSoiWKVEeh2f+g1t4R8g1kkIk+8ruR7WPflv1a29MRHAVop0tqgMSb2S4cg8K0CMDI6HTMIdkvuHEMJ2jPIInnl+I+Dct06lwlnzgoKRxJ9wpWGwpz+NYTcetLUbswG0mHwHotsuvFL9QtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Jy9B1xZK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CBa9Bj002055;
	Tue, 12 Mar 2024 16:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=7X2vSXMAScoiJxLj1PmKMl0pCpvMqNXlce2fTPnd/cc=; b=Jy
	9B1xZKbJ/AADOIhVH/v7uZiuzrCzog3g807dCUlM4Q9ZSodBuMtu8ld6YL205HQf
	b4vgw2UEUp/IgOYLB+xPEoB88TI1gXe1NyUXK2SCyJHpdZc2lfPS7XrbPoqWLAK1
	FrA5kkoGW1vahdX9YZiv6XbiksOfpTY+sUuA5C8U3u/iFSSmXW00umb5Ns/Htyns
	Q8l2HS9ne1UwBQ5UJm0vJt5VCgxHJJczWURY+QVubJyGZ8IcAyZkpbHRkffNxFJA
	90BuYU8eakLoeBscH/brED+jG5RRFEICAuej2BE3mv58z4dXGK2akFFgbAjI4MLL
	92TbVS88/ojxi1ly/q1Q==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wte5d1mfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 16:08:05 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CG827w022808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 16:08:02 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Mar 2024 09:07:59 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>
CC: <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2] nvmem: meson-mx-efuse: Remove nvmem_device from efuse struct
Date: Tue, 12 Mar 2024 21:37:43 +0530
Message-ID: <1710259663-14095-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: znuVCDFekpWMPK91xIzVv04MctyQn7kv
X-Proofpoint-GUID: znuVCDFekpWMPK91xIzVv04MctyQn7kv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120121

nvmem_device is used at one place while registering nvmem
device and it is not required to be present in efuse struct
for just this purpose.

Drop nvmem_device and manage with nvmem device stack variable.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
Changes in v2:
 - Fixed compilation issue.

 drivers/nvmem/meson-mx-efuse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 3ff04d5ca8f8..8a16f5f02657 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -43,7 +43,6 @@ struct meson_mx_efuse_platform_data {
 struct meson_mx_efuse {
 	void __iomem *base;
 	struct clk *core_clk;
-	struct nvmem_device *nvmem;
 	struct nvmem_config config;
 };
 
@@ -193,6 +192,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 {
 	const struct meson_mx_efuse_platform_data *drvdata;
 	struct meson_mx_efuse *efuse;
+	struct nvmem_device *nvmem;
 
 	drvdata = of_device_get_match_data(&pdev->dev);
 	if (!drvdata)
@@ -223,9 +223,9 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 		return PTR_ERR(efuse->core_clk);
 	}
 
-	efuse->nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
+	nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
 
-	return PTR_ERR_OR_ZERO(efuse->nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static struct platform_driver meson_mx_efuse_driver = {
-- 
2.7.4


