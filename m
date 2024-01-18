Return-Path: <linux-kernel+bounces-29755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0138312F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21D4E284DE7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C12EB670;
	Thu, 18 Jan 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BRVFcYNr"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D233B8F60;
	Thu, 18 Jan 2024 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705561844; cv=none; b=XHApRpKPWbWs447KjNZ3asWzvM6hqQqAHXe7yxKx0xhrDKiif0T/15erN+Jmw9zvPBdCFeWKwFtxzCb6Xp5piuwcFP8H0hlnaw+C/Jcu6CwtO8ASZL7HgM4efdy9JtJhPxvKmts9dZxu85nLELllnRSsspaAltVSqmbsUtkW9H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705561844; c=relaxed/simple;
	bh=J8zc81nhbkLlTLipfew74s88Z8Cv2qw0+nFpchu13Uw=;
	h=Received:DKIM-Signature:Received:Received:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EXCLAIMER-MD-CONFIG; b=nvv0neM1zvgzdMbkuwAjSoT2yB0kF6sJYpePh8yKW9y6TFV0ENbDnEzldbv0Uu2LR1t9MYznU8gwwzS7kX3umoS6HbynnRN4t4npS8zKbiWayJ9Wx1octloaNhE8VRag7Lc1Nvom31/YIFPcRfMZXwQRJIZG4McWIN/k7azlSss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BRVFcYNr; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40I7AAqr057376;
	Thu, 18 Jan 2024 01:10:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1705561810;
	bh=6de9bFeDnbDOTZiEP3LK+M5NI1s1zpjMrH0ph0gxBLY=;
	h=From:To:CC:Subject:Date;
	b=BRVFcYNrfB98znpVWWxOZqcgiArrwlvs88K4tSOxJdf8Z5o+iFwfzBX3MwIV+vR4G
	 3PQ92Wg22nfTdGOYzQiSdEwMYoa40wgGFO1vgUNkKtqPgXxTo6ZJw88VnGwJRBwt3a
	 CrCEYe7jkN4YhsEvtEAWhlilEXJm3pPdxzKmT5ss=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40I7AAph011337
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 18 Jan 2024 01:10:10 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 18
 Jan 2024 01:10:09 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 18 Jan 2024 01:10:09 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40I7A9dD046844;
	Thu, 18 Jan 2024 01:10:09 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 40I7A8qb021965;
	Thu, 18 Jan 2024 01:10:09 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: Rob Herring <robh@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>, Andrew Lunn <andrew@lunn.ch>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        Wolfram Sang
	<wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Grygorii
 Strashko" <grygorii.strashko@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Eric
 Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH v2 0/3] Introduce switch mode support for ICSSG driver
Date: Thu, 18 Jan 2024 12:40:02 +0530
Message-ID: <20240118071005.1514498-1-danishanwar@ti.com>
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

We get a second CHANGEUPPER event, the secind interface lan1 is also ICSSG
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

Changes from v1 to v2:
*) Removed TAPRIO support patch from this series.
*) Stopped using devlink for enabling switch-mode as suggested by Andrew L
*) Added read_poll_timeout() in patch 1 / 3 as suggested by Andrew L.

[1] https://lore.kernel.org/all/20230830110847.1219515-4-danishanwar@ti.com/

Thanks and Regards,
Md Danish Anwar

MD Danish Anwar (3):
  net: ti: icssg-prueth: Add helper functions to configure FDB
  net: ti: icssg-switch: Add switchdev based driver for ethernet switch
    support
  net: ti: icssg-prueth: Add support for ICSSG switch firmware

 drivers/net/ethernet/ti/Kconfig               |   1 +
 drivers/net/ethernet/ti/Makefile              |   3 +-
 drivers/net/ethernet/ti/icssg/icssg_config.c  | 324 +++++++++++-
 drivers/net/ethernet/ti/icssg/icssg_config.h  |  26 +
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  | 199 +++++++-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |  36 ++
 .../net/ethernet/ti/icssg/icssg_switchdev.c   | 478 ++++++++++++++++++
 .../net/ethernet/ti/icssg/icssg_switchdev.h   |  13 +
 8 files changed, 1067 insertions(+), 13 deletions(-)
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.c
 create mode 100644 drivers/net/ethernet/ti/icssg/icssg_switchdev.h

-- 
2.34.1


