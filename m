Return-Path: <linux-kernel+bounces-33523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C58836AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFDE282589
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AECD145B13;
	Mon, 22 Jan 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0EXtacg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F9C145B01;
	Mon, 22 Jan 2024 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936597; cv=none; b=EELH18H3wHPJuDqCeGyWMCsCYK7eKQilbgetgNeKRxnRUDlIKJKD3m6kvHnhOQ9Db7Q3Eg8E/78khC/5SGG19l+b8NtFNQsE+yOSb2BDTLzeauYeORubDw5gvJSIyKgpTfhNxgzlkI4Tn8wt7L60QSy02NxEhSkgRvEhkVyu6dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936597; c=relaxed/simple;
	bh=AQk5hOmfL93JC6vL1eUWDaHwTasBc7zSQVqZE3sW23M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5VGj6hSKCv88LbZ59vsCba2efRr1m7fnA3ZfLNITSOf69pPYkC9qHdvIUed5ceb2GL7aczSOb064cpqusT7G4+rx7DY1MPdlk1lnsVASm95k3UlfnXq9N+4WgCfCJ+vcIwuQo/FexoHxbR9hD/4v05kyBLu5ISZGR5rJicdZU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0EXtacg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1D7C43390;
	Mon, 22 Jan 2024 15:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936597;
	bh=AQk5hOmfL93JC6vL1eUWDaHwTasBc7zSQVqZE3sW23M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A0EXtacgQnrEQnhe0oabijJF/BGFvg3oLujGvE4Ag2yjxSrpZ6889vPhk+sHJqUCY
	 1SoNoMD840Ns0Bi3bocZ1YCgJNfSbchseGQnCX4VoBmTRlHpqrY0fSFyAQfTuy8L9L
	 +qQlcNRJei65XZJo4yJ9F4LHX7R1+U2C0oJ5FDn0n3VUqvFa5h/zCLksbi0SvCdEFv
	 ChLXRsz8fBXlpvtcUEw9Lp7RPHIOLId64EpvHZRgCpc9+nPYidlbNwSfNh7b3s0I5L
	 hfr0/gYg7xKxdlodPZd89+Y6tyENEryy7DblRRTkIiO9op6Ijw+tvhoGE9Z5eI4jer
	 GeNHwgcIoRggA==
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
Subject: [PATCH AUTOSEL 5.10 28/28] drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
Date: Mon, 22 Jan 2024 10:14:54 -0500
Message-ID: <20240122151521.996443-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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


