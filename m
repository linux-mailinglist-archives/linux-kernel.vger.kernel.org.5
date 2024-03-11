Return-Path: <linux-kernel+bounces-99380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5089D878790
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82AD81C21776
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD0055C3E;
	Mon, 11 Mar 2024 18:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rpOqJdYq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DFC58207;
	Mon, 11 Mar 2024 18:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182214; cv=none; b=n0ITi06zAltjyIR0ybpF5gTad0sJBqm8nHtjNTtiteJmxOBRFAgr+KTaxILm3UNKe6cjc6nxrld3fjpzzmYbdDkuJFSDvKIIoBREc2nhHyFQIvi4YnMJ/VJchFKZvZ7Zd8xwA3OVAi51o41M7LVKj90tqzoCTIYkruD4Hr/paEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182214; c=relaxed/simple;
	bh=IA2auWJWODwH5z1b1RuFSmAMwQl9MlpFfPqkOuWvdOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bs6Yz3s62tLzdC3w30GqLe+RIyiYy9YvTcui+9Pxv/jmxIH3Dxwm/y6sm0AqDSQn7Jj50GXVQOmmdP/hifQGoWqrhfvxhfPfIV/1MwTThweL6XyfzKkRsC61t4eHcvxVhIHA2Ga2rRzRqw9H0vTemdm5amDQHv4Zn5kqcJvbZVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rpOqJdYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54796C43390;
	Mon, 11 Mar 2024 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182214;
	bh=IA2auWJWODwH5z1b1RuFSmAMwQl9MlpFfPqkOuWvdOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpOqJdYqvFyWmjgHhSacPme38u+RKS6kXpQiyy0mnkqcK+ARSTV3FLb675wxuyMvs
	 cHGDULO/Ozy/Fjed1vU80CUgG/03/acODeiWCvTuhM1RLX87voTJ9G/Rc6H8KrKaYb
	 f5SyvkBpL2jTD8kUzdYzX9uPypux3FyoboxmtY/CoIdjCfSYXC91r44w4vH4mfpk80
	 Zn8uIxSZReXTIm47XxENX8ojejLdF1E2InJqWYF/InkJ2Hok80In09QpEealKqpa7+
	 PG5wvZn0dygQZOym516LOJs3si1rFzR9FpE0CNkyxWWgaktNUDSLEOAanja5Y1F2Nl
	 OgYULTjfNYWAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	gregkh@linuxfoundation.org,
	kailang@realtek.com,
	jian-hong@endlessm.com,
	bin.li@canonical.com,
	jeremy.szu@canonical.com,
	jin@mediatomb.cc,
	hui.wang@canonical.com,
	edward@edward-p.xyz,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.7 06/14] ALSA: hda/realtek: Add quirks for Lenovo Thinkbook 16P laptops
Date: Mon, 11 Mar 2024 14:36:09 -0400
Message-ID: <20240311183618.327694-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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
index eb45e5c3db8c6..9590fd31441bc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10288,6 +10288,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
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


