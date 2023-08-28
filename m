Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADF178B6C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbjH1RxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjH1Rwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:52:38 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2601B11B;
        Mon, 28 Aug 2023 10:52:34 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SCAefp025640;
        Mon, 28 Aug 2023 17:52:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=0YHfgI0evUTFth3w+FBJmzfotlV2fTB1VPb6dRYdnD8=;
 b=aP34WWZNjaYyUzuYTyOh/gZUKPEIrwEAzfLIlV/2rAQRu0YOQ1VISFwpvZK8UTTM4BlT
 0D4wAiZB3KjnawLx3JzfWrolUeq7bgQMJDmTlh38Mzcxu+Qsego8Id/DxPExWyLNWYda
 FX9mucalGi6V8Fz6NqsgSfoaYj3/Ac7kw75DrritcOej1iq0X/m6r9VGSYPmkI91XkFO
 ob/VqiFpmf/iCnZ/RNN6Xa3yBpit30jXgOgEmleRLRcmb7fGbLrpsFhjhygQFs0wDM/G
 1KoO0bq2S0K0+BGgo8+8UCnAHCqwlz1cLtyR5dJy/h8ElHDRrWTxZ0J1VVJ/09wIH1XY Yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sq6ruc9xy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:52:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SHqFYd031866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 17:52:15 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 10:52:12 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH 0/2] wifi: Fix struct ieee80211_tim_ie::virtual_map
Date:   Mon, 28 Aug 2023 10:52:02 -0700
Message-ID: <20230828-ieee80211_tim_ie-v1-0-6d7a4bab70ef@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPe7GQC/32NTQ7CIBBGr9LMWgwD/lBX3sM0TQNTO4uCQiWah
 ruLPYDL95LvfSskikwJLs0KkTInDr4C7hqw0+DvJNhVBiWVlkYdBRORkQqxX3jumYTULR60HEZ
 9clBnj0gjv7fkras8cVpC/GwPGX/2TyyjkEIZeyaN2qnWXZ8vtuzt3oYZulLKFxjgM6OyAAAA
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
X-Proofpoint-ORIG-GUID: sc6ufJyj2D9tRtiJvfE5nCh_56mRwgQ5
X-Proofpoint-GUID: sc6ufJyj2D9tRtiJvfE5nCh_56mRwgQ5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_15,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 mlxlogscore=574 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
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

To align with [1] change struct ieee80211_tim_ie::virtual_map to be a
flexible array and fix all size references to account for the change
in struct size.

As a precursor, add a size check in a place where one is currently
missing.

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

Internal note: posting to kernel@quicinc.com since although I believe
the legacy Qualcomm Atheros exception applies, it doesn't hurt to get
feedback/green light from the core kernel team before posting
upstream.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Jeff Johnson (2):
      wifi: cw1200: Avoid processing an invalid TIM IE
      mac80211: Use flexible array in struct ieee80211_tim_ie

 drivers/net/wireless/ath/ath9k/recv.c          | 2 +-
 drivers/net/wireless/ath/carl9170/rx.c         | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c | 2 +-
 drivers/net/wireless/realtek/rtlwifi/ps.c      | 2 +-
 drivers/net/wireless/st/cw1200/txrx.c          | 2 +-
 include/linux/ieee80211.h                      | 4 ++--
 net/mac80211/util.c                            | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)
---
base-commit: 4dddbad8907bc2ecda6e3714de3ea0a27b90a7d3
change-id: 20230825-ieee80211_tim_ie-0391430af36d

