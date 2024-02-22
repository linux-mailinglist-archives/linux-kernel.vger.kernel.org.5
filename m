Return-Path: <linux-kernel+bounces-77522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C19328606C7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62A29B21DED
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C07A157E97;
	Thu, 22 Feb 2024 23:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A74ZU4zg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4F14F992;
	Thu, 22 Feb 2024 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708643844; cv=none; b=ka3W/c+qzyWzjTcAc8ZjM+N4ImiSspDfUWqJqgvi0XQv9B4f+DAYhIkWeD0RMa7j0muEe8b2cfOij1nc0Tjq6xgkKHrc0Zt1i5bUKPwOxLmlXQ7m6k+R7phaCmgt8eUl0GuUWmHUiYaDMjsjSTQRPePbb9CHl7zwteDHBC2Hvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708643844; c=relaxed/simple;
	bh=gQwpF1V0gouoOAPEQGhntzNVFxNm4DMNbyPi7FdMCl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=LeGbNydpTKK4o/ENfIHZA9cjcC0Bpx0tFNnM1ZhJLGtLTE7N/9aDxK+OjN/y4mE4iIKCk8lTkOjqIYq08HALOGD2bKL/cp3BkERIlIO6vTLxy4Rj9t+sFnR5X9JRh45URvAS2/dvpljiScCLsf9aC1QiootGAGy0YFjt/j9NDs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A74ZU4zg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41MLjx5E007129;
	Thu, 22 Feb 2024 23:16:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=jOwfR/FjmwpUtqpMZm+Fy+OtEj0xIxNWKqW40RmlzwU
	=; b=A74ZU4zg/NKqshmuIf5hsrRyYxzH5KLeS3UdiIaLxPQgYad7CHTw31uP0ca
	j80GMKGYrLEFmWayAhl0Hw8pn+p3K6uUKb9uZmPZnfS16rCpLB6m71gOTcnpvYZl
	8KptQ4WaSkZvl9QNLr1Nlv3i8fMBe889aQGqZ1pGCuiZsT6DLeU3ARk6DLN2moiU
	GpwNJOWP+70GRexPmQea0ymjUk64ThlyN+0d/ko5ZLplfzklN4vcdZ141CcUR/8j
	dkzCwLpclNDT78tgLFLfYhkiU5C7vJ+w/aA9vyE+TPvtDVpybvxu+MxTzGe6xEi/
	yHKZdF8fXDsCwcapr04tosNlTTQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdvwwbj78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41MNGl2k028239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Feb 2024 23:16:47 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 22 Feb 2024 15:16:46 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Thu, 22 Feb 2024 15:16:58 -0800
Subject: [PATCH v17 35/35] MAINTAINERS: Add Gunyah hypervisor drivers
 section
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240222-gunyah-v17-35-1e9da6763d38@quicinc.com>
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
X-Proofpoint-ORIG-GUID: b-bFkiTBtvVnXQasl01_9c-9b3K8FlZV
X-Proofpoint-GUID: b-bFkiTBtvVnXQasl01_9c-9b3K8FlZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 mlxlogscore=867 clxscore=1015 phishscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402220179

Add myself and Prakruthi as maintainers of Gunyah hypervisor drivers.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf77be03fb2b..07d8ea2393a9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9322,6 +9322,18 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
 
+GUNYAH HYPERVISOR DRIVER
+M:	Elliot Berman <quic_eberman@quicinc.com>
+M:	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
+F:	Documentation/virt/gunyah/
+F:	arch/arm64/gunyah/
+F:	drivers/virt/gunyah/
+F:	include/linux/gunyah*.h
+K:	gunyah
+
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
 L:	dri-devel@lists.freedesktop.org

-- 
2.34.1


