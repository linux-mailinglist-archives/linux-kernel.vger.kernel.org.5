Return-Path: <linux-kernel+bounces-115739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E86B88975D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76481F3843B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE07366AC7;
	Mon, 25 Mar 2024 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nV4uqLYj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2421D15D;
	Sun, 24 Mar 2024 23:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321852; cv=none; b=iLiJ6UkHmQgbwAJXfhuNQ/X5ncC4aXh2rrdt3sa/vtS2iDMiljnrtISmVKlbme2siv2Q+S1aRuJsp0TZXe9qz55nmiGzKtgvw06bgNFUP2NZ+K9mPcG3od3f3d7ak+kGozo95aR3QFf4S5rxusqmHSLqxMsAdOzxrdM3FEPUq6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321852; c=relaxed/simple;
	bh=jtvvDvLTHptqMgKwVWj6/9UOww+mAtVi2jZFHDQ67tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwFnBbFxHwQ6IYmc/az55T391jvQkZLh6uKZvCCm2sVJ1tyjcA6v+SrtccOIkrRSlmpnBMSg+68O2hF+jaxAHXQrBixmIRw3wfkh0JJQE/l0ZyEkV1cHdnNFKeu8/LGQx9+qJKgNfAJcrfdSeehT4X+XrZXCCsH0SbkS6p3jIiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nV4uqLYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC60C433A6;
	Sun, 24 Mar 2024 23:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321851;
	bh=jtvvDvLTHptqMgKwVWj6/9UOww+mAtVi2jZFHDQ67tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nV4uqLYjFyya5VJVmdxqSRAw56RqdF9OHqn8IVnDpezSbYX5q9K/Zmtd/K0hrojOb
	 V/Zlk8EG6hD9y0RzIThXIbnaVo8UkFmIfk1pnsAYAE1qZVDPHLYYHBbgsY16M3CVaC
	 5HRZ5VoB1WMy48h4ZcizIYVANXGouTM0zPHXYqrw2ijSHPhip2OHzwKDZ5u6oQqPan
	 Z73Ir0kPWax5K3Acqb+sGyCoJcOGqAHpbYm7zRvT9Q+V4dz2RsvC+LNTbHaBGl58YX
	 BxSdY9q8z0lgzZ9Bo3qG9zxAYSwJwsfsYZp3DIBjOig3snfVKfb9gZV3myFxv7LQD7
	 +Tnk75TR8QdOw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 580/638] nouveau: reset the bo resource bus info after an eviction
Date: Sun, 24 Mar 2024 19:00:17 -0400
Message-ID: <20240324230116.1348576-581-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit f35c9af45ea7a4b1115b193d84858b14d13517fc ]

Later attempts to refault the bo won't happen and the whole
GPU does to lunch. I think Christian's refactoring of this
code out to the driver broke this not very well tested path.

Fixes: 141b15e59175 ("drm/nouveau: move io_reserve_lru handling into the driver v5")
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Acked-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240311072037.287905-1-airlied@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_bo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_bo.c b/drivers/gpu/drm/nouveau/nouveau_bo.c
index 280d1d9a559ba..254d6c9ef2023 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1255,6 +1255,8 @@ nouveau_ttm_io_mem_reserve(struct ttm_device *bdev, struct ttm_resource *reg)
 			drm_vma_node_unmap(&nvbo->bo.base.vma_node,
 					   bdev->dev_mapping);
 			nouveau_ttm_io_mem_free_locked(drm, nvbo->bo.resource);
+			nvbo->bo.resource->bus.offset = 0;
+			nvbo->bo.resource->bus.addr = NULL;
 			goto retry;
 		}
 
-- 
2.43.0


