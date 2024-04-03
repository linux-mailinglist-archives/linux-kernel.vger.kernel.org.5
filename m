Return-Path: <linux-kernel+bounces-130354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8094F897714
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22C91C2664D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9FE16DEA6;
	Wed,  3 Apr 2024 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6bM5Hwv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52187153BCF;
	Wed,  3 Apr 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164815; cv=none; b=L6U/9YQ9k1R5c9teEKTXOteGwbt4L2Eg2PiEQpVajLmKxXwvFOOZUTEdfrjulKr7nU75cX6uMWZfB/mtn6XLD9roN4FEgdvMV2e3q1jZRY54b8okFWqamOQAOPNvMJbXGYie0S/oi52Ux6iogqn+dZInzqDvzlm419AUL3q4XW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164815; c=relaxed/simple;
	bh=xgHiBXZov3Eiu6+bIYgBl0Hw0XQXQEEy/k6tIo/uDt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1NK5WQuUv1t+oiJa7kDKB8lycMYNblHQUURS5MYQy77Fmqvqp1JGppS0dSoC3o5IE9DMfJmnBWAfm63XXxEleNyfmWpkplD9V4fWA3YIzDrUgtVsCH2oKHWrlO2QiLirM58Ji8RvSOyzWUvwlvD1gcQVSbItIrIjrWqYpQDO04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6bM5Hwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7528C433C7;
	Wed,  3 Apr 2024 17:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164814;
	bh=xgHiBXZov3Eiu6+bIYgBl0Hw0XQXQEEy/k6tIo/uDt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6bM5HwviYZWVO23Fqq6nOlOGlpgSxhIuag12kXU+Q+MKTvC97Ny5P4F1dZrWr4w2
	 SSqk6/TTeDcYu1Un6zHTqs6mgqRqj/RivNugTV5VEmhDP1ScRASAwtLMTcXUHYG1Dp
	 GLQKdfdpEhC1jthbPKfa4CcqxV1arnrZ4qU5Gc8CxtWhbBko+yMNPzBBZpIhEYXwcZ
	 daNq4XpDPQadpJViFX0iWAuGE9In0GHlczEAXjnaV0dCtmbCHt/XDUrfeL80iRsach
	 Ir9nxTkQdWzxpU5DkMInMbzHNEJ0HFGP8GhOuvS9r+rExH5A/7i+HXcR5endCP8zTz
	 y1fu0SoAzIYRw==
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
Subject: [PATCH AUTOSEL 5.10 5/8] ASoC: soc-core.c: Skip dummy codec when adding platforms
Date: Wed,  3 Apr 2024 13:19:59 -0400
Message-ID: <20240403172006.353022-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172006.353022-1-sashal@kernel.org>
References: <20240403172006.353022-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index e9da95ebccc83..af4e678ba17b9 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1041,6 +1041,9 @@ int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
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


