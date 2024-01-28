Return-Path: <linux-kernel+bounces-41813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DC083F7FD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABE91F22762
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50525103C;
	Sun, 28 Jan 2024 16:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZwmedAK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C6A141998;
	Sun, 28 Jan 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458588; cv=none; b=MJ7XlwDFr5YSNZB/ve8D704e4EmWeyG1veMP7f7kYu5+blhOey2gr7JyEbgi6W3pSnJPMsVg5u3+8ahWuERbOk7x9NFhoyqZqGzNvIlW2fI+N8hQ5Wx8dlxWHSXMkcswqtd2wqiMfoSf4kudJ7yuIuJ23tFV8+X4gsFodNfjSqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458588; c=relaxed/simple;
	bh=9+l/9PWCv9b1KkwzutuHsikOMVDG14iQ8OfXxZAbxvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SPovgi/Ur/KNQYYTTdDoJ7mpe+YukCoy6oZ5Tkf1u+D2GuwfAfb1kpKCwbYr5u/CNppWk2zb7vT5L7DUv7RHJ6fSmaXNC/ecO+AOuJwEtneUdM9BQWIrbkId6Fw5fv0PGTVJzEIKpV9abn/R6f6CO4433QPd2/ArVt9hR2oTUhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZwmedAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D67C433C7;
	Sun, 28 Jan 2024 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458587;
	bh=9+l/9PWCv9b1KkwzutuHsikOMVDG14iQ8OfXxZAbxvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZwmedAKlh5gyUG1aKYHay/W3BHTBw4LQBHWdH2PKjMTU9ku/aYjGG6hHQao2imrq
	 WVf9XX6ORfwJpUAnRIL7fkHuBGPy8W16Wls4jzmAz7f+lkuV0lVSnPFYSbD5xZAdJO
	 uQ7cobr+KlRiLFpTHwTFkke1MhF/sLBOdDqvDmGaXjS+/fBN+DVRO6U0cVCUHWfGiW
	 SmUtg00TqROCm0q03POoRID6rVFDJabpVIqz0y20BnK5A8VsbjoPR/uYHNhKfKyncl
	 ac5rt3mV140TChaGeSwpAh2nluEu+4TWl3qcJZh9vWakSwUtSqrjfMZv2qdOWyqra/
	 TthkwH88jw4xg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Eric Huang <JinHuiEric.Huang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	evan.quan@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.10 12/13] drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'
Date: Sun, 28 Jan 2024 11:15:58 -0500
Message-ID: <20240128161606.205221-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161606.205221-1-sashal@kernel.org>
References: <20240128161606.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 6616b5e1999146b1304abe78232af810080c67e3 ]

In 'struct phm_ppm_table *ptr' allocation using kzalloc, an incorrect
structure type is passed to sizeof() in kzalloc, larger structure types
were used, thus using correct type 'struct phm_ppm_table' fixes the
below:

drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:203 get_platform_power_management_table() warn: struct type mismatch 'phm_ppm_table vs _ATOM_Tonga_PPM_Table'

Cc: Eric Huang <JinHuiEric.Huang@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
index b760f95e7fa7..5998c78ad536 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -204,7 +204,7 @@ static int get_platform_power_management_table(
 		struct pp_hwmgr *hwmgr,
 		ATOM_Tonga_PPM_Table *atom_ppm_table)
 {
-	struct phm_ppm_table *ptr = kzalloc(sizeof(ATOM_Tonga_PPM_Table), GFP_KERNEL);
+	struct phm_ppm_table *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	struct phm_ppt_v1_information *pp_table_information =
 		(struct phm_ppt_v1_information *)(hwmgr->pptable);
 
-- 
2.43.0


