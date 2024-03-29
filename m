Return-Path: <linux-kernel+bounces-124847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA49891D15
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0908E1F200E7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549ED1BDB98;
	Fri, 29 Mar 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3x6v+eb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9199A14A0B8;
	Fri, 29 Mar 2024 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716283; cv=none; b=LytF0+rDd7tULm+vvP8f5MxKouvgJFzHxEiAisU9jtROUwryLlyT0qpg432D+2Yc3bSt18qjzqfmM8vJ4KcPCM/KfiPmyI9Xnv6CagLRt/44NfX5Qh6ebwFUydbtM/9MGs9TVCQ5d4KM4N2IMtoqRtY1/Yjg/5Boa1oiM5WlBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716283; c=relaxed/simple;
	bh=aiYW0yw5E+HOidbqciMe7uHQZ7wj+DvE0N4dRycpisI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KSZv8yxixts4X3jzZFSVjeEzClbM2ZC2i3mFmUPgr13ZGlZk4BPwDMvC79/+E/E7kyV+8Fnpgd1W08QoCEgWamyemZPmocvKDonk98z1r8t8rk/aZguMbQ7S2RUBlf8tHn40qAgDk5uGxE3EY/bqc46jQDW3mYIZeyrZt99PU1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3x6v+eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A972AC433A6;
	Fri, 29 Mar 2024 12:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716283;
	bh=aiYW0yw5E+HOidbqciMe7uHQZ7wj+DvE0N4dRycpisI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M3x6v+ebKqW3jRgkXYQuPtwlnSC/XkO4ZQYnvZimbmmpfc12zn2F4yoyfM2jtDe7G
	 O5STZzbPEwISyPl+6K0S5vvt4nG3xliA5zzNEZq8Ggq9JBAQ3c6+pjSb173SJbAGu4
	 rtZaHZCyO7vYWD9CkfCA7Dx35hK2zIv0+ngsevudzWp0LzQJa99nNVafkpjga045Rc
	 XRcbd3FGDmiWMWC/YCCmOOmM3+Ys1qUvFiCJ3iQEuMiOxOjlCWxwY30BjVh5nWZufV
	 z7fW3nvFOYchwmALfMq0SMRMOyUq3xRc88Bg6cKTT0C7+C45VWCU8eOjUULPU1nlNJ
	 IPSoscEqnd6XQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aric Cyr <aric.cyr@amd.com>,
	Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	aurabindo.pillai@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 38/75] drm/amd/display: Fix nanosec stat overflow
Date: Fri, 29 Mar 2024 08:42:19 -0400
Message-ID: <20240329124330.3089520-38-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Aric Cyr <aric.cyr@amd.com>

[ Upstream commit 14d68acfd04b39f34eea7bea65dda652e6db5bf6 ]

[Why]
Nanosec stats can overflow on long running systems potentially causing
statistic logging issues.

[How]
Use 64bit types for nanosec stats to ensure no overflow.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/modules/inc/mod_stats.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
index 4220fd8fdd60c..54cd86060f4d6 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
@@ -57,10 +57,10 @@ void mod_stats_update_event(struct mod_stats *mod_stats,
 		unsigned int length);
 
 void mod_stats_update_flip(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns);
+		unsigned long long timestamp_in_ns);
 
 void mod_stats_update_vupdate(struct mod_stats *mod_stats,
-		unsigned long timestamp_in_ns);
+		unsigned long long timestamp_in_ns);
 
 void mod_stats_update_freesync(struct mod_stats *mod_stats,
 		unsigned int v_total_min,
-- 
2.43.0


