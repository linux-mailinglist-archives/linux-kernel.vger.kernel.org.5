Return-Path: <linux-kernel+bounces-68491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42220857B17
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538A01C234FA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595AD59B6C;
	Fri, 16 Feb 2024 11:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow0XBnY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA358230;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081544; cv=none; b=sK50I8dyfmSYA1x0FYgJ6GWCnzEOriBserBvcyFusg6ngUxb+HGm+WC04fDERSc0iItyerq8zskGGPpEbWlZ1lHvYDBZA6zslHm/JeV+mbMZzfloEjIXHp1wp+XeDxY/qW80ylH2BQ5k3txGrzYjOUsDJ40lTfCzqOhf4E6ADs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081544; c=relaxed/simple;
	bh=SU+tK2MlpgkdVnVhaHn0UQcoIzpj8l2UDGxN8QSA/B4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j5d2YW6dPwvcrY0xt/+wLSH9YiglBOEnlj23SsD3JSMfhGtHiIj1usqENZG7bfy+tjKrUeCVfhuvOh4ZC0DDtqyKnE4l+OC23uioQKcApmxc2lBSt9WKkBhnjfYeAGPRvqMAcQGCyf+BnKBpBTG1vCtQrpoxJG/354TzN5JSrYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow0XBnY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14E9EC433C7;
	Fri, 16 Feb 2024 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708081544;
	bh=SU+tK2MlpgkdVnVhaHn0UQcoIzpj8l2UDGxN8QSA/B4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ow0XBnY2/curX1mUkAN/HvlQNn/LSrgxQeQPUomCYOreHLG77CbdaXzUZerVuYhIB
	 Cg1tL6X8Lb3dUDqonxIDtPKwqYDs7++deINdPMGkGCdLW15Mt2xlGp0Bzvfzy1tuwW
	 cJyIRC+bKwiZt3V2d8RTlf6RMpaXY5WsHiXuWJjNukFOSQFGJcbCfUHa6Mb8rJDsab
	 hcvvqQXWmf5nxDl+NyYXlMtXNlbVNACQ5gzYCh9pifYZG6QYi3jh5ENdvHWDQFyMMR
	 NicMiaEtgOBdGX2rEw62aqiUJm6ooDwc6i9UQ3xPWpWgtb+LpG219zLq4QqbGpqHWz
	 ondUY353SvHeg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD7BC48BF3;
	Fri, 16 Feb 2024 11:05:43 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Fri, 16 Feb 2024 14:05:30 +0300
Subject: [PATCH net-next v2 2/8] net: dsa: mt7530: set interrupt register
 only for MT7530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id:
 <20240216-for-netnext-mt7530-improvements-3-v2-2-094cae3ff23b@arinc9.com>
References:
 <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
In-Reply-To:
 <20240216-for-netnext-mt7530-improvements-3-v2-0-094cae3ff23b@arinc9.com>
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: mithat.guner@xeront.com, erkin.bozoglu@xeront.com, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708081540; l=921;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=JV5lkSoAmKAO6vEQKKvFpHOlOFc0GQ6XMI05UOpapU0=;
 b=6sLS2Fy8GCQ4bmQBQV4SoJUoEQEDgsCOSuj01R+oOJZUOGxZdZTvsIczW36eKnIEd4CoKj+lD
 oXbDfaix77lBWRZS5Q4hzgZjQTvsUOlHXgUf2Y19WjieBgQHN4HM4Xp
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

From: Arınç ÜNAL <arinc.unal@arinc9.com>

Setting this register related to interrupts is only needed for the MT7530
switch. Make an exclusive check to ensure this.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Tested-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/dsa/mt7530.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 94d4b2c87799..5cfd303b773f 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -2055,7 +2055,7 @@ mt7530_setup_irq(struct mt7530_priv *priv)
 	}
 
 	/* This register must be set for MT7530 to properly fire interrupts */
-	if (priv->id != ID_MT7531)
+	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_set(priv, MT7530_TOP_SIG_CTRL, TOP_SIG_CTRL_NORMAL);
 
 	ret = request_threaded_irq(priv->irq, NULL, mt7530_irq_thread_fn,

-- 
2.40.1


