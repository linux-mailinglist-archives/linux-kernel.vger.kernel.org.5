Return-Path: <linux-kernel+bounces-128013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94E8954F4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8561C22715
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA4983CD0;
	Tue,  2 Apr 2024 13:13:53 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FF560DE9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063632; cv=none; b=KFuOuiiqSddXylRLbVSKSjBCrLV6r4oxxJiqSp+vY1MJLY66qUnYDBTrrrIwvctoMVstnCCjEH/DyjOTyrE3gep5HsMO6KCmySWwItf/2FHldsIi76TKc78Nu+kqBF9NLw0e2cplSKig/StsfNtF04iqsoYA4bfnyby8RH6aD/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063632; c=relaxed/simple;
	bh=EHoM22GRydz72htz26DdckIjRjxIqIKBM9jYuxEu6XM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Of/idZN1lXow92YA77ZkSiwlu8ABuM3iFr6Ei8WnMkvQzjtAw8/TEgtTS4sVihipTIQvRtYQdVamKtFGIeLCwa8pWeVV9dRomz0O1rKxo7MhNDPHXCFaR7/xBFsUdDYApr6LcermoXi77hIlfDmDulJBaoRn47Dl59UYQ/2WF4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxN-0007Ng-MW; Tue, 02 Apr 2024 15:13:41 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-009zW0-D7; Tue, 02 Apr 2024 15:13:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrdxM-006Ooh-15;
	Tue, 02 Apr 2024 15:13:40 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 0/8] net: dsa: microchip: ksz8: refactor FDB dump path 
Date: Tue,  2 Apr 2024 15:13:31 +0200
Message-Id: <20240402131339.1525330-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Refactor FDB dump code path for Microchip KSZ8xxx series. This series
mostly makes some cosmetic reworks and allows to forward errors detected
by the regmap.

Oleksij Rempel (8):
  net: dsa: microchip: Remove unused FDB timestamp support in
    ksz8_r_dyn_mac_table()
  net: dsa: microchip: Make ksz8_r_dyn_mac_table() static
  net: dsa: microchip: ksz8: Refactor ksz8_fdb_dump()
  net: dsa: microchip: ksz8: Refactor ksz8_r_dyn_mac_table() for
    readability
  net: dsa: microchip: ksz8: Unify variable naming in
    ksz8_r_dyn_mac_table()
  net: dsa: microchip: ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN
    on timeout
  net: dsa: microchip: ksz8_r_dyn_mac_table(): return read/write error
    if we got any
  net: dsa: microchip: ksz8_r_dyn_mac_table(): use entries variable to
    signal 0 entries

 drivers/net/dsa/microchip/ksz8.h        |   2 -
 drivers/net/dsa/microchip/ksz8795.c     | 144 ++++++++++++------------
 drivers/net/dsa/microchip/ksz8795_reg.h |   1 +
 3 files changed, 75 insertions(+), 72 deletions(-)

-- 
2.39.2


