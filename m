Return-Path: <linux-kernel+bounces-57071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7782A84D3B8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A9B28DC45
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644DC12D752;
	Wed,  7 Feb 2024 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sAl8kDKe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AD12E1FE;
	Wed,  7 Feb 2024 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340914; cv=none; b=d6rY1nE/5ojwcj75rkF/aLMunpnOMY+qQ+CHjxnhMCzP/+9MrclyDikdpQ8G+V6HzLBduQoJ+rmNgrjMuQ/Bbmf242JGvKrhKeB3jp+KdFjGJaPj7fDJL4jLtQoJR0nJgNuhFv5ONgPveZ33Xg4oTQ4cavTQsJj5uSIav0oachM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340914; c=relaxed/simple;
	bh=0VOhKIivJpvUBI1Diu2IvdC9acapXaOv9s1dqEnVZFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SMTD10TEkQBpsbr/rr2xYnfhxlAbVDiSpkgjR2e9kcsyktPcSEn8hp82BMyi7g1Ro1pf2oSept1DfJGaElRE2TBt2Webge1rhV4Q+0htcmXGWVCK/NnNI9jIz80HAzRxWRgPI+wsMbG0v30GMzkhk/Oce/uwnprjgGqsT8KRLDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sAl8kDKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1047FC4160D;
	Wed,  7 Feb 2024 21:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340914;
	bh=0VOhKIivJpvUBI1Diu2IvdC9acapXaOv9s1dqEnVZFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sAl8kDKe5NbYX3aOUiSsMF2rzvtCqTluQt+q4fHdiFXMcT48HMv9z3TZLw1C8rlVz
	 o16+Wbk82BTEucMV22zR/AVmRGImlprTqG8MSQtEABjF6qTW5/498CVl5YFPUsobuf
	 Aajnmj4Qe70F+ctG8oab/tXKIYRtYLZDXyKdIeXHPOU6NuU6h1fAYeLGsBBtA3ammx
	 8N6YbnUg5BLMMF26jml9KVOQoG7MKq/mhStDyWnJFDxeLolJfZftSbZCNxP1fOnSvy
	 +RIy/yE66VtEZtulK9dJqmE1t1o8wlnvk6oOrbIkIhlYIAOAKD6NaZYZh7B7OuW2an
	 wErV/o2iyULMA==
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
	cristian.ciocaltea@collabora.com,
	kuninori.morimoto.gx@renesas.com,
	posteuca@mutex.one,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 06/44] ASoC: amd: acp: Add check for cpu dai link initialization
Date: Wed,  7 Feb 2024 16:20:33 -0500
Message-ID: <20240207212142.1399-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 34b14f2611ba..12ff0a558ea8 100644
--- a/sound/soc/amd/acp/acp-mach-common.c
+++ b/sound/soc/amd/acp/acp-mach-common.c
@@ -1428,8 +1428,13 @@ int acp_sofdsp_dai_links_create(struct snd_soc_card *card)
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


