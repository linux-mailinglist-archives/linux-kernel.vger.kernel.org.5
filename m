Return-Path: <linux-kernel+bounces-26917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4283382E7D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 03:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9B21C22C84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB529AD;
	Tue, 16 Jan 2024 02:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="hIz5LCPN"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E6D38C;
	Tue, 16 Jan 2024 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.200.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id BCE413F24E;
	Tue, 16 Jan 2024 02:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705370904;
	bh=TXWQTtrX0W6hq4HrMu5964Ajg8E/3U66zO5MnWRJ90Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=hIz5LCPNMpeb4+xXz/OOolPfcA5R0kLA0iULHSO3f991nC+4jUxEzuwyiLDPTvjhg
	 f8AUzP14i67BHo7PC0+hDoV6BCNspohdGunFd7Mola806QcPwQhRKRD/uaxfpIrjFc
	 YZhbE/pU78C8x3ieusWIyPmYH7SCXpNkgo3/l1Tu2/eZoUpKe2F4IkEGQoPV7SnX3L
	 vCq0shdXKzcNmKaJkrFWhLDsNHCtX4uRG6enkuvEbGyB5jWZurro8ItwgZjIfgL7he
	 kLDUTgrlrjDkVzmDngcCxJqWzXl9nyUkJIeL75OOsQzv8HfOEansqY5o+c+RPxANVf
	 ITPVChzD6jhIw==
From: Yo-Jung Lin <leo.lin@canonical.com>
To: 
Cc: leo.lin@canonical.com,
	andy.chi@canonical.com,
	0xff07@gmail.com,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on HP ZBook
Date: Tue, 16 Jan 2024 10:07:19 +0800
Message-Id: <20240116020722.27236-1-leo.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some HP ZBooks, the audio LEDs can be enabled by
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF. So use it accordingly.

Signed-off-by: Yo-Jung Lin <leo.lin@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b68c94757051..311c4eee9770 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9955,6 +9955,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
-- 
2.34.1


