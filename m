Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9507531FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 08:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbjGNGcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 02:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbjGNGcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 02:32:11 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCED2713;
        Thu, 13 Jul 2023 23:32:10 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E4qfQr021009;
        Fri, 14 Jul 2023 06:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=MmGhu+/5RRPzkPlPjLdjT//+w2f0Pcq5VDgdzCBOCD8=;
 b=p8dkjBC2Kb2Q9EheQlxaeGtZpqxRRsk7TzixZoAu/lxzphz7qY2Wo4M4m6TNdXYqbdSp
 ro/jwyNBUWNlGLUAUYjJpdtpnI3jdWI8/G7lmPZAWkgpDtmhDifQ94Nsnm7Of/oPR7yT
 lnkSP5QGpE8t8wJk0r74TaD8gHcFuGhuTO+KG752WsVRPrq+ifnA4X/K3SjRSqU6XH5i
 MkhLR5kFzt5NgenCVIeVPOB0pFlBuKFpDEhzm8WIpN7TqwITwH3pjbkf37zSl44TmqEX
 x6obnMbiSq/zNKsn+GHJHZvtgkaD2jsewjfPvdZ5iLdpdDCmPfv1jZkDsyyeHvOrKMpV Bw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpujs0r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 06:31:58 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E6VvKB009296
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 06:31:57 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 23:31:54 -0700
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Luo Jie <quic_luoj@quicinc.com>
Subject: [PATCH v2 0/6] net: phy: at803x: support qca8081 1G version chip
Date:   Fri, 14 Jul 2023 14:31:30 +0800
Message-ID: <20230714063136.21368-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rx322_bbutwS5fDwNb16U2Z2tPWIasM1
X-Proofpoint-ORIG-GUID: rx322_bbutwS5fDwNb16U2Z2tPWIasM1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_03,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=680 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307140059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Luo Jie (6):
  net: phy: at803x: support qca8081 genphy_c45_pma_read_abilities
  net: phy: at803x: merge qca8081 salve seed function
  net: phy: at803x: enable qca8081 slave seed conditionally
  net: phy: at803x: support qca8081 1G chip type
  net: phy: at803x: remove qca8081 1G fast retrain and slave seed config
  net: phy: at803x: add qca8081 fifo reset on the link changed

 drivers/net/phy/at803x.c | 132 +++++++++++++++++++++++++++------------
 1 file changed, 91 insertions(+), 41 deletions(-)


base-commit: def3833fc6022c7f23bd4fd66ba5ed65c6b23272
-- 
2.17.1

