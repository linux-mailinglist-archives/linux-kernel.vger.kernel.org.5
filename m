Return-Path: <linux-kernel+bounces-19742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2A88272B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A881C218E9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0894A99F;
	Mon,  8 Jan 2024 15:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=catboys.cloud header.i=@catboys.cloud header.b="J/wBtsoX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.catboys.cloud (mail.catboys.cloud [185.233.107.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5F4C3BB;
	Mon,  8 Jan 2024 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=catboys.cloud
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catboys.cloud
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEDE2C0B01;
	Mon,  8 Jan 2024 16:15:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catboys.cloud;
	s=dkim; t=1704726924;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language;
	bh=XYe40yUbAp9wLca9aCV+041knviU6Ai80qscE96Dorg=;
	b=J/wBtsoXaj7CU2Ph0PGKCYixSirM1JW/q/M1Fip+0ph9jIjSN4ELaiMZHdoLk/ZriUvwW5
	xsmfrOzhfQhCz0HUcSz5H6mhaf7Z+mGkjX2Lp5GQNfMvQweuAJz0hu/67rxZL03lrMs8LL
	iNTo/Ln/cQ612XdqDJ+vuK8YkdlqZxFj+Aq5r7BT1VH7wzpI1tJcEPj9dSfjF5zzIAjgNv
	4ATgArHCqrsKg3ciOkyuWHDXoLRn8utaXFN/+y0uG4OOM8qpEjEzDOj6/jgirLxACve0lc
	j2wb77ehjOMkCziB40k7er5phPVUBIIDkT6uG1YNlAGVqZWS8RT6K3kzOm+wpw==
Message-ID: <651b26e9-e86b-45dd-aa90-3e43d6b99823@catboys.cloud>
Date: Mon, 8 Jan 2024 16:15:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Tom Jason Schwanke <tom@catboys.cloud>
Subject: [PATCH] ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy
 X360 13-ay0xxx
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

This enables the mute and mic-mute LEDs on the HP Envy X360 13-ay0xxx convertibles.
The quirk 'ALC245_FIXUP_HP_X360_MUTE_LEDS' already exists and is now enabled for this device.
Fixes https://bugzilla.kernel.org/show_bug.cgi?id=216197

Signed-off-by: Tom Jason Schwanke <tom@catboys.cloud>
---
  sound/pci/hda/patch_realtek.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 1dcfba27e075..475d7e843ed3 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9875,6 +9875,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
         SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
         SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
         SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+       SND_PCI_QUIRK(0x103c, 0x876E, "HP ENVY x360 Convertible 13-ay0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
         SND_PCI_QUIRK(0x103c, 0x888a, "HP ENVY x360 Convertible 15-eu0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
         SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
         SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
---


