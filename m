Return-Path: <linux-kernel+bounces-49544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8925B846BBA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB4C81C26239
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0796777F26;
	Fri,  2 Feb 2024 09:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARsrl0lh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8C604DD;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865573; cv=none; b=NCvlA0Yj64xLTExZ0Eb342FEA72N+dCh755PDQIW0Qf6uoRMU5BdablEvqxw9XOMvpd9n6vyG8wPXGJ3QbCmKfLcTkKBVhX6Y0k1WmiGUQyaaPKfvQVLyGtVUKP6g9rnTx9uVAdUzvZjGuGYaf2BMWovS3hdM3sNqMZ1sTM/SzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865573; c=relaxed/simple;
	bh=xE7EaY+SaLysKQoYh+sK179THKxjITu9cCGTNetAMsE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sInQt5gHYmV+gh2B1k+kzoESYSdLPS5QtqEOI5RnCfwYTlKkZAp4EaZtbP1NsKvz9WKZ+DHMPGTtwZBXUXAqHyF9mkcxTSPBsraYRwW3jlXlU7zDeVKsXlBkaBN508vJG/vxx4v0/cy5uSM6yP22U1+si7WYmHSpEazmtceiSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARsrl0lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93445C433F1;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706865572;
	bh=xE7EaY+SaLysKQoYh+sK179THKxjITu9cCGTNetAMsE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ARsrl0lhmfMY8srMfY2Apt7F5gCb6COauZuUOzfIT7dM37Kwz6IpUpqltZ8gzHeov
	 wcaI4lKjsglpPmmGoDUuK3BkHJcMlxGokJB9Km9jYEpJowY2pIaGmNgz+GDf9d1h8K
	 hpnbY864aSunSY+LGEjeHm63Ju8NvyxBUpqY3Wk4NhOHb/J7pGLvpNwWmAcl3siI95
	 v7lEfaQgAcKdb59XBmyVI7rrczIHON2B6FesHo6fTbQTXxIRkIrGDkRkjdjbVt7ZkD
	 Q+IT67nSHDi/YIDxmNtdgIovEBpf0xp6/XIjaKsOO5sGCZ+YcP2Z6vUdk5sWiCsi4v
	 Q3cEHg9LTy8PQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDEEC47258;
	Fri,  2 Feb 2024 09:19:32 +0000 (UTC)
From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= via B4 Relay
 <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH net-next v3 0/7] MT7530 DSA Subdriver Improvements Act II
Date: Fri, 02 Feb 2024 12:19:06 +0300
Message-Id:
 <20240202-for-netnext-mt7530-improvements-2-v3-0-63d5adae99ca@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIqzvGUC/4WOyw6CMBREf8V07SV9UB6u/A/josBFmkhL2tpgC
 P9urRtduZvJ5MzMRjw6jZ6cDhtxGLXX1iQjjgfST8rcEPSQPOGUl5RxBqN1YDAYXAPMoZaCgp4
 XZyPOaIIHDl05lqKqWFc2kqSexeGo17xxIQmFN0uuKZm0D9Y983hkOf/sMMEol7wtGipqBgyU0
 6YvHkbdz1m2RW/n3BH5F5fO/P8XOVDoFK1GOQwtdvSnct/3F0YuEvsVAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706865569; l=2936;
 i=arinc.unal@arinc9.com; s=arinc9-patatt; h=from:subject:message-id;
 bh=xE7EaY+SaLysKQoYh+sK179THKxjITu9cCGTNetAMsE=;
 b=JV8ZrWmbGIpnTvgNTtvg3p3kzLL5SUHQd8O9lRAeQNyXPg1sWhIXmlYwg3DSLhfVQKD8OIosM
 kHj7L+uTIWyCUcg4d29vb3TG9fjjdE4Vnuhr117r0dDfRVfS/kNcv72
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=VmvgMWwm73yVIrlyJYvGtnXkQJy9CvbaeEqPQO9Z4kA=
X-Endpoint-Received:
 by B4 Relay for arinc.unal@arinc9.com/arinc9-patatt with auth_id=115
X-Original-From: =?utf-8?b?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Reply-To: <arinc.unal@arinc9.com>

Hello!

This is the second patch series with the goal of simplifying the MT7530 DSA
subdriver and improving support for MT7530, MT7531, and the switch on the
MT7988 SoC.

I have done a simple ping test to confirm basic communication on all switch
ports on MCM and standalone MT7530, and MT7531 switch with this patch
series applied.

MT7621 Unielec, MCM MT7530:

rgmii-only-gmac0-mt7621-unielec-u7621-06-16m.dtb
gmac0-and-gmac1-mt7621-unielec-u7621-06-16m.dtb

tftpboot 0x80008000 mips-uzImage.bin; tftpboot 0x83000000 mips-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootm 0x80008000 0x83000000 0x83f00000

MT7622 Bananapi, MT7531:

gmac0-and-gmac1-mt7622-bananapi-bpi-r64.dtb

tftpboot 0x40000000 arm64-Image; tftpboot 0x45000000 arm64-rootfs.cpio.uboot; tftpboot 0x4a000000 $dtb; booti 0x40000000 0x45000000 0x4a000000

MT7623 Bananapi, standalone MT7530:

rgmii-only-gmac0-mt7623n-bananapi-bpi-r2.dtb
gmac0-and-gmac1-mt7623n-bananapi-bpi-r2.dtb

tftpboot 0x80008000 arm-zImage; tftpboot 0x83000000 arm-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootz 0x80008000 0x83000000 0x83f00000

This patch series is the continuation of the patch series linked below.

https://lore.kernel.org/r/20230522121532.86610-1-arinc.unal@arinc9.com

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Changes in v3:
- Update the patches with the latest received trailers.
- Patch 5
  - Disable TRGMII clocks for all cases.
- Link to v2: https://lore.kernel.org/r/20240130-for-netnext-mt7530-improvements-2-v2-0-ba06f5dd9eb0@arinc9.com

Changes in v2:
- Update the patches with the latest received trailers.
- Remove 'net: dsa: mt7530: move enabling port 6 to mt7530_setup_port6()'
  which was patch 5. I will bring a more appropriate change with a later
  patch series.
- Patch 5
  - Set P6_INTF_MODE(0) and explain why on the patch log.
- Patch 6
  - Mention the MT7988 document and explain more on the patch log.
- Patch 7
  - Explain more on the patch log.
- Link to v1: https://lore.kernel.org/r/20240113102529.80371-1-arinc.unal@arinc9.com

---
Arınç ÜNAL (7):
      net: dsa: mt7530: empty default case on mt7530_setup_port5()
      net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
      net: dsa: mt7530: remove pad_setup function pointer
      net: dsa: mt7530: move XTAL check to mt7530_setup()
      net: dsa: mt7530: simplify mt7530_setup_port6() and change to void
      net: dsa: mt7530: correct port capabilities of MT7988
      net: dsa: mt7530: do not clear config->supported_interfaces

 drivers/net/dsa/mt7530.c | 152 +++++++++++++++++------------------------------
 drivers/net/dsa/mt7530.h |   3 -
 2 files changed, 53 insertions(+), 102 deletions(-)
---
base-commit: 4acf4e62cd572b0c806035046b3698f5585ab821
change-id: 20240121-for-netnext-mt7530-improvements-2-b4f43661b485

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>


