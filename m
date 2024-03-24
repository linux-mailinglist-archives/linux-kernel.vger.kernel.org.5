Return-Path: <linux-kernel+bounces-114677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD158890A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68538293F14
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C925B2B45D2;
	Sun, 24 Mar 2024 23:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tj4j3MVV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A47F237B8C;
	Sun, 24 Mar 2024 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322319; cv=none; b=QvbgeJ0XLdyktVOAHt3hLOJo3V/5zDCNqOyYyk7uFC7C+9AFk8swrt6t/uuLdANxzXDUNvZ+zvBoe9hKNh4q5QULS+mkDSuynmJ0LaEjDgtP2j/U+48QmJ2JsZlpGWxCeOx/6ALAMIXK6Zx0hsgpWYuoWnX3lsGHaeBwedRnBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322319; c=relaxed/simple;
	bh=ixyv1ijNHSfkz44I+kjZwy6Pao+nB8OiidY3IGOVlwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAOQORu4qdcXnVGyzDIX+7KX9uNysjgZgdq+7L3EX1IyMKaHyg+8Oc46iwPvELNSm7jycjSFhH3ArzYK9Wl5YjGrXwXIbsYBtgITOYGUL+HsQxRJHKWPIRfh4kKxRtS+HhfBz8u7S+MGEDwsSsa3bje6CM5V7CIn9lCTkdNlYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tj4j3MVV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C6AC433A6;
	Sun, 24 Mar 2024 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322318;
	bh=ixyv1ijNHSfkz44I+kjZwy6Pao+nB8OiidY3IGOVlwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tj4j3MVVJdKT9mYq/u/wNdDZrdP9qMArdJmb7MI29kkxM989D7KyVEpqEtZdeNow2
	 2Hm4cFCTN58efWiDQeIbFWdP2m8IB0iOSyboC4mBuMRPA6LkxlpEYGwyLBojLYZwdf
	 2gm/JMZUXyZYMpS/qQdGfh14AYApGIoBXALZoZTxS9bNVbuDp76p2pmEMed+eMvWqy
	 HkM+bok5XfcSoyTGkLLOsKLo8eDVWxi+DLQgE+Mlrw8HLgP/NxJZ4DokPpq6JdZkd+
	 iJbIvqiX+kM7ugw5dKTIwPhIxcMEkjEoKSxM0NH3UjadNNgrHWCE++Fj+TbL7qusWw
	 ERypTF9WwYCxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 401/451] nouveau: reset the bo resource bus info after an eviction
Date: Sun, 24 Mar 2024 19:11:17 -0400
Message-ID: <20240324231207.1351418-402-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 126b3c6e12f99..f2dca41e46c5f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_bo.c
+++ b/drivers/gpu/drm/nouveau/nouveau_bo.c
@@ -1194,6 +1194,8 @@ nouveau_ttm_io_mem_reserve(struct ttm_device *bdev, struct ttm_resource *reg)
 			drm_vma_node_unmap(&nvbo->bo.base.vma_node,
 					   bdev->dev_mapping);
 			nouveau_ttm_io_mem_free_locked(drm, nvbo->bo.resource);
+			nvbo->bo.resource->bus.offset = 0;
+			nvbo->bo.resource->bus.addr = NULL;
 			goto retry;
 		}
 
-- 
2.43.0


