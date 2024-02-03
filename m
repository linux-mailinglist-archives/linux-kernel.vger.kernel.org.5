Return-Path: <linux-kernel+bounces-50835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 532A4847ECD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 03:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 864921C21E3D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 02:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A3146BF;
	Sat,  3 Feb 2024 02:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eR1vwBZi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2709F9D1;
	Sat,  3 Feb 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706927870; cv=none; b=YKZWzdrtxQphuOM5lZfL7nGtMqADIeCqiwnLR9nOvwXRqtHpkcl8/EjQYEg8MraFGNVg1KNUGJD+p+G0x3BpAMtG5pbIFk4cPZKy10Ic5Dqyeoj9SJZdJ31tVSEmgfXa2SAiY3R4oHONb1gX7v8CfeQlOqyqnlPBrBq2grdX1NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706927870; c=relaxed/simple;
	bh=Jk0LMWaa/SpQYHxNARX1Jnkq4LIW4HOuymWLQdv26ls=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbgdSpkHB4Cbb/Dnjus+ffXoGwnMvQTOmDKJVTlEW1VBctEZgk//i6edXrUXI1z3MMUyYF3UJwM5qmbOcXLc+ID39vOMJ4AsEFO7l4GPoXdp7GaCiaoC5O6MNUJHGhfDOcOOkaXCvni5CbHzpuLGmivX4kkdcMHL/AXD4Bv+iaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eR1vwBZi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4132VCBu003976;
	Sat, 3 Feb 2024 02:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=KLjeKKCPmPfKQrXevx6P
	EsBCLzPg435el7fcR46yWyc=; b=eR1vwBZi2JgJ0FUWRjou0HweM5+Xq5dZ1Y1j
	ckn4CQHXnt0XTxD9g1A5NmB1PK6aDpkKGaT3SriSfTZRdwCjnZayU0QGDtKl5Cjp
	CEB3701wOdqsOvWDxrvMDJgOaCxbxXKBI4RJQ/Y5hzMIzBKo4RmxBLsuUvH2sux4
	uEReorKDfrjaPnk3grrk0h0aGb/jwB6q0377pFEsjDJ3B72tqACPqM6HoXI2kUFL
	l+HCvU/P1C6bgCELYK4OVYuNWzx8IWtU7uwWfjo6iQHGcuZHMSMC9T4NFLIARbyL
	4G5ECY8GPyYWfMH+5oJkKer8yPgywgzAWHWNcqyGSpxDzljR4w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w1b6nr3n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 02:37:21 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4132bKWw003513
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 02:37:20 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 18:37:19 -0800
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
Subject: [PATCH v13 10/53] xhci: Don't check if the event ring is valid before every event TRB
Date: Fri, 2 Feb 2024 18:36:02 -0800
Message-ID: <20240203023645.31105-11-quic_wcheng@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240203023645.31105-1-quic_wcheng@quicinc.com>
References: <20240203023645.31105-1-quic_wcheng@quicinc.com>
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
X-Proofpoint-ORIG-GUID: NHfXKLdjhi6CZ8ggIXu9k9AQP9aMz80A
X-Proofpoint-GUID: NHfXKLdjhi6CZ8ggIXu9k9AQP9aMz80A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=473 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402030015

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

