Return-Path: <linux-kernel+bounces-542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC0E8142A9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48648B22C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004B410949;
	Fri, 15 Dec 2023 07:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GIQR3pZs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEE19445;
	Fri, 15 Dec 2023 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF6DIoG002558;
	Fri, 15 Dec 2023 07:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=cc46bw1
	4xJuIpwN3HCYVxNwMWDOdvELnA7ZzC1YJuPk=; b=GIQR3pZskWkwUmucLjO7/6X
	4spcm/Bn6Ve+0MyhMU+Bc9fB/W8MUjRLl2+0U20SMeZgqeqfFmlsVtlbunyj4eEj
	LP0iE38xFJgjUBytVmlKYH5pI5ulbv0PjaUtlXE24IKxrWF/fJkmxyF4FsFswS8j
	Vae4D+XP4UW3bympwmYGQA/n0wFynJMufy1cWSg+6yn8EDdhEPVJwhmN7wv/pFcG
	7Ngkr8uYG2U426d3TBsbn5BoYBLsdaOvqwAVbEkcSk1yluvDPjklnOlyg515GOQ2
	3+XShZT62Hozoa5aNus0OPkGqBciC9keKAPH7jNNuEE/TTr/lk+lHEuqJw2n4vg=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0hb1r6km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:40:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF7eQwU002232
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 07:40:26 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 23:40:22 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v8 00/14] add qca8084 ethernet phy driver
Date: Fri, 15 Dec 2023 15:39:50 +0800
Message-ID: <20231215074005.26976-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9Rao9__cIlWVS5ATnGxIwedAexYJD9KF
X-Proofpoint-ORIG-GUID: 9Rao9__cIlWVS5ATnGxIwedAexYJD9KF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxlogscore=954 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312150047

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

Changes in v7:
	* updated the patcheset based on the latest code

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
  dt-bindings: net: ar803x: add qca8084 PHY properties

Vladimir Oltean (2):
  net: phy: introduce core support for phy-mode = "10g-qxgmii"
  dt-bindings: net: ethernet-controller: add 10g-qxgmii mode

 .../bindings/net/ethernet-controller.yaml     |   1 +
 .../devicetree/bindings/net/qca,ar803x.yaml   | 158 ++++-
 Documentation/networking/phy.rst              |   6 +
 drivers/net/phy/at803x.c                      | 577 +++++++++++++++++-
 drivers/net/phy/phy-core.c                    |   1 +
 drivers/net/phy/phylink.c                     |  11 +-
 include/linux/phy.h                           |   4 +
 include/linux/phylink.h                       |   2 +
 8 files changed, 752 insertions(+), 8 deletions(-)


base-commit: 17cb8a20bde66a520a2ca7aad1063e1ce7382240
-- 
2.42.0


