Return-Path: <linux-kernel+bounces-41778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8803A83F79B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2561C2135A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00494CB30;
	Sun, 28 Jan 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjQgxB6O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9CF12837D;
	Sun, 28 Jan 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458505; cv=none; b=RuVG7e4XN0o3mw4JYmOMWgc+Cg+i2IN1feU3Aee73ks5W+aeC+50hdidCb2mteu9SS/dbWAD3csZSlPJxxEifQqOp7BDeTaxkzOxLGT02qzLYgygQoWszEGY02bTylnNp0OTRTkn4+EImHyXAtPhlb3A+XJabWoXgCXku0lriW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458505; c=relaxed/simple;
	bh=//GeY34yk8RDTyVL3z8PggsoJVR+7RJuYVHF4BbXmUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hb7qzhHb1r3VFn+Ywt/D6iTNzc8h0CwB9wsopw36RQ19DGTJYyTEHyP2CZIadphf1diGYlm4xxRB+7HVegtLfv06zulFz6KBVi3L9babMonZJDrOubyo+pmoxtrS00Fy2w+XggHzv1fcZ+yVxbfqQPnDpErrphT4+zyBpa/soTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjQgxB6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79103C433C7;
	Sun, 28 Jan 2024 16:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458504;
	bh=//GeY34yk8RDTyVL3z8PggsoJVR+7RJuYVHF4BbXmUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjQgxB6OX9oy97kOW6rGLiQUxYODndhe0zflqX60mT25YFddoTOk5PJUsdfUvtjPE
	 BSkCX9/ythA8/CzcYPOCPs40v4vCZBNR1INQ2CPPBdhyhCVhNfiC02GrsmmP+vD9Wk
	 tjlcsIBb/oUcYF+XLI4ZxrENMc3oMsCMV4yqa4n6enO/4BMnSf8zs2YAdmZ6t0+zv5
	 GKiPYCJbjXES7s7ez/DSJ0p6+3xHMSp1j2iDY+hvTFNwcUokmBNtD7+xRTQQeZEv/o
	 GqNMzi3lFmTd5gZpQwDs8U1yOkuns4F0WBgnhsl85uuGYGBjZ8gOPcqdRuTNO7E88b
	 TzmnXscr0dt5A==
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
Subject: [PATCH AUTOSEL 6.1 23/27] drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'
Date: Sun, 28 Jan 2024 11:14:08 -0500
Message-ID: <20240128161424.203600-23-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index f2a55c1413f5..17882f8dfdd3 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
@@ -200,7 +200,7 @@ static int get_platform_power_management_table(
 		struct pp_hwmgr *hwmgr,
 		ATOM_Tonga_PPM_Table *atom_ppm_table)
 {
-	struct phm_ppm_table *ptr = kzalloc(sizeof(ATOM_Tonga_PPM_Table), GFP_KERNEL);
+	struct phm_ppm_table *ptr = kzalloc(sizeof(*ptr), GFP_KERNEL);
 	struct phm_ppt_v1_information *pp_table_information =
 		(struct phm_ppt_v1_information *)(hwmgr->pptable);
 
-- 
2.43.0


