Return-Path: <linux-kernel+bounces-154247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91678AD9DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825EC285563
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35915A48E;
	Mon, 22 Apr 2024 23:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNPO8Zx1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CB15A489;
	Mon, 22 Apr 2024 23:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713830107; cv=none; b=Ygnz8fIhFz6vWWnk3dDkZwe8ewP1gEkQtTEC4ercCLdVHmEKhlzcf5T6eGmAAglAo1FfYMIGY+PbVBusXCab5nMXZVPl8sIRzG4SGfOlq+cSYw/iN2Ora0xlIsQJK0tyQNora0i+5VMdvbiLMVWjPth85rmlxoWGcGRm4IEebb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713830107; c=relaxed/simple;
	bh=A9NcAssscdfvlTZZwTtNGIo8MQooUxoGJFtl3frCGLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O8QNY9Phfj0owQRuvGC8BYt8tJRvomjLFuQBh1HZ44gn4DMSnFaz1Q1Ichv1IwCWqKOzQFZ5g/9iPQOTZKPKEcnFwH5jc+xzJ7Ex9MkqhAu0VsZP/598/3Yca+s48CX3ogjnFwmqlZAnjTTwgCvPxggdlGQXLOouzSH9YXylaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNPO8Zx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09B2C113CC;
	Mon, 22 Apr 2024 23:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713830107;
	bh=A9NcAssscdfvlTZZwTtNGIo8MQooUxoGJFtl3frCGLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNPO8Zx1rXqD7AZ8xq7sDLuWy7HukbJqfXe7H48JiXtwzjicB9vuEz15VWjRcZGx0
	 hDU8IUbGboQmD068Gh61DSqsvHRuMel0Vc2ARRQpBG4la1s2PNPWYK1/EQgRESn+4h
	 HGP9MYcnNw37fbI+5D2kdrGP/nQe9xRpMQ4JC9c1zOw4n87izu17gnsnuv81rWHcze
	 Lh5cL8svkyOv4OSRJCovoIcNnM3kPE8o3NP5jWp5rTzTRfw6AcBQ9cJXpz8zLurZAI
	 bYDPjuTLhBQ4KxlGieVdakyrG5/Tf4A1nhRejnlWhZeqfpXQICjUPDrkD3lVNPJbGZ
	 icS+rUPAEL/Tw==
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
Subject: [PATCH AUTOSEL 6.8 29/43] drm/amdgpu: implement IRQ_STATE_ENABLE for SDMA v4.4.2
Date: Mon, 22 Apr 2024 19:14:15 -0400
Message-ID: <20240422231521.1592991-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240422231521.1592991-1-sashal@kernel.org>
References: <20240422231521.1592991-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
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
index 45a67a77455ee..17eb160b7bcea 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1600,19 +1600,9 @@ static int sdma_v4_4_2_set_ecc_irq_state(struct amdgpu_device *adev,
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


