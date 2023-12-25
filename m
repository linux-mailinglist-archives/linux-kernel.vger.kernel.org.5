Return-Path: <linux-kernel+bounces-11142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BEC81E1F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 19:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D69071C2124D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C302537E7;
	Mon, 25 Dec 2023 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkZSt71s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C29253E24;
	Mon, 25 Dec 2023 18:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso39654355e9.2;
        Mon, 25 Dec 2023 10:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703528042; x=1704132842; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rz81Z+AsrglFOvFGWIx/vdHHlB2ARV8OVKRT2IbjlJE=;
        b=LkZSt71std6SfDismfeOiJg2rVTb6A5Tiq21rf2QC07dKNoEhwVyGph5Ccf/7CGAdd
         /+MNJvuJ27e14eUgd3oWGrdvpgFaH/mixO3seBDqINH/y+aZFerIYtqvhPAJD9+kzoBf
         g5Kof0hLry4nBruiXp08RwqRC3yjJPSLc16sWieebFzIWZZiQ7g8OvKTvylR1dUfO///
         D1Bj9BmFQovJnGG3IVMr447VAzNo9rE+2+ZzWS7XdBHUbRfDFIsKaGPzQZmLdbTWk0Uu
         OBl05AhqINihs0J1ckBh9fYgl90Xx8wdJbfDLVb8S22jCmtRif9/Xf6LoTVJT6dDpOal
         dYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703528042; x=1704132842;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rz81Z+AsrglFOvFGWIx/vdHHlB2ARV8OVKRT2IbjlJE=;
        b=YerrxOXeXRowrE1LRs1GYHy0ot1n6IFM+CDhzc1Ot3hzXnoinSwOYU3ArEvggGJaBO
         kNdiLRQXqRygnaDG6KWO5okFbs76ieBHabLXTe0sKxBc0u+5G+kPEJEBgsB1fFvHYtc4
         dKbaDAyQQJGiBluoMsBQUr2qtERj9oJLFSHRgPDzDCSQZwukhj/m+SqrDHS/rPBCC3+4
         cZhH8D5YSN5e8XjTzGGE9NwdPUj1Q+UZBHi3nuI9Cdx5vcBG/rLuhMG5YsnA10HJChjR
         +g3K5HsgtTgIgnTJzeYf/08uyVZ8XPWMTBks2WiqDFqkNGgh4JvHXzBnRvveOT+zNoC9
         7zYg==
X-Gm-Message-State: AOJu0Yxzys7tS7gGysU35STEWC9jADMkOrGNjuvBSAj0oBjzv765qcCQ
	4CAwWpZRtbHE1A0IUDg01o8=
X-Google-Smtp-Source: AGHT+IHsCJppzurm5GNWQBN+9kFR/KLp8m/kudotLA7VKadEEEmMdxDHCJg6uOmq586jCvIkIzsTeQ==
X-Received: by 2002:a05:600c:1390:b0:40c:6c80:efa4 with SMTP id u16-20020a05600c139000b0040c6c80efa4mr3641775wmf.35.1703528042273;
        Mon, 25 Dec 2023 10:14:02 -0800 (PST)
Received: from localhost.localdomain ([2a02:842a:1ce:5301:f733:18af:2fff:3d3d])
        by smtp.gmail.com with ESMTPSA id jg7-20020a05600ca00700b0040c46719966sm25640085wmb.25.2023.12.25.10.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 10:14:02 -0800 (PST)
From: Dorian Cruveiller <doriancruveiller@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	andy.chi@canonical.com,
	shenghao-ding@ti.com,
	ruinairas1992@gmail.com,
	l.guzenko@web.de,
	yangyuchi66@gmail.com,
	vitalyr@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Dorian Cruveiller <doriancruveiller@gmail.com>
Subject: [PATCH] Add support for cirrus cs35l41 sound amplifier
Date: Mon, 25 Dec 2023 19:13:52 +0100
Message-ID: <20231225181352.185455-1-doriancruveiller@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link up the realtek audio chip to the cirrus cs35l41 sound amplifier chip
on 2 two models of the Lenovo legion slim 7 gen 8 (2023). These models are
16IRH8 and 16APH8.

Signed-off-by: Dorian Cruveiller <doriancruveiller@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c3a756528886..d8c8bb4c71b7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10208,6 +10208,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3819, "Lenovo 13s Gen2 ITL", ALC287_FIXUP_13S_GEN2_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3820, "Yoga Duet 7 13ITL6", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3824, "Legion Y9000X 2020", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
+	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3827, "Ideapad S740", ALC285_FIXUP_IDEAPAD_S740_COEF),
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x383d, "Legion Y9000X 2019", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
-- 
2.43.0


