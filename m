Return-Path: <linux-kernel+bounces-58064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F169E84E0C3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A50CC283F3E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5621D76045;
	Thu,  8 Feb 2024 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f8W0zxW0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59F1D525;
	Thu,  8 Feb 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707395740; cv=none; b=mo9xmzYWM5Mlw+klxu1jm9A3LO+50P+hfHZaVcCuOKd2KyTou2hJerNpuUeDkJ4E26yMJi0mzueqOIsNAHZ4LrWsBI4iXrY55pbAL3tH+aeqwsyl7B0N6mv3WM18yYjAYLRExXz13/ScqQzVOxTqBgyUkZ2ZsUMMEuBAJtP5EkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707395740; c=relaxed/simple;
	bh=yfrto/Me4qW2MHQY54SNciFA0kVeMHFuyf7ci+k9tSY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=rzmIr3h/Ps6SHBp22Nur5Q4qpyrvaVWgESapIXlA82Ox11rwZzGI8z788dVzm+CcKbeCE9gmD4HZ7uwv9kuNXyFX0AL+k0oknR4c3+6S0+GoEfKOBSPjv8wGng1YuKjsg9rY/Cy1fl6b4dXNi9I0Ej1H0JTaRrdF+kPY+Gu01tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f8W0zxW0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418Akbvd028072;
	Thu, 8 Feb 2024 12:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=ikMJYK2WAvNN
	KXWt0Hgg52AE4P+Ye/pJr8QAkUFv0NQ=; b=f8W0zxW08WbA/IprkZBzMd5VuzhS
	+H15aAaaoFyuRBbGE1QfjXEcyu78EXwkrotzaBLZR2OWZDBTJRS62MNYXZQJap6c
	Mv0VBajbBOdXDnQ//mHn3bOvQ3xEBvbkKM05CzOPjMqtbyUDYoyECPhoATdji0sN
	JqTr/bt8PS6IbTgLOCbTzgAu9V8A94vf0nOzaZqV/AIfgrEC1yFkXaqO0wOvCqlr
	HilALapNQhAgNDwRJPEwfh8mwriUfWSh75iU+UgNkuhphzhNXDotsXWtS6qQ2kFP
	M0yr8f1QnmafH51pU7RnHcqpP6sDz9NOAxmtQfvhmC0ViAXUPnTwPm4s2A==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4pavhcun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 12:35:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 418CZVVs014362;
	Thu, 8 Feb 2024 12:35:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3w1ejm9s7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 08 Feb 2024 12:35:31 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418CZVNP014356;
	Thu, 8 Feb 2024 12:35:31 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-audityab-hyd.qualcomm.com [10.147.244.159])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 418CZUqm014355;
	Thu, 08 Feb 2024 12:35:31 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 207879)
	id 9BC3E5001CE; Thu,  8 Feb 2024 18:05:29 +0530 (+0530)
From: Auditya Bhattaram <quic_audityab@quicinc.com>
To: andersson@kernel.org, konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Auditya Bhattaram <quic_audityab@quicinc.com>
Subject: [PATCH v3] soc: qcom: mdt_loader: Add Upperbounds check for program header access
Date: Thu,  8 Feb 2024 18:05:27 +0530
Message-Id: <20240208123527.19725-1-quic_audityab@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Z6aUr7cHfi8mP0tq78xzmvJYc9DNKQLd
X-Proofpoint-GUID: Z6aUr7cHfi8mP0tq78xzmvJYc9DNKQLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_03,2024-02-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 clxscore=1011
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402080066
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
is found. Add an upperbound check to phdrs to access within elf size.

Fixes: 64fb5eb87d58 ("soc: qcom: mdt_loader: Allow hash to reside in any segment")
Cc: <stable@vger.kernel.org>
Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
---
Changes in v3:
 - Corrected wrong patch versioning in the Subject.
 - Added error prints for Invalid access.
Link to v2 https://lore.kernel.org/linux-arm-msm/9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com/T/#t
Link to v1 https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
---
 drivers/soc/qcom/mdt_loader.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 6f177e46fa0f..61e2377cc5c3 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -145,6 +145,11 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len,
 	if (phdrs[0].p_type == PT_LOAD)
 		return ERR_PTR(-EINVAL);

+	if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
+		dev_err(dev, "Invalid phdrs access: %s\n", fw_name);
+		return ERR_PTR(-EINVAL);
+	}
+
 	for (i = 1; i < ehdr->e_phnum; i++) {
 		if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == QCOM_MDT_TYPE_HASH) {
 			hash_segment = i;
--
2.17.1


