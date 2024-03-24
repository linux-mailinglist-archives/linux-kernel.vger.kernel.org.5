Return-Path: <linux-kernel+bounces-115289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F746889495
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4D2B2C3CE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A7415ECEE;
	Mon, 25 Mar 2024 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RriCyZuX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977B28002A;
	Sun, 24 Mar 2024 22:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320503; cv=none; b=JkRyaVJSIBLiCAjPFO4o2p3JIDs6FsfBtfxw05D0ePtFDQMZux5hsgQcy0FUwNpQq9fbdi+Py+JS/9qbPoHhKRSt1XYgn3KPNOn2TlhZNSi4RtXQ6mC+emf3sbQO47gVKhXRKu20c4Ro7LgUqefY66kaSjCJcWG450EBYNT7jmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320503; c=relaxed/simple;
	bh=OgG/WDJUTsEvv9Tyw8GnnVBTZTEmUUmnwLIp/HEj/Eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RT829Vy5Phzz1dwDnXTmi/2NU0B+G/tHgLM22yIYkLvJvPpcW1fm9PNcJ5LBMbeiYGrtTjbxhJmIskn3pVFYvswoJOrSgYHSBu4aZFNxqxlahY2MQnTIp/S3Z0jv1bP9hY/aqlWiXJp5//3yB/EPrPcxh/CizsqVI0xzq0YRi3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RriCyZuX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FA4C43390;
	Sun, 24 Mar 2024 22:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320503;
	bh=OgG/WDJUTsEvv9Tyw8GnnVBTZTEmUUmnwLIp/HEj/Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RriCyZuX15QM2sU9nriKQNuXda5FwE3tbj2tgshwXu1ytbnQFKFzlZECXxXa+pM9s
	 7bPQQ0O0vL0fTOUgxfFkbfk4qyu7t0yTzihH+pqeNBDiEBjiDnpxxrPcco60R8MAJ0
	 vyGNszDykR4Xi2nIa4swb/difhUxaC/F4jBb7zGdk9zaCHN/OpJAB9/BSQSTjYHrV0
	 QAkJtpC+a8xBZCJOFsKlwWeDknaWLfBK8RYGs9uezT0rRWv7txc2e1rsFtYO7NHu+c
	 XMQ+tJWS8b5lO0t1I+wvPTWgsL+OguFeo5UbLK8r7PT/Z6+/7UxfbzDfsgUluoCymG
	 cF0GsQoKHuGeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 063/713] drm/buddy: check range allocation matches alignment
Date: Sun, 24 Mar 2024 18:36:29 -0400
Message-ID: <20240324224720.1345309-64-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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


