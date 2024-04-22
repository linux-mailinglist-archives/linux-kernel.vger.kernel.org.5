Return-Path: <linux-kernel+bounces-154140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5988AD820
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD17C1C21217
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D9315B153;
	Mon, 22 Apr 2024 22:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dDFjV6P1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650DF155307;
	Mon, 22 Apr 2024 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713826208; cv=none; b=GSMASyKC4Wo3TkMszySB6wsSyk/ldG9eAd+oGVI/RtFBFbRLH9CHOCxR1qpRTWunmgsM6kz75ZASuRRYW8bWoFMPl///deJboe2Vr2baqIXfttO3JmQb0MejpwO6bcXD3z5G9SsUvIBhsp7sSI+WnJpxcepqsXgohGr/YLfstIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713826208; c=relaxed/simple;
	bh=XmiYPURCCkcrr938pQD/oRXOAbdwSPdaV9FMMyvU3w8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2ESHgiXv+4o9oryyrOT2DK+5DsQ2LqvNjFvj6RpjSPpGT/hQBDhHJX6LsBRpQvc5Rv+PcJDK7L/owOGdspQaoklvdwD3qqEHvQegRlnxIa2vnubJ2ouwUTdjlRgIRmjF4HrCpDdSG89jerGU1uIYYU0hq8wn0cNN0wvhzD+4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dDFjV6P1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MJUHEs015331;
	Mon, 22 Apr 2024 22:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=YNWjI42/PIj53s5xl6Pu
	4uO/vriEZ7tubnQTsQu+vDE=; b=dDFjV6P1I7tFphtHWUxdlqcGCspfSPvBQZr0
	aRC0Zwo5F6SbK+gQfQMO5VtlQHACq6UK2SAFBt4O8HdIqG5yQBLKMfoROhFzfIYT
	hTqi79PG1+Bw0sr6G3fv6nk3Hrgbc/9l/NV2RM+S0cy2jMeuBTVvDGgo8WugNOo3
	7LvFkR9MRgvIwNMqFXMnTQ14WH7MYBP3sG3ImLFHQmI80pyZKL7Rzg1D9nvQYbqL
	skXP5jBOlGjh2N3wRlOMxHXLbZzQQuSGh7MFzHaTGS0/s9EJ+o7Smm0QBksfVthZ
	5xnSoyhhT8pfjX/qjZsJ5vFDMX4yVNruTvRaIp9Fdj9Vdu2pbQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82ssjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MMnNsr027772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 22:49:23 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 15:49:23 -0700
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
Subject: [PATCH v19 26/41] ASoC: dt-bindings: Update example for enabling USB offload on SM8250
Date: Mon, 22 Apr 2024 15:48:51 -0700
Message-ID: <20240422224906.15868-27-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240422224906.15868-1-quic_wcheng@quicinc.com>
References: <20240422224906.15868-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hLkySKv5W5E_Fj8AXy39KnTC_mBAlOh0
X-Proofpoint-ORIG-GUID: hLkySKv5W5E_Fj8AXy39KnTC_mBAlOh0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_16,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220096

Add an example on enabling of USB offload for the Q6DSP.  The routing can
be done by the mixer, which can pass the multimedia stream to the USB
backend.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 .../devicetree/bindings/sound/qcom,sm8250.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 2ab6871e89e5..49e4f5bbe9dd 100644
--- a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
@@ -227,6 +227,21 @@ examples:
                 sound-dai = <&vamacro 0>;
             };
         };
+
+        usb-dai-link {
+            link-name = "USB Playback";
+            cpu {
+                sound-dai = <&q6afedai USB_RX>;
+            };
+
+            codec {
+                sound-dai = <&usbdai USB_RX>;
+            };
+
+            platform {
+                sound-dai = <&q6routing>;
+            };
+        };
     };
 
   - |

