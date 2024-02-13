Return-Path: <linux-kernel+bounces-62778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8295F8525BA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3B3285C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D9B42068;
	Tue, 13 Feb 2024 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fWtEtV8o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7C41EF13;
	Tue, 13 Feb 2024 00:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785696; cv=none; b=lMDhkmjKRSdurq5nn7P8CbTEiz1425T90cAWZgxikKZrVrQ1ZJdDx2LBz/fs2Ld17zjwt4wv/OViBdbDRIqXpD/GEi7WoMXlhGzIj7iLMYksKPbidcZlbnuvpWoPpTjGz0XdmreK5K+OILQfZXGFzVbRY8FFuY12lonMY8oRuAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785696; c=relaxed/simple;
	bh=httnPJJML5QlmnUl6L9g9SMmpTEhPWJw3rWiUQwkot4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSz+afFxEz18jx04RDhrcjwDHxhPQ9d/2y9cdzIsM7D5C298OQV2RF7+XPsg8DcCCROn6pw0Songx5x+PZvq1rWvl3hOsmWLL5hrsyJAxvfvuPMbkijjhPDpkxSOJRzmob1rRsNQD5fSAEiJSUPmLtytbTPuuA9O1TLK41PJ6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fWtEtV8o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41CNlaHD015770;
	Tue, 13 Feb 2024 00:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=v2ItLrNtk2j1QY1c2ABM
	7WgcR1ha0sOr3zVlmeNNouY=; b=fWtEtV8oSPZ8wnr1AHYQjQ7qff+uXxHp0Fs3
	FJk17PGQDk0GiPJjduppdqCCv+V8ZKMM4rQUbIx9unJ/1SA5nD+p60R9gP3dP/dX
	KsBhO/OslHj11i0Zyr5IykwFUZq44Rz53Vi2iNZKg3kudhWZv58SWxF209tYswSd
	gMhzdrNHvvN5AQJW7vm6B9aAV7QKPa6yRfIJxUjVio2sz42+OYoQ3Yy3uWvSYgOb
	J7jm5x0Y0H53MUSjXkSkQLplly6/WJmmTKwYTM2oQTsjA9J0Rezpc/GwgDcXbSHo
	8JQLgHjsqn5RmliX4j2ed+SQOJ80EufX0Na8/AnM7/P6Yvwutg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gvjhuwx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:35 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D0sY2X026772
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 00:54:35 GMT
Received: from hu-wcheng-lv.qualcomm.com (10.49.16.6) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 12 Feb 2024 16:54:34 -0800
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
Subject: [PATCH v15 07/50] xhci: add helper that checks for unhandled events on a event ring
Date: Mon, 12 Feb 2024 16:53:39 -0800
Message-ID: <20240213005422.3121-8-quic_wcheng@quicinc.com>
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
X-Proofpoint-GUID: KGBhyYkqqUhxvsgctafNYaxkd-P5tWpn
X-Proofpoint-ORIG-GUID: KGBhyYkqqUhxvsgctafNYaxkd-P5tWpn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-12_20,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130004

From: Mathias Nyman <mathias.nyman@linux.intel.com>

Add unhandled_event_trb() that returns true in case xHC hardware has
written new event trbs to the event ring that driver has not yet handled.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
---
 drivers/usb/host/xhci-ring.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 338b6fddedc3..48388bc16b24 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -113,6 +113,12 @@ static bool last_td_in_urb(struct xhci_td *td)
 	return urb_priv->num_tds_done == urb_priv->num_tds;
 }
 
+static bool unhandled_event_trb(struct xhci_ring *ring)
+{
+	return ((le32_to_cpu(ring->dequeue->event_cmd.flags) & TRB_CYCLE) ==
+		ring->cycle_state);
+}
+
 static void inc_td_cnt(struct urb *urb)
 {
 	struct urb_priv *urb_priv = urb->hcpriv;
@@ -2923,9 +2929,8 @@ static int xhci_handle_event(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 	}
 
 	event = ir->event_ring->dequeue;
-	/* Does the HC or OS own the TRB? */
-	if ((le32_to_cpu(event->event_cmd.flags) & TRB_CYCLE) !=
-	    ir->event_ring->cycle_state)
+
+	if (!unhandled_event_trb(ir->event_ring))
 		return 0;
 
 	trace_xhci_handle_event(ir->event_ring, &event->generic);

