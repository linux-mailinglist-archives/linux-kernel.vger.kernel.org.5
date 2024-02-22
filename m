Return-Path: <linux-kernel+bounces-77526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671AF8606DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A05C1C230E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7304159596;
	Thu, 22 Feb 2024 23:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X6Vli6+s"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8DF225A2;
	Thu, 22 Feb 2024 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643869; cv=none; b=qBo2BcG5m5rqrT0oGvFrnK2s2jBuc/IqK41+rPpLHZgUF+aQxgfzrTtSQQun8R/l1ckSY2BN1yqucPy6tY1C1q7aPqytyxd97JQLSwHkjhT3T/HhjK5ebX6ftkXryypSwIShUIlj4EcWxOwnehB4bSgAyrfp5L2610NRlJzkAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643869; c=relaxed/simple;
	bh=ybh8g1N0tzvxAt2uGzFNBCl5r6uDlNYge/rflP0xsm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ROan7HMBgAK+VpMFCMf62pq2GS5O7q4bdpq5+3HIOJW7JZ/a86IpkUNnwvLesDRXC4A2ej5+wINFOOikIVb+su39d8Xcsn9aYJW7XgjbuvxSHB8OtfJW1ogoHjKd7W7vnNcRp6lP1BJdX0P7xLcg+kd0CW87QAYWT13oD7qy9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X6Vli6+s; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MMfwf5023099;
	Thu, 22 Feb 2024 23:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=eO62myJpAZB3KKFa7P4YEhFwAaiw2pagW6qYX+cFAXk
	=; b=X6Vli6+sDHoLKdCXLHo9rQCyHJ3JHSrcQaJFf4s9JVXZO26TfdnSbBDa6Xy
	9rrjk6I87O8PbgsRCmF2O3TjAKBwZH7MJvnS0q3M+zebEACERDRy31bM7M1lNJu6
	OC3FMDP9wwWbTUW/1F26tWtu8DRswt/2P3UYA6TMX2WA7ZO1V+H99JM7fSW2dgAJ
	n/bn58HED8F3AJU89n7ZdGEwE4UuVVvfV8274ztgtslPFvJT5+R/aAUZ0K8d6VB2
	G4NSypuelBTlmF0RLBCdvYe4Jpgk7KS1yI1PMfclxIu8XswED/yn9k2YCKZuETxd
	F7spCEiOpWlCm5AgCiPFQFp4YHw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdw13afvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGTLY027663
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:29 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:28 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:26 -0800
Subject: [PATCH v17 03/35] gunyah: Common types and error codes for Gunyah
 hypercalls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-3-1e9da6763d38@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
In-Reply-To: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
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
X-Mailer: b4 0.12.4
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nyPv04IQzCqrW0808AZtf8mr0XHoRsna
X-Proofpoint-GUID: nyPv04IQzCqrW0808AZtf8mr0XHoRsna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=482
 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2402120000 definitions=main-2402220179

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
index 0000000000000..1eab631a49b6d
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


