Return-Path: <linux-kernel+bounces-91756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655D4871620
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 810B01C21CB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8847BAE1;
	Tue,  5 Mar 2024 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pgJM33lW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFF4500B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 06:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621913; cv=none; b=Oti+oxb/jEP/cjaz7Dge9Eg5FaH1ZzzpcsKZYdwH147y06pu400qmSZje8gnVkO2jGA47JpJ3tM+rzKwWiOPU0hAlE1JrDX8+9flX5gdgekTOGSI637q7PTB01bU35GtFKDtiCyw4D5jDSQkDcjza5LA5eX/fB66VrU1e6QcO5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621913; c=relaxed/simple;
	bh=mpVjU72c7z+Xlt/7vdlHPPlT/GWydQ588zNtj9AVb7c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hVWl+QPewav4zcMLGOT98RnjM7zShGdSmVTQdOrIlcqZbZgwMJyjxdZuX/CJu1Kv3UXRd6ZJQDtwzlxEoJdg8NfYUygcYB4qY4MZrEHeR0UmGkUqnBWXQzSDZXcRaodlTjKCseyjzpzXUVUxZtesL6JklQqcTHJvGwixR39MzJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pgJM33lW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4254kG67010647;
	Tue, 5 Mar 2024 06:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=gK3b0IT3wiu25dWPzQzhc0q9hQdh5h0QM5PIZNTwpzk=; b=pg
	JM33lWTHpDRZyblwaKdWmYc4BKhdBFmkT+W4uXFJ41HPNgJ0KMbQWZjPQ5Ns3UCJ
	EXFzjJXdNLwkMKXeU+RtSbBEg0GNSWv7g44G9Wnyynxcty6x47wSIXrBzJkvhLp/
	iVgkyCQZVugCqsp2ufMLIfQXNd96ZqmT+dEluFFnoKGA0cVAy/nOfneFWXkPP9/n
	R3vpAWjT+xRrWN07jQAhW8upIxbSjtI/pj+W0LzacavxFAzIORikAi537NZpnNAu
	2SMkqnc3jEvswar4LLmPS0BdnuqSWzYMB0U92p8pEzNAgwqmFUSukxOeFT2HZoLu
	ZbcoTOClIWCUo8IdBbyg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnn34937n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 06:58:26 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4256wPc8009040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 06:58:25 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 22:58:22 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <neil.armstrong@linaro.org>,
        <khilman@baylibre.com>
CC: <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH] nvmem: meson-mx-efuse: Remove nvmem_device from efuse struct
Date: Tue, 5 Mar 2024 12:28:08 +0530
Message-ID: <1709621888-3173-1-git-send-email-quic_mojha@quicinc.com>
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
X-Proofpoint-GUID: TEbPkxtb-smm8XtIyMUxAIr63JFkxxBd
X-Proofpoint-ORIG-GUID: TEbPkxtb-smm8XtIyMUxAIr63JFkxxBd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_04,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050053

nvmem_device is used at one place while registering nvmem
device and it is not required to be present in efuse struct
for just this purpose.

Drop nvmem_device and manage with nvmem device stack variable.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 drivers/nvmem/meson-mx-efuse.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 3ff04d5ca8f8..3f01fe03dde5 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -43,7 +43,6 @@ struct meson_mx_efuse_platform_data {
 struct meson_mx_efuse {
 	void __iomem *base;
 	struct clk *core_clk;
-	struct nvmem_device *nvmem;
 	struct nvmem_config config;
 };
 
@@ -223,9 +222,9 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
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


