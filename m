Return-Path: <linux-kernel+bounces-113534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80290888518
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:58:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8FDB21121
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F72E1C0184;
	Sun, 24 Mar 2024 22:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EthbQOwc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F521C016A;
	Sun, 24 Mar 2024 22:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320335; cv=none; b=gob94CjObfm76L23Y4IgC4fzGGqY2S80j4KLSL9iyPPSuQcGymds0X2SFQtKE88texRnlsYB4iJa12lwh9Vk0xjEVc60DZy6WcOPlJnqIDHAWZdksYf/+L8CoEXnnUqpem5I47tqWxm20M0vIwRPk4Cm5EeT7neAUEaBOXQuYeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320335; c=relaxed/simple;
	bh=BzF6GyIih33Dzu6RbIucEWNssIgpAID1Xg1s8IEoK9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Stb1gR1r+jZ9qNACaZUs4WBBBx8tZ7EGIrSjfZ7LzM8DQPwnYDyug00TdpXawTm4iMVJW7cwFtIC3qE/WmNirf5DwDHOBdtKg6jxOtM6pGBNuuyLmzSsqyOuHBBXjxiA4tTSLYUFxkSbrjbisoujRu2yb9uGMXoOpnmLOx5V0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EthbQOwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF2EC43390;
	Sun, 24 Mar 2024 22:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320335;
	bh=BzF6GyIih33Dzu6RbIucEWNssIgpAID1Xg1s8IEoK9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EthbQOwce6Yrd4mQDDKTKkjtztnVi3E5uIjb31uK2LjKMAnFT7NDzcxXr1KwZ/+Sq
	 vqVp1ZTgoR76RSG3lABy3wNfyg61wCujWjG5Ii70zjlKH+/YXlRCl7K70IdXNEZl3x
	 2IN55R5QNoROdvOV5PIGA8M79H+K46EMNALpuXz3euFjAjryI1q5oj/Zc68r0pgPKj
	 XvUpIwlPZtP6iF0A9krjbTiWKYdXzepUXDw7+jd3hkxORq2vDaf3ZHuqRkIQY1C7+9
	 7vkDFM15eYni0+7pr2MgzrctAAflchupxPpa3Ocm2OV25T2qDwyKQ11wtg3XK0F05f
	 RYtjXKQb0sGMg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 643/715] nouveau: reset the bo resource bus info after an eviction
Date: Sun, 24 Mar 2024 18:33:42 -0400
Message-ID: <20240324223455.1342824-644-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 00cc7d1abaa39..5d8ee17295424 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1264,6 +1264,8 @@ nouveau_ttm_io_mem_reserve(struct ttm_device *bdev, struct ttm_resource *reg)
 			drm_vma_node_unmap(&nvbo->bo.base.vma_node,
 					   bdev->dev_mapping);
 			nouveau_ttm_io_mem_free_locked(drm, nvbo->bo.resource);
+			nvbo->bo.resource->bus.offset = 0;
+			nvbo->bo.resource->bus.addr = NULL;
 			goto retry;
 		}
 
-- 
2.43.0


