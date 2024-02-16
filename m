Return-Path: <linux-kernel+bounces-68008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2BBA8574FF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01CB21C21560
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0D43C46F;
	Fri, 16 Feb 2024 04:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bF2J0WWl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F6FC1A;
	Fri, 16 Feb 2024 03:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056001; cv=none; b=Qal3/6retaawu6b5eDlOeaazJYeMJ6M+tkKE3TuKWBA34TrRs+OA23+Vw9JZwtTrKRMqFe6vr52HLewjB+0E3GTy9XWoZvivUJLq2c4GvOtWCWTWUmGngSAnoSXbzjhBPtYTc7C7Wrnci+xBoZrxDlDZsba/H0AQ2XrVDSkDGzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056001; c=relaxed/simple;
	bh=G9yhWCG9ljSwxwD/b/pq0X4Gg+ciUfl/kY2KSKAehRE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t/Dm++gHbban5RIuAediXJDMoza3PKRPKtWElKG/StcA3EU+35RIISeqwtBPgStDlq9/QqbhQZLC/cPwsoXcZcnt+xdIYW2lKpkSlpP7n4J/2onx8AlHG9+pgUB9nFIcJAGuurkeHp480q7Z04J420V5k4/vJggdUGW+h1ILo+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bF2J0WWl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G3N9kY023029;
	Fri, 16 Feb 2024 03:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=zeYUNCgNi3GrreCcNgrm
	15o+eiPFcVJfwXjt3Qbr4DA=; b=bF2J0WWlK72CQ8YpioDFMC1oouQ2ET6OJxuP
	T+ooqM3FJnWJZVnzY2ia5wrlJco+w+XqWOyTvITn4iSNsFwGyhyVNY9tYtWrCAPl
	u6tDhkppg6Ye5+YiCEdWLOkgwBrtM5DO50jo79qyvxJE6RJdABzQtw7SErU4eOb0
	dHgRJZ1ukmcpThc9EIJmHy/GNHwnbZh0Wcjb+yxFhc2W6HTatPIzhjsGUreQv6Go
	Vb7QL8K7W1vEuHW7YgZAqB1BlPrRVltyRcAjDg6f3Vf+sTjMCj4dg3ao/3at5tS/
	GSpqtU03v9xgiLDawQFJadBgwnHyR7pB8EoTZI2HxEkYtJxq0Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w9wxf06ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:41 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41G3xeo5014685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 03:59:40 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 15 Feb 2024 19:59:40 -0800
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
Subject: [PATCH v16 27/50] usb: host: xhci-plat: Set XHCI max interrupters if property is present
Date: Thu, 15 Feb 2024 19:59:00 -0800
Message-ID: <20240216035923.23392-28-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: QhtseoR-kNnTGXda3KjUWwMDmSrRumnH
X-Proofpoint-ORIG-GUID: QhtseoR-kNnTGXda3KjUWwMDmSrRumnH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_02,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160029

Some platforms may want to limit the number of XHCI interrupters allocated.
This is passed to xhci-plat as a device property.  Ensure that this is read
and the max_interrupters field is set.

Change-Id: Ib260d75b288ee54da53c30fcfbb0baba7f2a0bec
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-plat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d071b875308..1c12cadc02a1 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -258,6 +258,8 @@ int xhci_plat_probe(struct platform_device *pdev, struct device *sysdev, const s
 
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
+		device_property_read_u16(tmpdev, "num-hc-interrupters",
+					 &xhci->max_interrupters);
 	}
 
 	/*

