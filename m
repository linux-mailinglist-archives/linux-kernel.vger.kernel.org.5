Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E689C78B6C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjH1RxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjH1Rwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:52:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA2BF9;
        Mon, 28 Aug 2023 10:52:38 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SDjZIC014148;
        Mon, 28 Aug 2023 17:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=QSpOBhGDEboerpYfQTdunBKU7yMaQ08FvJIYYJHw0uA=;
 b=NCFvkVlDeaFRUi3yE9+o8CGcCkEIgA4DDJseqBZZfZ+C17fViJ/QHTGVlYd2yfBFnBdq
 T2NtZ/nzdrge9Yv1z+w3/iJGtQ7GgI8Xh6alLn+khHJspHSa5q3St5ti2JXMhs7l8M/t
 inX09pX7Fzz2s7sB177dz7n9YYCdO6ByKFfHLnhsuhRBYTrIdkZK3dzdT91hkZEWrxg0
 TePxD7q6tiXn7iJFoEOWszulGOiGyewggjzlVYdmUkqjLgCH3AsObYqkkfGTKXGzG+jN
 VxKasKUr+UkJSFgOdBOMZH9Ow33a5M07PZRTrKusXvbdX1yAHzZwVamm6AZNxREPqF6o 7w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srvr80ksr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:52:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SHqFEK007771
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:52:15 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 10:52:13 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Mon, 28 Aug 2023 10:52:03 -0700
Subject: [PATCH 1/2] wifi: cw1200: Avoid processing an invalid TIM IE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230828-ieee80211_tim_ie-v1-1-6d7a4bab70ef@quicinc.com>
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
X-Proofpoint-GUID: D5C97km0H22n0UgLIWLDIbFARe52i4bo
X-Proofpoint-ORIG-GUID: D5C97km0H22n0UgLIWLDIbFARe52i4bo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=694 spamscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308280158
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While converting struct ieee80211_tim_ie::virtual_map to be a flexible
array it was observed that the TIM IE processing in cw1200_rx_cb()
could potentially process a malformed IE in a manner that could result
in a buffer over-read. Add logic to verify that the TIM IE length is
large enough to hold a valid TIM payload before processing it.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/net/wireless/st/cw1200/txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index 6894b919ff94..e16e9ae90d20 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -1166,7 +1166,7 @@ void cw1200_rx_cb(struct cw1200_common *priv,
 		size_t ies_len = skb->len - (ies - (u8 *)(skb->data));
 
 		tim_ie = cfg80211_find_ie(WLAN_EID_TIM, ies, ies_len);
-		if (tim_ie) {
+		if (tim_ie && tim_ie[1] >= sizeof(struct ieee80211_tim_ie)) {
 			struct ieee80211_tim_ie *tim =
 				(struct ieee80211_tim_ie *)&tim_ie[2];
 

-- 
2.25.1

