Return-Path: <linux-kernel+bounces-114997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F32888C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2DC1F28F41
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8EF2E538B;
	Mon, 25 Mar 2024 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMTVi+/8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB2284559;
	Sun, 24 Mar 2024 23:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323794; cv=none; b=ATQV469mmbaoG+p65/UIAdBo/R01WzQa2DIfGdV1JoBNruGf3VIgnw5lKXKecmn7fx9cSzmfHdKW//7HFGJESWpOwlUCUYV6zvgUObrZHgvSNX/xG3NgWrMJoifF/RzKTtxRM0nSlD59Lf9lVYqcHKKB/OdYn0e5ctxam7/f2L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323794; c=relaxed/simple;
	bh=MN8aMj40GuMp0oDJC2Acpjv/qU1lXE28W5v93tDW/l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=llyMG6Wrzpdq89ggBOb9yqrZdLY4XsIJxOzQyvE5Pe+vTY9QdH1ZffPRiwV6xw1IL/UGLrtfVfCw9dvenko/amdpYWO1Jw148ZfwxMUE+2BmZqDA0yVxlm9jr7B7Ahx/N4hZGdHbkiyNZAxq72nw6XEWp6Eu5UaVBBLqIu8fHoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMTVi+/8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292D4C433C7;
	Sun, 24 Mar 2024 23:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323794;
	bh=MN8aMj40GuMp0oDJC2Acpjv/qU1lXE28W5v93tDW/l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMTVi+/81ONudUIouHbbWjKW1AvjyzQ6ymzdMUjHkpJEGk1u/S9SOzWedWXuXXOA8
	 HWyzuEeoKF5fDeSfeibuq/UADiBULPU+6q7RPOsE9AWzmvslvK/7Vz/RZlB4rx+xiX
	 jsw4x/7T5UHMIY82CX3x4VsLUYwD/kfK0pTAQbzSFiV2wL+pf7caU6ZFBIVV+MOLcF
	 c9IxdMnhlwXPJg0raYeX5E+GiEZMxhQLQ1SbRpoRDe9VIIwI1ySXV3hbHJfwo8wAKx
	 772pmTT2tSQSiBKkPHyHpvJ0ChufipfJU0nMPDSQFzV8rsTEA98JsevIzkOplZXeoW
	 RH/2H9s9mG1Hw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 171/238] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom_get_src_int()
Date: Sun, 24 Mar 2024 19:39:19 -0400
Message-ID: <20240324234027.1354210-172-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 4cfc786699c7f..c1841fa873f56 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -310,7 +310,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
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


