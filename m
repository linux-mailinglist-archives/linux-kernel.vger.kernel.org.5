Return-Path: <linux-kernel+bounces-154280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE78ADA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6CFA28557F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1702516DECE;
	Mon, 22 Apr 2024 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfiAe4ls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C6157462;
	Mon, 22 Apr 2024 23:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830212; cv=none; b=IRo2+by5xRantkK1i47FPy3W/ARkHaxGTzcPNYcnTH8/7yRPMdE9XNjubl1zk8eQUa31a9A+JEDGYvFYbEq6wvPyTdyi1AuYcI+xbu9xG7Do5Rucg73UlffwrO+FyhLQhOUCP3VVpl7RtW3F3Y+NOERFSKSPNO85D7xTLT5//h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830212; c=relaxed/simple;
	bh=neCIuZNTimoKBpGFJtl6Rx0sndwdJJCl75GVQjtgZeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sWp8haX1gC2hkNcRmVDQMmCeorVoC7RJvIPvWfS+aj6DUyYcSJ/c4ZvoZh6pvSvXiBlTG+E56nTdjMzdLF8GeP2rfAtkcaHPgpVH8xWmdQsoBHNPLAE+SfDN0QMtVH5h8DvklAbDIr6v+iJvL/UnTs8P7H6uMyCXJP5Tnm3hMFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfiAe4ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1388EC3277B;
	Mon, 22 Apr 2024 23:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830212;
	bh=neCIuZNTimoKBpGFJtl6Rx0sndwdJJCl75GVQjtgZeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BfiAe4lsxcUeNQMheiPUEhVexpi1Kjdy2BlnARi9yDY7+Y0Pj2QIyl2+nDdnUv8+M
	 hght47wnzahwc7HIBqB0FKtjUVEVRPMcG3EqF8gbJ+spBm/JTl4FG7YdVudOHTC4g1
	 fMOvlD307f0w3sTePlq9/whE0I5sTZUIhbkTV0XFgjvtpPLAgz5J3YIq33Y+5nv4ni
	 PZ0UY+QkR683IeZ+NeJfFRzfaiGF7HCazAjzDqglI7V1Krtm149jm+ke4K4duNbF2L
	 MMOmylDh0knbxgotuX/xpPLLOuxFGzDQ6mUdDnGQmwBw5AuCCRpU1nAGWRSRRumLMt
	 +BOMnPy5AvAAw==
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
Subject: [PATCH AUTOSEL 6.6 19/29] drm/amd/display: Skip on writeback when it's not applicable
Date: Mon, 22 Apr 2024 19:17:00 -0400
Message-ID: <20240422231730.1601976-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3442e08f47876..98dd07e3726af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2974,6 +2974,10 @@ static int dm_resume(void *handle)
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
@@ -5756,6 +5760,9 @@ get_highest_refresh_rate_mode(struct amdgpu_dm_connector *aconnector,
 		&aconnector->base.probed_modes :
 		&aconnector->base.modes;
 
+	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+		return NULL;
+
 	if (aconnector->freesync_vid_base.clock != 0)
 		return &aconnector->freesync_vid_base;
 
@@ -8445,6 +8452,9 @@ static void amdgpu_dm_commit_audio(struct drm_device *dev,
 			continue;
 
 notify:
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
 		aconnector = to_amdgpu_dm_connector(connector);
 
 		mutex_lock(&adev->dm.audio_lock);
-- 
2.43.0


