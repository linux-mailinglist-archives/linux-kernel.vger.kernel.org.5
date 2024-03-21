Return-Path: <linux-kernel+bounces-110338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45076885D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 020CB284863
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0933112CDB0;
	Thu, 21 Mar 2024 16:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5oA0Gq0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02C85650;
	Thu, 21 Mar 2024 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038580; cv=none; b=JPncBgG85xpyMOocVH+xCp5Y/Ov3iqVgb5TcfCuWjBcMbuxvc9xmQZSBNicR3J7ohNk03pjnmfLlMe2m6Br6KC4zgH5W0VlrAfQPAdmeQYN+kkLuupX0BhY8Y9THjywy/TxPj3Ya5VqbmpAi8uPl7nlxYNLgb5I3wT2EMylZggQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038580; c=relaxed/simple;
	bh=f2s9m94GQMqwkep6RHvJkC24pYKjgeZXaB8gUvBmMLU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TCL/IBJcbffNAsjE2J9yMIvJTp6zNUdq7wJnwtUQOtDhnJMN+nLNHLcNSvk/3bqLbnZzL9wI1d/m/ZnFjdr2gWi9DsN6xGLkK3+Z1sxSFBSFPGk1hBOXEk0dC2qJC0VNYFS4st//lNuA31+FJXa4SkZmzUdmDzDF/TioJhGmsz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5oA0Gq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5B48C433F1;
	Thu, 21 Mar 2024 16:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038579;
	bh=f2s9m94GQMqwkep6RHvJkC24pYKjgeZXaB8gUvBmMLU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=S5oA0Gq0eAVWR+Pej9Urae3ZTdKr/uoodQAKanMLWoqSGrkIqXlLs/hepKk0eUoqN
	 Oa1MYLr309GZvyybpJ17qKscdQpjG2sN23tP8ER4+PDSl3Rn9w8sahfYYloVlZSnGy
	 XFYcoiec8Np3A+9ckzEtLWP4ZNPU16S/gjn6FP4+io41DNnaTFXba6rXtxglzqcEp6
	 488l/HawOH1bQtg56NA8+A6DYQ3X/I/1sAhofg8JEWVFQj0uldD/3L2TDCzoW4wn19
	 +rP9tz+ArcXHzv8SdgT7bInOHgOB4lOLyQblesMhbRsI5OieV/pAgu4y8cG5b74U+o
	 2ybU7cPO9FZpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93A0C6FD1F;
	Thu, 21 Mar 2024 16:29:39 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net v2 0/2] Fix EEE support for MT7531 and MT7988 SoC
 switch
Date: Thu, 21 Mar 2024 19:29:12 +0300
Message-Id: <20240321-for-net-mt7530-fix-eee-for-mt7531-mt7988-v2-0-9af9d5041bfe@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAFhg/GUC/42NTQ6CMBCFr0Jm7Zj+SmHlPQwLUgeZBa1pCdEQ7
 m5tPICryfve5H07ZEpMGfpmh0QbZ46hBHVqwM9jeBDyvWRQQhmhZYtTTBhoxWVtrRY48QuJqOK
 K5Pd0zuFovTVWey/IQZl7JirPVXWDsgBDgTPnNaZ31W+yVj+T+9+0SRSoJ9kqddHGkLuOiYPvz
 j4uMBzH8QGfp2+35gAAAA==
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 =?utf-8?q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>, 
 Russell King <linux@armlinux.org.uk>, 
 SkyLake Huang <SkyLake.Huang@mediatek.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bartel Eerdekens <bartel.eerdekens@constell8.be>, 
 mithat.guner@xeront.com, erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711038558; l=1342;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=f2s9m94GQMqwkep6RHvJkC24pYKjgeZXaB8gUvBmMLU=;
 b=/6PP6fK764ZhfuLKywgjtgj/pSH6Pl3WLUSpeldm0cf8TIM2N7wD6Nyxiz1esoC3fNTmSwYep
 kfWBjAIgHnnDt+DUNRcOtb3r9KceZ8aeSscFgEEeQTFI+SDR9nOGJli
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hi.

This patch series fixes EEE support for MT7531 and the switch on the MT7988
SoC. EEE could not be enabled on MT7531 on most boards using ethtool before
this. On MT7988 SoC switch, EEE is disabled by default but can be turned on
normally using ethtool. EEE is enabled by default on MT7530 and there's no
need to make changes on the DSA subdriver for it. This patch series
disables EEE by default on MT7531 but makes it possible to enable it using
ethtool.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v2:
- Delegate the patch to the net tree.
- Remove patch 3, it was revealed that it doesn't fix a bug.
- Patch 1
  - Disable EEE advertisement on MT7531 by default.
- Link to v1: https://lore.kernel.org/r/20240318-for-net-mt7530-fix-eee-for-mt7531-mt7988-v1-0-3f17226344e8@arinc9.com

---
Arınç ÜNAL (2):
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards
      net: dsa: mt7530: fix disabling EEE on failure on MT7531 and MT7988

 drivers/net/dsa/mt7530.c | 14 ++++++++++++++
 drivers/net/dsa/mt7530.h |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)
---
base-commit: ea80e3ed09ab2c2b75724faf5484721753e92c31
change-id: 20240317-for-net-mt7530-fix-eee-for-mt7531-mt7988-a5c5453cc0e8

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



