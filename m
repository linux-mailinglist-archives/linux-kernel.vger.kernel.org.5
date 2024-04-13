Return-Path: <linux-kernel+bounces-143731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7998A3CC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F081282289
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5142446AC;
	Sat, 13 Apr 2024 13:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deo0xecY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B723D56D;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713013362; cv=none; b=eLMjk9TKMy8lPkXl9sBGYWFVNp3Lf4d/6AreVUf3e0wSwsE/hsr3/ohNWv8mYXdEI78CaRP+vU4LLXyguaAsJi7sqZPAeXLY/f6MaZdezX8RC23vjMY7AN1Kdq0XBEXjvsvMUh9FDuHto0IO6Nm5g8aXUxqpUtWnoIatv6Mt18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713013362; c=relaxed/simple;
	bh=tIwVcmzfuWrvRXOL2CNVlGRiqUSlmA862fC7CswLoWc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OhJ0q6Gp+5quRe1jfz6CpYWjuov2DgvDCTQukvoiNsK2xzPC3irWEc83Tmi5mW1cXuHsFxAf3nn5ps6hFBh4143QdQ9juEknP3Wr5R0MTWdEA67wieJf7eeSyuf2MAy1SyCX6lqJjI41DYsCW/P14XhkjTWRBH68K/78KREbtcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deo0xecY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E372C113CD;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713013361;
	bh=tIwVcmzfuWrvRXOL2CNVlGRiqUSlmA862fC7CswLoWc=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=deo0xecYYCfglU3Qnkjrp+fBSTarRhRzy5Wkb+HRTFB/TCH86sEw1QEtdUg44zetl
	 8j3+ZwE1Xu/AfpM+HTm2tVamGaXnhq6WRbDEndUL6Vl+33P+FA//XQ4qCIDWsWtPZ7
	 /6PJ5o346Uut0w9afs9rWXYxBYtdQLfvzFr+vx6M/ZI/5xT+AhurbhIY/fymh9MxtF
	 Mr/MTN4EjV/YNR2kvxbkoGIfctF1kh0yeUEd5UOy2Z1/wN3iBMOPxOhNkEBAmWqb8f
	 4LKZjaCXG3Re0/Jcy4qJK10MWiUAg6T+vOmwzanoyGw0GaI5JHAJK6hm6QyYpsfJRr
	 uOe1zwvE5MQXQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C374C4345F;
	Sat, 13 Apr 2024 13:02:41 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net 0/2] Fix port mirroring on MT7530 DSA subdriver
Date: Sat, 13 Apr 2024 16:01:38 +0300
Message-Id: <20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-v1-0-476deff8cc06@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADKCGmYC/x2NQQqDMBBFryKz7kA00cReRbpIY7QDmpFJKAXx7
 k27fPD++yfkKBQz3JsTJL4pE6cK7a2B8PJpjUhzZehUZ5RpNT4NLiyYYsG92F4rXOiDO4mwUFq
 xMG4c/IYHS0Gf5p82Oofa+t51YRhG66HmD4l1+b+eoObgcV1f7Wt53Y8AAAA=
To: Daniel Golle <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>, 
 Sean Wang <sean.wang@mediatek.com>, Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Holger Stadali <hs@giax.de>, 
 Bartel Eerdekens <bartel.eerdekens@constell8.be>, mithat.guner@xeront.com, 
 erkin.bozoglu@xeront.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713013352; l=731;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=tIwVcmzfuWrvRXOL2CNVlGRiqUSlmA862fC7CswLoWc=;
 b=AIrFvlQc3tcxviGzOLIGmBqZmIxEahKHRc9YPMCzCUupD2yadJp90xxhu93W3CrPfWgGyLLED
 MCUb176IfZaDE61ysaeVKABk/KB1+fYyhH9GXZ9wKbm+94vAREIVkeP
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt
 with auth_id=115
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hi.

This patch series fixes the frames received on the local port (monitor
port) not being mirrored, and port mirroring for the MT7988 SoC switch.

Arınç

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (2):
      net: dsa: mt7530: fix mirroring frames received on local port
      net: dsa: mt7530: fix port mirroring for MT7988 SoC switch

 drivers/net/dsa/mt7530.c | 16 ++++++++++++----
 drivers/net/dsa/mt7530.h |  4 ++++
 2 files changed, 16 insertions(+), 4 deletions(-)
---
base-commit: 4e1ad31ce3205d9400816e08cf14b7c96295d22e
change-id: 20240413-b4-for-net-mt7530-fix-mirroring-to-local-port-and-mt7988-37a582c6697a

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



