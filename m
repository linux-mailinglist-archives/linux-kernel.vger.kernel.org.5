Return-Path: <linux-kernel+bounces-130300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D3189768F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362151F21F88
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186EE15886B;
	Wed,  3 Apr 2024 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ulb12ZgW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54093158860;
	Wed,  3 Apr 2024 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164671; cv=none; b=HFnEAzM8jPuWH2Vz7qWTBEG2z0hEhLWYmwFneHtCUftv2/Jbu0XUaAQeMzzQjDbsk6R/xw1pzpVOdXZB0HCFOPbjZDVs8ky/cUmwsAVswj5bLTbnlPoW3tgN0TRYRBpaf0m22ZwgM5dlHr21ktV0ssf+eIKi/8C27wtAeWpLYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164671; c=relaxed/simple;
	bh=swLYWF+zuzZuzar6dZuK7XxalBoEyFnUH/kVyvk0etI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/sQDjYsvxNyw0G4FWuYW5NxldoeRPwiYAW0G0Bwh40qiz0dV621lO6b+Vb0QyA94M3y/by5WK8wbNoOsLzV3oEGa9LZpqqe4Qi0fKezd2ozhoj/XPBuX+119z07blkMzUE1Foba1UdrZdjV5KIzwbPuPqBXHEzjxnpg1O8IwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ulb12ZgW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB80AC433F1;
	Wed,  3 Apr 2024 17:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164671;
	bh=swLYWF+zuzZuzar6dZuK7XxalBoEyFnUH/kVyvk0etI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ulb12ZgW+ax3sbFmDWOXg+0KBgc9spJA3E0Iilr3uXn/frr2t2xco+CgHUFb7mOD4
	 F8IVCGD7U64XaiLia4PKbgMpd4+RrJZrx1u5wQxpPQmj3/1Fuie3O3chj3Znt7nzx2
	 MYN1gmoQngumBcSQSqMZW6mJ88kbz8C0tWqR9bwe6KOAx/Pq2WMFGNxD4R8Bqk8GRo
	 YzZKIf+1sVqBWvugazdTJwEyGQRjxw4gujsQF8gSCtcz4uYeuQsaryWfomwabqjXAe
	 lJKaUpmmJBi8NA9scuemSLxOo7tf1z1jFdZB2vhBzkwdSqIHbSXPONB3nAmMpuUPFO
	 S9/odexS4+2TA==
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
Subject: [PATCH AUTOSEL 6.8 26/28] ALSA: hda/realtek: Add quirks for some Clevo laptops
Date: Wed,  3 Apr 2024 13:16:28 -0400
Message-ID: <20240403171656.335224-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
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
index a1facdb98d9a0..3e66c8971a039 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -2646,6 +2646,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1558, 0x65f1, "Clevo PC50HS", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x65f5, "Clevo PD50PN[NRT]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x66a2, "Clevo PE60RNE", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
+	SND_PCI_QUIRK(0x1558, 0x66a6, "Clevo PE60SN[CDE]-[GS]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x67d1, "Clevo PB71[ER][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x67e1, "Clevo PB71[DE][CDF]", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
 	SND_PCI_QUIRK(0x1558, 0x67e5, "Clevo PC70D[PRS](?:-D|-G)?", ALC1220_FIXUP_CLEVO_PB51ED_PINS),
@@ -10145,12 +10146,14 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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


