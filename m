Return-Path: <linux-kernel+bounces-32464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD97835BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405631C23FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2E2175B0;
	Mon, 22 Jan 2024 07:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="tFq/h1QD"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4E16410;
	Mon, 22 Jan 2024 07:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909763; cv=none; b=tG6lkd9MUAJPcGB7dHmDQ5urBym9E6nawvW0hK/HFXE8gUe2D6gZvyoo0jPrCAP2EpFhm2g0MMgrTsBFAdGNdZf86OcbeHyLi4xS6SrM86aYuspxFkOYhyqCw7bZcI4kwAiu/RHvNyWXKc7nck8XuZL1rtk5tey8mx7mfIsk1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909763; c=relaxed/simple;
	bh=97zl6QgN9oNdGLUgQ8fFwCeVMViCX/2lSXi6MIcNxlc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rZbYPHt0E8CXro2RyuMeThxflaZYwOxINrDxrrYoPPEukudYTE+PRa+WZ/cShA30Pwv+gXvYUgfOCSP4EAjod+zZlfhI9wGF4y09ZPm4FVjFoD7M2unjJvPbZprKzfkVfbpq8+fqEupYSQ5wIAA5gH8aQ6YkJdMr54tdQPzH4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=tFq/h1QD; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (unknown [10.101.197.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 3EF583FB77;
	Mon, 22 Jan 2024 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705909753;
	bh=8MR2CHTpKy5z3N+uu2SQ+FkKZNYuDPWJMZj4SqZeOr8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=tFq/h1QD+OTwt/eb0GRwrY7ui7KbbPi6PQqNBBi/HwQI53rmGeOuejNlknF6yetCg
	 1Q5Q8ClAM00M7jNgjbVludyX2S/7YRHKVK9/rdaXJHit7nSAIhTfJ968Tz0kiPgPfX
	 hyji4may9/UjmLXGWuewOqPRV0OaxzMnKP6jfLrnHZIiWYlapGOJTAk2023o8+OXnY
	 a+rv0jG+Q27XZtrBW8jRi9q8fLhYOi3NTalYzXVCN2a3Jd9/TJ4124vthfaSKSdiOH
	 VWMNzfQY02TJTiDarkgWYr0MxDDwIF3omHaKkcJSsHplf+vmn+Sao0YBKW9FM2NfP+
	 JHNbdiY0YYBrw==
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
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power
Date: Mon, 22 Jan 2024 15:48:24 +0800
Message-Id: <20240122074826.1020964-1-andy.chi@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HP ZBook Power using ALC236 codec which using 0x02 to
control mute LED and 0x01 to control micmute LED.
Therefore, add a quirk to make it works.

Signed-off-by: Andy Chi <andy.chi@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f6f16622f9cc..19f2eb26659d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9957,6 +9957,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8c72, "HP EliteBook 865 G11", ALC287_FIXUP_CS35L41_I2C_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8c97, "HP ZBook", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8ca1, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8ca2, "HP ZBook Power", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca4, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ca7, "HP ZBook Fury", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8cf5, "HP ZBook Studio 16", ALC245_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
-- 
2.34.1


