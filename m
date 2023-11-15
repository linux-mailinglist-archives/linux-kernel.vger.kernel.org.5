Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD157EC4AF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 15:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344115AbjKOOJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 09:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKOOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 09:08:59 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B2DB3;
        Wed, 15 Nov 2023 06:08:56 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFCgZ3E032064;
        Wed, 15 Nov 2023 14:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=E43rW8abNEmb6j0ipQlvTrBofnJJgY2qLpietswJZ6s=;
 b=cClH3ZzvoVIBkwf0c6KSR9/qKMmYSuenfHuuntpUMorN/bQ5MwBGfTFZdBdZ7vua3Jx9
 zUa9HfAbwsnNr98Lg56feXuAQnPOy6Hpd5kOaWQGgRy2O/bQ5gxfMVV1o7uzKm3jd5Nm
 Ixw6TMG6jl3z6RaCfHX8KpIleMKvL7mHjzNRgjFyWr/2+u6V+6IPsK+NdPOFPNIFENKY
 2vWpZiTJKiOzQ7/vdIpbkR/1PQUSBE557yfrQnw/e1KySd41JxnTXxjj/bIDQJbMbkrw
 lgOiXHRR++L9xorJRqDiXlG9NLqwlUZaVeEiUMrUCnY2m2sodYOjGB7Kx3b063X9uM1h UQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucmbahfh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:08:41 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AFE8eCl015943
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Nov 2023 14:08:40 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 15 Nov 2023 06:08:37 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v3 0/6] add qca8084 ethernet phy driver
Date:   Wed, 15 Nov 2023 22:06:24 +0800
Message-ID: <20231115140630.10858-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UqUp-tg-hTFh3LSAaVigv0iWjWbD2Z3o
X-Proofpoint-ORIG-GUID: UqUp-tg-hTFh3LSAaVigv0iWjWbD2Z3o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_12,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=776 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311150109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
	1. pick the two patches to introduce the interface mode
	10g-qxgmii from Vladimir Oltean(olteanv@gmail.com).

	2. add the function phydev_id_is_qca808x to identify the
	PHY qca8081 and qca8084.

	3. update the interface mode name PHY_INTERFACE_MODE_QUSGMII
	to PHY_INTERFACE_MODE_10G_QXGMII.

Luo Jie (4):
  net: phy: at803x: add QCA8084 ethernet phy support
  net: phy: at803x: add the function phydev_id_is_qca808x
  net: phy: at803x: Add qca8084_config_init function
  net: phy: qca8084: add qca8084_link_change_notify

Vladimir Oltean (2):
  net: phylink: move phylink_pcs_neg_mode() to phylink.c
  net: phy: introduce core support for phy-mode = "10g-qxgmii"

 .../bindings/net/ethernet-controller.yaml     |   1 +
 Documentation/networking/phy.rst              |   6 +
 drivers/net/phy/at803x.c                      | 130 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   1 +
 drivers/net/phy/phylink.c                     |  77 ++++++++++-
 include/linux/phy.h                           |   4 +
 include/linux/phylink.h                       |  67 +--------
 7 files changed, 212 insertions(+), 74 deletions(-)


base-commit: bc962b35b139dd52319e6fc0f4bab00593bf38c9
-- 
2.42.0

