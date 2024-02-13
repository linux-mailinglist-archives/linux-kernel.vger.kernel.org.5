Return-Path: <linux-kernel+bounces-62626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3DD8523C7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B62301F221D4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22DAAD55;
	Tue, 13 Feb 2024 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdorAmTm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF6EAD31;
	Tue, 13 Feb 2024 00:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783620; cv=none; b=L1uCDumrQHDaoCQzE96wGhOnXWFtjLurZmifT1qEJhTJBEHenYlClG2gQZdCpAz6t4ZjNT9C3wZE4xnUPPUANfxOtLYQ5iUiYHzy0qDNukW4JI1tfJuVKtb6aVf/m+GemfAp5c203SMBjpZOgwtsfX4od2rLq1GMBlZ4O0DCH/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783620; c=relaxed/simple;
	bh=MhB09uoLchKIFVZv5NlKqSE86si9+K7vvDsEosL4XD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHwaTjnZZUo9V1cdJFzlnPGlVpgLqlfs9ScVv47rzlKz2ZOSJAQG8gxL3F9+Ud9LPWe30MGsT+CV+hkvsBy+GQnXbJYqmmrCTkO4MUFHwmU3VffmGxCWIjVGRQXaxDr2D/8YpeHIt142O8+F9K3Ulp9A5S59GYkDHUn4WacTV3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdorAmTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4FD2C433F1;
	Tue, 13 Feb 2024 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783619;
	bh=MhB09uoLchKIFVZv5NlKqSE86si9+K7vvDsEosL4XD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdorAmTmfyiMFu3ccCHFeQnK6OmucxHVOB3OfSqQivfJ7ZznLdUzRJQ2qQTR0zQUf
	 gTokOIlLBQyk3y0zkrbOppHJWd8rRPu7ETSnpjLgNnSLPNtm2sVuXX6MdrWl4i5+LL
	 PHB3sBUqb8080sWaP7OEyVutOp9pXzzxAq2l48aHOSSEsENgRPGgaj0eEz9cq02t7c
	 kh2EoPcCpHoYpcu5N6U/3dvB3cnQ3Wuhv15zHewXMn6cxgR+Yq4kw8wykXuLf7nr08
	 LcynmIX4OwSFIKlDJeP8MMscFnp7qb0T6ZZjN3/aeE1lobUX4Ani3tNGkxpgNszIUl
	 L1S6/fsGlsMkA==
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
Subject: [PATCH AUTOSEL 6.7 53/58] drm/amdgpu: Fix HDP flush for VFs on nbio v7.9
Date: Mon, 12 Feb 2024 19:17:59 -0500
Message-ID: <20240213001837.668862-53-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 25a3da83e0fb..db013f86147a 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
@@ -431,6 +431,12 @@ static void nbio_v7_9_init_registers(struct amdgpu_device *adev)
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


