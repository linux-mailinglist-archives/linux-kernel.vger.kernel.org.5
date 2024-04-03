Return-Path: <linux-kernel+bounces-130323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7568976C4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5431F2F6E6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE8615EFC6;
	Wed,  3 Apr 2024 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IZqevel2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACB415ECF6;
	Wed,  3 Apr 2024 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164733; cv=none; b=e9v7HukVJWWka/MIDpOFhF63VKwXUAgrsbQIPUc0cKDGFVpy4kiQIXfn0WZyXRnbW6o9A2ymX3xYkAUJsRux7EK0TUoblUHj0LMaEM8KU39Goxe1HxysfrPyEelAn8yF7MXvV/CO/oMX6P/XGq0j7nho+7WqdlC8+pp33ZrFvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164733; c=relaxed/simple;
	bh=IO5bfVpA8a0Mn/rD2wrtLMak+zqf/ysRgkQLGQfThU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpCU3TvyEPm9MLS1fBEWgiktZQnK/Qa04Gwr18R6xuwa3RUrifg3Iut2qqIhBdljqPN+K45BvWi4Uqo00DqcfvOfmM3WIxedyADIDjNivqQknM8wVd9HpYf9e2m3oIkPLU0ThKJ9l16zj1MzJgpNRcHyaVL1fbIChEb+sv6rX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IZqevel2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A01CC433F1;
	Wed,  3 Apr 2024 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164732;
	bh=IO5bfVpA8a0Mn/rD2wrtLMak+zqf/ysRgkQLGQfThU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZqevel22fw1HXfDxiz7HGGUmOICsKy8UsS77o/jwFm/4fl4oSvDb1XJM1FATHgAN
	 6joZ/F897AWf1hF8xv7ZOiFfipuey8EKYRujESPi21phaMJtx9xDOHfMRATQIzW7qf
	 jFqNys7iG4XjOg/EUAu4rh2f+9OLR3/YohmaGuqOYBL74PkGsWwL6lxctasLRfrbYy
	 M3Y8QcTZFYd7seN6PFIzDvt0+Z2gbgSHa12mYT03Up4FbWtmZXeqSJZbWyhl3EtaUG
	 G9GeB0Lm6wjXM+vdCiJQPjUZMUrEoPVcu0x12mtsngT69gDizj31Qig5tcCEfn7ymi
	 nxhX+HB3S0Ipg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tim Crawford <tcrawford@system76.com>,
	Jeremy Soller <jeremy@system76.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	sbinding@opensource.cirrus.com,
	kailang@realtek.com,
	luke@ljones.dev,
	shenghao-ding@ti.com,
	foss@athaariq.my.id,
	rf@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 19/20] ALSA: hda/realtek: Add quirks for some Clevo laptops
Date: Wed,  3 Apr 2024 13:18:00 -0400
Message-ID: <20240403171815.342668-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
Content-Transfer-Encoding: 8bit

From: Tim Crawford <tcrawford@system76.com>

[ Upstream commit 33affa7fb46c0c07f6c49d4ddac9dd436715064c ]

Add audio quirks to fix speaker output and headset detection on some new
Clevo models:

- L240TU (ALC245)
- PE60SNE-G (ALC1220)
- V350SNEQ (ALC245)

Co-authored-by: Jeremy Soller <jeremy@system76.com>
Signed-off-by: Tim Crawford <tcrawford@system76.com>
Message-ID: <20240319212726.62888-1-tcrawford@system76.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 88d006ac9568c..85d8c6cd27abb 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2645,6 +2645,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x65f1, "Clevo PC50HS", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x65f5, "Clevo PD50PN[NRT]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x66a2, "Clevo PE60RNE", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
+	SND_PCI_QUIRK(0x1558, 0x66a6, "Clevo PE60SN[CDE]-[GS]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x67d1, "Clevo PB71[ER][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x67e1, "Clevo PB71[DE][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x67e5, "Clevo PC70D[PRS](?:-D|-G)?", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
@@ -10023,12 +10024,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x152d, 0x1082, "Quanta NL3", ALC269_FIXUP_LIFEBOOK),
+	SND_PCI_QUIRK(0x1558, 0x0353, "Clevo V35[05]SN[CDE]Q", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1323, "Clevo N130ZU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1325, "Clevo N15[01][CW]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1401, "Clevo L140[CZ]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1403, "Clevo N140CU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1404, "Clevo N150CU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x14a1, "Clevo L141MU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
+	SND_PCI_QUIRK(0x1558, 0x2624, "Clevo L240TU", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4018, "Clevo NV40M[BE]", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4019, "Clevo NV40MZ", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x4020, "Clevo NV40MB", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.43.0


