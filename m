Return-Path: <linux-kernel+bounces-159985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571168B372D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC72845EC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32693145FFC;
	Fri, 26 Apr 2024 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Q/okE3gT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9114535C;
	Fri, 26 Apr 2024 12:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714134367; cv=none; b=EISiH7ahcGl5V2lOvHHOfez7SlP1Zh1wP9hibuStpANSkkXfi9dpUF4Vqi4HgtTc6HlQGO7FEEotPIXHi+TeKTBXSEH7lm3NwkgDTHMTkT27qWcqb8+ZggVUB8BJtcQGC3w8mxtuZsaSoguXDsrbCoTrD5DWCTwWD03/MyaBb2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714134367; c=relaxed/simple;
	bh=dYh57E6ZQFNHZXIEQC6AnVwy5RS0Foaz8BUdG7uKogU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j02TNXSiUSWtH8fwTLATSsaHHuHWJt617A0tQdqjDykN4ygVI5tkROko3bqdmo2BxD2ynhKg3IfcsgJVXc2/oQR4/sU4ls/6yNnQKeANQovdz9yRRQ175kqaSf1SYcJ4fvCvpLoO36YvVs1OEqLSGFD+hWjhF1PsPE4BydseyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Q/okE3gT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43QBdJgL011896;
	Fri, 26 Apr 2024 12:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=fHEAhtk
	w2wOoewJBYMs/2MEtu56/1mA6pRiADYx7uCk=; b=Q/okE3gTGMdnRj5Q6etX5yv
	OWmDLBFHKWmhfBMmRImGE0JvHEPulvsghahGPWjUWsA+D/2OVkjimZk8nQimLnIj
	r5gCIxXMlYlOWVzZZzPFJxs2a5qkE2DcKPfOAaK/1rvPmfR5SUwg1s4YPbyjpyIF
	oQGXbtucyrk5EFeCSkvjKD8lBEWoMOVFW4BdQIdM+ErOB8v7M6SH6W79cBZ/2Ybq
	L5Ot9ZqTtmdm5iFJOuafZNIlznc9IxKE+xkO+akwHdgMtQ8AkQA0UDh8WG420dpL
	GdtSn/03nM1cSMxqAgSF55Ko92TZR5BjMYhF7TJXnyzRDWC0ckG2b3GYNzHk8yg=
	=
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr3591t0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 12:25:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43QCPf37005147
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 12:25:41 GMT
Received: from hu-kuruva-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 05:25:35 -0700
From: Rajashekar kuruva <quic_kuruva@quicinc.com>
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
        <alsa-devel@alsa-project.org>,
        Rajashekar kuruva <quic_kuruva@quicinc.com>
Subject: [PATCH] [RFC PATCH] ALSA: usb-audio: endpoint: Prevent NULL pointer deference in snd_usb_endpoint_close
Date: Fri, 26 Apr 2024 17:55:11 +0530
Message-ID: <20240426122511.547755-1-quic_kuruva@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3qfEpPMRQq5Ur703ay_jX8btNchQt73f
X-Proofpoint-ORIG-GUID: 3qfEpPMRQq5Ur703ay_jX8btNchQt73f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_12,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1011 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=968
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260082

When multiple plug-in and plug-out events occur,
there is a risk of encountering a NULL pointer dereference
leading to a kernel panic during a headset use-case.
this issue arises in the snd_usb_endpoint_close function

To avoid check if ep->iface_ref is not null before decrementing
its opened count. If ep->iface_ref is null, we skip the decrement
and the subsequent logic.

Signed-off-by: Rajashekar kuruva <quic_kuruva@quicinc.com>
---
 sound/usb/endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 8f65349a06d3..0e3101b7e392 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -950,7 +950,7 @@ void snd_usb_endpoint_close(struct snd_usb_audio *chip,
 	usb_audio_dbg(chip, "Closing EP 0x%x (count %d)\n",
 		      ep->ep_num, ep->opened);
 
-	if (!--ep->iface_ref->opened &&
+	if (ep->iface_ref && !--ep->iface_ref->opened &&
 		!(chip->quirk_flags & QUIRK_FLAG_IFACE_SKIP_CLOSE))
 		endpoint_set_interface(chip, ep, false);
 
-- 
2.25.1


