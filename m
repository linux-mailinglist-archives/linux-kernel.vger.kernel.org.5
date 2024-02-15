Return-Path: <linux-kernel+bounces-67240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B41C85687A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8841C2288E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A292133996;
	Thu, 15 Feb 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="DPdt9LWk"
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94952133982
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708012196; cv=none; b=tX1SZeF0KIrKqyZQptSR4joXBLN5iUJa+Du3ahxGWLUnqCmX2NhVP855OpT7+uplUuijs7gDrFX7WupbfDuenzy9ogYT8uas5gtoScB+R4f9HyArIMD8YFKMCfjQkd4UieZdvNICNgauUIfEIR2CpjvdeERrdmRRTmoDqq99fLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708012196; c=relaxed/simple;
	bh=0UxlDs5v98il8Yvx5898jp0zflTPlEd7LBBWGgaz4vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qthzddX4unHVoVHArXN4PzFSipoa7Jm56Pfw+9q/AQnhUry9+XXtBcX4f2flz1AE3TZxdpY4JhDnWBZG+ps/eLrHfeZYGJ/5LMYM9nscEbwWPrvFMlbNh/RkCWb8lXdbvaa2CLQUsao8HX7F/1QOjTEI8eAJPtwtP6s2VdDySRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=DPdt9LWk; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1708012193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0UxlDs5v98il8Yvx5898jp0zflTPlEd7LBBWGgaz4vE=;
	b=DPdt9LWkOPjBXUEiNVNUIQMGOD6ZyBi/Qy/zg3jWugvbGgcyYVw3QJFQrVi2d1MB753gat
	mXtuCHl9R5veWpyLJzRcEB6W6fdnOYp7XVGbu8c2HZMo0bGvUe0tUONJ1C923NP64RiKiH
	lXbNMzBqGl2L22GhxML7YSBL1luXaGg=
Received: from g8t01560s.inc.hp.com (g8t01560s.inc.hp.com [15.72.64.154]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-5jmfhb03Pduo__cOpimguQ-1; Thu, 15 Feb 2024 10:49:52 -0500
X-MC-Unique: 5jmfhb03Pduo__cOpimguQ-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t01560s.inc.hp.com (Postfix) with ESMTPS id 06CD720399;
	Thu, 15 Feb 2024 15:49:50 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id C23FF17;
	Thu, 15 Feb 2024 15:49:48 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	eniac-xw.zhang@hp.com,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ALSA: hda/realtek: fix mute/micmute LED For HP mt645
Date: Thu, 15 Feb 2024 15:49:22 +0000
Message-Id: <20240215154922.778394-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87frxteoil.wl-tiwai@suse.de>
References: <87frxteoil.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

From: Eniac Zhang <eniac-xw.zhang@hp.com>

The HP mt645 G7 Thin Client uses an ALC236 codec and needs the
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make the mute and
micmute LEDs work.

There are two variants of the USB-C PD chip on this device. Each uses
a different BIOS and board ID, hence the two entries.

Signed-off-by: Eniac Zhang <eniac-xw.zhang@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: <stable@vger.kernel.org>
---

Changes since version 1:
 - Adjusted Signed-off-by lines to include original author.

 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 6994c4c5073c..c837470ef5b8 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9928,6 +9928,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 =09SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS=
35L41_SPI_2_HP_GPIO_LED),
 =09SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC"=
, ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 =09SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC"=
, ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+=09SND_PCI_QUIRK(0x103c, 0x8b0f, "HP Elite mt645 G7 Mobile Thin Client U81=
", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 =09SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", ALC23=
6_FIXUP_HP_MUTE_LED_COEFBIT2),
 =09SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_=
LED),
 =09SND_PCI_QUIRK(0x103c, 0x8b43, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_=
LED),
@@ -9935,6 +9936,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 =09SND_PCI_QUIRK(0x103c, 0x8b45, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_=
LED),
 =09SND_PCI_QUIRK(0x103c, 0x8b46, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_=
LED),
 =09SND_PCI_QUIRK(0x103c, 0x8b47, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_=
LED),
+=09SND_PCI_QUIRK(0x103c, 0x8b59, "HP Elite mt645 G7 Mobile Thin Client U89=
", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 =09SND_PCI_QUIRK(0x103c, 0x8b5d, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VR=
EF),
 =09SND_PCI_QUIRK(0x103c, 0x8b5e, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VR=
EF),
 =09SND_PCI_QUIRK(0x103c, 0x8b63, "HP Elite Dragonfly 13.5 inch G4", ALC245=
_FIXUP_CS35L41_SPI_4_HP_GPIO_LED),
--=20
2.42.0


