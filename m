Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA7A7E2BE1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 19:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbjKFS03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 13:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjKFS0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 13:26:19 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE7E1BF;
        Mon,  6 Nov 2023 10:26:16 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6FOkXu013264;
        Mon, 6 Nov 2023 18:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=55t/8xBDytWJU1+2fU6EcVnx5wtMVDKpMD1oL/ICq6Y=;
 b=QhBn8Eq4vDvpkJI43KvE+AW+bIs3ef28K8wj+cyHGpDuWBF0TbtK8sEToU/OzU4ZEhZq
 PrEyW6+am8jNbkR1u6NkR+G/VaYgzsLylALtwynVzawzdNT6l2wPyC5319BF50vEcEMv
 4K5/ym4qoLbrHwrVWfslHPfp9hXj6oBmUJ9DOwYyRe51Q7J92tEvO35P+D8lF1y95kS6
 soW6L8pJjrTSjKAaqouKTK5850L9Yl/qKq+bHC2pVeIncKUvl3VsXljCy03llrH4+mcw
 6tx4jszQ8AXPPpfnHl3gDSOcsDuYAsYV5obYjA7IPcre8AN1vH/2rdHGsX/fWDu2JRAR 8w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u72r28f9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 18:26:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6IQ5iL013288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 18:26:05 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 6 Nov 2023 10:26:05 -0800
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 6 Nov 2023 10:26:06 -0800
Subject: [PATCH 4/4] wifi: ath12k: Consolidate WMI peer flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231106-ath-peer-flags-v1-4-781e83b7e8e8@quicinc.com>
References: <20231106-ath-peer-flags-v1-0-781e83b7e8e8@quicinc.com>
In-Reply-To: <20231106-ath-peer-flags-v1-0-781e83b7e8e8@quicinc.com>
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 15c66zbwy1zOMu8kmutE6kYi05iXIM_l
X-Proofpoint-ORIG-GUID: 15c66zbwy1zOMu8kmutE6kYi05iXIM_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_13,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 phishscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 mlxlogscore=667 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently wmi.h has two separate set of definitions for peer
flags. One set of flags is defined in enum wmi_tlv_peer_flags, and,
except for the last three, are named WMI_TLV_PEER_*. The other set of
flags are defined as macros, and are named WMI_PEER_*. The last three
macros have the same name as the last three wmi_tlv_peer_flags
enumerators.

The code only uses the WMI_PEER_* names; the WMI_TLV_PEER_* names are
unused. So as a first step in consolidation, remove all the
WMI_TLV_PEER_* names.

But since having an enum to define all the flags is actually a good
thing since that provides a handle by which to refer to the entire set
of flags, recast the WMI_PEER_* macros into enumerators.

Compile tested only.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath12k/wmi.h | 61 +++++++++++------------------------
 1 file changed, 19 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.h b/drivers/net/wireless/ath/ath12k/wmi.h
index 7d295330e6f1..811aeea34e34 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.h
+++ b/drivers/net/wireless/ath/ath12k/wmi.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2021-2023 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef ATH12K_WMI_H
@@ -1146,25 +1146,27 @@ enum wmi_tlv_vdev_param {
 };
 
 enum wmi_tlv_peer_flags {
-	WMI_TLV_PEER_AUTH = 0x00000001,
-	WMI_TLV_PEER_QOS = 0x00000002,
-	WMI_TLV_PEER_NEED_PTK_4_WAY = 0x00000004,
-	WMI_TLV_PEER_NEED_GTK_2_WAY = 0x00000010,
-	WMI_TLV_PEER_APSD = 0x00000800,
-	WMI_TLV_PEER_HT = 0x00001000,
-	WMI_TLV_PEER_40MHZ = 0x00002000,
-	WMI_TLV_PEER_STBC = 0x00008000,
-	WMI_TLV_PEER_LDPC = 0x00010000,
-	WMI_TLV_PEER_DYN_MIMOPS = 0x00020000,
-	WMI_TLV_PEER_STATIC_MIMOPS = 0x00040000,
-	WMI_TLV_PEER_SPATIAL_MUX = 0x00200000,
-	WMI_TLV_PEER_VHT = 0x02000000,
-	WMI_TLV_PEER_80MHZ = 0x04000000,
-	WMI_TLV_PEER_PMF = 0x08000000,
+	WMI_PEER_AUTH		= 0x00000001,
+	WMI_PEER_QOS		= 0x00000002,
+	WMI_PEER_NEED_PTK_4_WAY	= 0x00000004,
+	WMI_PEER_NEED_GTK_2_WAY	= 0x00000010,
+	WMI_PEER_HE		= 0x00000400,
+	WMI_PEER_APSD		= 0x00000800,
+	WMI_PEER_HT		= 0x00001000,
+	WMI_PEER_40MHZ		= 0x00002000,
+	WMI_PEER_STBC		= 0x00008000,
+	WMI_PEER_LDPC		= 0x00010000,
+	WMI_PEER_DYN_MIMOPS	= 0x00020000,
+	WMI_PEER_STATIC_MIMOPS	= 0x00040000,
+	WMI_PEER_SPATIAL_MUX	= 0x00200000,
+	WMI_PEER_TWT_REQ	= 0x00400000,
+	WMI_PEER_TWT_RESP	= 0x00800000,
+	WMI_PEER_VHT		= 0x02000000,
+	WMI_PEER_80MHZ		= 0x04000000,
+	WMI_PEER_PMF		= 0x08000000,
 	WMI_PEER_IS_P2P_CAPABLE = 0x20000000,
 	WMI_PEER_160MHZ         = 0x40000000,
 	WMI_PEER_SAFEMODE_EN    = 0x80000000,
-
 };
 
 enum wmi_tlv_peer_flags_ext {
@@ -3844,31 +3846,6 @@ struct wmi_unit_test_cmd {
 
 #define MAX_SUPPORTED_RATES 128
 
-#define WMI_PEER_AUTH		0x00000001
-#define WMI_PEER_QOS		0x00000002
-#define WMI_PEER_NEED_PTK_4_WAY	0x00000004
-#define WMI_PEER_NEED_GTK_2_WAY	0x00000010
-#define WMI_PEER_HE		0x00000400
-#define WMI_PEER_APSD		0x00000800
-#define WMI_PEER_HT		0x00001000
-#define WMI_PEER_40MHZ		0x00002000
-#define WMI_PEER_STBC		0x00008000
-#define WMI_PEER_LDPC		0x00010000
-#define WMI_PEER_DYN_MIMOPS	0x00020000
-#define WMI_PEER_STATIC_MIMOPS	0x00040000
-#define WMI_PEER_SPATIAL_MUX	0x00200000
-#define WMI_PEER_TWT_REQ	0x00400000
-#define WMI_PEER_TWT_RESP	0x00800000
-#define WMI_PEER_VHT		0x02000000
-#define WMI_PEER_80MHZ		0x04000000
-#define WMI_PEER_PMF		0x08000000
-/* TODO: Place holder for WLAN_PEER_F_PS_PRESEND_REQUIRED = 0x10000000.
- * Need to be cleaned up
- */
-#define WMI_PEER_IS_P2P_CAPABLE	0x20000000
-#define WMI_PEER_160MHZ		0x40000000
-#define WMI_PEER_SAFEMODE_EN	0x80000000
-
 struct ath12k_wmi_vht_rate_set_params {
 	__le32 tlv_header;
 	__le32 rx_max_rate;

-- 
2.42.0

