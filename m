Return-Path: <linux-kernel+bounces-159244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D55A98B2B67
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D8A91F24F17
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5313C156F26;
	Thu, 25 Apr 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hn/BXb7V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF23152526;
	Thu, 25 Apr 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081926; cv=none; b=bvzQoCW74ZMEhZ2bAafjLy6ApBeW8mtFGQCTljSqX26cWJEdiN8TF5qMJA6SKO6ThBBRywSlzTQ0MMbxybxqyyS+LFI+93HYNdHGdQrGgCqEahksjE0SuMFbxf4hbfqyKvLrhrvy+djJjCi8rrn8ifSed7l+GVvleQNxVHJ9294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081926; c=relaxed/simple;
	bh=2TQXo2YMYhg/mBJxKuqafaOEZef1g+SCKODQN1pqdkU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d04lSxytpi9ImwJVqdfUOiK/ucqWs3nthxeRXsVPWqbpKi6MzI9jZaiRH1xNbmwN34jK4+BXaL01LebvT/fzyuA8k39POoOJFE+UTMYtX7te9JB1JJKUd5IYo6XBwnD5RBBuO1dFiUY9ovjDsVLMSXastw1XqqFowEes7hVc2Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hn/BXb7V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PL4mA7006203;
	Thu, 25 Apr 2024 21:51:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=/ZM8SPXr7udKkYr/SDUm
	noP1IOgbHf5SfkdSPWJ27XA=; b=Hn/BXb7VlfVhXcf95E7VPUe0a9UrXrgtP7oo
	qle+qxpkSK4bF3tosWhE8XUbI8nYVVFgypE9whUerAz/fbof6F1pjnJO6sHahuKG
	l9OAPF+CBj6xotXTAbJaSJwtrJ85GZtoZa3NVx7CzNEJ7CLYdVVNiPzF2/FlkfnG
	VpDbUevTW4ZPBhvx22F5evzuH+LQ5XYSDMHHnFdeb785M2A3FWP+25i6iHWFtiTE
	ObwXu8g3sRZOPKTMosVDnlowS/lbnkVaVCa0viKooXY4xVb2952FMe4IgnxQRT07
	YqF2KnL2iu/H06vgp81L9m5nVrurHfPVA2kGSnELd0L91jrCDw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqrwwrya0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:51:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PLpdcq024569
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 21:51:39 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 14:51:39 -0700
From: Wesley Cheng <quic_wcheng@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <gregkh@linuxfoundation.org>,
        <Thinh.Nguyen@synopsys.com>, <broonie@kernel.org>,
        <bgoswami@quicinc.com>, <tiwai@suse.com>, <robh@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v20 10/41] ASoC: dt-bindings: qcom,q6dsp-lpass-ports: Add USB_RX port
Date: Thu, 25 Apr 2024 14:50:54 -0700
Message-ID: <20240425215125.29761-11-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240425215125.29761-1-quic_wcheng@quicinc.com>
References: <20240425215125.29761-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: ImwJpJ3mamCAFMc3goEj0kRyqN-wU6lZ
X-Proofpoint-ORIG-GUID: ImwJpJ3mamCAFMc3goEj0kRyqN-wU6lZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_21,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404250159

Q6DSP supports handling of USB playback audio data if USB audio offloading
is enabled.  Add a new definition for the USB_RX AFE port, which is
referenced when the AFE port is started.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
index 39f203256c4f..6d1ce7f5da51 100644
--- a/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
+++ b/include/dt-bindings/sound/qcom,q6dsp-lpass-ports.h
@@ -139,6 +139,7 @@
 #define DISPLAY_PORT_RX_5	133
 #define DISPLAY_PORT_RX_6	134
 #define DISPLAY_PORT_RX_7	135
+#define USB_RX			136
 
 #define LPASS_CLK_ID_PRI_MI2S_IBIT	1
 #define LPASS_CLK_ID_PRI_MI2S_EBIT	2

