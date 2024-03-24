Return-Path: <linux-kernel+bounces-114724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA92889226
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17401C2DC81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D8319F50C;
	Mon, 25 Mar 2024 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwJBjcnq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1627211F;
	Sun, 24 Mar 2024 23:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323308; cv=none; b=cE77AK0WJkpU5POTvcAs5IRWkiZs3Bcd3hscAKxmowghkKZOT+TgLo0m6FTNYLCT+SAj/ch9gFBt/wHhIUScoso6vWvcD2iPfrJC7qr8R/NB528CJtICG47F7MJH3TyoLk7owKb9AYKFp+mqjicMdz1R+pHIivRGu4+cBGRgYgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323308; c=relaxed/simple;
	bh=dZe/VpeCcBYjYoGFpsGrAEwWc/lpdhliT+gbyEeOeBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgyFXXftvNKgs0VlnsJTl1f0hyYANjAZ4X9HFxWAYxL10oSlkEIrB1LqxnmaKCkK5TM7ZY7+nomjO8yXUjKyiAQrbrhelzVB46UpSQU8XSBOS0W3cGFaqcNJ+ckxcuKBh+XevKrLd8zmjAKFIsZQwnZrlW80uHuOlvPp8NzwDfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwJBjcnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E4AC43394;
	Sun, 24 Mar 2024 23:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323307;
	bh=dZe/VpeCcBYjYoGFpsGrAEwWc/lpdhliT+gbyEeOeBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwJBjcnqJWm0vFE7FJdREoPAVUp+DePzFGif/0vlSUGphEGgWyDRraShyaAW6BSuN
	 YjKqZNllSBS6jY1FcbBbskUUYcyAq5DgzGNPMaCnbxH3v02cdQBc12c8xlttoJsBmK
	 az88qtEJ+BKHbDeJI6eM/8Qi6Z8rT+bYTv4dMTaxGC/uUo/e6GhTcdVsJhwtaSrpEG
	 CrBnXVzIGFVKUDcH6SMrxc99bwGPabrirge3CRlwMbEjoMN2V2l9B2JCtecFhw/tci
	 mdTrFTWRWQNp7Qj0HK7FVky3ZOrDAJAbJybJ8OOxzfvXaUvun44nnGCRoh0A5bvPBj
	 1FbNXiO6tfAZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 007/317] ASoC: rt5645: Make LattePanda board DMI match more precise
Date: Sun, 24 Mar 2024 19:29:47 -0400
Message-ID: <20240324233458.1352854-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index f903bee194d5c..2cc3d814bab41 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3803,6 +3803,16 @@ static const struct dmi_system_id dmi_platform_data[] = {
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


