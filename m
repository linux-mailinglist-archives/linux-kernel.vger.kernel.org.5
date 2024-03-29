Return-Path: <linux-kernel+bounces-124716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B65CC891BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE401F25C11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3403F145B2E;
	Fri, 29 Mar 2024 12:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWsCKt87"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E5F145B1D;
	Fri, 29 Mar 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715975; cv=none; b=of3e9H9yoRRLb+TuKzDWTJYm8Esx0lY51W6y/MY4I14J/llteO3TwgfbJaEppP4abKCy7dmbZVNL2izO6GIqEVqM8HSP0LGe4OYhM5mlKrNMthaenriZ1C7yS+uHeLn5iZnvoEW7JoIx87dAyP2NLg40Ec4j53K++GAIuMWCdoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715975; c=relaxed/simple;
	bh=Bgva02h10YgXphpv/cc1/YN+9JhBWLSu9nK7PK7/9qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQ7BIpVTjTUzylvAZmXJwA26xkdbi65/a50XgflTUI8mCZTDPtYgSBBInL2hIeGFkiH7sOAz2veVdV8MZXS1JHUbEkO3TyuBej51d34315mfCf5H0FqyjQ+DHwkhvkuENz4YKf9U86ovq4yGCTXaKArRjij/lz7Gi+1p/iX+8UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWsCKt87; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5EBC43390;
	Fri, 29 Mar 2024 12:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715975;
	bh=Bgva02h10YgXphpv/cc1/YN+9JhBWLSu9nK7PK7/9qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lWsCKt87Byps5cVWHYCkVYFxrS9M2Qlv56bqdlZabsyJJnaqTnryR1ELO2yLqZYxm
	 bjQxCNZ5Kw5WiwJ9VPINzHegmyU3cP54lhpdZdNZcSKqBhfT5Psa4cKsqOO0Orugwm
	 3nfPyrpEgVTHoBjcQU8+QhiKO3TD1Hv++IdwmaAlpU8VIsIRI+cptwz9i5UTbXkFR1
	 +PPWicDctxFmluj7Ga7tui5UKs573OoOnG5jmAPZTnqY92xj+dcQJY4qqkRgDjdr+W
	 giFFu0FiKabrbgdATOXfN/Qdxj+LGdAonA7+KsC5te16HBU23h2fOqmK8awOAt8OhO
	 eNZU0u5s0mrsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	ray.huang@amd.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 07/98] drm/ttm: return ENOSPC from ttm_bo_mem_space v3
Date: Fri, 29 Mar 2024 08:36:38 -0400
Message-ID: <20240329123919.3087149-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 28e5126718c7b306b8c29d2ae8f48417e9303aa1 ]

Only convert it to ENOMEM in ttm_bo_validate.

This allows ttm_bo_validate to distinguish between an out of memory
situation and just out of space in a placement domain.

v2: improve commit message
v3: fix kerneldoc typos

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240112125158.2748-3-christian.koenig@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index edf10618fe2b2..f95b0406ca995 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -770,7 +770,7 @@ static int ttm_bo_mem_force_space(struct ttm_buffer_object *bo,
  * This function may sleep while waiting for space to become available.
  * Returns:
  * -EBUSY: No space available (only if no_wait == 1).
- * -ENOMEM: Could not allocate memory for the buffer object, either due to
+ * -ENOSPC: Could not allocate space for the buffer object, either due to
  * fragmentation or concurrent allocators.
  * -ERESTARTSYS: An interruptible sleep was interrupted by a signal.
  */
@@ -830,7 +830,7 @@ int ttm_bo_mem_space(struct ttm_buffer_object *bo,
 			goto error;
 	}
 
-	ret = -ENOMEM;
+	ret = -ENOSPC;
 	if (!type_found) {
 		pr_err(TTM_PFX "No compatible memory type found\n");
 		ret = -EINVAL;
@@ -916,6 +916,9 @@ int ttm_bo_validate(struct ttm_buffer_object *bo,
 		return -EINVAL;
 
 	ret = ttm_bo_move_buffer(bo, placement, ctx);
+	/* For backward compatibility with userspace */
+	if (ret == -ENOSPC)
+		return -ENOMEM;
 	if (ret)
 		return ret;
 
-- 
2.43.0


