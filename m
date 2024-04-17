Return-Path: <linux-kernel+bounces-148482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3728A8338
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 159352842D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE24612FB01;
	Wed, 17 Apr 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o2wHHrBu"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DCEEDC;
	Wed, 17 Apr 2024 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357311; cv=none; b=lYD0VTWblK8FOlmChivcN+i7NvTYOsychyhPMCmqEXRY+rhNAnWoZMtccACOuAMAQM/j3jvPD2Lt/RntgKOfZ8XK/Qrx3si25YFftKtFk1C1wPrqWF2HnGXTj7AC6eqhQR/Uu52AgD/jdzXmAebbhdDAYUCcX9ZmVlwEI7Mif60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357311; c=relaxed/simple;
	bh=xV9RyJnO8jY4uGL5tn563C63eGvy+VmK6A8flXYwhx8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i4KTQhdBDgX5tA40awvxCUtWaO0BlNhw6OBwYK3woJ1GvVJrZF3cjzpR8hIm7r1CgTplqZzySDLDhhmjmPzpYGlAxhpbB4JCc7vqYzW02pkbYNkMzfMp/iC/KeeFO7JzcgvW7NQrwzaNgAfM+k7Z4VWZpmbai05ATj6MHHaXPWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=o2wHHrBu; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43HBdBTV111559;
	Wed, 17 Apr 2024 06:39:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713353951;
	bh=R52pVjh/hMavFcBapHbH3dqRB91Y7TwXotnELGUYDTs=;
	h=From:To:CC:Subject:Date;
	b=o2wHHrBuuf86UUFFH0yCMYhP6a8ClGNQ34CxrE3XVREm7gk1qfM0MsXOv4bePSbeY
	 B/tHwIy6dPSeFtJ6E585EVBNe4iDDYS+1r6xMakilCfqK+t+fmvuKxv8B2FLmQ8WEU
	 J/LsbaYFvoOFu69bi2JCPs79KZyAg3ZLYKuOiuAU=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43HBdAGY060518
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Apr 2024 06:39:11 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 06:39:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 06:39:10 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43HBd9i8025032;
	Wed, 17 Apr 2024 06:39:10 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Julien Panis <jpanis@baylibre.com>, Arnd Bergmann <arnd@arndb.de>,
        "Dan
 Carpenter" <dan.carpenter@linaro.org>,
        Chintan Vankar <c-vankar@ti.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Grygorii Strashko
	<grygorii.strashko@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Andrew Lunn" <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
        Richard
 Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S.
 Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v6 0/2] Enable RX HW timestamp for PTP packets using CPTS FIFO
Date: Wed, 17 Apr 2024 17:09:02 +0530
Message-ID: <20240417113904.3804936-1-c-vankar@ti.com>
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

Series is based on linux-next tagged next-20240417.

Link to v5:
https://lore.kernel.org/r/20240402114405.219100-1-c-vankar@ti.com/

Changes from v5 to v6:
- Defined lockless variant of "am65_cpts_fifo_read()" as
  "__am65_cpts_fifo_read()", suggested by Paolo to avoid acquiring the
  same lock on cpts again in "am65_cpts_fifo_read()".
- Replaced "list_del_entry()" and "list_add()" functions with equivalent
  "list_move()"  function.
- Replaced "list_del_init()" and "list_add_tail()" functions with
  equivalent "list_move_tail()" function.

  This changes are done as per the discussion at here:
  https://lore.kernel.org/r/7c8be16329668d343a971e265e923543cba5e304.camel@redhat.com/

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


