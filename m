Return-Path: <linux-kernel+bounces-57116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1581A84D430
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8CCB2349F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E31145358;
	Wed,  7 Feb 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Itx20JIv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293991419B4;
	Wed,  7 Feb 2024 21:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341029; cv=none; b=TMLwhhDzYEFxPexPoUfzAAkUfHJxeKZDkTSzdc3IQg/v5yLjwtX7W78SpODw7vU5gc+cU0xgakpwr6B4KZPju3C/iI7GNZRCpHCiz3Q8VKveEVpwuBTpjIFg/z6YokAMdQYWHLKJ+Ms8YmfAg3W5bhLA8fu7GWU3sjPk+/P6m5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341029; c=relaxed/simple;
	bh=e00mbdOa1NFwOxTRbyuCpa2lpR636uuZRXk0qdpnvDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ex9izPcv+rTYw6HkvY4Ux641rL3p+8zGgTxaASmJgkiHUepZh5fVE6u1jRHjS7ZTqzf6XQIW5XW32ptWWvIWiTIPP/tlob5t5NXwUGL6E3UAIr62OzqnWxvwEXG+QI1vgBnkl1ydz2rYHB2hMIX+RVC24+BoGFM5Hs8/XPaXPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Itx20JIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49604C433F1;
	Wed,  7 Feb 2024 21:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341029;
	bh=e00mbdOa1NFwOxTRbyuCpa2lpR636uuZRXk0qdpnvDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Itx20JIvdLtdUHxwK/Mt33Kag66v5OahaHhITjzd1MztxAbyLhcq/JMAWp2uh4s1O
	 5xOhvp1pGnWOLC7kL0QjzLQTyDDviTygAbBsrb//HMT4K0mR16FKl0zRx9qvlbBCnC
	 4HRBpKWV0hC2E1Wsiq2gmxraTvLH3ikw8sqMsLfL0+hQYvIkeD8R2hXjrOIcpJZNu+
	 k1CweOCudHtbMUCjlr0ZZsy3Rxd4jxqWQCanGvMqKpx/iURd7zwjJ10fKh2KqJ/7j+
	 YbdHS9H48pf/9r+4lQc3JnMZnZhLnBkjywe1XhbWKgln8c5iiahieZ/0FQMRBQ3HvY
	 wi8h7mVmWqA/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	Syed.SabaKareem@amd.com,
	alpernebiyasak@gmail.com,
	posteuca@mutex.one,
	kuninori.morimoto.gx@renesas.com,
	cristian.ciocaltea@collabora.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/38] ASoC: amd: acp: Add check for cpu dai link initialization
Date: Wed,  7 Feb 2024 16:22:52 -0500
Message-ID: <20240207212337.2351-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>

[ Upstream commit 6cc2aa9a75f2397d42b78d4c159bc06722183c78 ]

Add condition check for cpu dai link initialization for amplifier
codec path, as same pcm id uses for both headset and speaker path
for RENOIR platforms.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Link: https://msgid.link/r/20240118143023.1903984-3-venkataprasad.potturu@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/acp/acp-mach-common.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp/acp-mach-common.c b/sound/soc/amd/acp/acp-mach-common.c
index a06af82b8056..fc4e91535578 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -1416,8 +1416,13 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
 	if (drv_data->amp_cpu_id == I2S_SP) {
 		links[i].name = "acp-amp-codec";
 		links[i].id = AMP_BE_ID;
-		links[i].cpus = sof_sp_virtual;
-		links[i].num_cpus = ARRAY_SIZE(sof_sp_virtual);
+		if (drv_data->platform == RENOIR) {
+			links[i].cpus = sof_sp;
+			links[i].num_cpus = ARRAY_SIZE(sof_sp);
+		} else {
+			links[i].cpus = sof_sp_virtual;
+			links[i].num_cpus = ARRAY_SIZE(sof_sp_virtual);
+		}
 		links[i].platforms = sof_component;
 		links[i].num_platforms = ARRAY_SIZE(sof_component);
 		links[i].dpcm_playback = 1;
-- 
2.43.0


