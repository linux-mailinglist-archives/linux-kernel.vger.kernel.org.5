Return-Path: <linux-kernel+bounces-153057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6953D8AC874
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23D0F280C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5256751;
	Mon, 22 Apr 2024 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UCoVhh62"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF265380C;
	Mon, 22 Apr 2024 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776773; cv=none; b=GFlLts0JVfNT459BSINvoMQ5USDZJlUHlSMTtWRjRrDbz6Af8zUwRfonltYU1IKBn8qKiN/qmcVkOxa/yoex3QUCgT5SV6sJ7/UAiduobbkpG67pkVthinYIlZAwnqFPhqik7cauhYKtzq6tocfiCnyhl3Cj3GJ1SLSXSYFuZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776773; c=relaxed/simple;
	bh=HjoZwO0t3poPJXRnLwuO9E7uwKecjJ9WRcXiAnkgUtg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jSfCufZvIsvpoBy9m87G78MaRYEdUj6KDWGGE7V94SnRVk0fygKmwLDijeW2f1WTk527yhjpuAXYQCRANDnXnDR0PSJoedz3kdwX8OQ/uLpIR5JsZIV7jT7AtUqBMurXa/iZI/ZZrmMKVBCeIeTKgX/cFvwWnoP7i7ORyr0DvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UCoVhh62; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M6Uh4V015751;
	Mon, 22 Apr 2024 09:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=Vk16qoA
	6fUZ55RxZHqTWBTIzqm8TdwxNPsT3R8UDqwQ=; b=UCoVhh62GLYw6IbL3xHVhO9
	IfDt6i+sqPg2ePtzURAa6ae4pJ7XhvoJiwStwwfuGwQXyZTQqK2eXFPGogidfBlN
	aziw8SN25AEApCLikJSeulail5ft7yJZH5pMJ1gl0zGuTzejhFjmBDlapcm1mdv0
	jus/DzAcSrA/yA8B2eIKy269OeR7msE1PzD/T2H9SJDakY39PrsnGDUd1wKx37vY
	jCLc70jCSKTD18nCxzaCRn61VtKvupqnY+/2MWsQDpJjQ17n46sIRZO3bKRAmWvH
	MuxYxK/iZkolq/q7W9nnDtdPjXyhmsO1WmXmwr7971wnXDCcAFiLdELIz134xlA=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xned0gs7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 09:05:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43M95wVJ008426
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 09:05:58 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 02:05:55 -0700
From: Prashanth K <quic_prashk@quicinc.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Wesley Cheng <quic_wcheng@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, Prashanth K <quic_prashk@quicinc.com>
Subject: [RFC PATCH] usb: dwc3: Poll CMDACT after issuing EndXfer command
Date: Mon, 22 Apr 2024 14:35:39 +0530
Message-ID: <20240422090539.3986723-1-quic_prashk@quicinc.com>
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
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nI3NPhOl3YzYZxs41TLb5YrC_fbIZNdV
X-Proofpoint-GUID: nI3NPhOl3YzYZxs41TLb5YrC_fbIZNdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_07,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=521 mlxscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404220038

Currently DWC3 controller revisions 3.10a and later supports
GUCTL[14: Rst_actbitlater] bit which allows polling CMDACT bit
to know whether ENDXFER command is completed. Other revisions
wait 1ms for ENDXFER completion after issuing the command.

Consider a case where an IN request was queued, and parallelly
soft_disconnect was called (due to ffs_epfile_release). This
eventually calls stop_active_transfer with IOC cleared, hence
send_gadget_ep_cmd() skips waiting for CMDACT cleared during
endxfer. For DWC3 controllers with revisions >= 310a, we don't
forcefully wait for 1ms either, and we proceed by unmapping the
requests. If ENDXFER didn't complete by this time, it leads to
SMMU faults since the controller would still be accessing those
requests.

DWC3 databook specifies that CMDACT bit can be polled to check
completion of the EndXfer. Hence use it in stop_active_transfer
to know whether the ENDXFER got completed.

Section 3.2.2.7 Command 8: End Transfer (DEPENDXFER)
Note: If GUCTL2[Rst_actbitlater] is set, Software can poll the
completion of the End  Transfer command by polling the command
active bit to be cleared to 0.

Fixes: b353eb6dc285 ("usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
 drivers/usb/dwc3/gadget.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4df2661f6675..acb54c48451f 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1701,8 +1701,8 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 {
 	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
-	u32 cmd;
-	int ret;
+	u32 cmd, reg;
+	int ret, retries = 500;
 
 	cmd = DWC3_DEPCMD_ENDTRANSFER;
 	cmd |= force ? DWC3_DEPCMD_HIPRI_FORCERM : 0;
@@ -1726,6 +1726,24 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	if (!interrupt) {
 		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
 			mdelay(1);
+		else {
+			/*
+			 * ENDXFER polling is available on version 3.10a and later of
+			 * the DWC3 controller (This is enabled by setting GUCTL2[14])
+			 */
+			do {
+				reg = dwc3_readl(dep->regs, DWC3_DEPCMD);
+				if (!(reg & DWC3_DEPCMD_CMDACT))
+					break;
+				udelay(2);
+			} while (--retries);
+
+			if (!retries && (dwc->ep0state != EP0_SETUP_PHASE)) {
+				dep->flags |= DWC3_EP_DELAY_STOP;
+				return -ETIMEDOUT;
+			}
+		}
+
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-- 
2.25.1


