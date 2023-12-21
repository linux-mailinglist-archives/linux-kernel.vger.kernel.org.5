Return-Path: <linux-kernel+bounces-8631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044F81BA64
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75AB1F2365B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48D750254;
	Thu, 21 Dec 2023 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oCV4Ghlm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF184E1B0;
	Thu, 21 Dec 2023 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLEur8K012177;
	Thu, 21 Dec 2023 15:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=KxELH7v
	9ITZOwsllWmWfZmzJThagjN0t4hjGlBiSjc4=; b=oCV4Ghlm96tCyPXkKLf4ccw
	FHNhKPc8QMqGnHUa7px5hmUpmhP+js19SF+wBJ8v6xZDse5Gnt2gX6W9GiMAgDWm
	Z7XS/oTv1fZsAE7tdmYUe6evIEjIjfqAK5l796c5Xjl9DKffN39nsHys8cN/H5BI
	hWKEyr593jxM/ETKREhaODEZWDtUnecpWLHiu1exvPJ/doiBCyWwqH/tQQZrguZA
	QebIOI7AcoS7BoHi1LOWISVTuY2DMxeifOnAO+jCWPeWQh1YPRv/ufeJK0HE7NEn
	KkcG5bachFT/JM1wLK3DpjMVD3I/OIlxB1xHIsbv09G0+1sTmiH5Aqm81k+W/zg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4pq386pw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 15:16:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLFGXJZ013592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 15:16:33 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 07:16:30 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>
Subject: [PATCH v2] usb: dwc3: gadget: Ignore dwc3 interrupt if GEVNTCOUNT reads corrupt value
Date: Thu, 21 Dec 2023 20:46:20 +0530
Message-ID: <20231221151620.16030-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Em5qpkGqSDNHFIOHKxtysObEv8P-wvrO
X-Proofpoint-ORIG-GUID: Em5qpkGqSDNHFIOHKxtysObEv8P-wvrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 mlxlogscore=842 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210115

In the current implementation, the check_event_buf call reads the
GEVNTCOUNT register to determine the amount of event data generated
and copies it from ev->buf to ev->cache after masking interrupt.

During copy if the amount of data to be copied is more than
(length - lpos), we fill the ev->cache till the end of 4096 byte
buffer allocated and then start filling from the top (lpos = 0).

In one instance of SMMU crash it is observed that GEVNTCOUNT register
reads more than 4096 bytes:

dwc3_readl   base=0xffffffc0091dc000  offset=50188  value=63488

(offset = 50188 -> 0xC40C)  -> reads 63488 bytes

As per crash dump:
dwc->lpos = 2056

and evt->buf is at 0xFFFFFFC009185000 and the crash is at
0xFFFFFFC009186000. The diff which is exactly 0x1000 bytes.

We first memcpy 2040 bytes from (buf + lpos) to (buf + 0x1000).

And then we copy the rest of the data (64388 - 2040) from beginning
of dwc->ev_buf. While doing so we go beyond bounds as we are trying
to memcpy 62348 bytes into a 4K buffer resulting in crash.

Fix this by ignoring the interrupt when GEVNTCOUNT register reads a
value more than the event ring allocated.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Changes in v2:
Instead of fixing amount of data being copied from ring, ignored
the interrupt when count is corrupt as per suggestion from Thinh.

Link to v1:
https://lore.kernel.org/all/20230521100330.22478-1-quic_kriskura@quicinc.com/

 drivers/usb/dwc3/gadget.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 858fe4c299b7..e27933fdcce3 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4451,6 +4451,7 @@ static irqreturn_t dwc3_thread_interrupt(int irq, void *_evt)
 static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 {
 	struct dwc3 *dwc = evt->dwc;
+	int ret = IRQ_WAKE_THREAD;
 	u32 amount;
 	u32 count;
 
@@ -4480,6 +4481,12 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (!count)
 		return IRQ_NONE;
 
+	if (count > evt->length) {
+		dev_err(dwc->dev, "GEVTCOUNT corrupt\n");
+		ret = IRQ_NONE;
+		goto done;
+	}
+
 	evt->count = count;
 	evt->flags |= DWC3_EVENT_PENDING;
 
@@ -4493,9 +4500,10 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (amount < count)
 		memcpy(evt->cache, evt->buf, count - amount);
 
+done:
 	dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
 
-	return IRQ_WAKE_THREAD;
+	return ret;
 }
 
 static irqreturn_t dwc3_interrupt(int irq, void *_evt)
-- 
2.42.0


