Return-Path: <linux-kernel+bounces-19101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B799282680A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF92281DA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BE48F55;
	Mon,  8 Jan 2024 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dy57MCOz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1FD8BE3;
	Mon,  8 Jan 2024 06:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4086U8ON004640;
	Mon, 8 Jan 2024 06:33:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=JMWF9k40UprW26wxgNWmhDwy0qWlpP7qOQtDuRRBBdM=; b=dy
	57MCOz6gx+YpvxgABQumBeEqm/ba/iuw8Ef7JY9wqhYI0AQIzg7FO0NeHjH1Ycty
	sl3Jj2yBsdLczSqA1XSf2um9pKo8DJNwXThWCUF3JDVyN+9C2WQ2XIYxROmUeOrl
	NYLnvxrVjMUTkE7eD97hsx97lHTBdnyGlicDQgf+qlwzzS7k5+mUBggr0bSSiozF
	T8KWyPMnKyn3I1cFCzpsYX4CRyjHHfId2/co3xAjI2qNdyyshffeuZJvEeZJFDPJ
	fRFCVay4vEeqpr4/+hyxnR7OqZMcp/eX/RknMdW9fVDtw9P43iwie/z7mzho/TRJ
	VanFn62OjYYVOBQDgKTQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vgbu2g07b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 06:33:51 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4086Xme9031303;
	Mon, 8 Jan 2024 06:33:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 3veyxkk0ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 08 Jan 2024 06:33:48 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4086Xl5e031297;
	Mon, 8 Jan 2024 06:33:47 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 4086XliP031296;
	Mon, 08 Jan 2024 06:33:47 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 0DA992505; Mon,  8 Jan 2024 12:03:47 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH] media: venus: flush all buffers in output streamoff
Date: Mon,  8 Jan 2024 12:03:35 +0530
Message-Id: <1704695615-1036-2-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1704695615-1036-1-git-send-email-quic_dikshita@quicinc.com>
References: <1704695615-1036-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wXcnaWKW-4bmguNWL7qAvOLhb1ePK2P5
X-Proofpoint-ORIG-GUID: wXcnaWKW-4bmguNWL7qAvOLhb1ePK2P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=868 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401080053
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

For scenarios, when source change is followed by VIDIOC_STREAMOFF
on output, driver should discards any remaining queued OUTPUT
buffers which are not decoded or dequeued.
Flush with HFI_FLUSH_INPUT doesn't have any actual implact. So,
fix it by invoking HFI_FLUSH_ALL which will flush all queued buffers.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 drivers/media/platform/qcom/venus/vdec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
index 29130a9..0d2ab95 100644
--- a/drivers/media/platform/qcom/venus/vdec.c
+++ b/drivers/media/platform/qcom/venus/vdec.c
@@ -1255,7 +1255,7 @@ static int vdec_stop_output(struct venus_inst *inst)
 		break;
 	case VENUS_DEC_STATE_INIT:
 	case VENUS_DEC_STATE_CAPTURE_SETUP:
-		ret = hfi_session_flush(inst, HFI_FLUSH_INPUT, true);
+		ret = hfi_session_flush(inst, HFI_FLUSH_ALL, true);
 		break;
 	default:
 		break;
-- 
2.7.4


