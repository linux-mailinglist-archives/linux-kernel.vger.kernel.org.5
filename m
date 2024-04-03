Return-Path: <linux-kernel+bounces-130345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAAE897700
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98A61C2696C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C8155752;
	Wed,  3 Apr 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BPH4JaEx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D06155751;
	Wed,  3 Apr 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164795; cv=none; b=RNyyj9FLRbIwStn8Wj+/Ja21U7DQhV1lN3MNpki1E0oq7WLJz+iKfLv/nefiid0jhSK6lFg8BjQvm3zWMSd8XAvOI7n/NSc4HxR/gCK9xJYExmB5D1mBOhlc9mJcO0Xd2xJv+rS5fhMXiyYjIhwokIDhgy8yoF6M3JC0AKzytbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164795; c=relaxed/simple;
	bh=yEQHGfdTQfgueNzJukGN+SUJw0maNjlPoXSPO9Gk4Fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViQGa3pFzpp4f0BVzS279/mldcpx6Y4RVpSQBCJE4hMvJKHidg17TY0o6/drDKabkRD+5nHEP9wK0VBZF5WfFM19CuVjPKptjlrXHqLBAYSKuRA36be/5ac2sYOgx+ebnemf007BvUARlYLUnGYSb4AtBbo2H7VAqRQnQvAMn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BPH4JaEx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B56C433B1;
	Wed,  3 Apr 2024 17:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164794;
	bh=yEQHGfdTQfgueNzJukGN+SUJw0maNjlPoXSPO9Gk4Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BPH4JaExf5qRZT9G15NAfQHG6dR7kF78XSfVU7dr3zQEE7775KGfYlZb33WBCXCDh
	 07sf4Koo9oyttl476zmU1oksbF5DVdY7nf51kHpQw8SZjeDdZwnIG6ILIHrsOdDdUw
	 sgZNqQwBh4VfsPLJ1J/n/51R6EcTYqgQ1E75rHceMI6FBDtEbJXltQ0vLdnpyMQb0b
	 yJOyQs2mJ3Is53sH5KOk2C0b1EGJkBmfmTY48mOBFsobGVjufDI3X8LOerBsilUdup
	 eJcgTxL4IEaNTwuKfAZi5+jaHkBorvlVEO6lK9xJhP8LiyMvFpHHEem3tnD3QLANW6
	 lW7nJACp2pRKw==
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
Subject: [PATCH AUTOSEL 5.15 5/8] ASoC: soc-core.c: Skip dummy codec when adding platforms
Date: Wed,  3 Apr 2024 13:19:38 -0400
Message-ID: <20240403171945.350716-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403171945.350716-1-sashal@kernel.org>
References: <20240403171945.350716-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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
index a5b3ee69fb886..1c4d8b96f77b1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1042,6 +1042,9 @@ int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
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


