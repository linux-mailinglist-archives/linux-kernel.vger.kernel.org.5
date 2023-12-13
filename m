Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165F4811A70
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 18:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjLMRHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 12:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjLMRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 12:07:13 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F59EA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 09:07:19 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BDEUHTZ006018;
        Wed, 13 Dec 2023 17:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:date:subject:mime-version:content-type
        :content-transfer-encoding:message-id:references:in-reply-to:to
        :cc; s=qcppdkim1; bh=yknmZA9L7qBJRQzXVQxSgoAamyNM1yoUA+KHW7sh2e4
        =; b=K5Tcqv4jZJvSMRR/c4gYjgl5hI1HsROtYhFZTHJP0+UpvQWR9TXSLDKlbXn
        wkdJ3TfF3ARG6i5NpTR2nCxaiuLttvYBHh3cMLpoRakb++AVIGpvtIBfR5F1Y+/P
        SS0jtpRMbCUk/C4Udck3MhNFb/5HT7pfBtPuA3M7yHqFVeIQghV9h0fAX4Apz1bZ
        CN1nJlf7jREh0xb4A1zewe6A+TYdNt/QYHc9E1JlfvuT/yqyVBF8CpJa1sqb22x2
        rC9SQW3AFX7/5conMqyvmIonWCkrFEIpjFDgDbWZEZ5olKX6O9U9oOddLMyTVJei
        xrtOczqj4PVeyKLSESkj01GoGUA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyahy8yk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:06:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BDH6fa9031587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Dec 2023 17:06:41 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 13 Dec
 2023 09:06:40 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Wed, 13 Dec 2023 09:06:40 -0800
Subject: [PATCH 2/6] wifi: ath10k: use flexible arrays for WMI start scan
 TLVs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231213-wmi_host_mem_chunks_flexarray-v1-2-92922d92fa2c@quicinc.com>
References: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
In-Reply-To: <20231213-wmi_host_mem_chunks_flexarray-v1-0-92922d92fa2c@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        <ath10k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B2Fi_ThWEObeB8ZqTMnrjEZJdSDefExK
X-Proofpoint-GUID: B2Fi_ThWEObeB8ZqTMnrjEZJdSDefExK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0 mlxlogscore=724
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312130122
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently ath10k defines the following struct:
	struct wmi_start_scan_tlvs {
		u8 tlvs[0];
	} __packed;

Per the guidance in [1] this should be a flexible array. However, a
direct replace to u8 tlvs[] results in the compilation error:
       flexible array member in a struct with no named members

This is because C99 6.7.2.1 (16) requires that a structure containing
a flexible array member must have more than one named member.

So rather than defining a separate struct wmi_start_scan_tlvs which
contains the flexible tlvs[] array, just define the tlvs[] array where
struct wmi_start_scan_tlvs is being used.

No functional changes, compile tested only.

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c |  8 ++++----
 drivers/net/wireless/ath/ath10k/wmi.h | 11 ++---------
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 88befe92f95d..4d5aadbc7159 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -6927,14 +6927,14 @@ void ath10k_wmi_put_start_scan_common(struct wmi_start_scan_common *cmn,
 }
 
 static void
-ath10k_wmi_put_start_scan_tlvs(struct wmi_start_scan_tlvs *tlvs,
+ath10k_wmi_put_start_scan_tlvs(u8 *tlvs,
 			       const struct wmi_start_scan_arg *arg)
 {
 	struct wmi_ie_data *ie;
 	struct wmi_chan_list *channels;
 	struct wmi_ssid_list *ssids;
 	struct wmi_bssid_list *bssids;
-	void *ptr = tlvs->tlvs;
+	void *ptr = tlvs;
 	int i;
 
 	if (arg->n_channels) {
@@ -7012,7 +7012,7 @@ ath10k_wmi_op_gen_start_scan(struct ath10k *ar,
 	cmd = (struct wmi_start_scan_cmd *)skb->data;
 
 	ath10k_wmi_put_start_scan_common(&cmd->common, arg);
-	ath10k_wmi_put_start_scan_tlvs(&cmd->tlvs, arg);
+	ath10k_wmi_put_start_scan_tlvs(cmd->tlvs, arg);
 
 	cmd->burst_duration_ms = __cpu_to_le32(0);
 
@@ -7041,7 +7041,7 @@ ath10k_wmi_10x_op_gen_start_scan(struct ath10k *ar,
 	cmd = (struct wmi_10x_start_scan_cmd *)skb->data;
 
 	ath10k_wmi_put_start_scan_common(&cmd->common, arg);
-	ath10k_wmi_put_start_scan_tlvs(&cmd->tlvs, arg);
+	ath10k_wmi_put_start_scan_tlvs(cmd->tlvs, arg);
 
 	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi 10x start scan\n");
 	return skb;
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 833ce0251a2c..52a409ff94e7 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -3218,23 +3218,16 @@ struct wmi_start_scan_common {
 	__le32 scan_ctrl_flags;
 } __packed;
 
-struct wmi_start_scan_tlvs {
-	/* TLV parameters. These includes channel list, ssid list, bssid list,
-	 * extra ies.
-	 */
-	u8 tlvs[0];
-} __packed;
-
 struct wmi_start_scan_cmd {
 	struct wmi_start_scan_common common;
 	__le32 burst_duration_ms;
-	struct wmi_start_scan_tlvs tlvs;
+	u8 tlvs[];
 } __packed;
 
 /* This is the definition from 10.X firmware branch */
 struct wmi_10x_start_scan_cmd {
 	struct wmi_start_scan_common common;
-	struct wmi_start_scan_tlvs tlvs;
+	u8 tlvs[];
 } __packed;
 
 struct wmi_ssid_arg {

-- 
2.42.0

