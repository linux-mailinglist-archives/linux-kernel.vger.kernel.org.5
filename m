Return-Path: <linux-kernel+bounces-154279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8148ADA38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA8BC1C21658
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1CA16DEA2;
	Mon, 22 Apr 2024 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3TKDLqD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5A916D9CF;
	Mon, 22 Apr 2024 23:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830207; cv=none; b=Xzf/FuKiNo7EpmxqPXjTHPsL8i5jWwPYhzwpk904jVK8eik6qig8+5wL7Q4aLWiftT8r0K7uhN/2PEBR2djTXhHTGbU6ZIs4Yfqg9S8Tr1TwmbZLZ4lAJBV2oykmYufw0C0/j7nRCdIX+4aVNx/INoafjg6IKz3pwMdiamXyHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830207; c=relaxed/simple;
	bh=7CwhetpXAtpSEN/yT616JyLPfDCP7DfK169cXlQsEJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkSwGxmU4HX+ggriYxda4TFHqfjm6kYfp5Tp6qFDHPimFYxXL5dkfknUEpad3oh/jhcZmxzzKzD98ITknAMPbcCcrS+58ilaeB7KFRL/tiB/fLPYk8F3gzHRM2H69bfr14V1MBS/X9qaDXj4RRiLLDXOs5/zEu+QLTEP2q+zpeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3TKDLqD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C9BC2BD11;
	Mon, 22 Apr 2024 23:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830207;
	bh=7CwhetpXAtpSEN/yT616JyLPfDCP7DfK169cXlQsEJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N3TKDLqDLYhPn4UlBwZo6S0DmxP6fOXiIN2faPRzqcKyAzvSbFbpNoha0wcKS/oMu
	 JrXJspKo8iE5lVKKUMmPzpyEbnrxy3Phe6r9HaTWKlwA+m+v7hGR3/TmJtmvGitutb
	 wp/FbAEsUiUfF4JoXworykzO6BXPzTiltMDHrbYi+fQzyPyU1pQaZuHW1DPPpzjdt8
	 VPm9hqGi6ZAoQ40a3BeEAR5X/AIeyE6Df2r0lFtZ76nSLuT6cDvX+BwWxUdHSwM4aB
	 y5wd8n8UGd5Lw3WhGLlro57Z6xXagkwsM9SGEIyJel/SJ1mxOC2eNAlPUSHdUIFqI2
	 bS3/U5rtA9qJw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tao Zhou <tao.zhou1@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	lijo.lazar@amd.com,
	le.ma@amd.com,
	srinivasan.shanmugam@amd.com,
	kevinyang.wang@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 18/29] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2
Date: Mon, 22 Apr 2024 19:16:59 -0400
Message-ID: <20240422231730.1601976-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231730.1601976-1-sashal@kernel.org>
References: <20240422231730.1601976-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Tao Zhou <tao.zhou1@amd.com>

[ Upstream commit f886b49feaae30acd599e37d4284836024b0f3ed ]

SDMA_CNTL is not set in some cases, driver configures it by itself.

v2: simplify code

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index f413898dda37d..7288bbdd1c264 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1612,19 +1612,9 @@ static int sdma_v4_4_2_set_ecc_irq_state(struct amdgpu_device *adev,
 	u32 sdma_cntl;
 
 	sdma_cntl = RREG32_SDMA(type, regSDMA_CNTL);
-	switch (state) {
-	case AMDGPU_IRQ_STATE_DISABLE:
-		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL,
-					  DRAM_ECC_INT_ENABLE, 0);
-		WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
-		break;
-	/* sdma ecc interrupt is enabled by default
-	 * driver doesn't need to do anything to
-	 * enable the interrupt */
-	case AMDGPU_IRQ_STATE_ENABLE:
-	default:
-		break;
-	}
+	sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, DRAM_ECC_INT_ENABLE,
+					state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
+	WREG32_SDMA(type, regSDMA_CNTL, sdma_cntl);
 
 	return 0;
 }
-- 
2.43.0


