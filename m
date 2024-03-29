Return-Path: <linux-kernel+bounces-124763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3E4891C46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5AD2B26F08
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C1A180A7D;
	Fri, 29 Mar 2024 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKPyu6CV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B518132E;
	Fri, 29 Mar 2024 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716102; cv=none; b=aNIWw17OkRd31O4yBLwrdPqkUtWAmJmXKK2G5wYO0wdS9UjVEXpVi7o5mA/MG5wrk5UC5qqIOdnDWQtSgjFMm/ZCWbu0aTGK4Rkt4LVb/Zb3HJr3z9t7QsZNl3s3YOPlCKfn08lzYo8no9zLlnzVsRXy3Au27nVfNhE4tAFfJeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716102; c=relaxed/simple;
	bh=58rZfvaFipaxYd8uXFiVRAcZUdsrKwMl21wU3vpq4q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdsNQbWy1sK4tVTguiifP3MOew1oqY+7OkkCQwpBp2fTeAf6fZ71Db819kYkiTrhLs630AXOeJ3uul1WtiGPqz7UrZtN9VqiYRdHH+ojcglPSp6OLFwtUH99ezt5e0UxIQqeoPyjRW4vLmhIWmKiO9cIsU+6+t8TIZzwFtmZQO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKPyu6CV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147F8C43390;
	Fri, 29 Mar 2024 12:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716101;
	bh=58rZfvaFipaxYd8uXFiVRAcZUdsrKwMl21wU3vpq4q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKPyu6CVVWdWaA+vz6/uZEEaFEkg3aIaFDwGNtx01yBYNuezoXkMxpHzTef1kbsT5
	 QCz9n3xgNAyn2XGiuRHKEM8jvoyYenXCZ6Sh7aqod7z9OzbsP7SAMtM76oenlU8Ja1
	 oauW/eokLc8gz13KD52zD5/eVAO82QwNsKe3mGPydQXkJFj21bfqNy1NkztsnO1GQN
	 cBMtFWhueOjc6f7uceG67tOdcWr7aUTMeNeKr/z8tCZ4EPRg3bxNms4AreNMahgKBN
	 AWy935ihw67H7+BU8v/uvO0CkobvZUeE3p7nwxKX257HfVLj1ZWk/rj6HyZ+Ys4NPi
	 EP1aFm/BekePQ==
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
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 54/98] drm/amd/display: Fix nanosec stat overflow
Date: Fri, 29 Mar 2024 08:37:25 -0400
Message-ID: <20240329123919.3087149-54-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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
index 5960dd760e91c..8ce6c22e5d041 100644
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


