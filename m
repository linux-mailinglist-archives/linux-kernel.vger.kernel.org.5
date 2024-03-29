Return-Path: <linux-kernel+bounces-124952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84806891E2C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ABE81F2E6F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCEE16C876;
	Fri, 29 Mar 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHRK2dhJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67B16C86C;
	Fri, 29 Mar 2024 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716500; cv=none; b=V2WXiICSqgrKWdmINWswo5uAI2EKtkryZ0SfzMhizJ6fhwbRf5JG6Gzxr0vKiU7Uh8sfS99xcaOzZHqxl1Ser0RgxyZ2z83/OOdKE96usrhGqYwJJmq044LChZvmz8jTfhELKsvIVlGC4Gx3KBfaFJkhUTbo9OgG22MNbd4VaZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716500; c=relaxed/simple;
	bh=aiYW0yw5E+HOidbqciMe7uHQZ7wj+DvE0N4dRycpisI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqO9ZT7VStyvLWJYYw/LT907jA3rGgfmYsSpZym+LPJyxoeC6Y8nBzbC8lUyHaHlO13OsGB55v3h8Ln4rN67SbrpPK/tCzZj2PQFuNGgpgptoK+haUMIpfHpSPDilz+hI0vct09BnEZMAFZFRr+9M9EBB/wuORKk3O3zCfzGUFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHRK2dhJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32399C43390;
	Fri, 29 Mar 2024 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716499;
	bh=aiYW0yw5E+HOidbqciMe7uHQZ7wj+DvE0N4dRycpisI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DHRK2dhJZkcJKNAWf/BFhJy+SylX4zcnvQ/1i8SJs32mVA+z8CVr2fj7o+YVDjAr2
	 V570dNpDBEt6hTatldcRBNoB1Qab1iCgCrbKBz2vlAcVyBdwACv5TNP957dgOXtVoe
	 kDCXZV6XnnECYMHl7s5nyiQI9vLJH4b3l6cDil3Y5Px1Re2DtG+ZGGuCrdU/ffalZ8
	 nCKSc3bK+qFG9oKGEf2ms5YPMGZU3x9VTZ2q/4o9mgiqWEC87ZZ5wxWHk8nQuszdU6
	 H420lvdlZMDCiBK8o6ca2ZcoEBtNVrMzMkBiXol9eWpLQvuA92zowGqsHl5i4dqux9
	 VD19vtWbbOe0g==
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
Subject: [PATCH AUTOSEL 5.15 16/34] drm/amd/display: Fix nanosec stat overflow
Date: Fri, 29 Mar 2024 08:47:17 -0400
Message-ID: <20240329124750.3092394-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
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


