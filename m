Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AE78C55C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236061AbjH2Naz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbjH2Nac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:30:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6442D198;
        Tue, 29 Aug 2023 06:30:29 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCwoTr030060;
        Tue, 29 Aug 2023 13:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=HikdfEPewUbomLXDhgfprFBBhu34LDZC++vWv7prWrA=;
 b=TCoIJ7OemOHKccmIutFAaVnq1uY+3OrSzHJ5jTR2V/CzPTmHdvWJEsdfq3gnrMaXK/MG
 F8B0DwdCrMIcx73XHMDToIZ2hYnYywMToy7wuW9IDzwPm0ccvoR8uhCSp2ixlKkSsmvX
 XsoL5nJmgNExnBaZ89vEaml79V7/JEJHRC5LMUae6Set3aLFYwmKF8H8541FWmfb+GJ5
 SzbtbXgqzn2rAk2KHvMpXJ+8QWe0p6r0Fuk2I/f9SbmipXiAjbnmtCvS/BoFwl6vMd1G
 2LYSSp8LJ3XhE5Wh7GpCPKQ40iYcRJHgt6U9XqX4b4SJMPtSCGO8YeRmr7eqn16kcq8o CA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss3fr1ttt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:30:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TDU6Sq010880
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:30:06 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 06:30:03 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Tue, 29 Aug 2023 06:29:37 -0700
Subject: [PATCH v2 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230829-ieee80211_tim_ie-v2-2-fdaf19fb1c0e@quicinc.com>
References: <20230829-ieee80211_tim_ie-v2-0-fdaf19fb1c0e@quicinc.com>
In-Reply-To: <20230829-ieee80211_tim_ie-v2-0-fdaf19fb1c0e@quicinc.com>
To:     <kernel@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "Christian Lamparter" <chunkeey@googlemail.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        "Helmut Schaa" <helmut.schaa@googlemail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c8Yg4LibsIbzIdNmO4rE9UfA-J2Zd4-r
X-Proofpoint-ORIG-GUID: c8Yg4LibsIbzIdNmO4rE9UfA-J2Zd4-r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxlogscore=940
 impostorscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290117
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently struct ieee80211_tim_ie defines:
	u8 virtual_map[1];

Per the guidance in [1] change this to be a flexible array.

As a result of this change, adjust all related struct size tests to
account for the fact that the sizeof(struct ieee80211_tim_ie) now
accounts for the minimum size of the virtual_map.

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/ath/ath9k/recv.c          | 2 +-
 drivers/net/wireless/ath/carl9170/rx.c         | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c      | 2 +-
 drivers/net/wireless/st/cw1200/txrx.c          | 2 +-
 include/linux/ieee80211.h                      | 4 ++--
 net/mac80211/util.c                            | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/recv.c b/drivers/net/wireless/ath/ath9k/recv.c
index 0c0624a3b40d..2a263a1b7fbf 100644
--- a/drivers/net/wireless/ath/ath9k/recv.c
+++ b/drivers/net/wireless/ath/ath9k/recv.c
@@ -520,7 +520,7 @@ static bool ath_beacon_dtim_pending_cab(struct sk_buff *skb)
 			break;
 
 		if (id == WLAN_EID_TIM) {
-			if (elen < sizeof(*tim))
+			if (elen <= sizeof(*tim))
 				break;
 			tim = (struct ieee80211_tim_ie *) pos;
 			if (tim->dtim_count != 0)
diff --git a/drivers/net/wireless/ath/carl9170/rx.c b/drivers/net/wireless/ath/carl9170/rx.c
index 908c4c8b7f82..5bdbde8c98a3 100644
--- a/drivers/net/wireless/ath/carl9170/rx.c
+++ b/drivers/net/wireless/ath/carl9170/rx.c
@@ -542,7 +542,7 @@ static void carl9170_ps_beacon(struct ar9170 *ar, void *data, unsigned int len)
 	if (!tim)
 		return;
 
-	if (tim[1] < sizeof(*tim_ie))
+	if (tim[1] <= sizeof(*tim_ie))
 		return;
 
 	tim_len = tim[1];
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 9a9cfd0ce402..f594835da7ce 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -669,7 +669,7 @@ static void rt2x00lib_rxdone_check_ps(struct rt2x00_dev *rt2x00dev,
 	if (!tim)
 		return;
 
-	if (tim[1] < sizeof(*tim_ie))
+	if (tim[1] <= sizeof(*tim_ie))
 		return;
 
 	tim_len = tim[1];
diff --git a/drivers/net/wireless/realtek/rtlwifi/ps.c b/drivers/net/wireless/realtek/rtlwifi/ps.c
index 629c03271bde..ea4b055bc6d8 100644
--- a/drivers/net/wireless/realtek/rtlwifi/ps.c
+++ b/drivers/net/wireless/realtek/rtlwifi/ps.c
@@ -506,7 +506,7 @@ void rtl_swlps_beacon(struct ieee80211_hw *hw, void *data, unsigned int len)
 	if (!tim)
 		return;
 
-	if (tim[1] < sizeof(*tim_ie))
+	if (tim[1] <= sizeof(*tim_ie))
 		return;
 
 	tim_len = tim[1];
diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index e16e9ae90d20..c2a51cd79ab8 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -1166,7 +1166,7 @@ void cw1200_rx_cb(struct cw1200_common *priv,
 		size_t ies_len = skb->len - (ies - (u8 *)(skb->data));
 
 		tim_ie = cfg80211_find_ie(WLAN_EID_TIM, ies, ies_len);
-		if (tim_ie && tim_ie[1] >= sizeof(struct ieee80211_tim_ie)) {
+		if (tim_ie && tim_ie[1] > sizeof(struct ieee80211_tim_ie)) {
 			struct ieee80211_tim_ie *tim =
 				(struct ieee80211_tim_ie *)&tim_ie[2];
 
diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index bd2f6e19c357..4cdc2eb98f16 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -961,7 +961,7 @@ struct ieee80211_tim_ie {
 	u8 dtim_period;
 	u8 bitmap_ctrl;
 	/* variable size: 1 - 251 bytes */
-	u8 virtual_map[1];
+	u8 virtual_map[];
 } __packed;
 
 /**
@@ -4405,7 +4405,7 @@ static inline bool ieee80211_check_tim(const struct ieee80211_tim_ie *tim,
 	u8 mask;
 	u8 index, indexn1, indexn2;
 
-	if (unlikely(!tim || tim_len < sizeof(*tim)))
+	if (unlikely(!tim || tim_len <= sizeof(*tim)))
 		return false;
 
 	aid &= 0x3fff;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 8a6917cf63cf..0c23223bb030 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1123,7 +1123,7 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 				elem_parse_failed = true;
 			break;
 		case WLAN_EID_TIM:
-			if (elen >= sizeof(struct ieee80211_tim_ie)) {
+			if (elen > sizeof(struct ieee80211_tim_ie)) {
 				elems->tim = (void *)pos;
 				elems->tim_len = elen;
 			} else

-- 
2.25.1

