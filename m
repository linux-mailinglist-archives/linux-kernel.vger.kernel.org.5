Return-Path: <linux-kernel+bounces-33391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7C6836926
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB7D1C229F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9EB77F04;
	Mon, 22 Jan 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzTojIqV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B277654;
	Mon, 22 Jan 2024 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936108; cv=none; b=oaqzpbk8FPVr8zZD/dq5hWO5jiDNvFu33+uQmGqKn3N7Yj0VH+rNpdNtR3kZE19pRZuoXShOSS3z5hjAlvq4TTg9/R1L5fYWHlzzPT379RO9j4N1zlygMGYW6ODakwJmz18deGfP5tiroNX35OljTUNska8pg4RDyfZutvfULpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936108; c=relaxed/simple;
	bh=g+NLjclfFpmz90ce/DyP/hk3mJkJ7WyLtF/ExALF3/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rBMojbyMHUsYrG32b1tmb45Pt6NjEBFoMSGfxK36GUbFieOKUK9++4aMezSZds/vc+kC0+lSZTbsvFc5yFJ/6tk/TWjvqMC2cpAIOZOwdTuVXrF2rV64GHSCwpFLTM1Q8FOVQevUhTtQLvD2AdL6MFtQvtzbze0dMZvUl6gDEcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzTojIqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81336C433F1;
	Mon, 22 Jan 2024 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936107;
	bh=g+NLjclfFpmz90ce/DyP/hk3mJkJ7WyLtF/ExALF3/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzTojIqV5lxrgADFDLY7oDttT/1mcZfQGSx9knV4YAKHrsaRraxFXdVo8+VZ9F5fr
	 JojMLpjJ5o0XOTLoPPu1dfl4ePk3YaIb/Lk9u0LtzKZI6H6SBRzNU8ImXahlNnrcmY
	 85VmRSde0NttCAoodVu82ggajixTNcvzvCH1zinhXZhMtwISsZpc4wDSHXBYNXPfTX
	 1WCWrZ5bvFlw4okfaRaEGkmjBoFJBnw9lkp9HqkXESWF3ntGHwr93jODi0eKtDlOJN
	 mCBcuex+mKfFrXg6nQkkr21YitQqIyVyZRNa+7/a2JjueVpYH+T41PwT1UX+hpRPqb
	 yEANXlvE944CQ==
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
Subject: [PATCH AUTOSEL 6.6 66/73] drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'
Date: Mon, 22 Jan 2024 10:02:20 -0500
Message-ID: <20240122150432.992458-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index 469785d33791..1ef758ac5076 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
@@ -90,7 +90,7 @@ struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
 		return NULL;
 
 	fence = container_of(f, struct amdgpu_amdkfd_fence, base);
-	if (fence && f->ops == &amdkfd_fence_ops)
+	if (f->ops == &amdkfd_fence_ops)
 		return fence;
 
 	return NULL;
-- 
2.43.0


