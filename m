Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5A78F27F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 20:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242634AbjHaSXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 14:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbjHaSXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 14:23:23 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC272E63;
        Thu, 31 Aug 2023 11:23:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37VDusal019670;
        Thu, 31 Aug 2023 18:23:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=6jtt+DhViAJuO+cKOsP8zuY5qDC3CpI+xO5LQW5CWys=;
 b=nx4pZMxLlzHi0j0UXAs455t35DQVQoSnpUfl76Z0gEDQBQm/l4SAc7Ziz6Zo3F6Z2ULD
 7hMd0t8f0ythUHN+B3CznjH58cANWvr+1JTrNHRp4dOLSoNrwQlJZZxUvNpW+S0qS+Kx
 fVXhFHjB2aTJZxAESvEGi+hH0ilYKsDlFRYGMBvPgvFr8VwnMYbifUrPjhqtfkL7bED1
 FOfe4yrz4OEnZOdKhZjwDAuLR/pWgjYxqmhBNLMnu2Hk77qNWhwQlM2sOgrdfVpdAhac
 FsNPSW7aJDiIFO++sxgy+W8CiXSIxS0I9fDcXuZuGNSRi4kWWfM8yCxls9x7V16nakUv IA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3stku29xrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 18:23:04 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37VIN24S010469
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 18:23:02 GMT
Received: from hu-jjohnson-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Thu, 31 Aug 2023 11:23:00 -0700
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3 0/2] wifi: Fix struct ieee80211_tim_ie::virtual_map
Date:   Thu, 31 Aug 2023 11:22:56 -0700
Message-ID: <20230831-ieee80211_tim_ie-v3-0-e10ff584ab5d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDa8GQC/32OzQ6CMBAGX4X0bE1/EIon38MYUtqt7EHQFhsN4
 d0txIMk6nE2mfl2JAE8QiD7bCQeIgbsuwRykxHT6u4MFG1iIpiQTIkdRQBQTHBeD3ipESiTFc8
 l004WliTt6sHhY0keT4lbDEPvn8tC5PP1TyxyyqhQpgTJpRWVPdzuaLAzW9Nf5vpbVT/UwpY6b
 3RTMnArdf4kis/16ktCpISz2vHKNdwwWCemaXoBA78z8TABAAA=
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
X-Proofpoint-GUID: ahr65fjEb7W4kcJd_KvteSgdgJHISFft
X-Proofpoint-ORIG-GUID: ahr65fjEb7W4kcJd_KvteSgdgJHISFft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-31_16,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=649
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308310164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To align with [1] change struct ieee80211_tim_ie::virtual_map to be a
flexible array.

As a precursor, add a size check in a place where one is currently
missing.

[1] https://docs.kernel.org/process/deprecated.html#zero-length-and-one-element-arrays

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v3:
- [PATCH 2/2] mac80211: Use flexible array in struct ieee80211_tim_ie
-     Complete rewrite based upon v2 discussion. As a result no driver changes are required
- Link to v2: https://lore.kernel.org/r/20230829-ieee80211_tim_ie-v2-0-fdaf19fb1c0e@quicinc.com

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

 drivers/net/wireless/st/cw1200/txrx.c |  2 +-
 include/linux/ieee80211.h             | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)
---
base-commit: b32add2d20ea6e62f30a3c0a7c2fb306ec5ceb3d
change-id: 20230825-ieee80211_tim_ie-0391430af36d

