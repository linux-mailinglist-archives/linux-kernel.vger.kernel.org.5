Return-Path: <linux-kernel+bounces-114850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7530A8891C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCEC291062
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96D27AF54;
	Mon, 25 Mar 2024 00:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBLGgZHC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3AE27BBC7;
	Sun, 24 Mar 2024 23:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323523; cv=none; b=ZOhnbFUwxNdARr6SoQJeBRYcFJeabbzaoLFV/yM/A0e6hBYxX6fH0cE/glGnFx66x0zyEuUOgr91MOVGqUslHUDz6/2bCKeQ/hokFGDJzX0B6btTqOIYpPApsP0mmdVk+kgzt1teUK8qDqtX37E8Wht/TMHckQuqutFVRBHmH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323523; c=relaxed/simple;
	bh=idfjZKhQHj3/3yUOplbiREuNytkT88D2q/TdJlu9oJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W9lqLJT33FO07/XlZvzQYN94Tjb65Jx8psgwShwYwPsCsNH2Q9edn+a+i27CmNsj5/JTXWsB/TVz/GjOewX7tunKu3z9bCqvRUg7D/5F31JWTa7YxK5jIu0BqSNYgfhw85FBM2Sq9IuT/PsU2/M+AXpQEYIpkY3nsBJrLPrDmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBLGgZHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59438C43394;
	Sun, 24 Mar 2024 23:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323522;
	bh=idfjZKhQHj3/3yUOplbiREuNytkT88D2q/TdJlu9oJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PBLGgZHCOcS7hwMFZNxUvxpCIbbu/EMIc99AZqIZXLrQ90yzB8qVp6TB1gOKkk1bD
	 Zv2w2uX4Pz3yrFptjhF20Fkoam/6X2q4AQinjsGPKUTDIXKDzfnIFJlWAlTqMVGfir
	 2lLDmjc8QISm8LpWhDB+FAchJ+lkMLOgDcVlHzQewZHbB99IG8yKn44uNHjgjQ9gjF
	 R7QZ257inkWPYvbbgSuyI4m8dVs3oIrX0u4bmZ4hmh62iw2SiGskT29ox+iQhAbLZ1
	 cqg3oxJINWzianaVs0UF2FDRyN8ENPiq0fLJpCcUJ9iqukCBUucnGXtO3x7DOeiTGy
	 Zpdehfh3O7qcw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 229/317] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom_get_src_int()
Date: Sun, 24 Mar 2024 19:33:29 -0400
Message-ID: <20240324233458.1352854-230-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 7cf1ad2fe10634238b38442a851d89514cb14ea2 ]

Missing break statement in the ATOM_ARG_IMM case of a switch statement,
adds the missing break statement, ensuring that the program's control
flow is as intended.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/atom.c:323 atom_get_src_int() warn: ignoring unreachable code.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: Jammy Zhou <Jammy.Zhou@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/atom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index 6fa2229b72292..c279718d22fba 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -311,7 +311,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
 				DEBUG("IMM 0x%02X\n", val);
 			return val;
 		}
-		return 0;
+		break;
 	case ATOM_ARG_PLL:
 		idx = U8(*ptr);
 		(*ptr)++;
-- 
2.43.0


