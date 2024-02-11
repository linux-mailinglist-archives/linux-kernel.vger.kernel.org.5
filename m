Return-Path: <linux-kernel+bounces-60822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E648509E9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F48EB2185B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4183B5DF08;
	Sun, 11 Feb 2024 15:08:15 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C415D8EE;
	Sun, 11 Feb 2024 15:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664094; cv=none; b=JwUb4si6qEcYCuig43iGCDzgk5WhkxUutdipRcfA9mKv8l2WrE+gz2RHDZ/4XD44NPnS8x95E3OBRs/0N+D9uhBhca3nacYtTCUUkASxWfLpkx7jZMnDOJApwPtYLPmgL1w4CjfbuovzmVKxWO7Kl1MQB5g6KVdmqDlV/Zktuv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664094; c=relaxed/simple;
	bh=6lVtZwGVnQw7WJULx6ndFVpcSiHixpJ5yBr0YKaxalw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TnAbiJg0zdC1dlDm3QMywIfydEX8vttgGqDb7A2BNbNEVb6PVhzBLxwzONhUVEvi5q2bcnHtCn0FajJM9iYCT7wLp3g5EcLXivp0x11SkD+DtF2OO9evV894Qj3hScTMw6u7apfagsne1ZqrHEamiBddcA0DuCPz/cppndXIlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Woojung Huh <woojung.huh@microchip.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, <UNGLinuxDriver@microchip.com>, Andrew
 Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Alexandre
 Belloni <alexandre.belloni@bootlin.com>, Helmut Grohne
	<helmut.grohne@intenta.de>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 18/18] net: dsa: microchip: Check return value of of_get_phy_mode()
Date: Sun, 11 Feb 2024 07:08:04 -0800
Message-ID: <20240211150804.3893-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

of_get_phy_mode() may return an error, so add a check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: edecfa98f602 ("net: dsa: microchip: look for phy-mode in port nodes")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/net/dsa/microchip/ksz_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index e3c338624b95..faffce6ea1e1 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -434,8 +434,10 @@ int ksz_switch_register(struct ksz_device *dev,
 					continue;
 				if (port_num >= dev->mib_port_cnt)
 					return -EINVAL;
-				of_get_phy_mode(port,
+				ret = of_get_phy_mode(port,
 						&dev->ports[port_num].interface);
+				if (ret)
+				    return ret;
 			}
 		dev->synclko_125 = of_property_read_bool(dev->dev->of_node,
 							 "microchip,synclko-125");
-- 
2.25.1


