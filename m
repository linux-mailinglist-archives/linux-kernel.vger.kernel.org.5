Return-Path: <linux-kernel+bounces-130335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926068976EA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 223B8296392
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257DB161336;
	Wed,  3 Apr 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYjvBBC0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6552B161324;
	Wed,  3 Apr 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164772; cv=none; b=A2/6fQQ8CvFGB1+o/8jzIoSDALkJ1fX9tM5Y3ujFLWc1xpSEkeM2jTOW/CxggMkZLMaFoQDhsUcjMxrRZ0mplA0aW1cIo2n0vcFbTM2gLv4JkoekLfYyoFFiEFdD7RLMW6ghr51SRN4dpBlEXCfoZ0RFIZOzJnAIe/lcJipXubs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164772; c=relaxed/simple;
	bh=1s7e/iUP+fl2GBm1UpjFeevJLSutEOfjvsGAu3dHY6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqRFOToRJzu+++SRbdEyxtqENn85MiUUTuSRb0/tqXGL/aar9kMTxsAut3X8dRFd+nI3LcQ5xkckUfOv5J9DzBNde/ySxwaGu6c3VYa8OKKLfmn0HHpTYmd0OQM1YER4nmbf6LFvH5/Y5NItnAlLpHGLKMZUtuWTZYZA9RJzFoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYjvBBC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ADCC433A6;
	Wed,  3 Apr 2024 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164770;
	bh=1s7e/iUP+fl2GBm1UpjFeevJLSutEOfjvsGAu3dHY6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYjvBBC0T8viwe7HErrdbrggZYno+SZBClskogs/PVY8+MOhiQH8fYkRKHxy+tdC8
	 OkMzZcizBy900siNb+KyZFZ3nDYpkBwNGgH/4g6ZazxfV9L0+XVtNkofYvSWRes6So
	 Tu3cWsafPyhlr/ECVTb/fRuPpJqdsDEaDlXA6hFHnTPrLBTQ/uv4tyKkPV4BqY4Rf2
	 CjnYmkwGXN/niAbo+h8pxE5IG8VjNgmeEkPxv+de0v+F98lgqFJODUU8bs7lZXm+Tp
	 K0le17efAetLz3U1n1xNgq7rK5tFGoE8+KZwZASHrg8ynjFOVZHTzKshbfhumcoUd0
	 nECzg81XrJRgA==
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
Subject: [PATCH AUTOSEL 6.1 10/15] ASoC: soc-core.c: Skip dummy codec when adding platforms
Date: Wed,  3 Apr 2024 13:18:54 -0400
Message-ID: <20240403171909.345570-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171909.345570-1-sashal@kernel.org>
References: <20240403171909.345570-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.84
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
index a409fbed8f34c..6a4101dc15a54 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1020,6 +1020,9 @@ int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
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


