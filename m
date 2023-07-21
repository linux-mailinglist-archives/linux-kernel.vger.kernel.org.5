Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C05875D678
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGUVYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjGUVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:24:42 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8C930D2;
        Fri, 21 Jul 2023 14:24:41 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LICQxF014910;
        Fri, 21 Jul 2023 21:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=nKGvPBx2yFBX7COtgnGBjTxJ1k51VWFzz7cx9JV3PLg=;
 b=Iqzc0WNIPrfc7wnDa62+LcxS7RQZFs7dmkj9QekyLZMwtRKyVcoJxqvamLDu6AxKWX1F
 1nVzI72/oXvpPT+IqBtb50ekI3E8CBZAZrv8UBs5OBHQB13ly//QfrPZgLZv0AunwqIe
 1/dThq3sDGnRkPnq39RdpMh4QWcgymL7SuCGXeK8hmETpOHnpiOUZGHA/44bVsYk0gZu
 ivNVx89e6SN9UF3d7UJsh0duhr6eZQRHo1svk5cLW6wEBlqlLZSmOK6vNqwIWOIwxSFA
 fPRtQn6LSH84gK2K/PJNKkIk3uPAlHIVmO9I57cOwCggWQ2W3VN2PekCE5PnDSfdRJQS Rw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ryw2ft9t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 21:24:27 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id C0F3F8047B2;
        Fri, 21 Jul 2023 21:24:26 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id ACDD0809FDC;
        Fri, 21 Jul 2023 21:24:25 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] ARM: Add GXP UMAC Support
Date:   Fri, 21 Jul 2023 16:20:39 -0500
Message-Id: <20230721212044.59666-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: FHhWNBQ5bGc6_iRzHglAskMVV9-IQxT_
X-Proofpoint-ORIG-GUID: FHhWNBQ5bGc6_iRzHglAskMVV9-IQxT_
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_12,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=924 impostorscore=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210189
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP contains two Ethernet MACs that can be
connected externally to several physical devices. From an external
interface perspective the BMC provides two SERDES interface connections
capable of either SGMII or 1000Base-X operation. The BMC also provides
a RMII interface for sideband connections to external Ethernet controllers.

The primary MAC (umac0) can be mapped to either SGMII/1000-BaseX
SERDES interface.  The secondary MAC (umac1) can be mapped to only
the second SGMII/1000-Base X Serdes interface or it can be mapped for
RMII sideband.

The MDIO(mdio0) interface from the primary MAC (umac0) is used for
external PHY status and configuration. The MDIO(mdio1) interface from
the secondary MAC (umac1) is routed to the SGMII/100Base-X IP blocks
on the two SERDES interface connections.

Nick Hawkins (5):
  dt-bindings: net: Add HPE GXP UMAC MDIO
  net: hpe: Add GXP UMAC MDIO
  dt-bindings: net: Add HPE GXP UMAC
  net: hpe: Add GXP UMAC Driver
  MAINTAINERS: HPE: Add GXP UMAC Networking Files

 .../bindings/net/hpe,gxp-umac-mdio.yaml       |  51 +
 .../devicetree/bindings/net/hpe,gxp-umac.yaml | 111 +++
 MAINTAINERS                                   |   3 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/hpe/Kconfig              |  43 +
 drivers/net/ethernet/hpe/Makefile             |   2 +
 drivers/net/ethernet/hpe/gxp-umac-mdio.c      | 158 +++
 drivers/net/ethernet/hpe/gxp-umac.c           | 911 ++++++++++++++++++
 drivers/net/ethernet/hpe/gxp-umac.h           |  89 ++
 10 files changed, 1370 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
 create mode 100644 drivers/net/ethernet/hpe/Kconfig
 create mode 100644 drivers/net/ethernet/hpe/Makefile
 create mode 100644 drivers/net/ethernet/hpe/gxp-umac-mdio.c
 create mode 100644 drivers/net/ethernet/hpe/gxp-umac.c
 create mode 100644 drivers/net/ethernet/hpe/gxp-umac.h

-- 
2.17.1

