Return-Path: <linux-kernel+bounces-62790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99E585263A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CFD28883B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4552C59B7F;
	Tue, 13 Feb 2024 00:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bsoKlUmZ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B66225A4;
	Tue, 13 Feb 2024 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785699; cv=none; b=SerdQRlG+t6hTfYhe3vkC8fHpOOTpZGa9+KUpu7ziZbweVdyeGW5wrs12qCfsZIWGQHRUAIds+F+WUYSzmLYMO91rnTFe2/mKyw/0CfpEZndhaUWnhZQmo9x9dCKa2C3qSfesspJ5+cQVz7neSiIPeKrlKs5HdsH4Yf3DVXyTTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785699; c=relaxed/simple;
	bh=iy+moeOwHnE7dgEZhZINQgamHIdgTcysBEEcZ7EgGr0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5F+YBNFLQx0kET3ZXbkp7KRuNOg4/HGrYrAN+Iqx3+sWiX8UE4A6E+7NbO6iYFn0AbhZdv+47d777GRDsOhwfTqrb42bI5l2LL2zjiBGSX1wR4TOSG3cYi/tOPAiuEE8O+X8qEXARz0U7j9ltX3oJg453hDGaFWB8qOOVYxHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bsoKlUmZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D0PAna011684;
	Tue, 13 Feb 2024 00:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=SG5fCDVTmpRgSZycQx3K
	EfThnpA6x5R39MnhiUzJey0=; b=bsoKlUmZjt/S891Nyb1XM83g9r9lJzrogdJf
	I+ooPVuFjXanyrnYD4Ria/FkpN1diqgENzzlPYN8QnOZynce4gk24xBXDiggPYyT
	svnr2w1hjrFSIfTsm9nv1eH8DC0Ybm7MLrNKL3rH1VOyoWFKrmp3muIRL25Pflrr
	t2ODJG8HdgzZPJHDEtj1TNeL+/AY2Ep5/AWaGspRZx7aglgGbGp/HWtSUnf7rIwQ
	2Q1wuVTUv3U7huLHhbvwMkH7aBqeVF4YFsF18J++Xxrlayf14XfAn+7RxI6+Ahmh
	R+RSZ8d+ehrCH57/LRIA5JuY4ae2pZUdxKeS88E48RWfaV7r/Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7nk91507-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:37 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D0san6031126
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:36 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:54:35 -0800
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
Subject: [PATCH v15 11/50] usb: host: xhci: Export enable and disable interrupter APIs
Date: Mon, 12 Feb 2024 16:53:43 -0800
Message-ID: <20240213005422.3121-12-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240213005422.3121-1-quic_wcheng@quicinc.com>
References: <20240213005422.3121-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: LCfdGDaDZiYhVHe7aTaewVdf5bQI7gFQ
X-Proofpoint-ORIG-GUID: LCfdGDaDZiYhVHe7aTaewVdf5bQI7gFQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 mlxlogscore=531 impostorscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402130005

Secondary interrupters can be OS owned, so expose the enable and disable
interrupter APIs, so that the interrupts can be configured as requested
depending on the client.

Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci.c | 6 ++++--
 drivers/usb/host/xhci.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 872ce8c1a5ba..834d8d160da4 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -320,7 +320,7 @@ static void xhci_zero_64b_regs(struct xhci_hcd *xhci)
 		xhci_info(xhci, "Fault detected\n");
 }
 
-static int xhci_enable_interrupter(struct xhci_interrupter *ir)
+int xhci_enable_interrupter(struct xhci_interrupter *ir)
 {
 	u32 iman;
 
@@ -332,8 +332,9 @@ static int xhci_enable_interrupter(struct xhci_interrupter *ir)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_enable_interrupter);
 
-static int xhci_disable_interrupter(struct xhci_interrupter *ir)
+int xhci_disable_interrupter(struct xhci_interrupter *ir)
 {
 	u32 iman;
 
@@ -345,6 +346,7 @@ static int xhci_disable_interrupter(struct xhci_interrupter *ir)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(xhci_disable_interrupter);
 
 /* interrupt moderation interval imod_interval in nanoseconds */
 static int xhci_set_interrupter_moderation(struct xhci_interrupter *ir,
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index eaea676c85d2..7c2481838f79 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1871,6 +1871,8 @@ int xhci_alloc_tt_info(struct xhci_hcd *xhci,
 		struct xhci_virt_device *virt_dev,
 		struct usb_device *hdev,
 		struct usb_tt *tt, gfp_t mem_flags);
+int xhci_enable_interrupter(struct xhci_interrupter *ir);
+int xhci_disable_interrupter(struct xhci_interrupter *ir);
 
 /* xHCI ring, segment, TRB, and TD functions */
 dma_addr_t xhci_trb_virt_to_dma(struct xhci_segment *seg, union xhci_trb *trb);

