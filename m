Return-Path: <linux-kernel+bounces-155750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE808AF6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C741C22E98
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA5D13FD74;
	Tue, 23 Apr 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="llPNQYid"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990181E53F;
	Tue, 23 Apr 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713897228; cv=none; b=d92+5qR90x47ywVAfmaYlikOovi4ypHlY+lzPRgrXQuWdYWJSC/0Gn9/rNxkGa3RiACl7PSxmZLYLtidtELQEfRk50KuB7qIbKWGaXZlxljyn0kh+HM8ExxYIn5Ij8KFi/WVjCIo09czhOYft7t/ea/Y6H8O5eb878hSR2hB8Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713897228; c=relaxed/simple;
	bh=A406q/tAi4UZG/IcGrX9tzSqvoePKRA9IiSHVZtAsos=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ugdk1M+Iwk8KiMfwYAn9M1bBG3PYFKHhlAK7mXv1oloUen+78r24jJLCUZwUSoSGhkeGXA6n4x6kSWEah27a4S+9qtx5QMV03JLpxW0hVecVI+VeNgq1B7mkRwUFaaQTatSDKV/HoFGF71qCc0rtx+Gb1KU4TsTtg7jlP9h7yRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=llPNQYid; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6CAE8C00282D;
	Tue, 23 Apr 2024 11:33:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6CAE8C00282D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713897221;
	bh=A406q/tAi4UZG/IcGrX9tzSqvoePKRA9IiSHVZtAsos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=llPNQYid5I7ncsvky7UeA6ELxr9WskCvmPzOsIBHVpgqWp2cD4Zj1lTXVE7lPBBSk
	 k0eEj92LPiiSsjUgOHJPXthctXCqLU3xhNb5lyIIjgGiVO9+HN8Yfvc7u4muB0ohrL
	 qBxB+PUUJsoZFr2r6Xvr9dD2vUSovlaRQj+eeSp8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8C4E318041CAC4;
	Tue, 23 Apr 2024 11:33:39 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 4/8] net: dsa: b53: Force flow control for BCM5301X CPU port(s)
Date: Tue, 23 Apr 2024 11:33:35 -0700
Message-Id: <20240423183339.1368511-5-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
References: <20240423183339.1368511-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like what b53_adjust_link() does, force flow control for the
BCM5301X CPU port(s) by forcing rx_pause and tx_pause in
b53_phylink_mac_link_up(). Preparatory step for getting rid of
b53_adjust_link().

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index a127a17be11c..6277ab7dcb7f 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1475,6 +1475,10 @@ static void b53_phylink_mac_link_up(struct dsa_switch *ds, int port,
 		return;
 
 	if (mode == MLO_AN_FIXED) {
+		/* Force flow control on BCM5301x's CPU port */
+		if (is5301x(dev) && dsa_is_cpu_port(ds, port))
+			tx_pause = rx_pause = true;
+
 		b53_force_port_config(dev, port, speed, duplex,
 				      tx_pause, rx_pause);
 		b53_force_link(dev, port, true);
-- 
2.34.1


