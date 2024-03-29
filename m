Return-Path: <linux-kernel+bounces-124908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37059891DB1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E236B1F2A6E4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCC529D390;
	Fri, 29 Mar 2024 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9zZArx/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD2A29D38A;
	Fri, 29 Mar 2024 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716411; cv=none; b=He4W/gqDHx5qz1aBaT7ivr6CwVUhRf2vHoquWzYxCJk5j1CNa8EWQeA02A1WCTRZesa+vKh30pJ+Rz/spl9FWRxI2MAjfi9A9PUTDyqnNvzWi+1PtyEHdmOg5Vs7Yu+tOd4HPJpt0c+BF+ODlEarfZ0K9dlHPqHbPlXWiIwa3vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716411; c=relaxed/simple;
	bh=aiYW0yw5E+HOidbqciMe7uHQZ7wj+DvE0N4dRycpisI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ac2XtY5jkMoghz3GMURugC//IFBNeq0ZhRaZ59Q8y41JehCcmvSpmE5ULfc3RPYqDGqI8+KCYpDugltr++EgNuMkchwTviHzU4xZEREUc9DIa/6GCd6mJ8afgJxi6Woo7SibcP7cuv0IuQRBL2im1DZ2sYlYttaQHiUmgMtdrYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9zZArx/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33944C433C7;
	Fri, 29 Mar 2024 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716411;
	bh=aiYW0yw5E+HOidbqciMe7uHQZ7wj+DvE0N4dRycpisI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I9zZArx/ejgGFTEYvrZX8+IKqWa9nCUJyAgQUZcdtw4VpP9MvRAF9w8gniKSOn8zm
	 edUq/IjHzRj7jumccAos2FlwgRxVgUMyZuG1A8NbVE7rRbK50KWLz2UZEByc3zPb9s
	 P7A4bMetDLB8Vgjq8/t/QxSBgDtwps7RdoSh/ENmni1jI6UplhQJ1xDqJXaQ3WtjvJ
	 jRSK6j+DONEvmK6W3JVHoRsrnucA1sX93JVgG+b7muzykwXZu1J2mtKqdxGvf91iVJ
	 lHnRTCHTtxpnY1ng3wLRdD074dXSHIqaM9l0h3o2OM2l7PXMhrgzM7Zl6v+SF5PD96
	 uRrfwPuH393BQ==
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
Subject: [PATCH AUTOSEL 6.1 24/52] drm/amd/display: Fix nanosec stat overflow
Date: Fri, 29 Mar 2024 08:45:18 -0400
Message-ID: <20240329124605.3091273-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124605.3091273-1-sashal@kernel.org>
References: <20240329124605.3091273-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.83
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


