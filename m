Return-Path: <linux-kernel+bounces-50498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DDD8479E5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C8C288C73
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D58060C;
	Fri,  2 Feb 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oJZA58Q4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E104215E5B0;
	Fri,  2 Feb 2024 19:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706903292; cv=none; b=dVZMDSdthN3AHWYL/aobD5GAVNhumjGolEqm0xSFLT/n9bVzhe2cCsziNti5byt+ZuDYqX1eLj9KR05OzZTh+EXuRwuOk2hCm+1ghIypA2M7mD4OIVawrx5LRdZv04J+xD3gb63vkc2ROWgipeBSwMwlCa87ehGrCH439GU/mMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706903292; c=relaxed/simple;
	bh=3oCXU5oLOkCP1EmBxyuE3BXoh2axCVFn3sXB5wmKqx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=hJrrhA4evLt6dbfGbNB/0JVwG41WJwRoWQllUtwBwjn0qnyVQkpMgyY8jYhc4dM4OT6AvwBLOl4Cjoom2jnZkf3Ne5ANg+fd1ybVrVHTfONkvrUkQxsqWyiakNJdDEqUQ7cj+8Egk8e98b24Yj3MSKFUkyNAproZHsdm3sz0/bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oJZA58Q4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412DTtNP008603;
	Fri, 2 Feb 2024 19:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=gq4
	o9jWhaIfaZM/pumBcf3agGL/sUeHK1Fv4y5qvKc0=; b=oJZA58Q4aOUmsZy4lxE
	I3L1+cSgbC3nFYhCJn2zrUUEMlaglUJEFdC+DMEPyw5jr5EiFMvHFb0JALmiMCis
	wl+mpJ8j/Kmq+mErTU/XgotORenhTFXzBiaQDHs6xFETaG2BMEcHWsosY5IJBHKf
	28Lfk0TkJW+0PmZDXXKI3gATMuYnF7OC//wRb42pXGTH+hQKuO7D9OaKwO18uVb8
	LLupRh3KOUrslSSnELF1KIhr4xPCrCUwRh05NuurxeYIiPrtcaGhW6Nu+Qp06jtY
	uKfXX2Ph4ivY3m9oM76qx2XAD5CD1RauISftlYBTj0xznZY/xzDFioenPF49vl/v
	jSw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0ptwacjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 19:48:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412Jm54q013580
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 19:48:05 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 11:48:03 -0800
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Date: Fri, 2 Feb 2024 11:47:43 -0800
Subject: [PATCH] soc: qcom: llcc: Check return value on Broadcast_OR reg
 read
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAN5GvWUC/x2MUQqAIBAFrxL7nWBhUV0lQmTdakEq1CKI7t7Sz
 8DAvPdAosiUYCgeiHRx4n0TqcoCcHXbQoq9ONS6NlqgZr5tCIj2PLzLZB1mizkG1Zped458bxo
 NMj8iSftfj9P7fhaWvgxqAAAA
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Unnathi Chalicheemala" <quic_uchalich@quicinc.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706903282; l=1046;
 i=quic_uchalich@quicinc.com; s=20240202; h=from:subject:message-id;
 bh=3oCXU5oLOkCP1EmBxyuE3BXoh2axCVFn3sXB5wmKqx4=;
 b=Q0AvVESI3f/xUctl+Ynr7fgvkuJfhQ8MToZPQ7gzOo0VS4UIEBVFLwlnAUtLu39v+9kQQREk4
 N/v9iRhStxUDvVuEGocC2TsfgObkoaQEEjU+i919GBNDXKCEtWXKjO1
X-Developer-Key: i=quic_uchalich@quicinc.com; a=ed25519;
 pk=8n+IFmsCDcEIg91sUP/julv9kf7kmyIKT2sR+1yFd4A=
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: o9MiPB8ZHQiKyF16kcAxMiL6-Qth9HWN
X-Proofpoint-GUID: o9MiPB8ZHQiKyF16kcAxMiL6-Qth9HWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 mlxlogscore=811 adultscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020142

Commit a3134fb09e0b ("drivers: soc: Add LLCC driver") didn't
check return value after Broadcast_OR register read in
llcc_update_act_ctrl(), add it.

Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 4ca88eaebf06..cbef0dea1d5d 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
 	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
 				      slice_status, !(slice_status & status),
 				      0, LLCC_STATUS_READ_DELAY);
+	if (ret)
+		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
 		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,

---
base-commit: 021533194476035883300d60fbb3136426ac8ea5
change-id: 20240202-fix_llcc_update_act_ctrl-64908aed9450

Best regards,
-- 
Unnathi Chalicheemala <quic_uchalich@quicinc.com>


