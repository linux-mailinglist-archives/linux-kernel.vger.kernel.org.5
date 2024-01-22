Return-Path: <linux-kernel+bounces-33241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C410D836710
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BB0828D972
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26384D594;
	Mon, 22 Jan 2024 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0KllUKq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1163EA8E;
	Mon, 22 Jan 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935476; cv=none; b=OhgeLI7spWr4HAzwKwJLxdhnItTBOD7UZ9fND+xiEO4InyoC16MUhEiMHcOYu9rqBc+TnCMt4zKXKDECZp+HiUirUOceD64EpOWCSGXty1CxYF0IJcvlf+h3/Ele70P2+/2hI8iRh+QKq83eZKw7TVb5phXv5ZRB55J6MR3Ve+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935476; c=relaxed/simple;
	bh=NABR2eoEe/Oiv+lPXCDO3bV4QQhTMcC72voA79i0h1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivlE/8/o24pQFMxkur4LTUbe6W1nNpeFV8TImVPNQiNLqzRbKyOUQteMQOXMMGSXbmKfvN7ITNmD8yClxbHt1PetQ4PocmJ6UmFYU2gUSIDgSOdHivSyzYCu13j4gPSytkj+Ob4ETfXmUirZfKFI+lBwV1RH0D/ssOKW4CeMNpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0KllUKq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A30CC43609;
	Mon, 22 Jan 2024 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935475;
	bh=NABR2eoEe/Oiv+lPXCDO3bV4QQhTMcC72voA79i0h1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k0KllUKqiR8duAK5VWvR2IXMWqhz1bWyLHuDe7GrbdCgCmDZBn/9Co47a701rLdDw
	 r4pzhOv1sGablPnFPAE1MdIUpvGDU9xlJD0NHl/OLnjpvKhJFg/fyT1Xh6KpryXyAU
	 fPOPpDi/I4g0Z8msfq02HFcoQPm9+QGszf47ZaRvIy1JX14a4lLD106Ga505Gu+Jg/
	 MNeuEIzkIHPydHgxIbckL9kKlh6njC+ad403+nFYvsRXKpjQ6Mxq48JsH/tr5dzF1N
	 YLMoEgUOjzrMb62biKBpuT3Crt6hdzplJPk6ibMvEzjSvHrpEm2QqIi6hEz6MP6dWY
	 AtU9C25JcXzxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	wayne.lin@amd.com,
	dillon.varone@amd.com,
	qingqing.zhuo@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 23/88] drm/amd/display: Fix writeback_info is not removed
Date: Mon, 22 Jan 2024 09:50:56 -0500
Message-ID: <20240122145608.990137-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit ab37b88ed9de9de8d582683f7ea17059f1251a7f ]

[WHY]
Counter j was not updated to present the num of writeback_info when
writeback pipes are removed.

[HOW]
update j (num of writeback info) under the correct condition.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 5055af147c20..37dc280e5566 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -497,11 +497,12 @@ bool dc_stream_remove_writeback(struct dc *dc,
 			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
 				stream->writeback_info[i].wb_enabled = false;
 
-			if (j < i)
-				/* trim the array */
+			/* trim the array */
+			if (j < i) {
 				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
 						sizeof(struct dc_writeback_info));
-			j++;
+				j++;
+			}
 		}
 	}
 	stream->num_wb_info = j;
-- 
2.43.0


