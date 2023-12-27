Return-Path: <linux-kernel+bounces-11821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B7381EC1D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09B428315C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797443D8E;
	Wed, 27 Dec 2023 04:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="isV3WURp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3428E7;
	Wed, 27 Dec 2023 04:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF63F1C0002;
	Wed, 27 Dec 2023 04:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
	t=1703652244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KyZYUwIL+GECnJEDu0681TxzHfLMsOSxLyHQOS5nnHg=;
	b=isV3WURpIRSf8KfHmijCsKeaKpbSjYPjygSBy9irtSWxUF0+GqpTu66fsPt6x2WYTePt8Q
	Rcej7z/VIkv/kPCjxCCd9/YfZNW7dRsf4lQfqCm+ILI+a9ab7n4QMjx4/rVKONBKRp0677
	ltZPFEGjIUZZo21BydqnWOU51RW7toKuP1jE3pTAALTpk5r/SmQDkNVZcIGAzyScMO2Fkw
	G5FedzT9NVlau1oUpjIlltVUCzPQRono4W5Ab7Qd1ZLBU+dN/A/49sncUFtMuD5WAJUS1M
	kq4mWTzReBQHHVVtq1l9Hr7uGDVBNiQ6UFAhn8r5SrM06e0yzNO8GLvMaJOi8w==
From: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Bartel Eerdekens <bartel.eerdekens@constell8.be>,
	mithat.guner@xeront.com,
	erkin.bozoglu@xeront.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v2 0/7] MT7530 DSA Subdriver Improvements Act I
Date: Wed, 27 Dec 2023 07:43:40 +0300
Message-Id: <20231227044347.107291-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com

Hello!

This patch series simplifies the MT7530 DSA subdriver and improves the
logic of the support for MT7530, MT7531, and the switch on the MT7988 SoC.

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

https://lore.kernel.org/netdev/20230522121532.86610-1-arinc.unal@arinc9.com/

v1: https://lore.kernel.org/netdev/20231118123205.266819-1-arinc.unal@arinc9.com/

Arınç

v2:
- Shorten the patch series, include only 7 patches.
- Add the reviewed-by tags given.
- Patch 1
  - Change variable ordering of mt753x_conduit_state_change().
  - Define the mask variable and store BIT(cpu_dp->index) on it.
  - Disable CPU_EN if priv->active_cpu_ports is 0.
- Patch 5
	- On the patch log, take the irrelevant information about the
    mt7530_setup_port5() call from mt7530_setup() out.
- Patch 6
  - Change the patch log to reflect correct information.

Arınç ÜNAL (7):
  net: dsa: mt7530: always trap frames to active CPU port on MT7530
  net: dsa: mt7530: use p5_interface_select as data type for p5_intf_sel
  net: dsa: mt7530: store port 5 SGMII capability of MT7531
  net: dsa: mt7530: improve comments regarding port 5 and 6
  net: dsa: mt7530: improve code path for setting up port 5
  net: dsa: mt7530: do not set priv->p5_interface on mt7530_setup_port5()
  net: dsa: mt7530: do not run mt7530_setup_port5() if port 5 is disabled

 drivers/net/dsa/mt7530-mdio.c |   7 +-
 drivers/net/dsa/mt7530.c      | 139 +++++++++++++++++++++----------------
 drivers/net/dsa/mt7530.h      |  16 +++--
 3 files changed, 91 insertions(+), 71 deletions(-)



