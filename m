Return-Path: <linux-kernel+bounces-113335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED3D888380
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D061E1C22BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770BE197552;
	Sun, 24 Mar 2024 22:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzhDlEPx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D7A6D1AB;
	Sun, 24 Mar 2024 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320136; cv=none; b=rgUloBT2bzc6LBxPr0fJeZo8N66oYo3TKp44l1/hjs6AX/tEvNBvDaU45kZfHhfX0bXPPKgvqP1lrDMvsoP0p5k23DGsND1Xnm11ZJkgav1OZKbN46gweWVZTFy1sCp0a8AgwbVM2WA/s0XcZlpIBwtuZYNrs2+5zgMYkEUOb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320136; c=relaxed/simple;
	bh=AE78y5qGH6kGnE6uPJn7AzC5Sja71QGpBQCSPAruAfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uUccQHdvdXXKHnIn+cqPlM5vNMIUfK6f0rmotWwZnFQESChNsrcC0+12dJSZpk8tXdKrp1lq3dO5q/ZUm71dnIejvFXo34BHhOSRwas6sr3EJi8Yr8u8SE2BZPn0YrBK3BedwsGB0XbrsMZzFtmpdUlZskHNAYJfS647iP5Kp+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzhDlEPx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69243C433A6;
	Sun, 24 Mar 2024 22:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320136;
	bh=AE78y5qGH6kGnE6uPJn7AzC5Sja71QGpBQCSPAruAfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzhDlEPxmo52JkcDlI900XwSL/3JmwuoAFkMS9nnND+vsS+w+4IPaPVLvluwAKswZ
	 noyrh9cfpMt/cesNeU0YZ2kGr0d/OqMD3/NkbWDydM9oUCPN2VozdlfG9pwrv03Nsl
	 CbU9SmdHOCEw7DXZSLbBDDZz5rhRRdB2wgLafQN4VSwruECEAbuTsR0Fl9pvKlE2Mb
	 c4x0mKVb97mk+4RIAlu1czP9NPFWW6ziuHiU4wiHFsyORyA8CP7v/leEYkk7ZqujVW
	 3ma9MFF/8Z40Q7GUCKNCTo5n2U/+RL9twM8ZJACdaP1Kyek7H0MdVGQ0fLv8kpmjuz
	 LhD/3DbdDL6sA==
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
Subject: [PATCH 6.8 444/715] drm/amd/display: Add 'replay' NULL check in 'edp_set_replay_allow_active()'
Date: Sun, 24 Mar 2024 18:30:23 -0400
Message-ID: <20240324223455.1342824-445-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 046d3e2054153..f1489f4a40c12 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -892,7 +892,8 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 
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


