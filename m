Return-Path: <linux-kernel+bounces-68013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFF0857513
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F3461F25EDC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5BA446C0;
	Fri, 16 Feb 2024 04:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QmB60wLA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BC417732;
	Fri, 16 Feb 2024 04:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056003; cv=none; b=YjdBKlus/2lizMop6H2y4rnppZdtkHTQlClXyX+YOd5bJ9bkbSB4eNzwQOFDTLIIGG/2Madd3ptt0Hw/psAg5QfVlzLgMT7l0jlXAohKgcIYjASzXdu1dgzJLt0dA+OKScFbg2VYx7rATFHH1y4V/zYSTu+VwH6eGrEu7KqN+Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056003; c=relaxed/simple;
	bh=yACmCd8uRMLMbG/RxnlZQEZ3dbApqskMSxX3bs+6bzM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EOmdeiuA7skirW8YP0wB1Xy+VpgwGEmvpIxiTnwPqskzjpLZZH6MyEEmjvrlWZuaNrTlO5RXD1fwHtqlf5CzEnCJBi1EmtlwCxUC8gHPO8pjxyaeaxPEqT5VBv3cCjodAXxrzG3SYTc6seYKX3dEsgS285YNLGNQvWokHrcPgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QmB60wLA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G1rXni001014;
	Fri, 16 Feb 2024 03:59:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=3Rla4vOqiATFlaDH89OE
	CyEspA3+qLF5pvp3IZEYbEM=; b=QmB60wLAVGuckuipK8SC9hUtz5FyXP5BAKnS
	gENyt8Lx4Hhmxy0Yvh8S6xtVpAJX2xkYsLey1HoNTzKIEYrjQXyg5QLFvFEAssm8
	NPGnCYbUOdAw/EtaBvgMddhGgz1JrqdNLs7vomNvZ6t/0YK9vmJ26xTk2TFB7/NE
	KpBnIq6MzXOn6DDxisgKk9Wlcr+5qpgU+uCVXKV8x8ZzorEdF53wrIfzDTeb+z29
	nPne0+fAnBenADUNCFFN+Pu1EIZHQ4bqQMKvomlvbl+SSggvIlKysN//GTqX4rs9
	Kr/kSMtiSwZ3Y/TByyQqH12hJFrUjEdeFRn7xlMVyscpqS79nw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xdx85dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:39 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xcgs032303
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:38 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:38 -0800
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v16 21/50] ASoC: qdsp6: q6afe: Increase APR timeout
Date: Thu, 15 Feb 2024 19:58:54 -0800
Message-ID: <20240216035923.23392-22-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240216035923.23392-1-quic_wcheng@quicinc.com>
References: <20240216035923.23392-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N_7PeJ2GZ_xnBsBOPggP-TdX7RS2krrB
X-Proofpoint-GUID: N_7PeJ2GZ_xnBsBOPggP-TdX7RS2krrB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=939 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160030

For USB offloading situations, the AFE port start command will result in a
QMI handshake between the Q6DSP and the main processor.  Depending on if
the USB bus is suspended, this routine would require more time to complete,
as resuming the USB bus has some overhead associated with it.  Increase the
timeout to 3s to allow for sufficient time for the USB QMI stream enable
handshake to complete.

Change-Id: Id00464382473fc51c8adf1270ff2cbe617b13cba
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 sound/soc/qcom/qdsp6/q6afe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 948007955934..452d7e8b9b30 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -366,7 +366,7 @@
 #define AFE_API_VERSION_SLOT_MAPPING_CONFIG	1
 #define AFE_API_VERSION_CODEC_DMA_CONFIG	1
 
-#define TIMEOUT_MS 1000
+#define TIMEOUT_MS 3000
 #define AFE_CMD_RESP_AVAIL	0
 #define AFE_CMD_RESP_NONE	1
 #define AFE_CLK_TOKEN		1024

