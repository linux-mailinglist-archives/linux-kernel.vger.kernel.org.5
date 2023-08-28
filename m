Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6236F78B6C3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjH1RxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjH1Rwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:52:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A1111A;
        Mon, 28 Aug 2023 10:52:34 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SHcSNW009484;
        Mon, 28 Aug 2023 17:52:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=ijWOdjRS2kyIUODPcH27cRwxDTTNTamNDeVZz58Vcb4=;
 b=JzEaOA0IU6JvjMHoS/AZf8Vd54ROUIfp05tFi5m7SeE2AD26bn50NJUSH+CJiRxgfErs
 TmyvGTGJmLzuAeCyz4L3UnoC3tUb6i9WsbtrVWWHHga8p09mcrYZcES+0bwPkaPiDqY4
 ai22lYm7zbRCc9y94KyONuR9hV4Rd952frqDslOtuTScHaouxxU8112yHs/9jvyLrFm9
 /woaReRURjrUofvSj6/vIgLdHi4jShZbbuP9yJM/crpe2p2Vw1AmNpK8PcJskfjlUD5T
 aai7/F3Bu/uNzhOSr554/b3WeyaJLIm5qcGUnidSH1V7cCseuIHwBsdqmrqHImyeUXmN fg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss052015m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:52:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SHqFMd032148
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:52:15 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 10:52:13 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 28 Aug 2023 10:52:04 -0700
Subject: [PATCH 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230828-ieee80211_tim_ie-v1-2-6d7a4bab70ef@quicinc.com>
References: <20230828-ieee80211_tim_ie-v1-0-6d7a4bab70ef@quicinc.com>
In-Reply-To: <20230828-ieee80211_tim_ie-v1-0-6d7a4bab70ef@quicinc.com>
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
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nX3qXLlSczm-C_15Z6G_5Po_uJ4bkAck
X-Proofpoint-GUID: nX3qXLlSczm-C_15Z6G_5Po_uJ4bkAck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 spamscore=0 lowpriorityscore=0 mlxlogscore=940 mlxscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308280158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
account for the fact that the sizeof(struct ieee80211_tim_ie) no
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

