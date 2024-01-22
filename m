Return-Path: <linux-kernel+bounces-33547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1FA836BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157ADB2679D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2351A14DB4D;
	Mon, 22 Jan 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQvi/Rs6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628BF14D45D;
	Mon, 22 Jan 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936683; cv=none; b=Tgubb6BNRKsTFR/CE1QVZSJ1Ivi0XdTGX71z2tULRnjEfiUb1KShHV4QWMkY/bpgJPNME4nKJX6glJROkIIEUsw2qMy9jBOMRmwHR7x5/5h8cpl6/x6GQIv9bCdGNo5fEYdBxlLGueLWaABpd0Cq7x5JitpywkDDgS5+pzDAJK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936683; c=relaxed/simple;
	bh=AQk5hOmfL93JC6vL1eUWDaHwTasBc7zSQVqZE3sW23M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t1tpNSf8kRDk1HM6r3Dww0cWDijRYa1GTVzAT/n7LJCGVaeCqPR8JtHEylX/DmYoTzVis6QAm3AnClaTfGIqDo4t94wlfBeVXJ0uCl69xhR3oyjauUs4tj6cQkbMMLMFs150hUZpQn4zN4a0f96FlazUA3+CZwVU2iZf48RE4DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQvi/Rs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1AEC433B2;
	Mon, 22 Jan 2024 15:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936683;
	bh=AQk5hOmfL93JC6vL1eUWDaHwTasBc7zSQVqZE3sW23M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQvi/Rs6+28sjYUCHLfh4rgT2PU+DEGn26ORjXFOCTWhEb5ahItetjK5eCvyKAI8n
	 Wu0pZDUei5wSluLydrjQKUUJsf2UVGUDorJxwLc77FCpiZLgo36wr8QR25of/tHX+x
	 7rzPY+ZdaHnu7EvCHD8p7lBY1HJpYbJDWqCPeqCJkr1DVaN+FvNIQTNvFK9G5qGZ80
	 rxyie4RusuQu54cE15+Ejs6anvHsu9l++yr31NW5p1GGL9I+ZVtSP0pkUdlSeOxBm/
	 cS7BmCP8ZN6md8pjdygx6Y7tuVPB2TEiITlVVJmi3tShJo2tshENGYGAlRzRTVA8Rr
	 XVnpcxCgx299g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 24/24] drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
Date: Mon, 22 Jan 2024 10:16:38 -0500
Message-ID: <20240122151659.997085-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151659.997085-1-sashal@kernel.org>
References: <20240122151659.997085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit bf2ad4fb8adca89374b54b225d494e0b1956dbea ]

Return value of container_of(...) can't be null, so null check is not
required for 'fence'. Hence drop its NULL check.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:93 to_amdgpu_amdkfd_fence() warn: can 'fence' even be NULL?

Cc: Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
index 3107b9575929..eef7517c9d24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -88,7 +88,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 		return NULL;
 
 	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
-	if (fence && f->ops == &amdkfd_fence_ops)
+	if (f->ops == &amdkfd_fence_ops)
 		return fence;
 
 	return NULL;
-- 
2.43.0


