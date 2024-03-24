Return-Path: <linux-kernel+bounces-114347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D4C8889DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A69601C28621
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A626AD89;
	Sun, 24 Mar 2024 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzH1kBUM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDE214109;
	Sun, 24 Mar 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321733; cv=none; b=mugXjbfiqEmCzEoWat4TVnK3Zc9MIPnO8UCU0hk4uqkvrZs2moiEfORdYSe6HaKM3jhquFEvkENdYPE2IYXPzYPXgMSrZaGGyLsKqBiJty5H/tAMG6rAaZNVFFV25LKrpA+NnnnI6tYkSfjow46nDfHAoLl8+r478e98tcClcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321733; c=relaxed/simple;
	bh=biddEyrHFDC1dMnWz8oTys6Z2TXT95L2Ux1W8OWj+1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roSz3H13atxoY6k01qxZlzOUamG7AbWZj1uMC7GbOp35WXcrpLyAp/p2Hl+KKPSb24LakP9yUZWZJgxr7UIX1Kgs1+xZzhot8OZEi+yXKsg71nZMrRr8eZxmOwR/qmemWQ00gZYaqDXpTJ46TQ43FjjSvH+1HFjcvXgtKFf7X64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzH1kBUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 818BDC433C7;
	Sun, 24 Mar 2024 23:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321733;
	bh=biddEyrHFDC1dMnWz8oTys6Z2TXT95L2Ux1W8OWj+1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzH1kBUMUCD1rm4bfcoWNxdPdNyxaXevkbSRrk4BYUKlPj3oFmfaKkjWupyWhmX8U
	 XHO400nv/6hF/EBZpRB0DmyIrY9TwrWdL2Uuy0i0h84NJzMnGRN89lehYEJGropZKx
	 /Pmwi53UFSveFQpMbAj5CNf76aLs0/cxIGrHUocS23sMrQ5UQGe8ViPzTu7NaktM+i
	 w/pynPus68H5aSpGY8sUn5zTa35LYCMt70voSpIBx/5TKJuSo90scyJtWHvAQ78myI
	 umYzb5I6eIJRD763Uv5ibLApOoKt0dvaZsQ23N8HBBzasPBUM276xJ9Icbxcj26e3W
	 HlXc8PciYuvKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 461/638] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom_get_src_int()
Date: Sun, 24 Mar 2024 18:58:18 -0400
Message-ID: <20240324230116.1348576-462-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 9f63ddb89b75c..1195d37f19fc5 100644
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


