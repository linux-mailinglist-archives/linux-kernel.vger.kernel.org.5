Return-Path: <linux-kernel+bounces-116101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE7E88994A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34E41F31C4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE7181BAC;
	Mon, 25 Mar 2024 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r81inP5M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3420178CE2;
	Sun, 24 Mar 2024 23:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323581; cv=none; b=FaQll4Hl1NxcjUf0ernzXlpvRPpxu95UO2pgrcXO13zZ002Zv1h4CUnttgh6RVOtSJ9F3td+RGUwlYIkFMArGJR4Q6EExVRO1tw53VuAquIcs5rfwhrq72yqx8jQC3RuddXwlVOF8cq77K1UnaVZVq7ofV0BupRSToWolP+gogk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323581; c=relaxed/simple;
	bh=sH0p05ZdpjB4X2ES+nRdMatQOHiBDZFvuGrQy/45kEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMfmhL1QqKVPl3ANKk55++EdFZo9v8v7Cn6qs39R/NF0scMJOPZl28OV/RYCE5ul6LOE4KSoWDK7KrUz2/N0kWZ/Kw8rD7B5yxjub/SEjmNoeCIWC0OmjprKXrzc2sVEOBY9fL/5fGMIIuNSlLx79n39PT4QJP6Go6uLqsq+UkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r81inP5M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA92C43394;
	Sun, 24 Mar 2024 23:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323581;
	bh=sH0p05ZdpjB4X2ES+nRdMatQOHiBDZFvuGrQy/45kEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r81inP5MR1Mo1VWpNX4WfZvIVFQ8A+sHLXyZo5Ol8UZJJY3Icomquq+ZZ2HiqQHtz
	 LmZJU5MtiwC42RJcwhEJJtlaiCSHbYt7p2oYfW/jaXOubT/RIHO+PuSWhTJBx4w3TX
	 JwvYK/DbxME6inBHya+0/vudINA4l8GmskJ0WUejw0QHyQIazmbWccRGyFxqZFky20
	 6cuMWSmAp7SFUoY6tgpdTKv5awIPWG6EWhajcaKLgXQXSGhBtN1d12smjeo3RcPOJw
	 M/NL+qn13Mku15oxczF1rVKXBVAe2SPxhxgkKoCGg3OAKkfrc0SkJ7bCkRJ2rZyiM8
	 0Me9UIwJSsH4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 288/317] nouveau: reset the bo resource bus info after an eviction
Date: Sun, 24 Mar 2024 19:34:28 -0400
Message-ID: <20240324233458.1352854-289-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index da58230bcb1fc..2048eac841ddf 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1186,6 +1186,8 @@ nouveau_ttm_io_mem_reserve(struct ttm_device *bdev, struct ttm_resource *reg)
 			drm_vma_node_unmap(&nvbo->bo.base.vma_node,
 					   bdev->dev_mapping);
 			nouveau_ttm_io_mem_free_locked(drm, nvbo->bo.resource);
+			nvbo->bo.resource->bus.offset = 0;
+			nvbo->bo.resource->bus.addr = NULL;
 			goto retry;
 		}
 
-- 
2.43.0


