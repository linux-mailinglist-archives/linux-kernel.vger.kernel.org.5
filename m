Return-Path: <linux-kernel+bounces-125013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 152FB891EC5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 475A11C26A99
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84731B7E46;
	Fri, 29 Mar 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OICQ5ysB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091A21B4536;
	Fri, 29 Mar 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716632; cv=none; b=l0PMc1xFg37TVZlGijnZxppQw7dTTr4ZkyIGDLUvYIZcbYrF0ffaG8yGNi6a/i82HGxEvRCd/5ZX/cBUn36B5yUsixYgmeD4SUjqhLjJ4pyg45OHa+at1GoLmsQ6LWubc9Y83mcl2MQEraRHsr2B2lI33AL2/ifGLBCFeC4Ko7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716632; c=relaxed/simple;
	bh=vWrJHpNpvv/pTjRBRuxyQkmES6YQhamOMA0mHriCXKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkOFoU3OusK9QrTbIQlBQUg5Isv1ppbpaCfGTHmKy7Exo3p/Lmk4b5azU83hVyW3+CrKhraXvYsSIyXNT9+foJa//HE+cKkVUIHVXoYOJfEKdlhoXJzQ96TckDiSIcNJ1lpO7BcVOj3cD7p7tA5rPDzC+ltbVe9MEr7o43JgXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OICQ5ysB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2959AC43390;
	Fri, 29 Mar 2024 12:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716631;
	bh=vWrJHpNpvv/pTjRBRuxyQkmES6YQhamOMA0mHriCXKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OICQ5ysBrjXUQtRRICa15HU1Ejd1qMZvwmP0IEgtmJNI/pBjRdQICvOursh81ocsW
	 HqtW+EUOatSDEquzJOA/ryo/ZcumyxlcaOAGPLEuwJR0lUKlHt7uLqU37orNEeHL4+
	 QvlyvGIbZTFLBBlDD+2/jbzHMIR9rtUbmNRU+nNJf0NO5lJtAOJgli2F33NCZE1R8P
	 oHeHheIT/Sy6kUhoz+5Ldtrl9z2V+l1dspIbSX0tktttV8mhmZ71zjtBKHeNX2saVI
	 JvEJxmEAiSZtIywBx7n49z4uxTgWbpye7WKgCq1LoavBThM5NHlqVR5uDYdcgStiCs
	 FccBuRPMDZtMA==
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
Subject: [PATCH AUTOSEL 5.4 11/23] drm/amd/display: Fix nanosec stat overflow
Date: Fri, 29 Mar 2024 08:49:44 -0400
Message-ID: <20240329125009.3093845-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329125009.3093845-1-sashal@kernel.org>
References: <20240329125009.3093845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.273
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
index 3812094b52e8f..88b312c3eb43a 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_stats.h
@@ -51,10 +51,10 @@ void mod_stats_update_event(struct mod_stats *mod_stats,
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


