Return-Path: <linux-kernel+bounces-113822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94876888E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E2828F2B4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B57C1FF5D5;
	Sun, 24 Mar 2024 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQvYU+4v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E931292EE;
	Sun, 24 Mar 2024 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320854; cv=none; b=CGv1uJCeGN3KkRM37xd95vqCXwuIbeLl0HqVzepiVlLOqqNbWNiy9EbvmP56To5I0VKoK3tmruT7B/L3ylJEWURQf07+nNGIrLMJ6rsUeHTwZG8jf6OxDTGh2gooJwA7s2stTxwwXDtAe37INjJSf5+79pIifqy0WpaDx2jOiIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320854; c=relaxed/simple;
	bh=YNNOWOco7RCQJS1bye+2aEHrtl5dCWSCAkScx6UKIfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCho61wIXAxVtdCzWJvFk6+1tO7bcUw2HUXNdLNpYaeGYjcdmc0iJkd6EMe1z37RCkENaUqhWtTxPq3Ebb7hIOVZzZXBlbF3MCB5QOIjn+NuNS6epVjIszSGbHm1xv8QRCAXwf0p/LXJegck3Bjx6sagjXG+FJSA9P1ddGN3H1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQvYU+4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDBAC433C7;
	Sun, 24 Mar 2024 22:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320853;
	bh=YNNOWOco7RCQJS1bye+2aEHrtl5dCWSCAkScx6UKIfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SQvYU+4vK5pRSIKU1+Oxsf5cJ/e/hZLMxeIBzezuDHznqjV8qtRs8vnbn5SZEcXW+
	 Wje2eLYwtGbWBAakvX4B6ibejrO5eHo5CHew3AjME7xXloKc/5ZfbCxLn5UDkdfzuM
	 q7i2d+pm8Uo+oNCgx+3UPqQney+q4koRzP43Ohb9DRpG+Wr+XLAPldaEx1qtHx5qCX
	 qwMAIHiQVI/e23TMMZHvNjDqwS4mUIUrp23PbK6PTOUVI/Y0TTvRHid/ol+jWnx7u/
	 biQp1tYljTujQqpE6ChTRv/L7Mya+O+MKuDhv+qdeWnygBbsDuUt17QH67izvUaN2y
	 AOZmzODUXx6Cw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 417/713] ALSA: hda: cs35l41: Set Channel Index correctly when system is missing _DSD
Date: Sun, 24 Mar 2024 18:42:23 -0400
Message-ID: <20240324224720.1345309-418-sashal@kernel.org>
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
index 5a5f4b499fd94..b5b24fefb20cf 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -207,6 +207,7 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 	struct spi_device *spi;
 	bool dsd_found;
 	int ret;
+	int i;
 
 	for (cfg = cs35l41_config_table; cfg->ssid; cfg++) {
 		if (!strcasecmp(cfg->ssid, cs35l41->acpi_subsystem_id))
@@ -292,16 +293,6 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
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
@@ -309,6 +300,11 @@ static int generic_dsd_config(struct cs35l41_hda *cs35l41, struct device *physde
 
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


