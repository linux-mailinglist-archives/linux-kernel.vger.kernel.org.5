Return-Path: <linux-kernel+bounces-108984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24724881300
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6E02287003
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD6D44C93;
	Wed, 20 Mar 2024 14:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c6ZSdohP"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C2D3A267;
	Wed, 20 Mar 2024 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943926; cv=none; b=qxKcQsyjY9xNAv1nqtY1ZPyoEW3MirECHU3eE6wxM2KUQEeVX/DQWlyNPlTnB/pkAaT0dbElcwywqVzLF9F/O0duVsa1ftmKRFzMUn1tjcMWHZvT9/LTCHPk7vSO5i5yiQ3uHqImGaYQ/2i5E+An0mAw2ZP17M+TSjpNhFbKj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943926; c=relaxed/simple;
	bh=Va03ZUxbbz51yCWnpPZsPDEwDl8kD420jlyH6swzV+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nNO8+18eo0QEtvcjRSFO9L0+ZvzyykZA5c08Rwr2VBX8aPQ/nDCxH3ZeIJvH7//h2K9Z4oDLETLKl6LBD/UWxB5zX3NRMZgNPZfAy4zN40tcn76h7NElQhtVy+Es7kGM+zUMdEFd+2eXIEXDvXagRF2SXNulx+sPVHi3L5i3sOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c6ZSdohP; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KDAd7A014690;
	Wed, 20 Mar 2024 14:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=v6pNyRmUfU9+7OKzKGP0
	wgRaZBJdk/SqtsxZ7zd1x6A=; b=c6ZSdohPfWYwExiHisXfaHdBRbCNovWsasL4
	Y5t6iA9lTobUX5561ZPLPBV3KIY7se5BJj6utJ0rYIOOK4qIEuZk8W9rFySKnEk2
	/Y2fTN6pMeTFS3gC5v5ahxz0HI+VxWDzjDsiLspuR006KzcCQzyqYnAdMeDZxo1U
	6E3K48WC/fRjHzAts+IwDqnklqalT7nWkzBKse9GSrDDVwJSBvwsJeKM4I7fJTo3
	Cf9X3HuUgtdYUQOzRJZsrYTOvJLP1CE2KbaZ+dDnfXvTrfUziabt8B8+FHcBjQzR
	noOiCO6g0BhqoqJXzSQosRjRdJYVm12HJHt/56jq0VFQlY1jiQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyq60sasx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:11:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KEBwTX021057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 14:11:58 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 07:11:55 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 1/8] media: qcom: camss: Add CAMSS_8550 enum
Date: Wed, 20 Mar 2024 19:41:29 +0530
Message-ID: <20240320141136.26827-2-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240320141136.26827-1-quic_depengs@quicinc.com>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ffW9N3FpZ_K9dH_CgBgZW47oCFRT_sJb
X-Proofpoint-GUID: ffW9N3FpZ_K9dH_CgBgZW47oCFRT_sJb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 mlxlogscore=856
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403200112

From: Yongsheng Li <quic_yon@quicinc.com>

Adds a CAMSS SoC identifier for the sm8550.

Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/qcom/camss/camss.h b/drivers/media/platform/qcom/camss/camss.h
index ac15fe23a702..2f63206a8463 100644
--- a/drivers/media/platform/qcom/camss/camss.h
+++ b/drivers/media/platform/qcom/camss/camss.h
@@ -78,6 +78,7 @@ enum camss_version {
 	CAMSS_845,
 	CAMSS_8250,
 	CAMSS_8280XP,
+	CAMSS_8550,
 };
 
 enum icc_count {
-- 
2.17.1


