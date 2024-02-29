Return-Path: <linux-kernel+bounces-87028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0444E86CE6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B330C282816
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607E615FE30;
	Thu, 29 Feb 2024 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okKFP5NZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A815FE1D;
	Thu, 29 Feb 2024 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221900; cv=none; b=obZXpqqJJbJp3Fb8XiSeD57m53RLCbJzkzDBk0gRBya+WtaKcqiwnzY9d9lXOK6GGAYwEXOEu4+PgiN0j63/O9bDlYmwiCdV/PtSWpUh1RYYsFiZ6eM7MPntlzl7SHUlGYBj9SeQU+ZAqmIbrVY1k57hBoslNSmc5TDvxHP91Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221900; c=relaxed/simple;
	bh=Oh8kyH0/0zXrHp59WgBRj19l8oF5oQzgagjTvXk6oAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0SBx7BXWEWEDeHtDoZM68lWBvgDBxmJS4lWX99JDZhDaJ6b6S584Q2eANLiPJBU0MsM/H/zgoT9AlpX3OIR4tZ5/p/hvk7EW6HXclp2BppS4LPOikVE+vb7V3q+0kL2w20rI9OuCat5x2fmNgSWgWNMiFK3VHfCS7C/oQ+H7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okKFP5NZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162E8C433C7;
	Thu, 29 Feb 2024 15:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221899;
	bh=Oh8kyH0/0zXrHp59WgBRj19l8oF5oQzgagjTvXk6oAw=;
	h=From:To:Cc:Subject:Date:From;
	b=okKFP5NZQMA4pjf5rG7192JeyK6M5kce0+BFPphQEVIyfcZM/SXY+xnWRXHLr63Of
	 KXhdiXoB6Itb4dSXEG3IwsXbo+uxIPWDY7VFT7MXnY019ljYz0mNqbLbJ+FGU7Z8zx
	 /QtbGQS0KG9k5dfvRD98FlKgAy4WYSN2JakhiaNjC6btXDKcEKCrqfxIgMMm3ZoMTJ
	 5Nu48/EgrUdOoGU2PQxH9xYCVE9OkkVBPTYc9LYm2Dgxp4two98oQiwm+O0aVNS4yT
	 +6azkiO6JNIesNp8T07RsKy3o1nxwg8DnzvSyNcfu5M1wUx5l2vXgLtQPUd88MLoE7
	 mW0el65UTuT/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 1/3] ASoC: rt5645: Make LattePanda board DMI match more precise
Date: Thu, 29 Feb 2024 10:51:35 -0500
Message-ID: <20240229155138.2851458-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.307
Content-Transfer-Encoding: 8bit

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 551539a8606e28cb2a130f8ef3e9834235b456c4 ]

The DMI strings used for the LattePanda board DMI quirks are very generic.

Using the dmidecode database from https://linux-hardware.org/ shows
that the chosen DMI strings also match the following 2 laptops
which also have a rt5645 codec:

Insignia NS-P11W7100 https://linux-hardware.org/?computer=E092FFF8BA04
Insignia NS-P10W8100 https://linux-hardware.org/?computer=AFB6C0BF7934

All 4 hw revisions of the LattePanda board have "S70CR" in their BIOS
version DMI strings:

DF-BI-7-S70CR100-*
DF-BI-7-S70CR110-*
DF-BI-7-S70CR200-*
LP-BS-7-S70CR700-*

See e.g. https://linux-hardware.org/?computer=D98250A817C0

Add a partial (non exact) DMI match on this string to make the LattePanda
board DMI match more precise to avoid false-positive matches.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://msgid.link/r/20240211212736.179605-1-hdegoede@redhat.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/rt5645.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 37ad3bee66a47..352aefddc7d70 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3796,6 +3796,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		  DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
 		  DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
 		  DMI_EXACT_MATCH(DMI_BOARD_VERSION, "Default string"),
+		  /*
+		   * Above strings are too generic, LattePanda BIOS versions for
+		   * all 4 hw revisions are:
+		   * DF-BI-7-S70CR100-*
+		   * DF-BI-7-S70CR110-*
+		   * DF-BI-7-S70CR200-*
+		   * LP-BS-7-S70CR700-*
+		   * Do a partial match for S70CR to avoid false positive matches.
+		   */
+		  DMI_MATCH(DMI_BIOS_VERSION, "S70CR"),
 		},
 		.driver_data = (void *)&lattepanda_board_platform_data,
 	},
-- 
2.43.0


