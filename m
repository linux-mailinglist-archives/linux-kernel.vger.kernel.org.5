Return-Path: <linux-kernel+bounces-130316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167EB8976B3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FF928F493
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163AE15B55C;
	Wed,  3 Apr 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+jb8dYY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1B715B150;
	Wed,  3 Apr 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164720; cv=none; b=t7eVvEee0xeg12t69Pkjw7PAAnPNr8xUzRJxrX7X2DswAl7gZfkYj5yM+mfGcyXXwjvWcSnXjEipiy7hhtt9Zjr8wsBxyciQJLMxzglgQW8oJP+u60nHe2bgyo7LBERFjxPgWEEQtV7NUrDoYweRebvJG6lu2vjdcH2hwsTd/68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164720; c=relaxed/simple;
	bh=b7qKLuZBQpjm25EPq+FVreOT32w/S9PxL6a0xKugA5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zexeft6TPDHoqu9KvHCX+8wDQkDrbZYBiIbAm+k3smKmX/YRoiu7HaCLjmDGv2QIdh5k7zc4/LQkdUI0y6dNPPPGBRrioCncpVcuvb4/p5V1MbuIHStK/Mm6g2tLFOW8c0UX+9pOZVkDxqMgAmvCRGpJ7HNz7RtougX97WbqQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+jb8dYY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151AAC433F1;
	Wed,  3 Apr 2024 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164720;
	bh=b7qKLuZBQpjm25EPq+FVreOT32w/S9PxL6a0xKugA5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L+jb8dYYJ8/f6CcmGj2+vMRffYl6nRIS5pQrSq6PteGKBzHFt8u9I2ZJ72zEvso7J
	 iRaiiXnyxVX766V27VvWlnSDQo3UA+L5kHxAdmBsZVREno5Q0f6HeoEztzCAnHq5nD
	 a/yDesMxtA8x6KPiZj1l/C+NWGYH6bAbgXv4G9NTdpiVYI3f2lnZyE20UYQ6mmg74I
	 z/Dq8/GXTPQaUiNAT04mcjZAhk6X9I9JZS3apW9KE4rth+dnEGgKvQap9gAjHcmb4B
	 CfCoEdUVbxO8bnBOKd0VHCQHegnjTCfHy85DyzHhxx5VwekHsMk5ohyb2oYWxd8euO
	 n3W/yJvBp5uew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chancel Liu <chancel.liu@nxp.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/20] ASoC: soc-core.c: Skip dummy codec when adding platforms
Date: Wed,  3 Apr 2024 13:17:53 -0400
Message-ID: <20240403171815.342668-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171815.342668-1-sashal@kernel.org>
References: <20240403171815.342668-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.24
Content-Transfer-Encoding: 8bit

From: Chancel Liu <chancel.liu@nxp.com>

[ Upstream commit 23fb6bc2696119391ec3a92ccaffe50e567c515e ]

When pcm_runtime is adding platform components it will scan all
registered components. In case of DPCM FE/BE some DAI links will
configure dummy platform. However both dummy codec and dummy platform
are using "snd-soc-dummy" as component->name. Dummy codec should be
skipped when adding platforms otherwise there'll be overflow and UBSAN
complains.

Reported-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
Link: https://msgid.link/r/20240305065606.3778642-1-chancel.liu@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9de98c01d8151..e65fe3a7c3e42 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1105,6 +1105,9 @@ static int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
 			if (!snd_soc_is_matching_component(platform, component))
 				continue;
 
+			if (snd_soc_component_is_dummy(component) && component->num_dai)
+				continue;
+
 			snd_soc_rtd_add_component(rtd, component);
 		}
 	}
-- 
2.43.0


