Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B5D7EDFA6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbjKPLZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345083AbjKPLZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:25:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62118E0;
        Thu, 16 Nov 2023 03:25:16 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGAXI6r013372;
        Thu, 16 Nov 2023 11:25:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=/ooACc8jx1rN0v4nvJOZ7IzOnyVXEda+38RURk8IomU=;
 b=R6BA0qW0nJkOzOhEeQT+qN8L081L5SybyzNjRHxbOICd/LTL4p6yKrRiSlVIZT/T4U5D
 goCVMXREhugTlBA1+ro+lGrrhxg2QKJnhXpQvdWq4qyJSzzRL/GJUwPNXph0LYmBDtEu
 cX3DEFkzD3r+sINMyndwkoTpJI+AF64k7Ac5+bJvlq19xnzMPL2OFOQShG5w0zQfRovn
 gQG4O4HZ6nPYR5kWg3zedj2Ifr35JScftY3LXWLvOd0iwGxQzV/iB6iz20srICSkjEey
 nE2gqE5gEm5mqikeTZcIp9Ut1bCqrNAjk2qHojhNhkLRTUTtU2ePorQH2Cf5JSHj+8WB qg== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udhe1r32j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 11:25:02 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGBP1x9015792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 11:25:01 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 16 Nov 2023 03:24:57 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v4 0/6] add qca8084 ethernet phy driver
Date:   Thu, 16 Nov 2023 19:24:31 +0800
Message-ID: <20231116112437.10578-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8MM2JxxeT1WhJHQQMKpWI28DIDtTpXuX
X-Proofpoint-ORIG-GUID: 8MM2JxxeT1WhJHQQMKpWI28DIDtTpXuX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxlogscore=661
 clxscore=1015 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160091
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCA8084 is four-port PHY with maximum link capability 2.5G,
which supports the interface mode qusgmii and sgmii mode,
there are two PCSs available to connected with ethernet port.

QCA8084 can work in switch mode or PHY mode.
For switch mode, both PCS0 and PCS1 work on sgmii mode.
For PHY mode, PCS1 works on qusgmii mode, the last port
(the fourth port) works on sgmii mode.

Besides this PHY driver patches, the PCS driver is also needed
to bring up the qca8084 device, which mainly configurs PCS
and clocks.

Changes in v3:
	* pick the two patches to introduce the interface mode
	  10g-qxgmii from Vladimir Oltean(olteanv@gmail.com).
	* add the function phydev_id_is_qca808x to identify the
	  PHY qca8081 and qca8084.
	* update the interface mode name PHY_INTERFACE_MODE_QUSGMII
	  to PHY_INTERFACE_MODE_10G_QXGMII.

Changes in v4:
	* remove the following patch:
	  <net: phylink: move phylink_pcs_neg_mode() to phylink.c>.
	* split out 10g_qxgmii change of ethernet-controller.yaml.

Luo Jie (5):
  dt-bindings: net: ethernet-controller: add 10g-qxgmii mode
  net: phy: at803x: add QCA8084 ethernet phy support
  net: phy: at803x: add the function phydev_id_is_qca808x
  net: phy: at803x: Add qca8084_config_init function
  net: phy: qca8084: add qca8084_link_change_notify

Vladimir Oltean (1):
  net: phy: introduce core support for phy-mode = "10g-qxgmii"

 .../bindings/net/ethernet-controller.yaml     |   1 +
 Documentation/networking/phy.rst              |   6 +
 drivers/net/phy/at803x.c                      | 130 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   1 +
 drivers/net/phy/phylink.c                     |  11 +-
 include/linux/phy.h                           |   4 +
 include/linux/phylink.h                       |   2 +
 7 files changed, 147 insertions(+), 8 deletions(-)


base-commit: f31817cbcf48d191faee7cebfb59197d2048cd64
-- 
2.42.0

