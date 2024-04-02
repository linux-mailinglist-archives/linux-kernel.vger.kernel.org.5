Return-Path: <linux-kernel+bounces-128509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C539895BD2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2791D287E1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1C315B134;
	Tue,  2 Apr 2024 18:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kOFWeNAg"
Received: from msa.smtpout.orange.fr (msa-218.smtpout.orange.fr [193.252.23.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD278495;
	Tue,  2 Apr 2024 18:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712082927; cv=none; b=ijUzlt66XRsm+P+hPLy8sCuIao1GqitqhaLOeKI50HWEOJTkrwDp0og7yqLXuwlLH7rLA5biAlnQ56p52R6K2k9HpI/s/O12566BqcN8cKaJuVNnKcrp8BpwQf4cAHtwy+e4TYFEOrYu9xzJ8InqrL3O203tYf/zMhsvv7C94FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712082927; c=relaxed/simple;
	bh=1Tr3evgpqgoyinYe9ZXN3oojD3I0yY6WTZcG5ZHh2iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRvl4NHnakUyGHha8VsXaXotIy/k3QuhRAAcyTfZkYzT5j6Ue5f8ffV8YjelH3CwN9+xdtvvNWSuJ4TQU6kSu3a77IpQhskLbT5T1PSTLJqC9CTN4LAYkURqoBNwiAAyFG0RE/NY0G8KXT+CPaBLcCfP/HWq7l6Od7YuklN1oLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kOFWeNAg; arc=none smtp.client-ip=193.252.23.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id rixOriJikJkhtrixOr9UEV; Tue, 02 Apr 2024 20:34:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712082845;
	bh=lFOjc52+8+hT07tTL2YCB1U/dZ8Xx1kaP44Rh2w3vjA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=kOFWeNAgbhKrXzWSoEoiSTd48dAtjGPnz8qptymiT3IBkhAiIfGRmhZqrVFVvCiB8
	 mDhcfF8VbGU8jJglg7pTBRz9h62HW/B69GMk6lWmKQAygE4DTvrBZn+sKrmL0gQ5ll
	 BsqWckqY4xDzRk2bgrvWubZt+PFlB3O+x20F9HJ/AM7sw8uwHCFuzFjJ0vET4E25ex
	 PVbo2Bsas+rBuwQz/yrkO4JV0CSfTqyLjBRmhAIA+Km5Y+4LgQkB2PASmIJxyoFMdG
	 Sj5THfl/Sx3M+AyF/MzJrc5W63TjVnzUOuAz80A7/kkzwy0t7AxJVgY3qF2DQlLbuP
	 J/CpnVD1uVVcA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 02 Apr 2024 20:34:05 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Vladimir Oltean <olteanv@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Walle <michael@walle.cc>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net] net: dsa: sja1105: Fix parameters order in sja1110_pcs_mdio_write_c45()
Date: Tue,  2 Apr 2024 20:33:56 +0200
Message-ID: <ff2a5af67361988b3581831f7bd1eddebfb4c48f.1712082763.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition and declaration of sja1110_pcs_mdio_write_c45() don't have
parameters in the same order.

Knowing that sja1110_pcs_mdio_write_c45() is used as a function pointer
in 'sja1105_info' structure with .pcs_mdio_write_c45, and that we have:

   int (*pcs_mdio_write_c45)(struct mii_bus *bus, int phy, int mmd,
				  int reg, u16 val);

it is likely that the definition is the one to change.

Found with cppcheck, funcArgOrderDifferent.

Fixes: ae271547bba6 ("net: dsa: sja1105: C45 only transactions for PCS")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/net/dsa/sja1105/sja1105_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
index 833e55e4b961..52ddb4ef259e 100644
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
@@ -94,7 +94,7 @@ int sja1110_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
 	return tmp & 0xffff;
 }
 
-int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int reg, int mmd,
+int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
 			       u16 val)
 {
 	struct sja1105_mdio_private *mdio_priv = bus->priv;
-- 
2.44.0


