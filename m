Return-Path: <linux-kernel+bounces-84982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A759C86AE81
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E47B22B56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E786CDBA;
	Wed, 28 Feb 2024 11:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lx9cvsd0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687373BBFE;
	Wed, 28 Feb 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709121301; cv=none; b=Ecp+gXTdtA9SysRDFG3qxCSGSyGJrqXDQTOaYSLBm791YmQ0x0rNNjhxrLjf/EXW24d5vIlduKwlz2f92/XBTXe4rPztZ8KWZrTz3uNWcYL47zFuWiC/q+31ChkE8oEEB202pBlpr7PP5j9RREzTF8BTnZCCUrR+vvkZ56TZRio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709121301; c=relaxed/simple;
	bh=xMUdnGoq6QicZhMufyqPYAP3/Ngm6o1tDFpEwqzwkVQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sSOTEhErlriNhRSfh7k/wf0cuit55E6l1KElPi720ZRbU7ZiE7uToHza20ifLtWpQqruxnIf2jnK0KNbEp1kglA/hYyqC7/fS6TBXwg/Fob3LAvNtdXFFLMTN2N1+zGIrrhzlgCcrHaXZQ3/Ja+ccbZy2RrF37k98Xj5X/OqvnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lx9cvsd0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S9EScE015466;
	Wed, 28 Feb 2024 11:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=qcppdkim1; bh=lPKI7ijCRTDGsDbPL2sw
	mcpW7vZDAd8x9irmrXuFoQc=; b=lx9cvsd0WselbOFtpFVVdKSUmGLrN73AHpLH
	xs/JJK2XgAWSP4Qzl5Mxl4cDW4XpGJKGb17bQqLfuQJHeRVuf2fFyGpgLk9+/9dP
	0BgEbtSIgaUOF5XVHMlZ2EVOws9wpMEseZTWT5VYfi5UyiKxZKB9eRri5MHAaPKi
	/DadNnbziqx3cmPSFYZDhsFxj04ub9KNvuci4t/5OYNUTstq5isoswVZ5K+Zkh4X
	plYa9pdEcDlp1FGmPnwAKjXVpazGZjfg2PNWrOnDCDVNZFPLxXI5+8qtlzrCJzKe
	tIWkt0rwzlv9tDLJyewmR6dZzislXM8/5NBdhORCE0CzU2NYEg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wj2148bcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 11:54:56 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SBst9o019977
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 11:54:55 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 03:54:51 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v2] usb: gadget: ncm: Fix handling of zero block length packets
Date: Wed, 28 Feb 2024 17:24:41 +0530
Message-ID: <20240228115441.2105585-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: f2AS7FZha-3XF9GRzWVZ9FWsyCu41o0B
X-Proofpoint-GUID: f2AS7FZha-3XF9GRzWVZ9FWsyCu41o0B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_04,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=496 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280094

While connecting to a Linux host with CDC_NCM_NTB_DEF_SIZE_TX
set to 65536, it has been observed that we receive short packets,
which come at interval of 5-10 seconds sometimes and have block
length zero but still contain 1-2 valid datagrams present.

According to the NCM spec:

"If wBlockLength = 0x0000, the block is terminated by a
short packet. In this case, the USB transfer must still
be shorter than dwNtbInMaxSize or dwNtbOutMaxSize. If
exactly dwNtbInMaxSize or dwNtbOutMaxSize bytes are sent,
and the size is a multiple of wMaxPacketSize for the
given pipe, then no ZLP shall be sent.

wBlockLength= 0x0000 must be used with extreme care, because
of the possibility that the host and device may get out of
sync, and because of test issues.

wBlockLength = 0x0000 allows the sender to reduce latency by
starting to send a very large NTB, and then shortening it when
the sender discovers that there’s not sufficient data to justify
sending a large NTB"

However, there is a potential issue with the current implementation,
as it checks for the occurrence of multiple NTBs in a single
giveback by verifying if the leftover bytes to be processed is zero
or not. If the block length reads zero, we would process the same
NTB infintely because the leftover bytes is never zero and it leads
to a crash. Fix this by bailing out if block length reads zero.

Cc: <stable@vger.kernel.org>
Fixes: 427694cfaafa ("usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call")
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Changes in v2:
Removed goto label

Link to v1:
https://lore.kernel.org/all/20240226112815.2616719-1-quic_kriskura@quicinc.com/

 drivers/usb/gadget/function/f_ncm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index e2a059cfda2c..28f4e6552e84 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1346,7 +1346,7 @@ static int ncm_unwrap_ntb(struct gether *port,
 	if (to_process == 1 &&
 	    (*(unsigned char *)(ntb_ptr + block_len) == 0x00)) {
 		to_process--;
-	} else if (to_process > 0) {
+	} else if ((to_process > 0) && (block_len != 0)) {
 		ntb_ptr = (unsigned char *)(ntb_ptr + block_len);
 		goto parse_ntb;
 	}
-- 
2.34.1


