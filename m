Return-Path: <linux-kernel+bounces-115966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC03C8894E8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79E1B1F2D27F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B67170A32;
	Mon, 25 Mar 2024 03:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D6SjBdma"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005F22310F6;
	Sun, 24 Mar 2024 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322242; cv=none; b=dmvw/T9yJY+Oq1vylkAAQnzoET6aL6FX3JDPqr57w4YueBMUlE8EM1VVeviKbEI/GGiwBpDrdu/Pg3X8JSmIKgYk3boedvcCl93EPyGW3pwmlSe5TP1ECyYGalGXp8ozBWP/mG5OsWp1nax0US5gQmwSzsVSn4AzlPU7vrKgY5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322242; c=relaxed/simple;
	bh=CtjPN60KHWabBCP40nzTYEuMUXB7PpgyH+0xKuKgn8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhKtAvlofoMWzkdWQUVB++p7pyVLpY87oLqGJRbm3zl2oeKlfnNSkoKTx8nopPMgTHYKVV4smxz00bMNV8kJI5DzV1Dta3vXkIOSiDOEv3BJx8k2qzvfyBLXNLhK5iSOHi0zVCZwcTW67ZwrGmdvDLLhjdqPpp9LY2/qjgiXAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D6SjBdma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7E2C433C7;
	Sun, 24 Mar 2024 23:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322241;
	bh=CtjPN60KHWabBCP40nzTYEuMUXB7PpgyH+0xKuKgn8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D6SjBdmalySKva+SaiZrJXU4KY3SYh9XH9j4cYQtLiWvisD3Izx35dgOO56bpbr6t
	 gBPhnC24cw4olL39QIv9l4AVvRTQiE3yezXIV0C1zj9yVQi+agoxaNbWhlpqOrZuKH
	 CiIwrrHnnwU5CCHGODTbC7GrSz13e9QGlwWZZnve1JjwBNuE7MfOeEGr/wGgfXxabr
	 AAmEs00uC3qazMoJENVeLdJPCnMrXIOUQ1U5L6rUwwWv1+Eg4RClbqf4mykXoICQPu
	 qnfHIBZ55GloSW5Y3JjO2xYzSeuSkzIEZxbECxWGdaQlkYgKjgs8x4MI33azQ2l6wv
	 QjuNSjL9rLYYg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 323/451] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom_get_src_int()
Date: Sun, 24 Mar 2024 19:09:59 -0400
Message-ID: <20240324231207.1351418-324-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 1c5d9388ad0bb..cb6eb47aab65b 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -313,7 +313,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
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


