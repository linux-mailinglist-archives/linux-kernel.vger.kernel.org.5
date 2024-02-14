Return-Path: <linux-kernel+bounces-65829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A94D185528D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DEFB1F2C9F2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B5A139561;
	Wed, 14 Feb 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="HazIUWUD"
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6F112F594
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936341; cv=none; b=riyPZLyRDF4gebxl1XdLfvzqlo2E5EkFqnstFsh8p7NP5JYsWiXH07QRzQ9CFwHtSCuGdzvy0BySV0+R0PSRS9Cu+bZFy3cO5R1KNzF3p6FACMdSA50GdxeJH0jOB1wB+qDPF9lb5KrK+xniKm6PV/IQy0OjRuWzNlKPj6OVjGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936341; c=relaxed/simple;
	bh=f+Ss+Vy5U6cHed6RvKSyVpq8OJxkSd2PHhtjh/PmpPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qwglcsYTml4JRYmzcL5V+plsiNdLCVXa5V14u/1w18rjfVgfmp+egREZKKZGGFTU1TsQgo0ElQhOIqBJDQabFW/ZKroKwOco/PAjnE1uG7OgZVfRvV8HGeUopUJ1J6W35A7JWPGTm2/4LGEV6OIJWNt0xaoJuDPNR7Zcl3QfXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=HazIUWUD; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1707936338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f+Ss+Vy5U6cHed6RvKSyVpq8OJxkSd2PHhtjh/PmpPk=;
	b=HazIUWUDqyGqt7E6KTC3CzbsbOCKwRnpLQ21TJSChwD4yhtnmHI/oqjgrzeu9UxfH062nQ
	mS+HTgQjmiH9Yl3HFXi43tTVnLdAvRA1bUqLkcKJtUIg8d1WtUHaXxLDSJ8JuLHkyIIzXz
	4LKJStQwBmGJW53POAUOMsu3GV8r9T4=
Received: from g8t01559s.inc.hp.com (g8t01559s.inc.hp.com [15.72.64.153]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-qdKEUu9zPUieSwWbA3Rg_w-1; Wed, 14 Feb 2024 13:45:37 -0500
X-MC-Unique: qdKEUu9zPUieSwWbA3Rg_w-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t01559s.inc.hp.com (Postfix) with ESMTPS id E75CF2056B;
	Wed, 14 Feb 2024 18:45:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id A5C7917;
	Wed, 14 Feb 2024 18:45:33 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-kernel@vger.kernel.org,
	eniac-xw.zhang@hp.com,
	Eniac Zhang <eniacz@gmail.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: fix mute/micmute LED For HP mt645
Date: Wed, 14 Feb 2024 18:45:07 +0000
Message-Id: <20240214184507.777349-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
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

From: Eniac Zhang <eniacz@gmail.com>

The HP mt645 G7 Thin Client uses an ALC236 codec and needs the
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF quirk to make the mute and
micmute LEDs work.

There are two variants of the USB-C PD chip on this device. Each uses
a different BIOS and board ID, hence the two entries.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Cc: <stable@vger.kernel.org>
---
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


