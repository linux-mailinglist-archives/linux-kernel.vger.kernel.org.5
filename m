Return-Path: <linux-kernel+bounces-57120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C8384D439
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E760FB239C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1C12F397;
	Wed,  7 Feb 2024 21:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbY64i5g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644712F380;
	Wed,  7 Feb 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341037; cv=none; b=m+g+LC1rASvUZ+62eZaJ3mjdgi+mqnlQ3HRBDsrEA9eZau5mlrRmMUEumIojc43Fd8ggP6XWoXALhmzQAFGGnMN08TjhSAtVj6iUe4T+ZHh8RszSZ3lKxxe+J3n/HJpPiGM0X1uZxDBAF+THVjjLG/c+F8wKguBp+z0fOv1QAdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341037; c=relaxed/simple;
	bh=JJSnxL/ThxXwdwW4PCeK2wQm+USqqGeu2ttXOrYM++U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMIxCZlZ0uxtPe/7jtkGlFTuRFD82cJUJvP+cOTaMhSzkIMO+XxaHYVsieBdEX0zKs0A18iO4CDo56WL6+L86NRAqQeGOg4BzjsBrcZydx2yFxQE96MMLZkzMhIN4P4PoXuiJlSUXujeGnquqrL5BXOBCnolNmWBJXLPxsV/XcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbY64i5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF53BC433F1;
	Wed,  7 Feb 2024 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341036;
	bh=JJSnxL/ThxXwdwW4PCeK2wQm+USqqGeu2ttXOrYM++U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CbY64i5g1E7FuKaM+sAibg8M2YoicqYhT/KcZNd6+PHU/jkgAROFqtM0rR5S6LLzy
	 8rWI3PtRp0XDZGJwcNdqXBBaAaD7xLxLd9O9CTwqagBUB5/oJWF2L89s1IfTNYmNhh
	 euHc6diCKW2K1aFG3dMnSXhUhq+zPONzG0t2gqyTo+1qWroSAI8/0i5RlyAK9I81Jm
	 KcoYNQBUegl7AzFEiy3J6hB3slVwrETPtzCpJ61Snm7ErRLIVEOHkqXYv6hP6etEVB
	 aZWEE+k3eUggsWfo3x3g5EK13bLWC+jbGWg78BmAHWn+30re+92EipDUvorMJHCPjD
	 bCwZG7Bvv8O9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rui Salvaterra <rsalvaterra@gmail.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	maarten.lankhorst@linux.intel.com,
	siyanteng@loongson.cn,
	jasontao@glenfly.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 10/38] ALSA: hda: Replace numeric device IDs with constant values
Date: Wed,  7 Feb 2024 16:22:56 -0500
Message-ID: <20240207212337.2351-10-sashal@kernel.org>
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

[ Upstream commit 3526860f26febbe46960f9b37f5dbd5ccc109ea8 ]

We have self-explanatory constants for Intel HDA devices, let's use them instead
of magic numbers and code comments.

Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Link: https://lore.kernel.org/r/20240122114512.55808-2-rsalvaterra@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 75148485b755..4a9772ebdf8d 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1735,8 +1735,8 @@ static int default_bdl_pos_adj(struct azx *chip)
 	/* some exceptions: Atoms seem problematic with value 1 */
 	if (chip->pci->vendor == PCI_VENDOR_ID_INTEL) {
 		switch (chip->pci->device) {
-		case 0x0f04: /* Baytrail */
-		case 0x2284: /* Braswell */
+		case PCI_DEVICE_ID_INTEL_HDA_BYT:
+		case PCI_DEVICE_ID_INTEL_HDA_BSW:
 			return 32;
 		}
 	}
-- 
2.43.0


