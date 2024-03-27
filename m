Return-Path: <linux-kernel+bounces-120766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F63088DCBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1828A1F2B98B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7981292EA;
	Wed, 27 Mar 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Q0ba12QM"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF3127B63;
	Wed, 27 Mar 2024 11:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711539694; cv=none; b=GkUDpC3CM3Oc2H1kKq7pRwFjWG1fLHqHfbhROvNk4rSAIBLZsS8yO/vJwdDlibbyw60m2SKRJphyjVyQibtsMGfojHZ1rnLPJ3ydSnwUIGHT2YBvx/3sLrDYANhxrbdDQoJCpUx9aFOmCsH6C136jJh7uNIXiqX6IHEM2UMkVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711539694; c=relaxed/simple;
	bh=8S10TShbK7NVAgLMK/uY9/tW32bHuspxRSfeBNPPsco=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c30C/ZTEdt/Z8f3ky1BlTnUgr8J4JfEq/HzoGvg8Qv90NOWZa6lUyKw0XE4QQ/aliBCYL7Itu7+2F2iIzOqHq62TjrbBiEgix0+3X5+/YNt1efZqslCPFle/0weNsQKKjYGI86OQsl40K80I1hIbTxJ+qlzaU1sReB6WiGLnHYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Q0ba12QM; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42RBewSo017493;
	Wed, 27 Mar 2024 06:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711539658;
	bh=UgBAmGa0xTUagxwLDTjgPxO9yR714D/ocgy+2OQSpwk=;
	h=From:To:CC:Subject:Date;
	b=Q0ba12QM9msCoeqNEJe1rvaBYe8/NCsMp/T37zM6pTKdAFEr50bUdSrHG8LKS/z38
	 dAkCS6ihFRSY+PZV0qWbKCeq1Hc4Hie5k5FTviO3lwbbdALezkITtru3RBKeOFFDyD
	 ETT2Mes3D8EeBffACT945IdTscJVeDbRElsIW/Fw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42RBew2w010203
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Mar 2024 06:40:58 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Mar 2024 06:40:57 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Mar 2024 06:40:58 -0500
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42RBevBc002603;
	Wed, 27 Mar 2024 06:40:57 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 42RBev9E025437;
	Wed, 27 Mar 2024 06:40:57 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: Diogo Ivo <diogo.ivo@siemens.com>, Rob Herring <robh@kernel.org>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>, Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [PATCH net-next v3 0/3] Introduce switch mode support for ICSSG driver
Date: Wed, 27 Mar 2024 17:10:51 +0530
Message-ID: <20240327114054.1907278-1-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This series adds support for switch-mode for ICSSG driver. This series
also introduces helper APIs to configure firmware maintained FDB
(Forwarding Database) and VLAN tables. These APIs are later used by ICSSG
driver in switch mode.

Now the driver will boot by default in dual EMAC mode. When first ICSSG
interface is added to bridge driver will still be in EMAC mode. As soon as
second ICSSG interface is added to same bridge, switch-mode will be
enabled and switch firmwares will be loaded to PRU cores. The driver will
remain in dual EMAC mode if ICSSG interfaces are added to two different
bridges or if two differnet interfaces (One ICSSG, one other) is added to
the same bridge. We'll only enable is_switch_mode flag when two ICSSG
interfaces are added to same bridge.

We start in dual MAC mode. Let's say lan0 and lan1 are ICSSG interfaces

ip link add name br0 type bridge
ip link set lan0 master br0

At this point, we get a CHANGEUPPER event. Only one port is a member of
the bridge, so we will still be in dual MAC mode.

ip link set lan1 master br0

We get a second CHANGEUPPER event, the second interface lan1 is also ICSSG
interface so we will set the is_switch_mode flag and when interfaces are
brought up again, ICSSG switch firmwares will be loaded to PRU Cores.

There are some other cases to consider as well. 

ip link add name br0 type bridge
ip link add name br1 type bridge

ip link set lan0 master br0
ip link set ppp0 master br0

Here we are adding lan0 (ICSSG) and ppp0 (non ICSSG) to same bridge, as
they both are not ICSSG, we will still be running in dual EMAC mode.

ip link set lan1 master br1
ip link set vpn0 master br1

Here we are adding lan1 (ICSSG) and vpn0 (non ICSSG) to same bridge, as
they both are not ICSSG, we will still be running in dual EMAC mode.


This is v2 of the series [1]. It addresses commenst made on v1 [1].

Changes from v2 [2] to v3:
*) Dropped RFC tag.
*) Used ether_addr_copy() instead of manually copying mac address using
   for loop in patch 1/3 as suggested by Andrew Lunn <andrew@lunn.ch>
*) Added helper API icssg_fdb_setup() in patch 1/3 to reduce code
   duplication as suggested by Andrew Lunn <andrew@lunn.ch>
*) In prueth_switchdev_stp_state_set() removed BR_STATE_LEARNING as
   learning without forwarding is not supported by ICSSG firmware.
*) Used ether_addr_equal() wherever possible in patch 2/3 as suggested
   by Andrew Lunn <andrew@lunn.ch>
*) Fixed typo "nit: s/prueth_switchdevice_nb/prueth_switchdev_nb/" in
   patch 2/3 as suggested by Simon Horman <horms@kernel.org>
*) Squashed "#include "icssg_mii_rt.h" to patch 2/3 from patch 3/3 as
   suggested by Simon Horman <horms@kernel.org>
*) Rebased on latest net-next/main.

Changes from v1 to v2:
*) Removed TAPRIO support patch from this series.
*) Stopped using devlink for enabling switch-mode as suggested by Andrew L
*) Added read_poll_timeout() in patch 1 / 3 as suggested by Andrew L.

[1] https://lore.kernel.org/all/20230830110847.1219515-4-danishanwar@ti.com/
[2] https://lore.kernel.org/all/20240118071005.1514498-1-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (3):
  net: ti: icssg-prueth: Add helper functions to configure FDB
  net: ti: icssg-switch: Add switchdev based driver for ethernet switch
    support
  net: ti: icssg-prueth: Add support for ICSSG switch firmware

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 306 ++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  26 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 199 +++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  36 ++
 .../net/ethernet/ti/icssg/icssg_switchdev.c   | 477 ++++++++++++++++++
 .../net/ethernet/ti/icssg/icssg_switchdev.h   |  13 +
 8 files changed, 1048 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.h


base-commit: 237bb5f7f7f55ec5f773469a974c61a49c298625
-- 
2.34.1


