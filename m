Return-Path: <linux-kernel+bounces-151161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BE98AAA21
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C6E28242F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF2856477;
	Fri, 19 Apr 2024 08:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EBOctmOK"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9104AED9;
	Fri, 19 Apr 2024 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515229; cv=none; b=XmQAlRopRD3xqKdyhmcfXupbWtgJjkWHpw0PKYOA8EZUh4jCkjitnaY//qjhNRyxL0k+2XlPJQ7d7ZTtH0JHYirVSvTkX6DJnVPgUrhtYiC8X2YeEDr+/a/rWwSyIXaot1xG6rP+JuwBG2c4bt4b01bLPB1+14QQ/JKJkHARii4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515229; c=relaxed/simple;
	bh=ofgIfXEUZyXIhhEeNyNeHg/vT25Lnt/08niZkgCBmec=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mJ7D6HotLuP9heSaY31UoYJ3h8XGMPM4kCm5NHiWPY/gkUyuPMhgp/M2v+R56I5T8S7cYAtrM1sYoXJpbjDtfrmkC4tNhRBD5dVAKIXAo2qXL9qi2Fp6spkmxG+AykQ6PXoPS7PeTlhaoGpzy3yBYx9OhxKfkXB+r8TUFWs3Ekk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=EBOctmOK; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43J8QoE0038515;
	Fri, 19 Apr 2024 03:26:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713515210;
	bh=2ZZ/WurYzNmG+fF4XG7e2gevauRo3lC7JLRh3tkitu4=;
	h=From:To:CC:Subject:Date;
	b=EBOctmOKRAvqwd8H1/+IUAjwHepvT6D7Gbk8wnCDEdHXDpJbJYgrAS+y5+1i/Exu0
	 hkXZwShb8k6HDuArNHOG+G964/9C3qOFP+ak/A3Ns4g7gDrSKuatSZgOlaFK56NLk6
	 NthLmc6c7ubiVl9fTKpOiCa8g/w/tQa7VguwRj5E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43J8Qoqo127401
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 19 Apr 2024 03:26:50 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 19
 Apr 2024 03:26:50 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 19 Apr 2024 03:26:50 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43J8QnZv042265;
	Fri, 19 Apr 2024 03:26:50 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        Dan
 Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Chintan Vankar <c-vankar@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>, <s-vadapalli@ti.com>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v8 0/2] Enable RX HW timestamp for PTP packets using CPTS FIFO
Date: Fri, 19 Apr 2024 13:56:24 +0530
Message-ID: <20240419082626.57225-1-c-vankar@ti.com>
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

The CPSW offers two mechanisms for communicating packet ingress timestamp
information to the host.

The first mechanism is via the CPTS Event FIFO which records timestamp
when triggered by certain events. One such event is the reception of an
Ethernet packet with a specified EtherType field. This is used to capture
ingress timestamps for PTP packets. With this mechanism the host must
read the timestamp (from the CPTS FIFO) separately from the packet payload
which is delivered via DMA.

In the second mechanism of timestamping, CPSW driver enables hardware
timestamping for all received packets by setting the TSTAMP_EN bit in
CPTS_CONTROL register, which directs the CPTS module to timestamp all
received packets, followed by passing timestamp via DMA descriptors.
This mechanism is responsible for triggering errata i2401:
"CPSW: Host Timestamps Cause CPSW Port to Lock up."

The errata affects all K3 SoCs. Link to errata for AM64x:
https://www.ti.com/lit/er/sprz457h/sprz457h.pdf

As a workaround we can use first mechanism to timestamp received
packets.

Series is based on linux-next tagged next-20240419.

Link to v7:
https://lore.kernel.org/r/20240417120913.3811519-1-c-vankar@ti.com/

Changes from v7 to v8:
- Removed empty lines between trailers in [PATCH v7 2/2] as suggested
  by Jakub.

Chintan Vankar (2):
  net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets
    using CPTS FIFO
  net: ethernet: ti: am65-cpsw/ethtool: Enable RX HW timestamp only for
    PTP packets

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c |  13 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |  51 +++++-----
 drivers/net/ethernet/ti/am65-cpts.c         | 107 ++++++++++++++------
 drivers/net/ethernet/ti/am65-cpts.h         |  11 +-
 4 files changed, 118 insertions(+), 64 deletions(-)

-- 
2.34.1


