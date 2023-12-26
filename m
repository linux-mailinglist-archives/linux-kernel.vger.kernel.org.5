Return-Path: <linux-kernel+bounces-11225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA0581E366
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25BEC1C2164C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1838D54FA5;
	Tue, 26 Dec 2023 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SdsWkxdI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BBE54F98;
	Tue, 26 Dec 2023 00:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F9DC433C7;
	Tue, 26 Dec 2023 00:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550101;
	bh=p/BebQ48YEVn+IHs/jwEKLnGLxZZ7Nzj/lUF+KWf0DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SdsWkxdI02HtKGF6JtMWpZZrZUZ+6B6dqwcSAY729uEU71CwLFfTWgdlKYa0pExiD
	 Fp5THzbNF32ljZ5u35s86x2PanZIIbhWD70zOBqylTCY047dBCCX1/D6XZcraNBqNi
	 iML8uzNBSHnVd+HcBb5fPKFf18+eVi/8KBTSkzTmzjMjLHMjTcrIFcAORZdQZI+QQx
	 ZLw8wck3NjxMCF813x6shN5BXo89Ca840awGbwAgtnQNyG1YCvpvaOXhF6vkBP5G1y
	 34Rsc/69VsWWv/6hfRAN1vAMeLg0qNzEQE51/nQHnLiN7bZuaVTNyuX5jd20B0RXom
	 uGE9TELYnANEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philip Yang <Philip.Yang@amd.com>,
	Felix Kuehling <felix.kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 32/39] drm/amdkfd: svm range always mapped flag not working on APU
Date: Mon, 25 Dec 2023 19:19:22 -0500
Message-ID: <20231226002021.4776-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit ebab8c3eb6a6515dc14cd93fc29dd287709da6d3 ]

On gfx943 APU there is no VRAM and page migration, queue CWSR area, svm
range with always mapped flag, is not mapped to GPU correctly. This
works fine if retry fault on CWSR area can be recovered, but could cause
deadlock if there is another retry fault recover waiting for CWSR to
finish.

Fix this by mapping svm range with always mapped flag to GPU with ACCESS
attribute if XNACK ON.

There is side effect, because all GPUs have ACCESS attribute by default
on new svm range with XNACK on, the CWSR area will be mapped to all GPUs
after this change. This side effect will be fixed with Thunk change to
set CWSR svm range with ACCESS_IN_PLACE attribute on the GPU that user
queue is created.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 63ce30ea68915..8e368e4659fd5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1632,18 +1632,24 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			if (test_bit(gpuidx, prange->bitmap_access))
 				bitmap_set(ctx->bitmap, gpuidx, 1);
 		}
+
+		/*
+		 * If prange is already mapped or with always mapped flag,
+		 * update mapping on GPUs with ACCESS attribute
+		 */
+		if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
+			if (prange->mapped_to_gpu ||
+			    prange->flags & KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED)
+				bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
+		}
 	} else {
 		bitmap_or(ctx->bitmap, prange->bitmap_access,
 			  prange->bitmap_aip, MAX_GPU_INSTANCE);
 	}
 
 	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
-		if (!prange->mapped_to_gpu ||
-		    bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
-			r = 0;
-			goto free_ctx;
-		}
+		r = 0;
+		goto free_ctx;
 	}
 
 	if (prange->actual_loc && !prange->ttm_res) {
-- 
2.43.0


