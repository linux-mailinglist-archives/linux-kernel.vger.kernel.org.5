Return-Path: <linux-kernel+bounces-127879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4A895229
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258841F24704
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451477F11;
	Tue,  2 Apr 2024 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DmdydIF8"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF9F69979;
	Tue,  2 Apr 2024 11:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058273; cv=none; b=PMlzfrPsz5JJL0nJxXB58zPfLuPvg3OM9+wgw6kEuFfq1dpGSfPJLA3h6/hydHIvH5zeDCfCP60KXcFBPSjHjNxFwjzVW/qikauYrUa7yS3jvKD/KdVYjMTZQU2HcpdFd3G38pHg9JtRw5FpzWHqYpZ9r6eEjr3hmF5RBrgVICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058273; c=relaxed/simple;
	bh=AuMo0OYxSwQJjavMi1CoqMKsM6fTwjYKi6dyzUZOR1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=abhdI3hhCJWhHEl67unZ+NK8c8VAniSCVitZvAYlVuBpaoW/7tVLQMQSoOv1JCqXRLGAcvHTQKEWS4+XL2V3mN/lklWXSfLWmY+V/I/2p2dXoQPz8vDe5fkFLdvEwZjgUQWOyR6CxDWE1iXK7xw+oPOQuLfxjOdOxUFK+JmGwsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DmdydIF8; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 432Bi8BK030239;
	Tue, 2 Apr 2024 06:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712058248;
	bh=sh3LQCdFxCykwoTOJhgerGFGuJZbahgKwqL4JpT+OdE=;
	h=From:To:CC:Subject:Date;
	b=DmdydIF8cScV55+QZOrt4LuXmyJG+rErqB7scCJs59XY1mP7yCMzjqPkEh1gNQu9w
	 u1eIaP57/AevT6+helV5xcMQvuUECHKyCTAAcpT6nLUuiKCHPG/2UfOUxtK2AwdqTc
	 O7rON0LWvKSm489oKdhTRQAcJJtw/IIcPd8MR6UQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 432Bi8e1090261
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Apr 2024 06:44:08 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Apr 2024 06:44:08 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Apr 2024 06:44:08 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 432Bi7lB126375;
	Tue, 2 Apr 2024 06:44:07 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Chintan Vankar
	<c-vankar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v5 0/2] Enable RX HW timestamp for PTP packets using CPTS FIFO
Date: Tue, 2 Apr 2024 17:14:03 +0530
Message-ID: <20240402114405.219100-1-c-vankar@ti.com>
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

Link to v4:
https://lore.kernel.org/r/20240327054234.1906957-1-c-vankar@ti.com/

Changes from v4 to v5:
- Added cover letter
- Updated commit messages.
- Combined [PATCH v4 2/3] and [PATCH v4 3/3] in v5.
- Replaced "list_del_entry()" and "list_add()" functions with equivalent
  "list_move()" function in [PATCH v4 1/1].
  
  This changes are done as per discussion at here:
  https://lore.kernel.org/all/20240327054234.1906957-1-c-vankar@ti.com/

Chintan Vankar (2):
  net: ethernet: ti: am65-cpts: Enable RX HW timestamp for PTP packets
    using CPTS FIFO
  net: ethernet: ti: am65-cpsw/ethtool: Enable RX HW timestamp only for
    PTP packets

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 13 ++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 50 ++++++------
 drivers/net/ethernet/ti/am65-cpts.c         | 87 +++++++++++++++------
 drivers/net/ethernet/ti/am65-cpts.h         | 11 +--
 4 files changed, 105 insertions(+), 56 deletions(-)

-- 
2.34.1


