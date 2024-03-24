Return-Path: <linux-kernel+bounces-113864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70817888708
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B40E28F0EB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E384120931A;
	Sun, 24 Mar 2024 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5j/aqUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC031DCCAD;
	Sun, 24 Mar 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320912; cv=none; b=r3NLsc2oCjx9lr9bS7XrkJEbZd8YMpHtdBGyZroBdJK4vNyUpjqsGg2HVHxceFhEgz5/me6iJhZaC/KafVg2e509V1DYqrYadEWlke8L+Uk17LOBY23kjkCHIl/2mrMW40i4ej//Y6LF0jRJQQA4+e4Haty04hQi+9OZAaHZHRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320912; c=relaxed/simple;
	bh=RG5DNBFWOVV6swYzwisXML9v67pmLM2qNfQPiK8Naw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvGXFN7f5Nbh0v7k/vBEKd0xy75L7aWOaP1OGK3gJD6lbpl9W/N5vn2hQaYF4iXAteS/0/Rejq4lHKJUsZLgUnPWGdfmD25xChYHy7z2PtYgxlidUtkWkjSefb4hRGdini+4SBQUdWSRPHfYpNerKavYqcEOs93r1/GIAkok0gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5j/aqUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E0EC433F1;
	Sun, 24 Mar 2024 22:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320911;
	bh=RG5DNBFWOVV6swYzwisXML9v67pmLM2qNfQPiK8Naw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5j/aqUSCXNAa7WeaykddcYjQGwW/y6jQ1oruo1AoBSfIHHVH0z8Svr3wTT7H/zMq
	 H6W1AC48M0ZJb28TVTtZ8W4bOxzNkIuW7eC80W0MV6/g8MZDBjllZrWjLqMiQgXOvW
	 3+lHkRJsr5Drg0MLJDp36Jx+EbXjK9LBVyhbohrxLSYsiA+IFL/Wjv/1LIaIMLkQwM
	 636/nWXFtM0PHMcnXdMLquzI+BbqYVsa/aYEvwbBs7Nk+sToGwHNwJ1rwxqOI4/lPv
	 J7WE/AqoL/WUJrnJE30aw/RwOjXAclFkrsxl+zzdAI48361UiHIdQrnZzXMoRrFSrK
	 TvsnnuN8RIrRQ==
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
Subject: [PATCH 6.7 474/713] drm/amd/display: Add 'replay' NULL check in 'edp_set_replay_allow_active()'
Date: Sun, 24 Mar 2024 18:43:20 -0400
Message-ID: <20240324224720.1345309-475-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index bdae54c4648bc..7c4a93d3cda5d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -889,7 +889,8 @@ bool edp_set_replay_allow_active(struct dc_link *link, const bool *allow_active,
 
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


