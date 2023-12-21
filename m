Return-Path: <linux-kernel+bounces-8174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0E081B326
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B12111C24314
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA694F1E9;
	Thu, 21 Dec 2023 10:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mI7F/UnV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF04D5A6;
	Thu, 21 Dec 2023 10:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BL63EN3028172;
	Thu, 21 Dec 2023 10:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Kq8VbpDqe3FOuWKJfLOXUx2yB0WHYeTuEVaPSqZj6UE=; b=mI
	7F/UnVBAk9r3yMw+NjTPcVp69U+6DhGZxr4OvhXoc3okMkg/HtRGPlCepskrXw/F
	9zanMNBT1diPhrrv1/UsbHD9mxN2fNy4rQBvdglNVuj03DHMPS6amZcDJOfHMXuk
	N21w6vx3Neu3pqy8w40f2p4LbBGXDvhqX5M2dtuh6YqAt8ZQQ66fMLPeATpds6fj
	DLjqqwtCvypJB48n3MM4RAdBv6CoE8Clv66RoIo9RY0qyhvJezsfi2ztzbW2cZeu
	HFWBXf7uj1CTsJg9u/tPGnWXRi+NdJVP8XAsJEXDqoE590tDyqaTGZdrjwthZoQy
	kOwdkKL1jdxH0xpkk9GQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3v33c83c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 10:05:53 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLA5qV1006123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 10:05:52 GMT
Received: from sarannya-linux.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 02:05:47 -0800
From: Sarannya S <quic_sarannya@quicinc.com>
To: <quic_bjorande@quicinc.com>, <bjorn.andersson@kernel.org>,
        <andersson@kernel.org>, <quic_clew@quicinc.com>,
        <mathieu.poirier@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <quic_sarannya@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING
 [GENERAL]" <netdev@vger.kernel.org>
Subject: [PATCH V1 1/1] net: qrtr: ns: Ignore ENODEV failures in ns
Date: Thu, 21 Dec 2023 15:35:35 +0530
Message-ID: <1703153136-3607-1-git-send-email-quic_sarannya@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IRYirnL3ks9jCOZ42oyKBpMvPWsk6E75
X-Proofpoint-GUID: IRYirnL3ks9jCOZ42oyKBpMvPWsk6E75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=724 clxscore=1011 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312210074

From: Chris Lew <quic_clew@quicinc.com>

Ignore the ENODEV failures returned by kernel_sendmsg(). These errors
indicate that either the local port has been closed or the remote has
gone down. Neither of these scenarios are fatal and will eventually be
handled through packets that are later queued on the control port.

Signed-off-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Sarannya Sasikumar <quic_sarannya@quicinc.com>
---
 net/qrtr/ns.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index abb0c70..8234339 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -157,7 +157,7 @@ static int service_announce_del(struct sockaddr_qrtr *dest,
 	msg.msg_namelen = sizeof(*dest);
 
 	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
-	if (ret < 0)
+	if (ret < 0 && ret != -ENODEV)
 		pr_err("failed to announce del service\n");
 
 	return ret;
@@ -188,7 +188,7 @@ static void lookup_notify(struct sockaddr_qrtr *to, struct qrtr_server *srv,
 	msg.msg_namelen = sizeof(*to);
 
 	ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
-	if (ret < 0)
+	if (ret < 0 && ret != -ENODEV)
 		pr_err("failed to send lookup notification\n");
 }
 
@@ -207,6 +207,9 @@ static int announce_servers(struct sockaddr_qrtr *sq)
 	xa_for_each(&node->servers, index, srv) {
 		ret = service_announce_new(sq, srv);
 		if (ret < 0) {
+			if (ret == -ENODEV)
+				continue;
+
 			pr_err("failed to announce new service\n");
 			return ret;
 		}
@@ -369,7 +372,7 @@ static int ctrl_cmd_bye(struct sockaddr_qrtr *from)
 		msg.msg_namelen = sizeof(sq);
 
 		ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
-		if (ret < 0) {
+		if (ret < 0 && ret != -ENODEV) {
 			pr_err("failed to send bye cmd\n");
 			return ret;
 		}
@@ -443,7 +446,7 @@ static int ctrl_cmd_del_client(struct sockaddr_qrtr *from,
 		msg.msg_namelen = sizeof(sq);
 
 		ret = kernel_sendmsg(qrtr_ns.sock, &msg, &iv, 1, sizeof(pkt));
-		if (ret < 0) {
+		if (ret < 0 && ret != -ENODEV) {
 			pr_err("failed to send del client cmd\n");
 			return ret;
 		}
-- 
2.7.4


