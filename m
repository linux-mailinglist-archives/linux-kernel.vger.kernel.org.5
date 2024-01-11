Return-Path: <linux-kernel+bounces-23957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C90A82B47A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4A98B251C8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABE153813;
	Thu, 11 Jan 2024 18:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dq+eu/vo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A451036;
	Thu, 11 Jan 2024 18:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40BArZaq003403;
	Thu, 11 Jan 2024 18:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=RGPZeqDQNRac1/rQmrmIEHG5grim6/lqZ/AxEhfEY9g
	=; b=dq+eu/voj8FX1q3iehmvJ3+qNmRX73OMuCpWvOQTZc8oIiBQGJretZzEKLx
	6TU3zEC2NnhH0Xr6UckqR4mvZOezyp5x+99hy4xaNmPVQlOlSpTlKROhbOIO+zqc
	Y3EUzii0oLLFYAbFLvStSqagJYUKfcBWBhnD92gnxJ18NkL4XYjrIIJ2VJ0T7JyI
	dITP93Xko6gfiLlq5F/2by8Aq3X4RbJCYbUeaYArJQJmOR9rRyYk4AtoMGFlim1S
	7JNwPrkoI2SitXJ3Mjigav0NFM62UCiw2ozFUPh/8twl587KJJrc91je592qwP1I
	jj4d8IRIRNt19L5GVVe6adUqDCQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj6c8j64k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:05:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BI5gNr004005
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 18:05:42 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 10:05:42 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 11 Jan 2024 10:05:31 -0800
Subject: [PATCH v2 2/3] wifi: ath12k: Add missing qmi_txn_cancel() calls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240111-qmi-cleanup-v2-2-53343af953d5@quicinc.com>
References: <20240111-qmi-cleanup-v2-0-53343af953d5@quicinc.com>
In-Reply-To: <20240111-qmi-cleanup-v2-0-53343af953d5@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vopB0sYRD5CN4obQqOla83QOllI_SmHG
X-Proofpoint-GUID: vopB0sYRD5CN4obQqOla83QOllI_SmHG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401110142

Per the QMI documentation "A client calling qmi_txn_init() must call
either qmi_txn_wait() or qmi_txn_cancel() to free up the allocated
resources."

Unfortunately, in most of the ath12k messaging functions, when
qmi_send_request() fails, the function returns without performing the
necessary cleanup. So update those functions to call qmi_txn_cancel()
when qmi_send_request() fails.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/qmi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/qmi.c b/drivers/net/wireless/ath/ath12k/qmi.c
index 180e86c2a10c..1f2df2e3fbce 100644
--- a/drivers/net/wireless/ath/ath12k/qmi.c
+++ b/drivers/net/wireless/ath/ath12k/qmi.c
@@ -1977,6 +1977,7 @@ static int ath12k_qmi_host_cap_send(struct ath12k_base *ab)
 			       QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_host_cap_req_msg_v01_ei, &req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath12k_warn(ab, "Failed to send host capability request,err = %d\n", ret);
 		goto out;
 	}
@@ -2040,6 +2041,7 @@ static int ath12k_qmi_fw_ind_register_send(struct ath12k_base *ab)
 			       QMI_WLANFW_IND_REGISTER_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_ind_register_req_msg_v01_ei, req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath12k_warn(ab, "Failed to send indication register request, err = %d\n",
 			    ret);
 		goto out;
@@ -2114,6 +2116,7 @@ static int ath12k_qmi_respond_fw_mem_request(struct ath12k_base *ab)
 			       QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_respond_mem_req_msg_v01_ei, req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath12k_warn(ab, "qmi failed to respond memory request, err = %d\n",
 			    ret);
 		goto out;
@@ -2229,6 +2232,7 @@ static int ath12k_qmi_request_target_cap(struct ath12k_base *ab)
 			       QMI_WLANFW_CAP_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_cap_req_msg_v01_ei, &req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath12k_warn(ab, "qmi failed to send target cap request, err = %d\n",
 			    ret);
 		goto out;
@@ -2572,6 +2576,7 @@ static int ath12k_qmi_wlanfw_m3_info_send(struct ath12k_base *ab)
 			       QMI_WLANFW_M3_INFO_REQ_MSG_V01_MAX_MSG_LEN,
 			       qmi_wlanfw_m3_info_req_msg_v01_ei, &req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath12k_warn(ab, "qmi failed to send M3 information request, err = %d\n",
 			    ret);
 		goto out;
@@ -2618,6 +2623,7 @@ static int ath12k_qmi_wlanfw_mode_send(struct ath12k_base *ab,
 			       QMI_WLANFW_WLAN_MODE_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_wlan_mode_req_msg_v01_ei, &req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath12k_warn(ab, "qmi failed to send mode request, mode: %d, err = %d\n",
 			    mode, ret);
 		goto out;
@@ -2709,6 +2715,7 @@ static int ath12k_qmi_wlanfw_wlan_cfg_send(struct ath12k_base *ab)
 			       QMI_WLANFW_WLAN_CFG_REQ_MSG_V01_MAX_LEN,
 			       qmi_wlanfw_wlan_cfg_req_msg_v01_ei, req);
 	if (ret < 0) {
+		qmi_txn_cancel(&txn);
 		ath12k_warn(ab, "qmi failed to send wlan config request, err = %d\n",
 			    ret);
 		goto out;

-- 
2.42.0


