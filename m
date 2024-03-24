Return-Path: <linux-kernel+bounces-113379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8DF8883DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290281C234FB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB719FD9E;
	Sun, 24 Mar 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkmJ4MJy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E119FD82;
	Sun, 24 Mar 2024 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320181; cv=none; b=g1PtUiyVVBD4+yZQAhsldRVd18pd8L76+zdiaOR+AG6feQiz49jJyXejDjNNSQ91KOfIq3NSIOanx+FCvMjfYiP4eWOehCttmaJGekcFm0ID5QJH2HC0+Z2bRgYv0s8axXOOApW1dJpN5m69y8RkLR9fKh98IMQdk1JjRCFPwB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320181; c=relaxed/simple;
	bh=QKC9+Re7sEtL0gom4oBbG8bBk7rzUVifjFxB/JrvpDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dW3OTGZS1t2/TdqM1tCKBfshCW1OE6ZWWP7WOAl4bfL6+gEUIVbG5b6g54c4wfpSOc0vC7n5fFGCXdqXoprbpDW4oHpCywEC3XM5Nabfp6mvh8DzhrHJTVKHUTkaiaxBEepAlh87kIkmMH2uY8xTPLBKVlsG5EXGmPvNBuW7Lo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkmJ4MJy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD57C43394;
	Sun, 24 Mar 2024 22:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320180;
	bh=QKC9+Re7sEtL0gom4oBbG8bBk7rzUVifjFxB/JrvpDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkmJ4MJyP3mDQSIY+Ktp2zaLuW3745jJjk9BhTUBH6QE/pewENESQ28OdBvxhDb5W
	 MnDSV3WXdnsD0eYAphGli17lGbjCkBtEelXVIidq/4p5+CB/BlMgdOZmka2wp4bHIJ
	 Z5ohLgG/e74/KmK/iTSdAoRMAYTFEiRSygLlwQVrqp05Z+Mw/WPVKQ9IInb24W4ec3
	 5XKiFD1m/4X+AX5P1ZHOld1hSrMXPV0URnlyZThwYSXQGTJPHqI4+xWAdABm7Fifax
	 dZxp9KfmqjvTeiDLZcz8dbJ28tPR5M2mrW+MsT3sisy1TZoydRfrvaPgKWZt7O/lUn
	 iJmOw2gQw6FZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 488/715] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom_get_src_int()
Date: Sun, 24 Mar 2024 18:31:07 -0400
Message-ID: <20240324223455.1342824-489-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index a33e890c70d90..ac51d19b518ca 100644
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


