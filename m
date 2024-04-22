Return-Path: <linux-kernel+bounces-154248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901508AD9E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FCA286442
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E6F15A4AD;
	Mon, 22 Apr 2024 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oaEJERZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD104653C;
	Mon, 22 Apr 2024 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830112; cv=none; b=uoL25nO/peFLvhp1NUsfPOgAWM4WM8L5N+Sx4PWYPMpgTy0L6fArYKyLpqbnxIevcNM1H5dIRFLa54w9L1EFeoukjkFp2LNJSXOzuP876f/ha00KQ4rH2Vut6B2iYeZC+RulysF9TWJG5Sma66EoNAenjn0fKAQ6Q7qU1xQeonI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830112; c=relaxed/simple;
	bh=31Z4bQuaIYjqmvrjVEK/bypJnlUYm5xxmOm4jDPxfho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hU09rxafQS75s1kLYu+XGfCDCaJLmMwha93XN2gnDxxBmM8Eg9fdzFSQBV9sgZTtZhd5zeyhBkkEp1XDz8qdEnoPJUhC2GTb4Wy2lyAYsOyIRo1H1qwQyxRW/srTOgQv3S51YHvgQmN/H78BSzjyBaLINGjT6kBU+CBbTy5U26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oaEJERZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05E06C113CC;
	Mon, 22 Apr 2024 23:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830112;
	bh=31Z4bQuaIYjqmvrjVEK/bypJnlUYm5xxmOm4jDPxfho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oaEJERZJl0EiHN7vkbg16y7I4cszgTuUIK9RbZ/aE9V4o1zE6FvUI92X7Edgs/ND+
	 eySIP59xi21CB8ByHbI1m3af0c5tQq/o1bZRt2gig7z82Mr00IS/Le4O4sfem9dyeh
	 azwqwCoG9ScVfulUr2C/mS9L8ID5md/Hb8ZhQKZxT0LbjF/1R//MRKT/siyudGcYvz
	 sRznesH3GwPgZEdH5XFRtm4GjojQFWdeyxF5uDMpO21KSbfXb0YbWcirhqF7zGnKvM
	 DbTa+QFaembFWtlK0ntbmha7yABjeMXrEb1/1PLni72qSd0NUVpt31gbFraCi2L0w3
	 UBPceFHmS4bKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	hamza.mahfooz@amd.com,
	wayne.lin@amd.com,
	srinivasan.shanmugam@amd.com,
	joshua@froggi.es,
	haoping.liu@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 30/43] drm/amd/display: Skip on writeback when it's not applicable
Date: Mon, 22 Apr 2024 19:14:16 -0400
Message-ID: <20240422231521.1592991-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit ecedd99a9369fb5cde601ae9abd58bca2739f1ae ]

[WHY]
dynamic memory safety error detector (KASAN) catches and generates error
messages "BUG: KASAN: slab-out-of-bounds" as writeback connector does not
support certain features which are not initialized.

[HOW]
Skip them when connector type is DRM_MODE_CONNECTOR_WRITEBACK.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3199
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0d3e553647993..9044214dfdbdf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3028,6 +3028,10 @@ static int dm_resume(void *handle)
 	/* Do mst topology probing after resuming cached state*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (aconnector->dc_link->type != dc_connection_mst_branch ||
 		    aconnector->mst_root)
@@ -5879,6 +5883,9 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		&aconnector->base.probed_modes :
 		&aconnector->base.modes;
 
+	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		return NULL;
+
 	if (aconnector->freesync_vid_base.clock != 0)
 		return &aconnector->freesync_vid_base;
 
@@ -8633,10 +8640,10 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
 			continue;
 
+notify:
 		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
 			continue;
 
-notify:
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		mutex_lock(&adev->dm.audio_lock);
-- 
2.43.0


