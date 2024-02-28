Return-Path: <linux-kernel+bounces-85048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C992F86AF9A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CD71C2511B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60576148FF4;
	Wed, 28 Feb 2024 12:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GRZKI6KV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126E145B3F;
	Wed, 28 Feb 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125085; cv=none; b=MfQUJB8maxUiQ8dFkTCp+gS/aHjIDhMkMDUPg3bSUPbRHsJ+io9jq2fQncEiD3uj/4RLDE6LX5rufB82tYpw3Sv7W5jUzSVAnOAFhla/ruhf2ITRB6lCrufjjMYVhsAyAhuLxFv52+hfY2wkSs+Tk3gWurzH50qpiimpyLJXE78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125085; c=relaxed/simple;
	bh=xCd9FCuV0P6I+DGvJ2VP4AxODq0+yihzQbQZWXqZEcQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cKXmt15TCWWBND7fsvKN8Slf80CNtkI3datIbiX8NH8PpVqmZGAkapjqHvVFh7bwroDIoNNnxBE2ZVywMwzu59mS9XVBfiwCNk6F4s0jWzF07RsqvtPkxwu0HuweLPAXZVzzFkzJq9uQJ+qIzycDdA1D52L9avX3WOuj7BVYtb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=GRZKI6KV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S9EgMl015857;
	Wed, 28 Feb 2024 12:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=kulUHZQ
	+sWUZhWg1oiTqSixzXqPkzM/P81bT+Eqkzbk=; b=GRZKI6KVWYHooG7yUAAXDCo
	KJZtl3v4CXO1H/nqNTrlytWXdG7f7u0kU6yPzkdIhyVpHoHzwv7xN/demDL5JbIZ
	DRlNsINsl9PMe/hmuGg+oBTXf/7IVPe0jLsln0eSMZpZ7LbkRRWKfiq9gTYw1b6X
	9scCCnN655vcsxp671PnD3fRe/8ua+nxc22uYYvzn1vk9jDHgmW13R/vfIvKKbKC
	1/uqAzR8Nt1H6ThTcV/b4qd95/IaQba1EGrCzRXidk7zetpyzhfAcMM+D9mZocqL
	gNegcKHV70PVw/nZJW4GKzVMimXXBT+gf1SnUBRFueT7vjQOXdv2hLEgrFrW2pQ=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj2148hdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 12:58:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SCvh5p014995
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 12:57:43 GMT
Received: from hu-prashk-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 04:57:40 -0800
From: Prashanth K <quic_prashk@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman
	<mathias.nyman@intel.com>
CC: Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Prashanth K
	<quic_prashk@quicinc.com>, <stable@vger.kernel.org>
Subject: [v2] usb: xhci: Add error handling in  xhci_map_urb_for_dma
Date: Wed, 28 Feb 2024 18:27:24 +0530
Message-ID: <20240228125724.1527491-1-quic_prashk@quicinc.com>
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
X-Proofpoint-ORIG-GUID: w9uZjln_i_-dGx8q_D9E4qnlsdSeQOJ6
X-Proofpoint-GUID: w9uZjln_i_-dGx8q_D9E4qnlsdSeQOJ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_05,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=543 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280103

Currently xhci_map_urb_for_dma() creates a temporary buffer
and copies the SG list to the new linear buffer. But if the
kzalloc_node() fails, then the following sg_pcopy_to_buffer()
can lead to crash since it tries to memcpy to NULL pointer.
So return -ENOMEM if kzalloc returns null pointer.

Cc: <stable@vger.kernel.org> # 5.11
Fixes: 2017a1e58472 ("usb: xhci: Use temporary buffer to consolidate SG")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
---
v2: Updated -EAGAIN to -ENOMEM

 drivers/usb/host/xhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index c057c42c36f4..35e9efdee3b2 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1217,6 +1217,8 @@ static int xhci_map_temp_buffer(struct usb_hcd *hcd, struct urb *urb)
 
 	temp = kzalloc_node(buf_len, GFP_ATOMIC,
 			    dev_to_node(hcd->self.sysdev));
+	if (!temp)
+		return -ENOMEM;
 
 	if (usb_urb_dir_out(urb))
 		sg_pcopy_to_buffer(urb->sg, urb->num_sgs,
-- 
2.25.1


