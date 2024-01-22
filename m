Return-Path: <linux-kernel+bounces-33570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA56F836B81
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EA4283F1F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B268154BE0;
	Mon, 22 Jan 2024 15:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERRuoMMv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B958AC5;
	Mon, 22 Jan 2024 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936760; cv=none; b=jJL4M6IN/uwD5H/25EUW4TpiOwpi8HfXsfmVELRdG4pbgiKwcuV9rG4P5V9iO3nzVYD6r2eJ84Q6oqo/27sdT4TtAECAlOfKd1Ve7yzebRnTRoNDyp1DqaOMtdx58Bzzp3rbepkAzz68MzBMr6bA+ID7gCbks1QDuNULhY/CL+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936760; c=relaxed/simple;
	bh=xJ4neBRc9rcores4yeDpzeEV0IVbHaw1JnsY+i1CBqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1hRmS1voDF90ipl5r0LlZ5w8U269LnYC6/8ldPxXun1q6AFNhr9yYyJ6glPGecHIEl6hpikF0Tzm0nloKVb6hzPQjLBDI1p9k2z74pu89Hb11gAEArL7FrLbcU1w+pCxAAeH0g1N6wZl10WuoKsEvl3TzQ+kIjAQo0fXdtPNnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERRuoMMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E920FC433C7;
	Mon, 22 Jan 2024 15:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936760;
	bh=xJ4neBRc9rcores4yeDpzeEV0IVbHaw1JnsY+i1CBqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERRuoMMvKAonYXcFCoWIhImQJ5K+ZUsxuShjNbJDVLnbeuSBK3v28TM4y+fJqgZPG
	 idBmN7KWZ4dweHJH/gGFMNu4b+iE0tUyHGzwhuG+8PVxWL0NBqIEXS0JviRHm/iN7J
	 OKyw8fvHdJP0mW3zAo402ak4BEPdessINPbBp+mCot0lHo+5Q27Uuzw4T+xH1limnM
	 JoHivJ41cnOsqrTSquqYccKnjf8wlfQHnLapBcbZp6NbUYqbyOMZckz4u+opqEkdZp
	 rWfqpMIzCdvgxpNPPb7qxx6JpMQ7yE5vEiPZ1VKqK4qSBm3kjhfG/YVpFzVEiYbvS5
	 /TBCH28IbCZBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josip Pavic <josip.pavic@amd.com>,
	Aric Cyr <aric.cyr@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	qingqing.zhuo@amd.com,
	mario.limonciello@amd.com,
	hamza.mahfooz@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 21/23] drm/amd/display: make flip_timestamp_in_us a 64-bit variable
Date: Mon, 22 Jan 2024 10:18:01 -0500
Message-ID: <20240122151823.997644-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151823.997644-1-sashal@kernel.org>
References: <20240122151823.997644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.305
Content-Transfer-Encoding: 8bit

From: Josip Pavic <josip.pavic@amd.com>

[ Upstream commit 6fb12518ca58412dc51054e2a7400afb41328d85 ]

[Why]
This variable currently overflows after about 71 minutes. This doesn't
cause any known functional issues but it does make debugging more
difficult.

[How]
Make it a 64-bit variable.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Josip Pavic <josip.pavic@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index b789cb2b354b..c96ff10365d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -357,7 +357,7 @@ union dc_tiling_info {
 	} gfx8;
 
 	struct {
-		unsigned int num_pipes;
+		unsigned long long num_pipes;
 		unsigned int num_banks;
 		unsigned int pipe_interleave;
 		unsigned int num_shader_engines;
-- 
2.43.0


