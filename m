Return-Path: <linux-kernel+bounces-130289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AE4897671
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8B01C291C8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0C8157476;
	Wed,  3 Apr 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJxXL5Km"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18525157468;
	Wed,  3 Apr 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164651; cv=none; b=de5kbJSwdjpEzXrsG84OAxIU93kqgpnNcjv4Yq4kZ967RynjpMXtnhXvyoIxnlb6ml+Uo4j5GLJp9QFpEKAACtuRae013F0PwMFozSvmhS7fb3JbsZMXM2DgpTvOnbDzpDt52wM5t+cNPoSdWgABKjoMrmFT5DsPF8sa8PQv9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164651; c=relaxed/simple;
	bh=pSKtIhrEgfmgjAXnCxGmxTJj02e3TpZuMW53XL31DLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtY9bWCgTPdwC+fXHfoqsK4bf856SvtivhUd0QoVdat49ifVhgNF9IjLKUqZxdTy1NBkPKS+aG6S9XXEUBBr/f5wHDSZJI3l7j9FRbX/dhab3Fl3hSYWsNVb/5nEvl0OG7AIoDaVevXDbKmKsD2ZsF+8DzExQvcf3aKlQVkmT5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJxXL5Km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95282C433C7;
	Wed,  3 Apr 2024 17:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164651;
	bh=pSKtIhrEgfmgjAXnCxGmxTJj02e3TpZuMW53XL31DLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJxXL5Km6EnuSv+yT9KU+hC1T50iaQrNTrYIDPlJqTvxtJc8KyhS5MzFF8YOHSV4T
	 FMlkS0WKf1mKMFqyKFiF/7TDUh8sCi7EQ8TTEkjd5ZZ9eCeZegBKPa6CduwiaMDEXt
	 SAgZC+vdiq27lt+IPVTF4VTJZoDgQ1Onl1ckz5PVcH0wRUIq4lujhHitL4F/9BpB8C
	 8farMxddIt3mkeAV0kAjXQEtQanB/Nlq1vHGsS5nbnNOeeLR3LWemo15blB/OP/LVr
	 kxFnbPoV/xBQxAp9l8ibm88Rgl95NHKyHDGqWuTTW1DrI4sDnyuUYuW8rC7xxNML15
	 g+3HYi0GbvLLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: M Cooley <m.cooley.198@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mario.limonciello@amd.com,
	me@jwang.link,
	jeremy@system76.com,
	git@augustwikerfors.se,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 15/28] ASoC: amd: yc: Fix non-functional mic on ASUS M7600RE
Date: Wed,  3 Apr 2024 13:16:17 -0400
Message-ID: <20240403171656.335224-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171656.335224-1-sashal@kernel.org>
References: <20240403171656.335224-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.3
Content-Transfer-Encoding: 8bit

From: M Cooley <m.cooley.198@gmail.com>

[ Upstream commit db185362fca554b201e2c62beb15a02bb39a064b ]

The ASUS M7600RE (Vivobook Pro 16X OLED) needs a quirks-table entry for the
internal microphone to function properly.

Signed-off-by: Mitch Cooley <m.cooley.198@gmail.com>

Link: https://msgid.link/r/CALijGznExWW4fujNWwMzmn_K=wo96sGzV_2VkT7NjvEUdkg7Gw@mail.gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 90360f8b3e81b..1ab69a53174e6 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -318,6 +318,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "E1504FA"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "M7600RE"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


