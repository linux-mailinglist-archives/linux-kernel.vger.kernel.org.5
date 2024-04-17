Return-Path: <linux-kernel+bounces-148893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3188A88A1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A0EB25568
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16578148839;
	Wed, 17 Apr 2024 16:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9ZcRXMk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5426F1487E4;
	Wed, 17 Apr 2024 16:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370608; cv=none; b=gKX2EQZI2sJvf5qBq2Ng4esiKyJM1O06IrNREnZjEHkuWEsbLA6YbhpEvHhCMt/BianeA02jm1z+Wys6PfbbNCMb797B1AGG23WQq1oyO9ssOYBsQsOC0BQ1fQrcjUl8kDvrlXL9LjZw3L3KGcjQzJFRhCMvQVZCvbH4Zyu1ijQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370608; c=relaxed/simple;
	bh=kilas/NCA6Kdhuk9D+qD9nfskcb8RieBMJZ8E34ynxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V/kiPkc2DyKMhTbu9jdcfxYEO8v7A7ro+YwwZO7zc9aracV+/6PBs7psaNx3PVf0AezsOUiRmTwllMlBHLaSEvvYyFDlfi8SMgOR7R8d/U4GeUEnJDKXBLPSHX1zWZRTfRNtKyGjackpPhQNVqgC+U0aKdtxfy3/L15M2o3Ezww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9ZcRXMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF4FC072AA;
	Wed, 17 Apr 2024 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713370607;
	bh=kilas/NCA6Kdhuk9D+qD9nfskcb8RieBMJZ8E34ynxY=;
	h=From:To:Cc:Subject:Date:From;
	b=S9ZcRXMk8vQMJLSm6szRJ2k8dw3EFMFnx0bzhC/18VdzZEtqeZhI/08DVoOPhStvx
	 x/G6VZ2nI9FVCGk6E2Ejvkm2RJBrwIAkS6NFwEOKQcLLU2CGdrzXE8gZJeWSGNcyTo
	 u4A980F6xBA7HFbZ0m+/BtSOcb48hxey8QKP9n9GodCpaJIsu21X6JU41F3NHo9//n
	 e/dN7Hhad1JltT2lpHx4B+0AeB98BDynlAlwbgxfMBuO0elucPN6siZKv7eEKlaxj2
	 nmozZs+1Td4LTUabXZkXBnucMF0gOVRHgiWxBbDTbWJ/ShtQHPwv5zH6M07mByrOOQ
	 FIbX1lkujbNTA==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
	(envelope-from <mchehab@kernel.org>)
	id 1rx7xk-000000001F8-0268;
	Wed, 17 Apr 2024 17:16:44 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: linux-sound@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	"Luke D. Jones" <luke@ljones.dev>,
	Athaariq Ardhiansyah <foss@athaariq.my.id>,
	Jaroslav Kysela <perex@perex.cz>,
	Kailang Yang <kailang@realtek.com>,
	Matthew Anderson <ruinairas1992@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirks for Huawei Matebook D14 NBLB-WAX9N
Date: Wed, 17 Apr 2024 17:16:33 +0100
Message-ID: <b92a9e49fb504eec8416bcc6882a52de89450102.1713370457.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The headset mic requires a fixup to be properly detected/used.

As a reference, this specific model from 2021 reports
the following devices:
	https://alsa-project.org/db/?f=1a5ddeb0b151db8fe051407f5bb1c075b7dd3e4a

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 8c2467ed127e..a11d8a954e6c 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10215,6 +10215,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1462, 0xb120, "MSI Cubi MS-B120", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1462, 0xb171, "Cubi N 8GL (MS-B171)", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x152d, 0x1082, "Quanta NL3", ALC269_FIXUP_LIFEBOOK),
+	SND_PCI_QUIRK(0x152d, 0x1262, "Huawei NBLB-WAX9N", ALC2XX_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1558, 0x0353, "Clevo V35[05]SN[CDE]Q", ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1323, "Clevo N130ZU", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1558, 0x1325, "Clevo N15[01][CW]U", ALC293_FIXUP_SYSTEM76_MIC_NO_PRESENCE),
-- 
2.44.0


