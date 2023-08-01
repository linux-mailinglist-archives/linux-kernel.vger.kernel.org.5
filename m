Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB1776B313
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHALXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjHALWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:22:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C2EC7;
        Tue,  1 Aug 2023 04:21:38 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37189J0a015315;
        Tue, 1 Aug 2023 11:21:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=jV34UgqeTpwbC4njYvTOZIRvfhzdVPO+PNcNHQuZut4=;
 b=dchElO3fhQItDkiLFxi4I7m4XG222fgJi36wtLIOdjOCqpvC0b+kw/BG3KkS9jEfU1oY
 1iOzydwzrUJHM3JwxQEg5+UsVfVEfvx1E7jFxlsry9MSZ6/XOZL31m/0oLnOYxssbTcU
 s045hGYH3XlrLKOk8wwJykhvvPYPYoO3IIHFCiIEoHJfopeyY+pZFiq95kEmWLSoc86F
 q209a+HuohgYq2Cu4vnILqKycbYQlvltijz2rOLL2SXwa6vB9oDJAJfrzbiZCftSsYrz
 mFPz/pgMYWFTAE7Xvw8Y30sXS1QniqO3vZpXtm/kZIIOkMtUAb9oSgXJzvhWLAakHsAF Ew== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6a2vbga1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 11:21:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 371BLQrN010000
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 1 Aug 2023 11:21:26 GMT
Received: from hu-ajainp-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Tue, 1 Aug 2023 04:21:20 -0700
From:   Anvesh Jain P <quic_ajainp@quicinc.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Simon Horman <simon.horman@corigine.com>,
        "Kuniyuki Iwashima" <kuniyu@amazon.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andy Ren <andy.ren@getcruise.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Venkata Rao Kakani" <quic_vkakani@quicinc.com>,
        Vagdhan Kumar <quic_vagdhank@quicinc.com>,
        Anvesh Jain P <quic_ajainp@quicinc.com>
Subject: [PATCH] net: export dev_change_name function
Date:   Tue, 1 Aug 2023 16:51:01 +0530
Message-ID: <20230801112101.15564-1-quic_ajainp@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4gzdaoF0T6fEAtMd1JrRkhseghLmD9aN
X-Proofpoint-GUID: 4gzdaoF0T6fEAtMd1JrRkhseghLmD9aN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308010103
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

export dev_change_name function to be used by other modules.

Signed-off-by: Vagdhan Kumar <quic_vagdhank@quicinc.com>
Signed-off-by: Anvesh Jain P <quic_ajainp@quicinc.com>
---
 net/core/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 69a3e544676c..1dad68e2950c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1254,6 +1254,7 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	return err;
 }
+EXPORT_SYMBOL(dev_change_name);
 
 /**
  *	dev_set_alias - change ifalias of a device

base-commit: 0a8db05b571ad5b8d5c8774a004c0424260a90bd
-- 
2.17.1

