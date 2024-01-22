Return-Path: <linux-kernel+bounces-33545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABAD836B16
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B85283940
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F8714D42B;
	Mon, 22 Jan 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IyTeum1J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3057863;
	Mon, 22 Jan 2024 15:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936678; cv=none; b=cvbj/xZmBEV/FU6oXapuK5d8FHcQYnxrwMSbpy/8mQQcEUnDhsMstDujyFM3nPqrH1a7I8gyvA7M1LFtMXiLf+O2G3kKTxcr/qyTkKdr+Axe2BVsmKHeF6zbG5e3AVCRgZfGeZ4K03qNnIgiFAApIazhwzdCVy+2OW35POcdAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936678; c=relaxed/simple;
	bh=bMawO10I3hl7jFjEz0kMbTCMFYdlXvwJZ/zmQMb6maI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUutiz+WMiAPnvCx97t1ycxwBVD8EO0Wju3tUI/Lk6lWCif7B7IpvuYO8SA3q1OqbC0h5BalEnhk1OmDrBtjlJuAJCxQ6Yce88l7cRPUFBZH48KODLp0JSSerFIxpXX3/JZSE91zF2Q3LdQKCn+G8YgGc3sPiXYyAiHlDYhHbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IyTeum1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E76C433C7;
	Mon, 22 Jan 2024 15:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936678;
	bh=bMawO10I3hl7jFjEz0kMbTCMFYdlXvwJZ/zmQMb6maI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyTeum1JzD7/Qu8TGdLTSu8HvB0sQktdF8YXdwtqCHN4LU0b+K1H6Yul5/nGsY1mq
	 L45J/yuo8lHoGB+8pYkoP64GXq/JnqgcYoeYwtVgJH/FFBJ9lJ2jTbFFv16slw3EcX
	 zTNki5LpZKtpk7oopikacM1Bi5JMZWTBG6wU0UnR8PuLws6G1S+qWqhI/jr4fcij3X
	 pCHbWCY+aZH9iwpXCLS7bIfKyWTrfdFbJysc+GVg02mO9Uoer0kacoW2ggqBbQpE8U
	 8XkSPkWyq0dKnGAJqSrUEzcQvKt7ormYg9bVTrwNBwCQeDA8z5Y9bAYCzOiSRJ1Muo
	 JDKU+cogZfFkQ==
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
	mario.limonciello@amd.com,
	qingqing.zhuo@amd.com,
	wenjing.liu@amd.com,
	hamza.mahfooz@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 22/24] drm/amd/display: make flip_timestamp_in_us a 64-bit variable
Date: Mon, 22 Jan 2024 10:16:36 -0500
Message-ID: <20240122151659.997085-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index 0b8700a8a94a..c6281d4a18ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -423,7 +423,7 @@ struct dc_cursor_position {
 };
 
 struct dc_cursor_mi_param {
-	unsigned int pixel_clk_khz;
+	unsigned long long pixel_clk_khz;
 	unsigned int ref_clk_khz;
 	struct rect viewport;
 	struct fixed31_32 h_scale_ratio;
-- 
2.43.0


