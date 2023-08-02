Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F29C76D898
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbjHBUW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjHBUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:22:19 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BAF268F;
        Wed,  2 Aug 2023 13:22:16 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372FVvh9010627;
        Wed, 2 Aug 2023 20:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id; s=pps0720;
 bh=G0kiRdSmBdyx4TfhxwwXuA3DkCJaC8w3wSHrV5TtevA=;
 b=losdoeyMauHKGt0wydRV31KeTYN3hmJ9cixTbBQwjdm69XrvUe64/9Rnvvf0CrXjLvsR
 gsTsHDYLUOvJejw5FHREL8c3pboJ3vWi3sRagLcNdr+swGk0gdRK3RhFoozYUSzAvo5l
 3aRK21DjB/zdx5QrWJKKkmp9pkE5iX3Opxi5D1peRcy08MiWJNCZV6RDJEUwlLL4Tl7h
 p5Ay3BQCQF5dIbJHIcIZHVDJ6gpTuDxMqrAFaQWKGVssngsWRfgN6X4s/43u3MvOhnCi
 1X9opa5Xotm/F/NJhdRsiRr4tzEChpK3RMrm/e5hmg4q7gZHi0wlHg/Zz4gg5hb2+qL/ YQ== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3s7hb76myd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 20:21:55 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id D2B07800187;
        Wed,  2 Aug 2023 20:21:53 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 4656580E885;
        Wed,  2 Aug 2023 20:21:52 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     christophe.jaillet@wanadoo.fr, simon.horman@corigine.com,
        andrew@lunn.ch, verdun@hpe.com, nick.hawkins@hpe.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] ARM: Add GXP UMAC Support
Date:   Wed,  2 Aug 2023 15:18:19 -0500
Message-Id: <20230802201824.3683-1-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
X-Proofpoint-GUID: x9Sy7t70ZgbTuaig2oIaHBpPQUSxddJI
X-Proofpoint-ORIG-GUID: x9Sy7t70ZgbTuaig2oIaHBpPQUSxddJI
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_16,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 mlxscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308020178
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
on the two SERDES interface connections. In most cases the internal
phy connects directly to the external phy.

---

Changes since v1:
 *Corrected improper descriptions and use of | in yaml files
 *Used reverse christmas tree format for network drivers
 *Moved gxp-umac-mdio.c to /mdio/
 *Fixed dependencies on both Kconfigs
 *Added COMPILE_TEST to both Kconfigs
 *Used devm_ functions where possible in both drivers
 *Moved mac-address to inside of port in yaml files
 *Exchanged listing individual yaml files for hpe,gxp*
 *Restricted use of le32

Nick Hawkins (5):
  dt-bindings: net: Add HPE GXP UMAC MDIO
  net: hpe: Add GXP UMAC MDIO
  dt-bindings: net: Add HPE GXP UMAC
  net: hpe: Add GXP UMAC Driver
  MAINTAINERS: HPE: Add GXP UMAC Networking Files

 .../bindings/net/hpe,gxp-umac-mdio.yaml       |  50 +
 .../devicetree/bindings/net/hpe,gxp-umac.yaml | 112 +++
 MAINTAINERS                                   |   2 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/hpe/Kconfig              |  32 +
 drivers/net/ethernet/hpe/Makefile             |   1 +
 drivers/net/ethernet/hpe/gxp-umac.c           | 889 ++++++++++++++++++
 drivers/net/ethernet/hpe/gxp-umac.h           |  89 ++
 drivers/net/mdio/Kconfig                      |  13 +
 drivers/net/mdio/Makefile                     |   1 +
 drivers/net/mdio/mdio-gxp-umac.c              | 142 +++
 12 files changed, 1333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac-mdio.yaml
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
 create mode 100644 drivers/net/ethernet/hpe/Kconfig
 create mode 100644 drivers/net/ethernet/hpe/Makefile
 create mode 100644 drivers/net/ethernet/hpe/gxp-umac.c
 create mode 100644 drivers/net/ethernet/hpe/gxp-umac.h
 create mode 100644 drivers/net/mdio/mdio-gxp-umac.c

-- 
2.17.1

