Return-Path: <linux-kernel+bounces-113950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F25B888EEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11831C2ADFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE4312CDB5;
	Sun, 24 Mar 2024 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cFSoStCX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7412CDB4;
	Sun, 24 Mar 2024 22:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321082; cv=none; b=iPsW6YsAUMHiIhjrofNCP7sEyjej/QSibaLB8ti7bcql3XLSVeAgfeLvg0Hqm4mVruCpwOw9mZg8pLtOpTX17Gh4iMDvy8yLtjGlPCE1L0ovX0gw5SIVFHnMwkwzWoncejfPKMQySBttSVyfr8JIOc6bD2An+9fMoylhv84+/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321082; c=relaxed/simple;
	bh=jtvvDvLTHptqMgKwVWj6/9UOww+mAtVi2jZFHDQ67tk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tLpFWz9K9GpatyebLnSnSimmJ7sOXgjL9C/vukgW9HTk11DbDbNk4G3+deSf2hE0wbWEymrhn+paXMoiDo62jPpboW++eQ9X8Mcet70LgfRZHdn5ufGImdWV2yxt9n8enf/3NlwGyJD5h8bzyi+SbDdokBGQsyYQRoJ3U09T+gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cFSoStCX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A6AC433C7;
	Sun, 24 Mar 2024 22:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321081;
	bh=jtvvDvLTHptqMgKwVWj6/9UOww+mAtVi2jZFHDQ67tk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cFSoStCX1jZbbrhuNJvS7W11FAYB9qkbbbMZt4CEqgB8uCnxa4XB6icyZySAZm1e5
	 OKaK3onLhxrdW8N9f/qNq1nb4jHFjkCqJwBFXlUmRId9iokjyb7Hi4kCKExjDydN59
	 wS30m9TP5PSrm0MktnAjMa9mwWvxjWXs0j4oq5h8GCc262/kU5Djn+iAvFexQ2ZQ1B
	 8O63Qb4GP7o45fLfKwlxtPH5FVu12r7XDfdyO6lf0IDNcs5LWQmD9c+R/y/0RLyAOG
	 3qvArlzOgGVQBuBwF1XNBFJznjuF3UnYNcDXHUfRAWZGDPhL+2gi4QMv/W/hssymea
	 HdqiFSAFcVbtQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 645/713] nouveau: reset the bo resource bus info after an eviction
Date: Sun, 24 Mar 2024 18:46:11 -0400
Message-ID: <20240324224720.1345309-646-sashal@kernel.org>
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


