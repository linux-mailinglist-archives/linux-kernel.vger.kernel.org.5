Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ECE754DE1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjGPIuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 04:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjGPIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 04:50:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B227D1;
        Sun, 16 Jul 2023 01:50:07 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36G8hoFj023888;
        Sun, 16 Jul 2023 08:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=hDdXCZERYfn71furWI3uaJ1k/v+9hd+rEY7GuQAcRG8=;
 b=AXpDU1QVLtv/AIKZIpqnn3+mytTGNsjeQVQNTIEhUMn8AThcE8TV4WA7cYUyjGQiIgQI
 Wb6218l5dogy0cyggrfyG9si+ZlFLCYxawRG/4RMN94xUWXFeEs5Rzb8qpf0eTFyqZW7
 QWdfYlWqP6p567FSMn1QaOFUU03DAE4HKf4sSjvDCzi+iBbvd0DJyiQG0n0IHBHkDAhg
 49qxiRotPttDZ0/oJKPP2c8AbmGBJpa+jHHYrLpm11l9O3DpoeRzougKFMJ09E+Nl6nw
 Phti13ADwuIlMK/muAGUHKEF8xpfdByx8kP+yNHlVoKKHhS2G+0AvFrYm61T2hO7bpFi sA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run1k19bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:49:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36G8npUN000935
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Jul 2023 08:49:51 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Sun, 16 Jul 2023 01:49:48 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v3 0/6] net: phy: at803x: support qca8081 1G version chip
Date:   Sun, 16 Jul 2023 16:49:18 +0800
Message-ID: <20230716084924.9714-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VpL7UIZoBMQsaL49jnmw90laqrUGQCrU
X-Proofpoint-ORIG-GUID: VpL7UIZoBMQsaL49jnmw90laqrUGQCrU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_14,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxlogscore=677 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307160081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add supporting qca8081 1G version chip, the 1G version
chip can be identified by the register mmd7.0x901d bit0.

In addition, qca8081 does not support 1000BaseX mode and the sgmii fifo
reset is added on the link changed, which assert the fifo on the link
down, deassert the fifo on the link up.

Changes in v1:
	* switch to use genphy_c45_pma_read_abilities.
	* remove the patch [remove 1000BaseX mode of qca8081].
	* move the sgmii fifo reset to link_change_notify.

Changes in v2:
	* split the qca8081 1G chip support patch.
	* improve the slave seed config, disable it if master preferred.

Changes in v3:
	* fix the comments.
	* add the help function qca808x_has_fast_retrain_or_slave_seed.

Luo Jie (6):
  net: phy: at803x: support qca8081 genphy_c45_pma_read_abilities
  net: phy: at803x: merge qca8081 slave seed function
  net: phy: at803x: enable qca8081 slave seed conditionally
  net: phy: at803x: support qca8081 1G chip type
  net: phy: at803x: remove qca8081 1G fast retrain and slave seed config
  net: phy: at803x: add qca8081 fifo reset on the link changed

 drivers/net/phy/at803x.c | 135 +++++++++++++++++++++++++++------------
 1 file changed, 95 insertions(+), 40 deletions(-)


base-commit: 68af900072c157c0cdce0256968edd15067e1e5a
-- 
2.17.1

