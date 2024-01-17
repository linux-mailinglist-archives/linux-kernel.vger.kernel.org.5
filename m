Return-Path: <linux-kernel+bounces-29168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7AE8309F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B721F24812
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075012232E;
	Wed, 17 Jan 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="SksRX1d6"
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3142232A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 15:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705506155; cv=none; b=SUiIrMnunPdHIncEpebW9XXpfqS5U8e9hjLatrQJHNr+vbdoj1xoKIwjz+ziUROHMDfOLSjk1RXCZS++6cFlZ+Hfm4ffU/dVk5q33HXGZx3z8Fo4IshQACoKLBAWBsFGkGcXWrSgyX7CSuwz2OktCuL7/2WXojFwLCz8Dj6133c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705506155; c=relaxed/simple;
	bh=PIaNYP7tKeLz3DbZoaeyg/wZV1PgwT/q0h8pnJkFj8A=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=su8bDWn+t57/2quKK5O8D7m/7nfhYMXF2wENqIeLa7UFmK6JUNJ07n2rBePh44OLYlGMD5Z97FZUkQu1OF0dUEE/MOuJyfOU1ZyeO8GqsKCOkvvIWS0vt9YW5o7dYg3fK5+MCqEwkyDKjoMXZawOonUrbvMRzFoRJV9tryFV6GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=SksRX1d6; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.binli.uk.vpn [10.172.193.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E5AEB3F6E1;
	Wed, 17 Jan 2024 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1705506144;
	bh=AoyQYoWLWFR0VSl3BzntiZASNvn8wxYLWDvkVYPdumk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=SksRX1d69ZG1ixWKGjJKDZYVQsvJqjcTlUJf3ldGK0f/uTHYrjw7ClcTe2BOy/Mzh
	 5TCQmwIo83Tl/bYTFqnfNL/wRzRDUOepYLeAV5yZRPzvdSs3FxCi8Sxa1z8x4EjzQg
	 sdEQqzh2swiWeQY59FW7osBZwctZF6C1PBFy9rOTaviunRAxmiVFHny1ZiyHP5a8u4
	 6hwGOfzjLrkcJzmR27er98UOdUIof/VzochhSXS/fVU7XoNbXfVYK1R3MA5gY3TC+s
	 ec6/h+9XVrvt6vqX8oefoEDtVHtW+uuhWP9q4eez6na80B1HYjT2zNZ4/Hk6zx1ngT
	 6SWcRxPwyB2KQ==
From: Bin Li <bin.li@canonical.com>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	aaron.ma@canonical.com,
	libin.charles@gmail.com
Subject: [PATCH] ALSA: hda/realtek: Enable headset mic on Lenovo M70 Gen5
Date: Wed, 17 Jan 2024 23:41:23 +0800
Message-Id: <20240117154123.21578-1-bin.li@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Lenovo M70 Gen5 is equipped with ALC623, and it needs
ALC283_FIXUP_HEADSET_MIC quirk to make its headset mic work.

Signed-off-by: Bin Li <bin.li@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b68c94757051..7057e888d373 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10231,6 +10231,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3176, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3178, "ThinkCentre Station", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x31af, "ThinkCentre Station", ALC623_FIXUP_LENOVO_THINKSTATION_P340),
+	SND_PCI_QUIRK(0x17aa, 0x334b, "Lenovo ThinkCentre M70 Gen5", ALC283_FIXUP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3801, "Lenovo Yoga9 14IAP7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3802, "Lenovo Yoga DuetITL 2021", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3813, "Legion 7i 15IMHG05", ALC287_FIXUP_LEGION_15IMHG05_SPEAKERS),
-- 
2.34.1


