Return-Path: <linux-kernel+bounces-130291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5149897677
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9631C2941C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD408157A4F;
	Wed,  3 Apr 2024 17:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEHfgFlN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC84157494;
	Wed,  3 Apr 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164654; cv=none; b=tgBHbYJnbiSCFq99K/Z9zeLFDqMK3RZZ78TlzNSx3jEj8qw32x3WenjVZoZsSzTjKIfVUoALxrymadaGr2ho7TeStPc7l2n8CkrlW5+U7Vc0D3R5PN2GRKIRrbJLnHvUH/A6RzuP1DSeDzSlwkdh+Iso19xcRyW285N3GTV7a28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164654; c=relaxed/simple;
	bh=jDZXdNjG+msuVOBh1CPC0UAJj9LWGOlyG+98NmA8qCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0Say++w/kXVn7/G99fL7S2v5ZNUNjVFTAMckEeF4Vc3dqcJyOHguCEcPq/EZxFn/M+KohutLdkbi31fFAfwxtH5TdesVvo9LfJCTeach5iRVdrn0a/1WMzYAiS0iMORL+sf3UGv5KV1dt3XGg8CDI21dwwMneeyF8wsoIIXXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEHfgFlN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6070C43390;
	Wed,  3 Apr 2024 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164653;
	bh=jDZXdNjG+msuVOBh1CPC0UAJj9LWGOlyG+98NmA8qCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEHfgFlNtzLImX+dB1Sn5R9z5iVFgHM7QF3UaYt8kzNiquKDzVWZ1rq8Ubfj/wMHj
	 uJ2R2cx1cmVtisBXct+df+hDIXEIK0xO6LlKRmcB2hlagTGEf8dgccME8EjYkTrtkF
	 rxXmGmOxpSzeY5LDcEPXajXtiy/08NtjEyMoTWQossRyn9PNYaNwv9WoP8MHOXv6KW
	 9HSo5SnSRQQpIAozk5N5nrWCPquDTx9UknD39iP9LQZDL/9dnur/Uvjj/5Or+lHKmV
	 FaBO/mYs0FF7ggz4TZFjUvhtHfiBsUsZTIGBXY+NnkqCDB14PhHP1rdNexNR5Sd+lF
	 fcCZigHF8CS7A==
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
Subject: [PATCH AUTOSEL 6.8 17/28] ASoC: soc-core.c: Skip dummy codec when adding platforms
Date: Wed,  3 Apr 2024 13:16:19 -0400
Message-ID: <20240403171656.335224-17-sashal@kernel.org>
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
index 516350533e73f..8b5b583a2bad0 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1218,6 +1218,9 @@ static int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
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


