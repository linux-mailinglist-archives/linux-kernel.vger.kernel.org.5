Return-Path: <linux-kernel+bounces-13993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F6F821695
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8250F281ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE21ED6;
	Tue,  2 Jan 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="ls3Hry8I"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B397EBC;
	Tue,  2 Jan 2024 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.197.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 872E83F2AE;
	Tue,  2 Jan 2024 02:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1704163818;
	bh=EWkKSm+nN6fBmS9JU50EaFN7HE3LdA/HGHMNIUbvCq4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=ls3Hry8IzfVXSA836/9OxoK9XjBXgHxcKgvwcyT9rXghBgKEeSH0SFBaaNY4J0+J5
	 Uc0RmnN85cpCRc03ffP40NkY6h/EMqvYxvfVnWVu8XxHarQ+J6vnq3Gnk/hZJqWIxO
	 czP7CaM8W65GAWDhTSm/2LnDUGIuUU+cbi42AnzkLWq9LEx4O/iiqvbUnwebzySr0n
	 enZmEn9pfiHhl3xyFT2m/lHKPaw/vYw9btu4XDjaBNHr3qD162sdXlsa76pm/0XXIm
	 B9g2ZryVXVWxrqV8JgWy21NB3UachkNE0sP0LO3qw+NhJPsveQ4deX4MNiU6J4it9l
	 fLqsxjtIY03lA==
From: Andy Chi <andy.chi@canonical.com>
To: 
Cc: andy.chi@canonical.com,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Kailang Yang <kailang@realtek.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Luka Guzenko <l.guzenko@web.de>,
	Yuchi Yang <yangyuchi66@gmail.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook
Date: Tue,  2 Jan 2024 10:49:15 +0800
Message-Id: <20240102024916.19093-1-andy.chi@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a HP ZBook which using ALC236 codec and need the
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make mute LED
and micmute LED work.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 7e9d8c1cedfc..1c8d5b58eb64 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9939,6 +9939,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c70, "HP EliteBook 835 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c71, "HP EliteBook 845 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
-- 
2.34.1


