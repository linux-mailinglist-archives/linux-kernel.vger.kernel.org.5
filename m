Return-Path: <linux-kernel+bounces-114559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2D889059
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96F22919DC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F78296BB2;
	Sun, 24 Mar 2024 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWeYDqLU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4BB22EAAB;
	Sun, 24 Mar 2024 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322202; cv=none; b=IkA+t5cFimc1H6RcjSllM1B34mI46tsAy8zFRY5eJzCs+zttRkG8ziAFNQz4WnUbTaSHQYuXIzcPC4sKA9+9ctOgZwhtgz92mQ/sZQ8vY3AvAa4sJwpypOniEr5TbIafdc0mIfRitgWB6hJH6G2nRg/q6/k9HhoRTvA7cilCbMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322202; c=relaxed/simple;
	bh=CrBC/CpoMhZxoAj0Biazm+a1TGHdkEOePqPGa6jE8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/gB4Sj0QU2USLGYwWd+WW5ugVX2KGIVAqSacnvK9g3a7vmuKDQ/WGvs69io8vyccTwF36QXwPcneIUChj/nenwgCg3PnV+Hv+vKVpsi0t0ofKUYMcK5MoPz+nSYUupUfc8IYVKcB7z5Q4Jnto3BRWN+dFm/o6snh8KIjXNaLeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWeYDqLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C5BC433C7;
	Sun, 24 Mar 2024 23:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322201;
	bh=CrBC/CpoMhZxoAj0Biazm+a1TGHdkEOePqPGa6jE8wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GWeYDqLUF70N83OSLUHitMlXHhNANXnwj0nVG/sbEfRRxWrlNfRwmiJgDL1S8509D
	 IGoq29CEtVZOJWgNfuFFL40zsppw1I05aIqzlZqbBtsoDEjgkbjVROXw16Xe56rSYo
	 XOhEMl+jFD2FqtDw+bJGsuXyRQJgxSkZqs07XhGqTVcz8SQYzcJyXbKe5Ml1lLAZzO
	 UJZBfRzyzjdgaACxaSjvQiQ7dG4jF7sgY3dk+b1Zd/5cbGLX5Ajdq0CS153k8DDJnO
	 E7ctC1TxaQiOEjOs77veJ4nWY1rtHjm22PBfZDoPDTbR+zcGoZtYbDl1WCRA3ElhjV
	 +gDujhKL1DfAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 281/451] drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
Date: Sun, 24 Mar 2024 19:09:17 -0400
Message-ID: <20240324231207.1351418-282-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 927e5f42e97d0..3e48cbb522a1c 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -813,7 +813,7 @@ int ni_init_microcode(struct radeon_device *rdev)
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


