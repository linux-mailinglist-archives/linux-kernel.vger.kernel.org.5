Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5E78C561
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbjH2Nay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjH2NaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:30:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A919113;
        Tue, 29 Aug 2023 06:30:22 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCI3Pi005325;
        Tue, 29 Aug 2023 13:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=zGo6iwCFhDzbB5gY/d6fWoZR/bLTLLlNy1q10Rr+8E4=;
 b=MSG9tcdhaUNWSAL19IhfqPBSx33NlsIcOkIMaTO0hGRqWhXqsH4Dy+Osg4GfaR/v6w6t
 2t4/IbLNAyhIb4Yw9vZlDsnQcsOhFyvC+DDDlXQCrf2UV6Gm8XZtZPaZEIkLCd/uZ3sj
 SFneSnz/LTUqwWePjhw3RBajL2m1b1979DLQqzHrjGsckCjpIUun4gs0DeC7f3vpdxeu
 LWXF99tbSHxzHJBAiqNKiLfXnWb6E35BemjMzoGL7T4Mj9skNK/wWU8UCYSqWm+NRyk/
 j+Li3FHf99raQoqvuOlR0lVf9nYbORjEN+qhhia7wWfu/d+MOelC3WXFa5OwuNJ6sl1u FA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss6j89ck2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:30:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TDU5Aw031776
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 13:30:05 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 29 Aug 2023 06:30:03 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v2 0/2] wifi: Fix struct ieee80211_tim_ie::virtual_map
Date:   Tue, 29 Aug 2023 06:29:35 -0700
Message-ID: <20230829-ieee80211_tim_ie-v2-0-fdaf19fb1c0e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL/y7WQC/32Nyw6CMBBFf4V0bU07RSiu/A9DSGkHmQUPWyQaw
 r9biBsXujw3OecuLKAnDOycLMzjTIGGPgIcEmZb09+Qk4vMQIASGk6cEFELkLKaqKsIuVCFTJU
 wjcoci9rosaHnnryWkVsK0+Bf+8Mst/VPbJZccNA2RyWVg8Jd7g+y1NujHbqt/lH1DzVzuUlrU
 +cCmy+1XNf1DR3uTCntAAAA
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
X-Proofpoint-ORIG-GUID: xsfCJMpgrS0AD5Yy20VmSrz8O2DdS5q_
X-Proofpoint-GUID: xsfCJMpgrS0AD5Yy20VmSrz8O2DdS5q_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_10,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=691
 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308290116
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- Cover Letter
-     removed internal note
- [PATCH 2/2] mac80211: Use flexible array in struct ieee80211_tim_ie
-     Fixed typo: s/no/now/
- Link to v1: https://lore.kernel.org/r/20230828-ieee80211_tim_ie-v1-0-6d7a4bab70ef@quicinc.com

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

