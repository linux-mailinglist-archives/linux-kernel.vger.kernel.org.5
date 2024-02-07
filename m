Return-Path: <linux-kernel+bounces-57121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F9284D43B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1202865CC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED8014A0A7;
	Wed,  7 Feb 2024 21:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8ni/tPo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75331272BC;
	Wed,  7 Feb 2024 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341040; cv=none; b=PCmG54BBC5sqYmY/VW/6hncEZsZmRtyIQO4Qln5gTV/aj29gc9KmDBUxgH22strQDnmGUiSyOSk4I/ALPtluoexUdiJnGIC6d0lv7LkVdHO2kB8/aZD441KokT/PqH4lCqujO+Ean1WdSD16R28h9AiNjbMnSCbUoEn4VjJjkiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341040; c=relaxed/simple;
	bh=N5V2nVbrJQTw4/4WWF2aUk4OcKbWlNp0VXU/eTyPBto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWgMk0dR4Fru0IxI5O726DZcc9cgr8QtDbS6n0b343bikfo8iueOuBDvnxQiZ/282yKucPC1QWNnGhwaRGQdYvzfKZamwhffhDcea/AtiA1T5KeC+49gKBhYu9cTy81KRoQgO9AdCVZwBb1o9JlGypVrH3VmPiHuATHoOB+ZDlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8ni/tPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADBCDC43390;
	Wed,  7 Feb 2024 21:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341039;
	bh=N5V2nVbrJQTw4/4WWF2aUk4OcKbWlNp0VXU/eTyPBto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8ni/tPoAwhbJ32VYoG/dIB3CcQzaI7zhuPleo2fr1zAr/Ra01PGisq5a+tMh4X6z
	 DZGH9j1SBeSb+lVk2k8Mwy0pwlk9Z4hdVC5IXIpyriLRJIRJzz8cO41E8P8gnkhtkf
	 ALIMmMgF/911avjgMVcGM5A3wtbQxNqD4d/W6hTo9jqHjMHNBPeM4LcrFLjhlGWuvi
	 BiNBrZvxlLEADg+j55yIIWFYzrJEIuWbC1664JhoJHe/0XmBRGyc6IH1u0Ve/JrFfp
	 QAjHyLnm+ap1FvzQv5yeBVKFAz75wNq/tqHhEcWVFcEKpO8HW5vKUTgmutaarL7M8g
	 7fSVns5fz6hVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rui Salvaterra <rsalvaterra@gmail.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	kai.vehmanen@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	siyanteng@loongson.cn,
	jasontao@glenfly.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/38] ALSA: hda: Increase default bdl_pos_adj for Apollo Lake
Date: Wed,  7 Feb 2024 16:22:57 -0500
Message-ID: <20240207212337.2351-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Rui Salvaterra <rsalvaterra@gmail.com>

[ Upstream commit 56beedc88405fd8022edfd1c2e63d1bc6c95efcb ]

Apollo Lake seems to also suffer from IRQ timing issues. After being up for ~4
minutes, a Pentium N4200 system ends up falling back to workqueue-based IRQ
handling:

[  208.019906] snd_hda_intel 0000:00:0e.0: IRQ timing workaround is activated
for card #0. Suggest a bigger bdl_pos_adj.

Unfortunately, the Baytrail and Braswell workaround value of 32 samples isn't
enough to fix the issue here. Default to 64 samples.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240122114512.55808-3-rsalvaterra@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 4a9772ebdf8d..4f2f36658a12 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1738,6 +1738,8 @@ static int default_bdl_pos_adj(struct azx *chip)
 		case PCI_DEVICE_ID_INTEL_HDA_BYT:
 		case PCI_DEVICE_ID_INTEL_HDA_BSW:
 			return 32;
+		case PCI_DEVICE_ID_INTEL_HDA_APL:
+			return 64;
 		}
 	}
 
-- 
2.43.0


