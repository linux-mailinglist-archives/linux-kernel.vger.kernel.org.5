Return-Path: <linux-kernel+bounces-113272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689908882FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09272B221EF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5533A18AFE9;
	Sun, 24 Mar 2024 22:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ft8AyGUj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F7D18AFD7;
	Sun, 24 Mar 2024 22:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320072; cv=none; b=OVI4866mr9FuXer52iqjOr9EONIIP80A0fAhK0RhyhFwtNTzn2kC/+RAM3nMyA3hBdJOXKXGGhjUXXiMKgTER7N29Q7168iLjguuqTLzFY2H827sePR8JWMJRl/OWUEBhKqVmhDC492GEBL3X4SuibyfApunDDcMesZqUeWt/ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320072; c=relaxed/simple;
	bh=xifQRL+fORxpmntrffE/NQn4dgpIQhHCBsc94lA7hxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PPRP7FABPHi/ketZxz5B+EiBjslcPp2+/XGlSHjLXTtkKEebyAJTsdZeIl4Hh7QFWNVioe8a/2LPpbqVAjdbHmJsmY9cIF2lh8zHYiWd6ok5OzrcnrTqGvPaVBzAneqPTJxYFQX0sgXuGS9yCfjqEBFS0z9eOeAFKv9RvXuI7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ft8AyGUj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF1BAC43394;
	Sun, 24 Mar 2024 22:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320072;
	bh=xifQRL+fORxpmntrffE/NQn4dgpIQhHCBsc94lA7hxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ft8AyGUjPpXmsOzgIheUhqJtLsr3P3e+sZedTXvMj7PKE6LsTROP3v1EnI4iH3X6F
	 C7Wr14o69aztAZskXcKANpsaUKlVP4mkOD+8TXOP6Nvh1fizzo4dRHtpbHyjW3zdJo
	 GZlDe32/vYEqYTEvj0D0fXOoHL3sUE+rmShNeOJaoFxayqqxAV2rP5w1zOhIjvPWdU
	 xSBXqB636DF+Dwud0jjwAdgFdaNeIY9ZfujwrKlkUdPQCtnP0bF86GHh0Nr0yFqIct
	 BllmGyw8kRfQ1G1vbxpJb7Zv7uS9mNSyA5RUv8eJRCE31zrPZIrlR1ciuNjMkCZE22
	 4rs3HuoM1nkGQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 381/715] ALSA: hda: cs35l41: Set Channel Index correctly when system is missing _DSD
Date: Sun, 24 Mar 2024 18:29:20 -0400
Message-ID: <20240324223455.1342824-382-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit 135096ebfab656823d0037102a00776f3914fee3 ]

Current method to set Channel Index when the system is missing _DSD
assumes that the channels alternate, which is not guaranteed.
Instead use the same methodology as the main driver does when _DSD
exists.

Fixes: 8c4c216db8fb ("ALSA: hda: cs35l41: Add config table to support many laptops without _DSD")

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240126164005.367021-2-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index e436d4dab317f..86ddaff915de1 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -210,6 +210,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 	struct spi_device *spi;
 	bool dsd_found;
 	int ret;
+	int i;
 
 	for (cfg = cs35l41_config_table; cfg->ssid; cfg++) {
 		if (!strcasecmp(cfg->ssid, cs35l41->acpi_subsystem_id))
@@ -295,16 +296,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 			cs35l41->index = id == 0x40 ? 0 : 1;
 	}
 
-	if (cfg->num_amps == 3)
-		/* 3 amps means a center channel, so no duplicate channels */
-		cs35l41->channel_index = 0;
-	else
-		/*
-		 * if 4 amps, there are duplicate channels, so they need different indexes
-		 * if 2 amps, no duplicate channels, channel_index would be 0
-		 */
-		cs35l41->channel_index = cs35l41->index / 2;
-
 	cs35l41->reset_gpio = fwnode_gpiod_get_index(acpi_fwnode_handle(cs35l41->dacpi), "reset",
 						     cs35l41->index, GPIOD_OUT_LOW,
 						     "cs35l41-reset");
@@ -312,6 +303,11 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 
 	hw_cfg->spk_pos = cfg->channel[cs35l41->index];
 
+	cs35l41->channel_index = 0;
+	for (i = 0; i < cs35l41->index; i++)
+		if (cfg->channel[i] == hw_cfg->spk_pos)
+			cs35l41->channel_index++;
+
 	if (cfg->boost_type == INTERNAL) {
 		hw_cfg->bst_type = CS35L41_INT_BOOST;
 		hw_cfg->bst_ind = cfg->boost_ind_nanohenry;
-- 
2.43.0


