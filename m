Return-Path: <linux-kernel+bounces-116339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD177889E5E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8859A292C59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A832B3D82D4;
	Mon, 25 Mar 2024 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oarQq/B0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BE3297D4E;
	Sun, 24 Mar 2024 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324344; cv=none; b=X8F1WYTFOOnoprz4mEbbWcamuK7e4DNEf2OWV+glthgnCOUsQ4DlCz67LUXo5MUriQJyR6XbeipO2enyv49uJD/eKlzpwEI8oayjW++p0bXaJZion6WOBiEa7s9sOzefz5NAJbbHjJAWgE7bmYFwXxvS7y1TblGXXVlZtUikPSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324344; c=relaxed/simple;
	bh=ZAT3ncz812PIt8v3RzdCC/9OCXWgUcc+8Gwq9u9p1Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K26bO6bceTTqK+G+PppssoPQ31KyQ720hpGUDvTnFsAsyRFqicBl4K9g0t9/lxXhrwqtjb4L86H6UxaXkFOT75ZxM7bj67L+lojIGjiA25Rq9HB4BgMecBSx/2+tot64RVjXHgEuYWgf6BSoaec7hwqgQ7EsDRh6YGgvgnmigZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oarQq/B0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4267C433F1;
	Sun, 24 Mar 2024 23:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324344;
	bh=ZAT3ncz812PIt8v3RzdCC/9OCXWgUcc+8Gwq9u9p1Bo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oarQq/B0brE161VG/TPRIiPhXgwb6fPiRzeWbp2c6HLA6D+7Ypa4+7A93wK0rA7OW
	 mKGq48um7U8sILyfDEM6/laqTlbnwF9HTfjHBiDd5JPNaoZjdcWFk58CzoJt+b8fye
	 Ol8+o75tYKrcuBbFKqimiX2Hz41EaJbRxG5m9xrxQvzKU85EJ9J14SxbIw3HG2OR9T
	 1A2/f2CxrmLOr/PyVvYMKYYVNw708Ki4ZDN7KsvgTOv/YK7Z9puLHqNpzC1J7RA+qG
	 Q7EuVTH6f49xn2+T+INgjWVq77ATZxMjItRoqmG6sKYq90I8lieHTQnHyBdd87hbQG
	 z233azaJN1MiA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Jammy Zhou <Jammy.Zhou@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 114/148] drm/amdgpu: Fix missing break in ATOM_ARG_IMM Case of atom_get_src_int()
Date: Sun, 24 Mar 2024 19:49:38 -0400
Message-ID: <20240324235012.1356413-115-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 0222bb7ea49b4..805ac556635d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -306,7 +306,7 @@ static uint32_t atom_get_src_int(atom_exec_context *ctx, uint8_t attr,
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


