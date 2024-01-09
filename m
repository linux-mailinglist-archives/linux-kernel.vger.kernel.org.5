Return-Path: <linux-kernel+bounces-21323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A6B828D95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF001C24A18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0A23D962;
	Tue,  9 Jan 2024 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jTlTqzla"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BAA3D3BB;
	Tue,  9 Jan 2024 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409Gxr7f030302;
	Tue, 9 Jan 2024 19:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=79hmU2lp1B5mL+vTI4VCC81K4NZ9OnMRLXsigEg7NjA
	=; b=jTlTqzlaIoNWJ3xWkBqZpGr2TQgOr6wi6b494/cSFWtw7QSSyTqCrtx96LT
	+ombeaEOt3hRv6ciEFkaP5u4mcpL8hKDry+NnqIHHtl6NAG8ZQQGfxj8iKIf9WaL
	pZcqabCID5S1f8gc8Voude/n7IkfvqwTS64JD+EzAxvZauvtcbGbKhEVYuwOG9BA
	mWBMm4QhN9XaGZrc/mXNK2w+LC8WSChTVFbukp7kpmSSmM0r0vwtmMh6F0oTb35/
	XRX0T1w9PUS5Nr3MI2erJ1rCVscVnuLQbqRUuTBpQyM+A07n70RDXG1pAt3FxGxr
	IlhBZb2LTRUeput0KGlPLU7jfqg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh98m8hqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:37:52 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jbp4d011905
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:37:51 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:37:50 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:41 -0800
Subject: [PATCH v16 03/34] gunyah: Common types and error codes for Gunyah
 hypercalls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-3-634904bf4ce9@quicinc.com>
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
X-Proofpoint-ORIG-GUID: c6Fe_jSNy_BQ31t0hfFNRHbgo2Psl9eu
X-Proofpoint-GUID: c6Fe_jSNy_BQ31t0hfFNRHbgo2Psl9eu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxlogscore=368 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Add architecture-independent standard error codes, types, and macros for
Gunyah hypercalls.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 include/linux/gunyah.h | 106 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
new file mode 100644
index 000000000000..1eab631a49b6
--- /dev/null
+++ b/include/linux/gunyah.h
@@ -0,0 +1,106 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _LINUX_GUNYAH_H
+#define _LINUX_GUNYAH_H
+
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/limits.h>
+
+/* Matches resource manager's resource types for VM_GET_HYP_RESOURCES RPC */
+enum gunyah_resource_type {
+	/* clang-format off */
+	GUNYAH_RESOURCE_TYPE_BELL_TX	= 0,
+	GUNYAH_RESOURCE_TYPE_BELL_RX	= 1,
+	GUNYAH_RESOURCE_TYPE_MSGQ_TX	= 2,
+	GUNYAH_RESOURCE_TYPE_MSGQ_RX	= 3,
+	GUNYAH_RESOURCE_TYPE_VCPU	= 4,
+	GUNYAH_RESOURCE_TYPE_MEM_EXTENT	= 9,
+	GUNYAH_RESOURCE_TYPE_ADDR_SPACE	= 10,
+	/* clang-format on */
+};
+
+struct gunyah_resource {
+	enum gunyah_resource_type type;
+	u64 capid;
+	unsigned int irq;
+};
+
+/******************************************************************************/
+/* Common arch-independent definitions for Gunyah hypercalls                  */
+#define GUNYAH_CAPID_INVAL U64_MAX
+#define GUNYAH_VMID_ROOT_VM 0xff
+
+enum gunyah_error {
+	/* clang-format off */
+	GUNYAH_ERROR_OK				= 0,
+	GUNYAH_ERROR_UNIMPLEMENTED		= -1,
+	GUNYAH_ERROR_RETRY			= -2,
+
+	GUNYAH_ERROR_ARG_INVAL			= 1,
+	GUNYAH_ERROR_ARG_SIZE			= 2,
+	GUNYAH_ERROR_ARG_ALIGN			= 3,
+
+	GUNYAH_ERROR_NOMEM			= 10,
+
+	GUNYAH_ERROR_ADDR_OVFL			= 20,
+	GUNYAH_ERROR_ADDR_UNFL			= 21,
+	GUNYAH_ERROR_ADDR_INVAL			= 22,
+
+	GUNYAH_ERROR_DENIED			= 30,
+	GUNYAH_ERROR_BUSY			= 31,
+	GUNYAH_ERROR_IDLE			= 32,
+
+	GUNYAH_ERROR_IRQ_BOUND			= 40,
+	GUNYAH_ERROR_IRQ_UNBOUND		= 41,
+
+	GUNYAH_ERROR_CSPACE_CAP_NULL		= 50,
+	GUNYAH_ERROR_CSPACE_CAP_REVOKED		= 51,
+	GUNYAH_ERROR_CSPACE_WRONG_OBJ_TYPE	= 52,
+	GUNYAH_ERROR_CSPACE_INSUF_RIGHTS	= 53,
+	GUNYAH_ERROR_CSPACE_FULL		= 54,
+
+	GUNYAH_ERROR_MSGQUEUE_EMPTY		= 60,
+	GUNYAH_ERROR_MSGQUEUE_FULL		= 61,
+	/* clang-format on */
+};
+
+/**
+ * gunyah_error_remap() - Remap Gunyah hypervisor errors into a Linux error code
+ * @gunyah_error: Gunyah hypercall return value
+ */
+static inline int gunyah_error_remap(enum gunyah_error gunyah_error)
+{
+	switch (gunyah_error) {
+	case GUNYAH_ERROR_OK:
+		return 0;
+	case GUNYAH_ERROR_NOMEM:
+		return -ENOMEM;
+	case GUNYAH_ERROR_DENIED:
+	case GUNYAH_ERROR_CSPACE_CAP_NULL:
+	case GUNYAH_ERROR_CSPACE_CAP_REVOKED:
+	case GUNYAH_ERROR_CSPACE_WRONG_OBJ_TYPE:
+	case GUNYAH_ERROR_CSPACE_INSUF_RIGHTS:
+		return -EACCES;
+	case GUNYAH_ERROR_CSPACE_FULL:
+	case GUNYAH_ERROR_BUSY:
+	case GUNYAH_ERROR_IDLE:
+		return -EBUSY;
+	case GUNYAH_ERROR_IRQ_BOUND:
+	case GUNYAH_ERROR_IRQ_UNBOUND:
+	case GUNYAH_ERROR_MSGQUEUE_FULL:
+	case GUNYAH_ERROR_MSGQUEUE_EMPTY:
+		return -EIO;
+	case GUNYAH_ERROR_UNIMPLEMENTED:
+		return -EOPNOTSUPP;
+	case GUNYAH_ERROR_RETRY:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+#endif

-- 
2.34.1


