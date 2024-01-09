Return-Path: <linux-kernel+bounces-21322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E3828D94
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15DA61F23790
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1A83D578;
	Tue,  9 Jan 2024 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bqDBYTlT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7F3D3A0;
	Tue,  9 Jan 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409Gashn012246;
	Tue, 9 Jan 2024 19:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=icjWnj0mkCwFQ21u1pvtQcXcenrQAbg51OlUAoFY4js
	=; b=bqDBYTlTznzQzDDe/plCWxNrXBj0C+AuBiF9nl2bWqlMa4C867i8U3UyhWg
	ftNcHS0TTD/PChYDLzXd1s3/lzOa4m8O8uh0Kzqnj1h3n3xcyfvBC7W85E//60A5
	4L5MBJ2SbgfI46/u6FNCHd6/gV4r/TvTnlzhuYCR6RHVezFSf3f+1w3srNDzevO9
	fbuIpK+Ea2ADnFDMspYMDE8v7eNkFtIp0zOo9KRXZVxtg4fA4yXeS08P8E2S6ef0
	ArVuxvy++oFgiYVs6OE6IhJ2AmeQzXZDk1ChOFIWkSMH7B9wagruHaoyTU6Hqs7t
	nH8m6jW6Z1rrKtJweqGbJ27evvQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh9ta0dw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:37:53 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jbq3R024506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:37:52 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:37:51 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:43 -0800
Subject: [PATCH v16 05/34] virt: gunyah: Add hypervisor driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-5-634904bf4ce9@quicinc.com>
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
In-Reply-To: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Ig6iQvpCLqOoTnh4LaxOTKhPE4RmuWK3
X-Proofpoint-ORIG-GUID: Ig6iQvpCLqOoTnh4LaxOTKhPE4RmuWK3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Add driver to detect when running under Gunyah. It performs basic
identification hypercall and populates the platform bus for resource
manager to probe.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/Makefile        |  1 +
 drivers/virt/gunyah/Makefile |  3 +++
 drivers/virt/gunyah/gunyah.c | 52 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index f29901bd7820..ef6a3835d078 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -10,3 +10,4 @@ obj-y				+= vboxguest/
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-y				+= coco/
+obj-y				+= gunyah/
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
new file mode 100644
index 000000000000..34f32110faf9
--- /dev/null
+++ b/drivers/virt/gunyah/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_GUNYAH) += gunyah.o
diff --git a/drivers/virt/gunyah/gunyah.c b/drivers/virt/gunyah/gunyah.c
new file mode 100644
index 000000000000..ef8a85f27590
--- /dev/null
+++ b/drivers/virt/gunyah/gunyah.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/gunyah.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+
+static int gunyah_probe(struct platform_device *pdev)
+{
+	struct gunyah_hypercall_hyp_identify_resp gunyah_api;
+
+	if (!arch_is_gunyah_guest())
+		return -ENODEV;
+
+	gunyah_hypercall_hyp_identify(&gunyah_api);
+
+	pr_info("Running under Gunyah hypervisor %llx/v%u\n",
+		FIELD_GET(GUNYAH_API_INFO_VARIANT_MASK, gunyah_api.api_info),
+		gunyah_api_version(&gunyah_api));
+
+	/* Might move this out to individual drivers if there's ever an API version bump */
+	if (gunyah_api_version(&gunyah_api) != GUNYAH_API_V1) {
+		pr_info("Unsupported Gunyah version: %u\n",
+			gunyah_api_version(&gunyah_api));
+		return -ENODEV;
+	}
+
+	return devm_of_platform_populate(&pdev->dev);
+}
+
+static const struct of_device_id gunyah_of_match[] = {
+	{ .compatible = "gunyah-hypervisor" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gunyah_of_match);
+
+/* clang-format off */
+static struct platform_driver gunyah_driver = {
+	.probe = gunyah_probe,
+	.driver = {
+		.name = "gunyah",
+		.of_match_table = gunyah_of_match,
+	}
+};
+/* clang-format on */
+module_platform_driver(gunyah_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Gunyah Driver");

-- 
2.34.1


