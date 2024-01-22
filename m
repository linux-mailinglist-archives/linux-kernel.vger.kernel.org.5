Return-Path: <linux-kernel+bounces-33521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE00836AAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CC71F232D1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41535145340;
	Mon, 22 Jan 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVEcdqN0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB456471;
	Mon, 22 Jan 2024 15:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936592; cv=none; b=Oapw3Q/MTRR69v2vCYBVsEZI/Az0cHjPTuoGCtypSxMh+N4u0uHHcGnJraHe9yf0VYyFvrOpP3UbVarZH0tTiJwjK/eJH+XyiNyCGN5AYzDOoOHMr6k/4pHG7Z+35FfDNuc2oIYK8HGcjMeVo1CX0ltzjWfc3gZfN4lm9AOhrQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936592; c=relaxed/simple;
	bh=vUodo6WyU9TKSHALWdJBer1gkM041uMGsj3HnwCnqiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQd06o0Vu0IR3+aRvA5gIpQJD2K7kwpfSE0cVPRV9L//zzgoC4DEbOga6tjQEZtvgq8FPpbxGrZBEDvrAIj3Xqo9fyQZNZ3YGAu9qBo4XW1fboVD1IrNZ0L/ZwL9xLLP4q4oLvXFQlujBWMDGQ7AYB0lbgOlVTnUV4Wg9/iQOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVEcdqN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FD5C43390;
	Mon, 22 Jan 2024 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936592;
	bh=vUodo6WyU9TKSHALWdJBer1gkM041uMGsj3HnwCnqiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVEcdqN0VOq7Dfv6SPqvLNm2FngGI0DHHSbifKJ1trfrNS0lHdYW3/RbrQTlpoWqx
	 DrdTgA3dmLoB4DWtzmAL9HoCSPvRXnyG0o9KMVUW41NFUkQFnxhO8lAdwcJcIFT5et
	 08MRL2d+IGtJlv7Q6fO4KPXya1uBxjWsS/syTRnqmX38XdttDvpEuULfbVMUuveIU+
	 rG1k2VDMTQMKOtojbZLzssb59mjFhXgM4YaNSTluXhBScEwURVEJ+6Ol4jbL/r9ciO
	 g41+mQ0T9jWGWGCz8RiMwrBqtX1lJUnfiHv3WSMJ/kcv+XWkcZY026RGEEKGBKHH41
	 HYhFQmEM0Q/nw==
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
	qingqing.zhuo@amd.com,
	mario.limonciello@amd.com,
	wenjing.liu@amd.com,
	hamza.mahfooz@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 26/28] drm/amd/display: make flip_timestamp_in_us a 64-bit variable
Date: Mon, 22 Jan 2024 10:14:52 -0500
Message-ID: <20240122151521.996443-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 1a87bc3da826..b36d4c5d0eca 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -426,7 +426,7 @@ struct dc_cursor_position {
 };
 
 struct dc_cursor_mi_param {
-	unsigned int pixel_clk_khz;
+	unsigned long long pixel_clk_khz;
 	unsigned int ref_clk_khz;
 	struct rect viewport;
 	struct fixed31_32 h_scale_ratio;
-- 
2.43.0


