Return-Path: <linux-kernel+bounces-58833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FA84ED70
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0368A1F2823B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4350604C0;
	Thu,  8 Feb 2024 23:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eRIdNiTm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF345026B;
	Thu,  8 Feb 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707434086; cv=none; b=Sc5HlLA9deFZ1nclbBQl3AvV6VdXXmCV3yTyFGgaFLAMowohZNnRN2ZbD/PXER4CC7ri5P7CoQMFq//e9uycDhuaZZg8CcwwnOVxSyzdi/CGyFq5SPPKImKPT5YiikJKiWtKMd4Y2D6WdPLP2vvHenSIiKrjpHEC2rUcPJ2SWIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707434086; c=relaxed/simple;
	bh=Jk0LMWaa/SpQYHxNARX1Jnkq4LIW4HOuymWLQdv26ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fp913WSRaSY/blxhXeFN35CE7p0SgcXfUFLdKMENTvUcUehq1Vp9TzYwsJEfI78/cWQbqPSR3WGH6C0iMrcIWDEfgAEH9+Igu5ZOEpkbZM6KnUAkHgeCaUnfvq643PV6HMsU3CkdAjogRqc/ahQ0YCBW/Po13xkNXlvouk0XGec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eRIdNiTm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 418KFtpA005718;
	Thu, 8 Feb 2024 23:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=KLjeKKCPmPfKQrXevx6P
	EsBCLzPg435el7fcR46yWyc=; b=eRIdNiTmMl6+jbowa4xC8fs7fbsBMAPyjJ2Q
	9/+UdM1KNgJ537SBDdDQpxgtuYWWXYFM2wu2Bdm86mg3SuWUv1MmuGER2Xr8GdPM
	o6sA0O9DhxAaXeP0b88hc7IW9bL+badHvp8z2FCw2jYwvHLUOopBHzoUfPjJKDXd
	RtKVs7Nn951/fwcNfqtKsSAn0y53Zgp7n2E2fqLFu0e5F+nDZWtwnQW/+pdUiT/t
	AiFJ5ft2nBhqSLb+AkrSEROcnk7IYDwzr56zXXZlIUiVKKILjnTNWNWe5fTYJFur
	a6mINJpToY53LJOWzz9emGub5sPsmWFbt9dhggP98Hrg+InJow==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4hhkbaj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 23:14:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 418NEIdp005532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Feb 2024 23:14:18 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 8 Feb 2024 15:14:18 -0800
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
        <alsa-devel@alsa-project.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Subject: [PATCH v14 10/53] xhci: Don't check if the event ring is valid before every event TRB
Date: Thu, 8 Feb 2024 15:13:23 -0800
Message-ID: <20240208231406.27397-11-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208231406.27397-1-quic_wcheng@quicinc.com>
References: <20240208231406.27397-1-quic_wcheng@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 93zJEfuOBtSwavi2uQlPONvU6kF3CJUY
X-Proofpoint-GUID: 93zJEfuOBtSwavi2uQlPONvU6kF3CJUY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_11,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=477 spamscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402080131

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Check if the event ring exists and is valid once when the event handler
is called, not before every individual event TRB.

At this point the interrupter is valid, so no need to check that.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 48388bc16b24..293239d8fab0 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2922,12 +2922,6 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 	union xhci_trb *event;
 	u32 trb_type;
 
-	/* Event ring hasn't been allocated yet. */
-	if (!ir || !ir->event_ring || !ir->event_ring->dequeue) {
-		xhci_err(xhci, "ERROR interrupter not ready\n");
-		return -ENOMEM;
-	}
-
 	event = ir->event_ring->dequeue;
 
 	if (!unhandled_event_trb(ir->event_ring))
@@ -3031,6 +3025,12 @@ static int xhci_handle_events(struct xhci_hcd *xhci, struct xhci_interrupter *ir
 
 	xhci_clear_interrupt_pending(xhci, ir);
 
+	/* Event ring hasn't been allocated yet. */
+	if (!ir->event_ring || !ir->event_ring->dequeue) {
+		xhci_err(xhci, "ERROR interrupter event ring not ready\n");
+		return -ENOMEM;
+	}
+
 	if (xhci->xhc_state & XHCI_STATE_DYING ||
 	    xhci->xhc_state & XHCI_STATE_HALTED) {
 		xhci_dbg(xhci, "xHCI dying, ignoring interrupt. Shouldn't IRQs be disabled?\n");

