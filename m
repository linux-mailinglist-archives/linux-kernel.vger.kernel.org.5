Return-Path: <linux-kernel+bounces-68000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F15F8574CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B22028304E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DB2377A;
	Fri, 16 Feb 2024 04:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fsMcTJXV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF5CFC0C;
	Fri, 16 Feb 2024 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056000; cv=none; b=Gk3CVyAHYsAAoUFV9O+knHbFZnV0U8ZXcexwh8ERm8u1+0+76bdNEp5cJXQrXzU5q3/IIuQvF8aX3nMsCZofhdafvM0rgx8JzOUE6k+o3DoBjAyxMGf8bpA2t/ZyU8zO9O7G6tma7n6EBYkb++KvGa1PIBm9MqZNeKeIVNuhkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056000; c=relaxed/simple;
	bh=D9iCBf4uVlGbolQEK0TZrES/30NrOiurE7BaYTyF02s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKEQ9LVC3s7UXvcMUpXdmoorK2M1e9GXc7iGWCPoNWbPBV4/qsDlkin0iwk/2ZfiZEH2xUMz0OhzraKvH9Vk+4a/FdO7NWXwzJAOlq0GPZj0yv7/mxAkJbqgJzWSECBvoZqncReXhtOC0Vq7+gG62ciuq6rXJecKPnPYXwmoYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fsMcTJXV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G3dvKc005273;
	Fri, 16 Feb 2024 03:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=RAZe4P21Vgy0TC60BB4t
	orvOPX1Bh2tZGi72hcSJDBo=; b=fsMcTJXVZhz2sMMoAkJFNG4RGlpnjRqgllkX
	5DAENv3FKdHK2V+TWE/lJ011DPXXUaYWFlBy2ifs5f3EdjPAjeXCyO0OJIBLdush
	Nc/t4s1wVJgQvWWmnrMEhUPeUaF1byaufrBuZH7yb4Bl+n/sKanq4UxosVeQPVgl
	QayklDS9f5FNFdGhBE4lQYdT3Rc9nIZhn0EQ7jNwAgqf8A/va3XK4nMLd4Vpn5QQ
	3jdsiNln5g18UoPHFdEOxtJbZKGNwDPmoIY4zkCeGAg3mMW+LelGXzdBMc2pqGrh
	HseBkmBFzF2yr3N0f5sOprNP3jAQBufM5xDKClJJrTqY3db8ng==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9xv9g3w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:43 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xhbN032329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:43 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:42 -0800
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
Subject: [PATCH v16 36/50] ASoC: dt-bindings: Update example for enabling USB offload on SM8250
Date: Thu, 15 Feb 2024 19:59:09 -0800
Message-ID: <20240216035923.23392-37-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 2j1F-DM39TlxzpEMBPk1fZT-YMnLf_K0
X-Proofpoint-GUID: 2j1F-DM39TlxzpEMBPk1fZT-YMnLf_K0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_03,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160031

Add an example on enabling of USB offload for the Q6DSP.  The routing can
be done by the mixer, which can pass the multimedia stream to the USB
backend.

Change-Id: I346cb0c027608a5a69a2e102b22e1d2b28690286
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 .../devicetree/bindings/sound/qcom,sm8250.yaml    | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml b/Documentation/devicetree/bindings/sound/qcom,sm8250.yaml
index 6f419747273e..e78b8b660fce 100644
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

