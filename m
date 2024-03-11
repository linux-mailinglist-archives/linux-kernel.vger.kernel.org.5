Return-Path: <linux-kernel+bounces-99066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB47878310
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4901F22ABC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D895677A;
	Mon, 11 Mar 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o38p21XE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8255674D;
	Mon, 11 Mar 2024 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169976; cv=none; b=nKyrl1lkWhnbMHP3COFdt4sXyxZSBxfBnHPqFKpcP9+qandPOWeCwZlmA3s3ktJBvQ9HiOXdTlBJP0IYHNCPOJN6iMUwwgqBRXKEvbb+CaEWlnBLcyHmJdfocQczoKzRXreD9hYGIUx0Rauocvf3XQTebLiWT6GoTkwYf1IGRO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169976; c=relaxed/simple;
	bh=OgG/WDJUTsEvv9Tyw8GnnVBTZTEmUUmnwLIp/HEj/Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mt6bzHxuSg1Xd6lZOb0XSELvRhiyufIta7ZnPWGrLthRc2wsPDib72/DPbozw67dkTyaqTYD7iAHzZPCoT6stFWB52B4RMdLRaEqEa3JEI2KFk+83MRrAm0RzsOzJrVPE2n+MaDyQg78du8vvFtViD8Qh5j2YXTbhn5UDbqriLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o38p21XE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F724C43394;
	Mon, 11 Mar 2024 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169976;
	bh=OgG/WDJUTsEvv9Tyw8GnnVBTZTEmUUmnwLIp/HEj/Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o38p21XEU9GB+2aFSM+Zo6CewuEX9KSjwQghrgnqQ3YDu9cJQkWG0WYyITouLQRZ7
	 FCoBTDd15pcKXJx3BrCktgsc1eZFtD/1Ph+XkOlyoN7qCYxj8NJL/6wX58TE19kcFo
	 EPuCmKbTN53+sYUQNF4MwA4TFn802NQHKMPr1V+jRpXCA6Ejjd8eFMCt59dKFzYISn
	 fCXfcrRg4hyFNvtYRtyuzhwxMbUdxAKytou89aNwc2N8BlgPvKjAARNrk2sRtbYrAY
	 DLdnZTvw33Wk/LN+bvAhaw/tKSU0L7tXOAHEWfHZuhQ5OlRZhQLQStCluTgGTPd7/4
	 O44u31JEf51gg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 17/23] drm/buddy: check range allocation matches alignment
Date: Mon, 11 Mar 2024 11:11:57 -0400
Message-ID: <20240311151217.317068-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit

From: Matthew Auld <matthew.auld@intel.com>

[ Upstream commit 2986314aa811c8a23aeb292edd30315495d54966 ]

Likely not a big deal for real users, but for consistency we should
respect the min_page_size here. Main issue is that bias allocations
turns into normal range allocation if the range and size matches
exactly, and in the next patch we want to add some unit tests for this
part of the api.

Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240219121851.25774-5-matthew.auld@intel.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_buddy.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_buddy.c b/drivers/gpu/drm/drm_buddy.c
index f3a6ac908f815..5ebdd6f8f36e6 100644
--- a/drivers/gpu/drm/drm_buddy.c
+++ b/drivers/gpu/drm/drm_buddy.c
@@ -771,8 +771,12 @@ int drm_buddy_alloc_blocks(struct drm_buddy *mm,
 		return -EINVAL;
 
 	/* Actual range allocation */
-	if (start + size == end)
+	if (start + size == end) {
+		if (!IS_ALIGNED(start | end, min_block_size))
+			return -EINVAL;
+
 		return __drm_buddy_alloc_range(mm, start, size, NULL, blocks);
+	}
 
 	original_size = size;
 	original_min_size = min_block_size;
-- 
2.43.0


