Return-Path: <linux-kernel+bounces-60823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 188FD8509EB
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A22731F21E4A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741A55C5EC;
	Sun, 11 Feb 2024 15:08:34 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E155B695;
	Sun, 11 Feb 2024 15:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664114; cv=none; b=JGXrq6RXnNcztDo2+LCkF2EB/BT0OnCvs8WTTyUAQ1OSHy+KWHJaeq60XMC+CISBavhmYyUf2lGJBzbYAERzvkhfut3+O0SBn9FCni6n32yNGWdGzGaZEvQAkUSFcT2mv/IfMV2p5Nyao19JdWpDNVmFenYLM0GAgck68kYWPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664114; c=relaxed/simple;
	bh=IvTIcU18qlQtiOl7Wv/JqJLqq3hP94HFMtbZnDwMaw8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N8Mok1nYCacgfM5QQoU3i9+bi+o39ZzMhTk3veK0NrTiYGSgTpP+jKbtHLdVuhOeJxqC2EVGl7SQvI1uXx95mZEoCggJqH1+K5ZF2q65QNizf5uFm+Os8aWO5LW+GdhzRsuVdhLBsV0DuV8//FrGKqDCU11KsSlPJx2rtGCzrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Russell King <linux@armlinux.org.uk>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] net: sfp: remove redundant NULL check
Date: Sun, 11 Feb 2024 07:08:24 -0800
Message-ID: <20240211150824.3947-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

bus->upstream_ops in sfp_register_bus() cannot be NULL. So remove
redundant NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: ce0aa27ff3f6 ("sfp: add sfp-bus to bridge between network devices and sfp cages")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/net/phy/sfp-bus.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 850915a37f4c..829cb1dccc27 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -478,14 +478,12 @@ static int sfp_register_bus(struct sfp_bus *bus)
 	const struct sfp_upstream_ops *ops = bus->upstream_ops;
 	int ret;
 
-	if (ops) {
-		if (ops->link_down)
-			ops->link_down(bus->upstream);
-		if (ops->connect_phy && bus->phydev) {
-			ret = ops->connect_phy(bus->upstream, bus->phydev);
-			if (ret)
-				return ret;
-		}
+	if (ops->link_down)
+		ops->link_down(bus->upstream);
+	if (ops->connect_phy && bus->phydev) {
+		ret = ops->connect_phy(bus->upstream, bus->phydev);
+		if (ret)
+			return ret;
 	}
 	bus->registered = true;
 	bus->socket_ops->attach(bus->sfp);
-- 
2.25.1


