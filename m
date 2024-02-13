Return-Path: <linux-kernel+bounces-62678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADE385244C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE656B26B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E21420DF8;
	Tue, 13 Feb 2024 00:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wm4Q5C6v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7FD69977;
	Tue, 13 Feb 2024 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783738; cv=none; b=PvikC5VeM3B2gkCPVIY3xZIkdoJEQE8b9n9VKRyaUBP5Ep8dBKEXe8MVETL5AICQBM87u6RQvTCYSt9vIdJUiB8QFV47JPs7Z7a1a6LgpE5fWsZrjSWljFX55A6dPdk+tGnfsSK7olUyYVxxBnThWDunRhMFdUt67WtGQVeL57s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783738; c=relaxed/simple;
	bh=aMAgC0uSzdSH+LBgNOd4d9/zLeS3JaOvXR7L7AeKLpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ou55nqylE6x9PMTHZQof69Kj3nFX9+F9464nE5rls6XgldTFKfoDZuWTvemX2e8r9pe8rw5A13WqeeoyxHAPorLpByRyYe2u3wHbyOGSDwRLbZFlwBrhYqKIHZK3hrUiJ/ZjfK5Hs2jnmoJUvle1/I0Td4GHk3W06mV+2MO7OOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wm4Q5C6v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FBFC433F1;
	Tue, 13 Feb 2024 00:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783738;
	bh=aMAgC0uSzdSH+LBgNOd4d9/zLeS3JaOvXR7L7AeKLpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wm4Q5C6vYN4lIG3+4aomy5V5thYCbVPdhb0o0XJETHYMTjO3fgMlGw/bTwLpC1Ltu
	 wqB6L4qKQ8f9QHhpUzBDbCRUESi/dE0vSqldNh/7KjcRwW7P+WDRSnJ2KWX0IzdAci
	 aN/KKZk5uTS0bpEhmIJMPBePXvggVjs+9kGdXPG8mvLlt8dBwltf1EHyCz6OihnTdZ
	 UwfBXZ6evUT/jIVGsnrHT10bYR/XFf8n7ro7XbtPW9yYCXw5bXNigC8gOMmGIv/83l
	 oVfoVFxatnaor31m16O0vm15YUecIVJSP2mQW5wgjlpJ2PaJeTwdV9dW/aR2tqy+ol
	 8jePbBqlcn4Gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lijo Lazar <lijo.lazar@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	le.ma@amd.com,
	Felix.Kuehling@amd.com,
	James.Zhu@amd.com,
	tao.zhou1@amd.com,
	asad.kamal@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 46/51] drm/amdgpu: Fix HDP flush for VFs on nbio v7.9
Date: Mon, 12 Feb 2024 19:20:23 -0500
Message-ID: <20240213002052.670571-46-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Lijo Lazar <lijo.lazar@amd.com>

[ Upstream commit 534c8a5b9d5d41d30cdcac93cfa1bca5e17be009 ]

HDP flush remapping is not done for VFs. Keep the original offsets in VF
environment.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
index ae45656eb877..0a601336cf69 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -426,6 +426,12 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
 	u32 inst_mask;
 	int i;
 
+	if (amdgpu_sriov_vf(adev))
+		adev->rmmio_remap.reg_offset =
+			SOC15_REG_OFFSET(
+				NBIO, 0,
+				regBIF_BX_DEV0_EPF0_VF0_HDP_MEM_COHERENCY_FLUSH_CNTL)
+			<< 2;
 	WREG32_SOC15(NBIO, 0, regXCC_DOORBELL_FENCE,
 		0xff & ~(adev->gfx.xcc_mask));
 
-- 
2.43.0


