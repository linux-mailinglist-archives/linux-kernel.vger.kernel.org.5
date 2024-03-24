Return-Path: <linux-kernel+bounces-115139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F49D889321
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2517229B9E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4AD1C6AF5;
	Mon, 25 Mar 2024 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNN8d617"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0B6229C11;
	Sun, 24 Mar 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324136; cv=none; b=Ki244qSZ8kvlLyxYNieuhBD69h9ec5AWJB1lzqpLRVqoIWyK5/O1Ejk/7g2bm8pZUYjZ7HpeN34SXVfzoxqfowK+6Y6Mk/H/RQ8liJsW/QYpHEgVL1WX0SrN1Kim61Azci8ylrztXwznIXPvW39H56eB/FPOj7HvvQRJNxVkGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324136; c=relaxed/simple;
	bh=4z44WqP148c/NqMRodDAXC6Z65nxiKYR7xAvPBfIzd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDEIrYHBPEIrFevPPmjjFIdQGBgHWhiCOYgTDNVvmKcI/icp5lle/AfEqHuTAZxgcKbXPHjWllqyUrGO/KN9rxKDWZUPc0JyJF98XMOqBIbaArFXVzb0/cEeVHQ/qfK7FBqEp4eenaHFY/IbvlwvtgNf+Gz6jobWuYhb7f9HQ+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNN8d617; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418D7C433F1;
	Sun, 24 Mar 2024 23:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324135;
	bh=4z44WqP148c/NqMRodDAXC6Z65nxiKYR7xAvPBfIzd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNN8d617ZhkCTMQ/u7mevgnwyZhywZGJGtKuCGUW2Jo3v3aDOYMwYtcJeAgBBXoWf
	 xlBY/SAF/rCfq3ORN59rB9a0AAWJzDY5mj+yi4G/V6N+W8L1HBS/ciseozUppfeUrm
	 czIg+tukaxph3rk3Bi38J2x6Zui3YXwg5mIYUTx0Hujd/YIP7WLQ7SE93a/5Wav15V
	 zSk+z8EQpIvo8/fKBoT99sGOlbT73ot3FJ2pesIis+9VX4BcDO6K13BAqaRzF8udiZ
	 1vSyKMQuNIwHcAyzvC7ZGHepPBkSKHvLH4O9rCG/ssxQICNxC964fFtdOiquRwRheZ
	 Zw186atTxqTEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 132/183] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom_get_src_int()
Date: Sun, 24 Mar 2024 19:45:45 -0400
Message-ID: <20240324234638.1355609-133-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index cae426c7c0863..e1503b52519a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -308,7 +308,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
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


