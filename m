Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D0578F282
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347000AbjHaSXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbjHaSXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:23:33 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89283E76;
        Thu, 31 Aug 2023 11:23:29 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VGqv1Z015308;
        Thu, 31 Aug 2023 18:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=IJf8Pu/6BU2lt6uAstwMsRX3afks4d+RjDyGbuNxntM=;
 b=fBYT15YZO6AMbOnu1/qLdxKB2X2MFnkjzIThppqv/8IJq7O9/JaeD5T8V6Fajlms/Woo
 5tSg2dt9GyCm8VoyBOguey6cNLUm1YKE1yyXvXDFooePOH0T9MQjnLqLMj2XtowNz0fY
 3wTW2w00REwuJszpG/uDxt6Sp2hX+aWqHsbQLkjDb+27YIT4Ea2x2bnMrFy4KWe1U92j
 Dj1RQgX5OHCgs8FQcFjU0+V0d5nyY0BdMDRk+O5WBxBKDcpfxbJadrRE73OO9tmKft2a
 ODIps2c8RBOedzbIilKoSa5c/rcl6rVyzWp6uXCBUYERz4lTTpFAmsSc6z0DkpzEblgr 8g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stxru071s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 18:23:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VIN3BS000964
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 18:23:03 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 31 Aug 2023 11:23:00 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Date:   Thu, 31 Aug 2023 11:22:58 -0700
Subject: [PATCH v3 2/2] mac80211: Use flexible array in struct
 ieee80211_tim_ie
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230831-ieee80211_tim_ie-v3-2-e10ff584ab5d@quicinc.com>
References: <20230831-ieee80211_tim_ie-v3-0-e10ff584ab5d@quicinc.com>
In-Reply-To: <20230831-ieee80211_tim_ie-v3-0-e10ff584ab5d@quicinc.com>
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
        Paolo Abeni <pabeni@redhat.com>,
        Kees Cook <keescook@chromium.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.12.3
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LiCqdd0xbcioSUS6eezCocJY3MUEpGaz
X-Proofpoint-ORIG-GUID: LiCqdd0xbcioSUS6eezCocJY3MUEpGaz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_16,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 mlxlogscore=538 mlxscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308310164
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

Per the discussion in [2] wrap the virtual_map in a union with a u8
item in order to preserve the existing expectation that the
virtual_map must contain at least one octet (at least when used in a
non-S1G PPDU). This means that no driver changes are required.

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays
[2] https://lore.kernel.org/linux-wireless/202308301529.AC90A9EF98@keescook/

Suggested-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 include/linux/ieee80211.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index bd2f6e19c357..340d7e0f6bf7 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -951,17 +951,24 @@ struct ieee80211_wide_bw_chansw_ie {
  * @dtim_count: DTIM Count
  * @dtim_period: DTIM Period
  * @bitmap_ctrl: Bitmap Control
+ * @required_octet: "Syntatic sugar" to force the struct size to the
+ *                  minimum valid size when carried in a non-S1G PPDU
  * @virtual_map: Partial Virtual Bitmap
  *
  * This structure represents the payload of the "TIM element" as
- * described in IEEE Std 802.11-2020 section 9.4.2.5.
+ * described in IEEE Std 802.11-2020 section 9.4.2.5. Note that this
+ * definition is only applicable when the element is carried in a
+ * non-S1G PPDU. When the TIM is carried in an S1G PPDU, the Bitmap
+ * Control and Partial Virtual Bitmap may not be present.
  */
 struct ieee80211_tim_ie {
 	u8 dtim_count;
 	u8 dtim_period;
 	u8 bitmap_ctrl;
-	/* variable size: 1 - 251 bytes */
-	u8 virtual_map[1];
+	union {
+		u8 required_octet;
+		DECLARE_FLEX_ARRAY(u8, virtual_map);
+	};
 } __packed;
 
 /**

-- 
2.42.0

