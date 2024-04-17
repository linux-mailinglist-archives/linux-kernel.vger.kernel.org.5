Return-Path: <linux-kernel+bounces-148459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690B78A82E0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC0CB24B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5622013DDD7;
	Wed, 17 Apr 2024 12:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZU+pYh4z"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF9D13D265;
	Wed, 17 Apr 2024 12:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355798; cv=none; b=Hph8YTCbvSgkZ93bV/R90MpgZ9REBt7KemcfX79yaMXlJpSbfLGE52kt0jYlA91ZhFDWyYugMDBv803kYOlrVI3bBFTVgVK0ZNQwlJxbUCDzwgz5nGnHZCPDCGmlcFtow4OSmsJhXxfzmpRi74UzmjZGnfHYO3VKxzM1eg06cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355798; c=relaxed/simple;
	bh=GjSaOGwFNMybY9lKOFxekFpuffQQIHrKo2pbho1ofX4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gnX8mKE/UvQ/g03+ds4yRaMz2DjCLaC/Syb9hR8CGqYqYdT05I9YTxJ0uTqk/hPYBOQ8GimGpd9LDcGtgMfS6CXNDwxZPz4hIplxLQ9Ucq5CC3e7JHhSfdezEpxi4a4hS/qVepUpSMAo1oO1Kx82sz5fb0L2UCAm/ZU8Lp0fdOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZU+pYh4z; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43HC9bkc122416;
	Wed, 17 Apr 2024 07:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713355777;
	bh=x4zjLk+YAE5yPKLZ3hViFOFc6PktnT2GSPJb75GTQ9Y=;
	h=From:To:CC:Subject:Date;
	b=ZU+pYh4zZCePpaBDDmnL6fYw1c2HPi2Zjcze2npPBwm3cl7qsFYMUNJpU0ePMtUU7
	 i4yS7iJUx9Xak4hs65xekFiv9WLPzNf3hFCv9Gcs56fuAw+9p8LmMrnApWc2x27faB
	 qeSR42wPZ6A+QEqAdtG8iNlxHkkz+D0sK3e4D7Jw=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43HC9bBR002000
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Apr 2024 07:09:37 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 07:09:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 07:09:37 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43HC9avf071120;
	Wed, 17 Apr 2024 07:09:37 -0500
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
Subject: [PATCH net-next v7 0/2] Enable RX HW timestamp for PTP packets using CPTS FIFO
Date: Wed, 17 Apr 2024 17:39:11 +0530
Message-ID: <20240417120913.3811519-1-c-vankar@ti.com>
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

Link to v6:
- Due to some issue in my email client cover-letter and [PATCH v6 1/1]
  is missing from v6.

Link to v5:
https://lore.kernel.org/r/20240402114405.219100-1-c-vankar@ti.com/

Changes from v6 to v7:
- No changes.

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


