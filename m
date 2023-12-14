Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412FF812BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443525AbjLNJsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjLNJsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:48:42 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830D6E0;
        Thu, 14 Dec 2023 01:48:48 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE4Qpbg001177;
        Thu, 14 Dec 2023 09:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=5gAIgXH
        XeRin2mY+3nShzO93vkScwEPkafSycd779B0=; b=GhDRMXiOI2oQt1NUXTi/fVK
        zYR8P+l3guWUMrjWhvf05gfaNQMqucmb167oXUWLx2W+3LlAjPWftDnS7c1SDjAa
        fLRl9/fH3dmLfI8bNlmQWSvKN+zE680aj2soYCOBbyRnx6iBtfjedXYx3UradpeZ
        D50PtrRq2DMlNjHf134ZZaC3tzyVOV/U3jH/QYsjmvkDdoUdSOTmvqbSinyMKrJh
        7TNEM7JjcUeMnP4kKLdtStdP8k8D9HMkbI9zz3HZeRXrzsOBNcLF2ej+GKKXxsJD
        qkhrbolMlHSmYGik3KO/TPqPqhDzY27mfxRLvgsL4SJ3q0rt6EslndSdATHHzmw=
        =
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynja94p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:48:28 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9mRlT000717
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:48:27 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:48:22 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 00/14] add qca8084 ethernet phy driver
Date:   Thu, 14 Dec 2023 17:47:59 +0800
Message-ID: <20231214094813.24690-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: XHYkJ8TAGLrIFIgXHOeOiDABrmoi6RgO
X-Proofpoint-ORIG-GUID: XHYkJ8TAGLrIFIgXHOeOiDABrmoi6RgO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 mlxlogscore=905 mlxscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312140065
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
For PHY mode, PCS1 works on qusgmii mode.
The fourth PHY connected with PCS0 works on sgmii mode.

Besides this PHY driver patches, the PCS driver is also needed
to bring up the qca8084 device, which mainly configurs PCS
and clocks.

The qca8084 PHY driver depends on the following clock controller
patchset, the initial clocks and resets are provided by the clock
controller driver below.
https://lore.kernel.org/lkml/20231104034858.9159-2-quic_luoj@quicinc.com/T/

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

Changes in v6:
	* drop the "inline" keyword.
	* apply the patches with "--max-line-length=80".

Changes in v7:
	* add possible interfaces of phydev
	* customize phy address
	* add initialized clock & reset config
	* add the work mode config
	* update qca,ar803x.yaml for the new added properties

Luo Jie (12):
  net: phy: at803x: add QCA8084 ethernet phy support
  net: phy: at803x: add the function phydev_id_is_qca808x
  net: phy: at803x: Add qca8084_config_init function
  net: phy: at803x: add qca8084_link_change_notify
  net: phy: at803x: add the possible_interfaces
  net: phy: at803x: add qca8084 switch registe access
  net: phy: at803x: set MDIO address of qca8084 PHY
  net: phy: at803x: parse qca8084 clocks and resets
  net: phy: at803x: add qca808x initial config sequence
  net: phy: at803x: configure qca8084 common clocks
  net: phy: at803x: configure qca8084 work mode
  dt-bindings: net: ar803x: add qca8084 PHY propetry

Vladimir Oltean (2):
  net: phy: introduce core support for phy-mode = "10g-qxgmii"
  dt-bindings: net: ethernet-controller: add 10g-qxgmii mode

 .../bindings/net/ethernet-controller.yaml     |   1 +
 .../devicetree/bindings/net/qca,ar803x.yaml   | 158 ++++-
 Documentation/networking/phy.rst              |   6 +
 drivers/net/phy/at803x.c                      | 586 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   1 +
 drivers/net/phy/phylink.c                     |  11 +-
 include/linux/phy.h                           |   4 +
 include/linux/phylink.h                       |   2 +
 8 files changed, 758 insertions(+), 11 deletions(-)


base-commit: 48e8992e33abf054bcc0bb2e77b2d43bb899212e
-- 
2.42.0

