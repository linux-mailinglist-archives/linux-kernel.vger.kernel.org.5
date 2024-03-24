Return-Path: <linux-kernel+bounces-115702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6375B88947A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200D1295A07
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9799F210A5D;
	Mon, 25 Mar 2024 02:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t3Rj4L4Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233D21087B;
	Sun, 24 Mar 2024 23:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321699; cv=none; b=F21CFsv/HWrKk+2qMx2+j5u/f/VEH7mB/j8Nm28yd1rto9v/L1qSOCnDKU9CX05xuKmlAfI+Bc+qhVVQLPapm9Ec6r7jFD9mYSiX7Co1HCGbQGx4tE7j1MfeXiajerfNI/3bg/GE/4VOv40S9GbgA/8Z5KthbD5CWj5B6CC+jz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321699; c=relaxed/simple;
	bh=0robPL3ORU/kdT281CZW4S42KKfCnq5JV9Z1hIIsSwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6BKnkiD6YCNxY0KnruI05aWf77/RP/U3iOrXOvT8IYLISSBFW5h6uxX0LpnEJUZebl/Jz1DQBUp1eDSE3FWEtDQu596OnRP8LCfoqSHT4/6WWtNF55nseg8T1xcR67/UXMqGnDGWRApFpdsRxRcXh+tG6ctb+5UU/0m2UQ+mx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t3Rj4L4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC982C433B1;
	Sun, 24 Mar 2024 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321697;
	bh=0robPL3ORU/kdT281CZW4S42KKfCnq5JV9Z1hIIsSwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t3Rj4L4Z30NccqUfgjbd3uBmKA2U7qwNORPu3SehzJLYYwEeMUWLclTNIMjuJaHAn
	 51SGphk42wvQ20xndge+cJuxBWCNZgVkQU/EY7nUFIl6ekcyIjGH7JY23XIPIMHhIl
	 gWGLhs89IW3wrIoQu+XUt/8AQHemqMWDAyQIEts/aRbrG9P6P4nHUyQxE+Oceq9kSI
	 V5VYcGGF2HpTR355LBkuOhDSW96ACJpaV16o9gtoTbbQlCCkZgTXNuTsMuscMpxF+g
	 +QGRDMrHmVPe7H/0WF7t6yaz/gdC2XcaQDGZoR1aLqVg152DJ8kl1OKAIU+DOflGNr
	 U+5pd5n6qEHSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
	Roman Li <roman.li@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 426/638] drm/amd/display: Add 'replay' NULL check in 'edp_set_replay_allow_active()'
Date: Sun, 24 Mar 2024 18:57:43 -0400
Message-ID: <20240324230116.1348576-427-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit f6aed043ee5d75b3d1bfc452b1a9584b63c8f76b ]

In the first if statement, we're checking if 'replay' is NULL. But in
the second if statement, we're not checking if 'replay' is NULL again
before calling replay->funcs->replay_set_power_opt().

if (replay == NULL && force_static)
    return false;

..

if (link->replay_settings.replay_feature_enabled &&
    replay->funcs->replay_set_power_opt) {
	replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
	link->replay_settings.replay_power_opt_active = *power_opts;
}

If 'replay' is NULL, this will cause a null pointer dereference.

Fixes the below found by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_edp_panel_control.c:895 edp_set_replay_allow_active() error: we previously assumed 'replay' could be null (see line 887)

Fixes: c7ddc0a800bc ("drm/amd/display: Add Functions to enable Freesync Panel Replay")
Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Suggested-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 6f64aab18f07b..13104d000b9e0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -882,7 +882,8 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 
 	/* Set power optimization flag */
 	if (power_opts && link->replay_settings.replay_power_opt_active != *power_opts) {
-		if (link->replay_settings.replay_feature_enabled && replay->funcs->replay_set_power_opt) {
+		if (replay != NULL && link->replay_settings.replay_feature_enabled &&
+		    replay->funcs->replay_set_power_opt) {
 			replay->funcs->replay_set_power_opt(replay, *power_opts, panel_inst);
 			link->replay_settings.replay_power_opt_active = *power_opts;
 		}
-- 
2.43.0


