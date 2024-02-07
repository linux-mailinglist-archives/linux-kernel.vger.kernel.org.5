Return-Path: <linux-kernel+bounces-57075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C9084D3C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07BFAB21605
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7212880D;
	Wed,  7 Feb 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HHKw68Ft"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240213247A;
	Wed,  7 Feb 2024 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340921; cv=none; b=Kj0ldkZt5dUShx1PCz1TSs9KBYj8c3i+O3m4SoHeZoJo7CVUifv05yJIWnrbM/O8ejustxPWtKta8+UdhyQoGgTKqPLIDyh3n0cvVTyqKYu1RvL+LXGDvfoZX1s2K4nk8kKf3ogzCQQHoUY46K9BzNNHN8fGiA0Mma/Z7WLNPRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340921; c=relaxed/simple;
	bh=/5nl6Iew2ZZ6v34fHncyB6p62geweUKDTTaTWheOpiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YvPaNlG7jTeH/kCfaWLr6qoqaBN9K+HzfL+4Rs+6GfZE22kmBIIOqUIK9r2r1Pl3VJwpnVpCL0X20/CksyhNMEY2/jrXRedOU02Qtd+BIqoDXWr1j4a2NZ8HEAdG4N9xd0nSGmGLmwmBqvfqdhzhzww+9ZBllL4wqhAZJLQdSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HHKw68Ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B2AC433F1;
	Wed,  7 Feb 2024 21:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340921;
	bh=/5nl6Iew2ZZ6v34fHncyB6p62geweUKDTTaTWheOpiY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HHKw68FtSJqJLTHXAGHI5G+UBSKzt0+G+TyqzjTU66xdoIHfxfKgxO09h8Xxp6bsq
	 AXSF1eNkZGCIfOk5F9kdkh8jXT/KVdHXeh9yP/6x7HizHTSkfH+ebkD3eQwSwxFNCx
	 QHvRmrJOaatI6NkPGw8WaGWE4A4Bd6p3RyfDM6XyQUwiaDMOC7CJEdXBZTaZ6LRMNQ
	 PEMXLl0MkqXoC+roQlgo/vwKIXe5aQnRr3B7V6kstNaaFINiKBLiVxhq85IaBfdL61
	 eaLQFpwjHo5Cm6vRiOHftj29+/H5UkOolG9rZdcUY9+gQkN/f/SOsdMT0Rbt6sPCas
	 +KrIBaUNmYxag==
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
Subject: [PATCH AUTOSEL 6.7 10/44] ALSA: hda: Replace numeric device IDs with constant values
Date: Wed,  7 Feb 2024 16:20:37 -0500
Message-ID: <20240207212142.1399-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 2d1df3654424..98b162c8eab6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1729,8 +1729,8 @@ static int default_bdl_pos_adj(struct azx *chip)
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


