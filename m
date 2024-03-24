Return-Path: <linux-kernel+bounces-115320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B15F889AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC61E1C336AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125061DF0FC;
	Mon, 25 Mar 2024 02:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xkpx9r+I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAC580046;
	Sun, 24 Mar 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320512; cv=none; b=dWDSyAs0RywNGDQk6ZpsgmFB86z0pEkFDz/iJLyqXmE+V4j5sBd38jOqxynZR4uhx5VmHTwO6qjrL7s955aljjje0Av9KxA/BfHSvlC9iDpEzEfLPJ1Twkd2KvaIW/Uqeh5eUUHSTXp4cY9JG/BJ91ss6pqIr9exYAwAqrr+BvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320512; c=relaxed/simple;
	bh=0EowKxSuj9Iounah89l3Kjvg/Er0LQCGF6R7b/uy6FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEIVpBxQ3LvyFfxoJQk/HxNXTuIbMTeBds0EfZ/S/DLT/P/WI5aWXzNytBzH/fIV2BTo9A5Em2o9ktf0XYDXnFhUgDbSVfPBm6ojvYCK6AVqdF9jnJGhiAd1yLBkgQTZU0oTT5+fF47f6DK9bGyst4bPueOqU2jKLhjligenYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xkpx9r+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1B2C43399;
	Sun, 24 Mar 2024 22:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320512;
	bh=0EowKxSuj9Iounah89l3Kjvg/Er0LQCGF6R7b/uy6FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xkpx9r+IBayNo0nlQ0DCjdVYyn7cSJQJIuJJMGAu2hWWE9F7jdg0M3vnKzvaQdzJv
	 c+x4MY5DKJ1qu8ktP8wb7McyqzB5SNaMHYTX7ThLgQ4SHKnqnDYEfBG1uL/VdUs7J5
	 ZPqIe61WWZbhA8qsGzPyIcVWS8Yf4J3w+KhKE8wOis9p/niBgVXCKzdYssJe2WbxZ0
	 vbD7LyTcCiA0CYzwCnCO9MKMLQm+Ex+EEl3Mx84n650OEwZzYypImxmJwj8qR57i5v
	 9p2kRuOBs+iPQx5J1GjbflAuuQnjK5SKaVhpScBExxLmX8lqaKL7+F6y+mwPZuMZ1z
	 Inoba3WeUsKcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 072/713] ALSA: hda/realtek: Add quirks for Lenovo Thinkbook 16P laptops
Date: Sun, 24 Mar 2024 18:36:38 -0400
Message-ID: <20240324224720.1345309-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 6214e24cae9b10a7c1572f99552610a24614fffe ]

These models use 2 CS35L41 amps with HDA using I2C.
Both models have _DSD support inside cs35l41_hda_property.c.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218437

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240301160154.158398-3-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index ebde2ea8fa812..baf550b5a7c49 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10289,6 +10289,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38a9, "Thinkbook 16P", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.43.0


