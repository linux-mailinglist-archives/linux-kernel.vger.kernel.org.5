Return-Path: <linux-kernel+bounces-115240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B35888DED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13D92901E6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3BA3136A3;
	Mon, 25 Mar 2024 01:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOLp1qvr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D6B184F03;
	Sun, 24 Mar 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324339; cv=none; b=LIlemU7Cq+8F0SLQJJ3GaKRsvnGZJ97CM6+ryPRU6LpiCYWcMduZp43oKnSBgc4A0y/t8DqgYkmh52oxzMXEzQa2VM8JpiCYtKBOOm/WdLmlN96V647mxaGqPwRLBesimemmz1jxUQHAK2T/Yi0Y77iarww98L1PYXyxDdlsnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324339; c=relaxed/simple;
	bh=QDqgZV5Fcdtcnfr801KMcgRP7NgSQJ85Lz+W/n382oE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+NQ9nDtHdA9/h6bBncOaTUnRwVC5gA1mjvT6I9wDDLcwfqJv5nHe1WmVOIV8uD1DMR1XsQab3n6V91iTppbPE5WxwjsBedyLz5W7FihGrx+yVouexR+a0/VsW9wak8b92qQfCVyARN3/JBWaylW8ExVdvYW9CL98I9va0UtEMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOLp1qvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1E3C43394;
	Sun, 24 Mar 2024 23:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324338;
	bh=QDqgZV5Fcdtcnfr801KMcgRP7NgSQJ85Lz+W/n382oE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GOLp1qvr/i9Ply+BWzGEakFlPPNRMuRizHmaJXPXGN/28WKcFIKEYthmFt+iJMgTA
	 BLnia4i9U9r7QjyKIwvhstWfd9FlZkyWeq2hzThU5CX93f4K/8DjTpE7bWDkiCeghb
	 awCGKLgFyFZirujJ+YDLEpZyA0vZ/B5K5LC6ZQReYJfik6kii5UX/KN2XecImueTXk
	 KKqUMo8HLUGVG3+AjjmEPeQACrWBqkLyYTe4HWsCcRGxwzNQdUnKoh39XLKeJprRrP
	 i+40YVXc2BsDDcDB3p/x1G0Zga2+ehilP/tFrXQkElC1yXtzdLkSfi+SazAqVp4thn
	 7+vQsVJUFvohA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 108/148] drm/tegra: put drm_gem_object ref on error in tegra_fb_create
Date: Sun, 24 Mar 2024 19:49:32 -0400
Message-ID: <20240324235012.1356413-109-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

[ Upstream commit 32e5a120a5105bce01561978ee55aee8e40ac0dc ]

Inside tegra_fb_create(), drm_gem_object_lookup() increments ref count of
the found object. But if the following size check fails then the last
found object's ref count should be put there as the unreferencing loop
can't detect this situation.

Found by Linux Verification Center (linuxtesting.org).

Fixes: de2ba664c30f ("gpu: host1x: drm: Add memory manager and fb")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231215093356.12067-1-pchelkin@ispras.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tegra/fb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/fb.c b/drivers/gpu/drm/tegra/fb.c
index 4c22cdded3c21..e39d33f66d795 100644
--- a/drivers/gpu/drm/tegra/fb.c
+++ b/drivers/gpu/drm/tegra/fb.c
@@ -157,6 +157,7 @@ struct drm_framebuffer *tegra_fb_create(struct drm_device *drm,
 
 		if (gem->size < size) {
 			err = -EINVAL;
+			drm_gem_object_put(gem);
 			goto unreference;
 		}
 
-- 
2.43.0


