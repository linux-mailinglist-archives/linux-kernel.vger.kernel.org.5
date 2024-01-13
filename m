Return-Path: <linux-kernel+bounces-25181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB3682C92B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 03:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F6471F25127
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C462748A;
	Sat, 13 Jan 2024 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=marun.edu.tr header.i=@marun.edu.tr header.b="IeawEYCX"
Received: from mx1.marmara.edu.tr (mx1.marmara.edu.tr [193.140.143.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B82CA78;
	Sat, 13 Jan 2024 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marun.edu.tr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marun.edu.tr
Received: from mx1.marmara.edu.tr (localhost.localdomain [127.0.0.1])
	by mx1.marmara.edu.tr (Proxmox) with ESMTP id DFD418463D;
	Sat, 13 Jan 2024 05:37:44 +0300 (+03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marun.edu.tr; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:message-id:mime-version:reply-to:subject:subject:to
	:to; s=mx; bh=enLySNBZNDXysPx4FKcckBCSCxA9UJHEJk2lktUGMLk=; b=Ie
	awEYCXKd0FMy1qG1y1mchL7xZiVpcjj2xqsJDKlecWhwSheAvE6onkIoJbKa+kPX
	M1aapx6E564+WdMoI0XJxYRyw8k3CW+ZjiKUFf9OIs10LmvBkzaW87+j+XhoRsYP
	d435+DqBdMU1UsELOslWZp+C1Zg9aVzxhEA4mLY4vjJj/FxbDpOIJqr8fesueetx
	AymR81Jpzgy2tDL3V1BH4Ajp2naQkdX4zHnkA0JRMQV1nyDWGH6571fAbvbTuYiP
	OgEbkrgd+rKBbO5B7llHn+S5u7/fnFpK5YeHNE40oCHJ/fEYf4jY+0lmvq+M8Odg
	IynSPgaWsofyQLZzE8cj//ZP3rTNdjef2/iyep8s1aA6jVEtkC1SxFKNdpZT9iRb
	yK59vFXHwWClKsGW9GpOSMdBSyMN85jGiU+X9MV3tdqhjC45lDpeoc92U9DT+Diq
	c7OHs+hDlR+C8i4wn8HOsNCVu1JHs2/qWjvS/3pIIVzjv/h4kOy66R5Jey3fYyKK
	cAGFzN0Vs/XEiuDmZN0HEPhM5a17q69ba3ny4TSj/bqum2R4U0ML525+kZIWkqWy
	RO/JK3O1bFXFoADEAe0g7bARGexDjxF7xWGcWMkQMTWHx+CBvuLQwUkT4bByAnAM
	qiS7+PyB5pR7VdV2UYAjU2ZDBwHqy6d5gETByvfzU=
From: =?UTF-8?q?=C3=87a=C4=9Fhan=20Demir?= <caghandemir@marun.edu.tr>
To: 
Cc: =?UTF-8?q?=C3=87a=C4=9Fhan=20Demir?= <caghandemir@marun.edu.tr>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx
Date: Sat, 13 Jan 2024 05:37:33 +0300
Message-ID: <20240113023734.10817-2-caghandemir@marun.edu.tr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This HP Laptop uses ALC236 codec with COEF 0x07 idx 1 controlling
the mute LED. This patch enables the already existing quirk for
this device.

Signed-off-by: Çağhan Demir <caghandemir@marun.edu.tr>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b68c94757..124bee526 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9876,6 +9876,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8870, "HP ZBook Fury 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8873, "HP ZBook Studio 15.6 Inch G8 Mobile Workstation PC", ALC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x887a, "HP Laptop 15s-eq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x87FE, "HP Laptop 15s-fq2xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x888a, "HP ENVY x360 Convertible 15-eu0xxx", ALC245_FIXUP_HP_X360_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x888d, "HP ZBook Power 15.6 inch G8 Mobile Workstation PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8895, "HP EliteBook 855 G8 Notebook PC", ALC285_FIXUP_HP_SPEAKERS_MICMUTE_LED),
-- 
2.43.0



--
Bu e-posta mesajı ve içeriği gizli veya özel bilgiler içerebilir. Mesajın içeriğinde bulunan tüm fikir ve görüşler sadece göndericiye ait olup, Marmara Üniversitesi’nin resmi görüşünü yansıtmaz. Kurumumuz bu e-posta içeriğindeki bilgilerin kullanılması nedeniyle hiç kimseye karşı sorumlu tutulamaz. Mesajın belirlenen alıcılardan biri değilseniz, mesaj içeriğini ya da eklerini kullanmayınız, kopyalamayınız, yaymayınız, başka kişilere yönlendirmeyiniz ve mesajı gönderen kişiyi derhal e-posta yoluyla haberdar ederek bu mesajı ve eklerini herhangi bir kopyasını muhafaza etmeksizin siliniz. Kurumumuz size, mesajın ve bilgilerinin değişikliğe uğramaması, bütünlüğünün ve gizliliğin korunması konusunda garanti vermemekte olup, e-posta içeriğine yetkisiz olarak yapılan müdahale, virüs içermesi ve/veya bilgisayar sisteminize verebileceği herhangi bir zarardan da sorumlu değildir.This e-mail message and its content may cont
 ain confidential or proprietary information. All ideas and opinions contained in the message are solely those of the sender and do not reflect the official opinion of Marmara University. Our institution cannot be held responsible to anyone for the use of the information contained in this e-mail. If you are not one of the designated recipients of the message, do not use, copy, disseminate, forward the message content or attachments, and immediately notify the sender of the message via e-mail and delete this message and its attachments without retaining any copies. Our institution does not guarantee you that the message and its information will not be changed, its integrity and confidentiality will be protected, and is not responsible for any unauthorized intervention to the e-mail content, viruses and/or any damage it may cause to your computer system.


