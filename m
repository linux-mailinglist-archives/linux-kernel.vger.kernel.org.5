Return-Path: <linux-kernel+bounces-115230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB36889363
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2E191F30E86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF671CCE22;
	Mon, 25 Mar 2024 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqSc7+mr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B69184EEC;
	Sun, 24 Mar 2024 23:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324329; cv=none; b=j/lIELcI9K4VUD2FZSD6ABUM2BfKwYRuHGmCuVv+ZwMyWWMTwTphrhrSqpIN+VZJRJ2U9Ixf/cjKDRGptSEySoR2uoo+lZez0BgXn4O0kR2I1P9ymTBzzp/PfXM0Spax+eyTky6Hljqg01kqgFd6fzKo1gvbUsk3eJ6Aj4CQGEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324329; c=relaxed/simple;
	bh=sDG4rOwpzFaELZWsI+4BlWSlAny5s8pTTOdaMh72O5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEhj/C8dU4PsaZhdHWnF2ypDurjM7+V1ieR0gr2yYcwvQOvmybS7Si7wPvJMqh93mTFHWTLQPyqYNH3vNT60TWlObUVFCsUPs6RB+YoYbG5JG381IaYuuxj8CyO2ato+ddaAOzjXzTA1zymvRMT2M/75NQawsTdJftgSAIYcdsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqSc7+mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76E2C43399;
	Sun, 24 Mar 2024 23:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324328;
	bh=sDG4rOwpzFaELZWsI+4BlWSlAny5s8pTTOdaMh72O5w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PqSc7+mro36y0StvWewDCExNMu2Sbvk5kuakSxm5IGte38EykFfuPWsPJ2adKkP8f
	 mP3cpfPm3MJoyczPIM06EXV3BLt1gOR8k2k6LG/cgjdnJsG+L5iskn/2dsSOfWuUU/
	 AtxXCO6HaNNfzY/MXceGG/+QXkvc2yOlzbw6AXWYwiErHFf+h5J2BZwYCOHQmzCcCM
	 0WI6uIA5sFkZ0Oj8kH0N93+70sQE3hRpZuoQxP/XTi2wczLbd4o4AavvjuwuUezsYS
	 nXCEAwVoJ34MpWVa9MjVXsy6gj5zeT2BF5jINrsviwxaAF2FW7F3JhDUUuMpfa+6ue
	 oxemAhGLxbLZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 099/148] drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
Date: Sun, 24 Mar 2024 19:49:23 -0400
Message-ID: <20240324235012.1356413-100-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>

[ Upstream commit c4891d979c7668b195a0a75787967ec95a24ecef ]

Clean up a typo in pr_err() erroneously printing NI MC 'rdev->mc_fw->size'
during SMC firmware load. Log 'rdev->smc_fw->size' instead.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 6596afd48af4 ("drm/radeon/kms: add dpm support for btc (v3)")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/radeon/ni.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 381b0255ff027..e2f8b68a999af 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -823,7 +823,7 @@ int ni_init_microcode(struct radeon_device *rdev)
 			err = 0;
 		} else if (rdev->smc_fw->size != smc_req_size) {
 			pr_err("ni_mc: Bogus length %zu in firmware \"%s\"\n",
-			       rdev->mc_fw->size, fw_name);
+			       rdev->smc_fw->size, fw_name);
 			err = -EINVAL;
 		}
 	}
-- 
2.43.0


