Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46A87EFE02
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 07:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjKRG22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 01:28:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjKRG21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 01:28:27 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17155D5D;
        Fri, 17 Nov 2023 22:28:24 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AI6MOOZ031123;
        Sat, 18 Nov 2023 06:28:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=y3Zz7GCHDFah9QxpNLHMDf5YRAeO9fNs/MMz1Kc2zS0=;
 b=bzkEC6Sh9LSiNXxP2zAW/U/utVDAUIxAb4dCapg9H36vd1ZvjSWM5spBGT9gdIbeM7qJ
 fLPHVN9xKxZjBnIO9E/7kRSwIuClZHbTr1FKmJJ/q1hn3D6kKLPSZG/cKE8p+c8wEmO9
 Ucm+6z7NndZXv1I9vZK9ydOwk2M4AFoBSBbj2yxxNIkenMMA1BqB9EWqi0mVWKswSNX8
 NGtqVOJ+GZLoG+vXwD8vDBulQgnTP4bZsDDKByrXqFw+nPDtrv4QDsQqzqOCuqmkviFH
 91UoZqlhDHTXMOYT+5dsZjj+XkxYstRJVVcR4aTD3pm+RJUKU9TyO3Qw9t9seIqYItNr zQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uem80g8rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 06:28:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AI6S7Am017661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 18 Nov 2023 06:28:07 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 17 Nov 2023 22:28:03 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v5 0/6] add qca8084 ethernet phy driver
Date:   Sat, 18 Nov 2023 14:27:48 +0800
Message-ID: <20231118062754.2453-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _9XxuwS-eAsb7qcFOKPmGfEQ8WWrOf4z
X-Proofpoint-ORIG-GUID: _9XxuwS-eAsb7qcFOKPmGfEQ8WWrOf4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-18_04,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=638
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311180045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Changes in v5:
	* update the author of the patch below.
	  <introduce core support for phy-mode = "10g-qxgmii">.

Luo Jie (4):
  net: phy: at803x: add QCA8084 ethernet phy support
  net: phy: at803x: add the function phydev_id_is_qca808x
  net: phy: at803x: Add qca8084_config_init function
  net: phy: qca8084: add qca8084_link_change_notify

Vladimir Oltean (2):
  net: phy: introduce core support for phy-mode = "10g-qxgmii"
  dt-bindings: net: ethernet-controller: add 10g-qxgmii mode

 .../bindings/net/ethernet-controller.yaml     |   1 +
 Documentation/networking/phy.rst              |   6 +
 drivers/net/phy/at803x.c                      | 130 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   1 +
 drivers/net/phy/phylink.c                     |  11 +-
 include/linux/phy.h                           |   4 +
 include/linux/phylink.h                       |   2 +
 7 files changed, 147 insertions(+), 8 deletions(-)


base-commit: eff99d8edbed7918317331ebd1e365d8e955d65e
-- 
2.42.0

