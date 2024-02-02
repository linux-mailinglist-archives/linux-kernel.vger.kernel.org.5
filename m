Return-Path: <linux-kernel+bounces-49289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF50846840
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9C11C22E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B453FB14;
	Fri,  2 Feb 2024 06:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lGjSRLdf"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA1D2C1A4;
	Fri,  2 Feb 2024 06:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856079; cv=none; b=rGXPMnQyZii923MxeFl6J0mRM1Fge2/+ox7IrnmEa+vIUSC7CCaoCkavjg42M/vDrZOkcYhtxbtQGHe7zp/qSV4a7te4RNNcEIsy9lw5hAcTTEY0pdSsmrugsHImps4crpHx1z5fEXcs9RqOsRMM03Z52UhFrLhzs38Ygx8Hoys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856079; c=relaxed/simple;
	bh=1lIbGo/2OziT53zdE91LvXzUa34Sa/eIpMungQw96p0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rn3RZ0bB8mQmo4k7u+2PZiO9Dp7nc1kDWVsMaT5PSJjlLNKFJNz4/7Qkp3W1PGafZbOw1yzZv+M0bxBsX84YV8WcMPdePg2ymlMBbqqx0K9o+Dk1g7dNc/PpKUYHnsXv/yCQB0DKUyszBPbwSJ1fEIaIHcs6i0TXUjz7J7RZdm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lGjSRLdf; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4126Jjn6006809;
	Fri, 2 Feb 2024 06:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=c0WEn7PDNbcN5mbu7n7y
	lJu5j7la+dT4GWYZ7RDLOa4=; b=lGjSRLdfSwv/OXfcKmYdz07s1bgFtjEvQdKq
	wXLjLpxleOrYgXrFYKx51km+BYi6uOCajuTmdPxds2bcRZF9BjlWdv8L0PpGB5HD
	Swsm9DnwIwkHMQg5eYuFxT22T0jSszNENjuNAbP40VGOnzwAh7v21qV4ibOU5aai
	SeZnYxkzwYG8Kku0QgMS54FWR1wCJG9QlCCIyf768TZq9VmvOI7qP/MoR8eT/Hgn
	pfgxPsMlJspZrLQeeJ46qAt+y2KkJ8ml+oXsmjON+FvYDMXTWPTkbwWiGcoNC9+T
	qoCHh3UO/+dBaR215X1HVcYrnGjTYg36Ifvfv7lmEFzf+dtUWw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu00n3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:16 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126fFCV027515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:15 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:41:13 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 12/16] misc: fastrpc: Add support for users to clean up DSP user PD
Date: Fri, 2 Feb 2024 12:10:35 +0530
Message-ID: <20240202064039.15505-13-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tyeGU-yEyKpxEj1cJQVYCunYuKPLrxRl
X-Proofpoint-ORIG-GUID: tyeGU-yEyKpxEj1cJQVYCunYuKPLrxRl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=796 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

Add a control mechanism for users to clean up DSP user PD. This
method can be used by users for handling any unexpected hang
scenarios on DSP PD. User can clean up DSP PD and restart the
user PD again.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index d4a4ad54a5c9..d1be89f84214 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -2360,6 +2360,11 @@ static int fastrpc_internal_control(struct fastrpc_user *fl,
 	case FASTRPC_CONTROL_RPC_POLL:
 		err = fastrpc_manage_poll_mode(fl, cp->lp.enable, cp->lp.latency);
 		break;
+	case FASTRPC_CONTROL_DSPPROCESS_CLEAN:
+		err = fastrpc_release_current_dsp_process(fl);
+		if (!err)
+			fastrpc_queue_pd_status(fl, fl->cctx->domain_id, FASTRPC_USERPD_FORCE_KILL);
+		break;
 	default:
 		err = -EBADRQC;
 		break;
-- 
2.17.0


