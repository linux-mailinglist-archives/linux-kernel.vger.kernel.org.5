Return-Path: <linux-kernel+bounces-116181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE14A889A10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F022B1C30965
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766453B7849;
	Mon, 25 Mar 2024 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds4e/Ix4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECC917BB3E;
	Sun, 24 Mar 2024 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323769; cv=none; b=urAnbmAGkmI6Yp/+OmHJJdyF/mNNWxT7dB+IgMuZ+ZKJPP1WQAfuNDoavZLzNRtK62jUyfhyFMR2M9Q8di37vLN2IeX+y+9ft9Kz8C9gmTqZTNLno4KiWTRpoHoNjSD8ENNZxXFtIEUWqVvkRGguiiokXflyOXBxfDin0iVEsNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323769; c=relaxed/simple;
	bh=1oNMrC29GJrki16Dt7/08qwNYkt2iDuH7FPUMAoc8NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwE0JCClOZLUqJUn4g4o1WN3UHmKp9nyHkT3L9jZd4dvc2Z0EigLxCC9IRys7KNgv3G/8wQxMCz8V5G9+24FSqIgNF3OfUm3yh/BtrEvJ80DxdUi6yJJdoFfpNyNWfThdynicLTRgDg7TvaYcslG7Gk/KJaEnrn3iisDBBHnnZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds4e/Ix4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE301C43390;
	Sun, 24 Mar 2024 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323769;
	bh=1oNMrC29GJrki16Dt7/08qwNYkt2iDuH7FPUMAoc8NQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ds4e/Ix4jgLJN6AhCxP6xSnakEGH2YoYJnWq4iDndoUE9YZ2DY/56D8fQPrE0Nu70
	 VCkCVYvPHJzDc1Tfh/TuH/ZULUeYhvzH8x6p1/2EVdbMZbACy+hPGSSk2/R9Hf2do4
	 Bvo09gmW/I/sXMYGDLZ9BVvqlNB6D/xazjI1YTn5Fi4romIdbBtTEWpFaZdmkapZnB
	 30gr2y+pjmXIcrxkBxPibB20UBls5F5LygwCmp2yEIZ3+jaB4DJoR3AXKJ0PSkNoaO
	 J6wpPYnyCcmiFo8Jg15QOcMlZjMbrPjlzHvJnLura7wTQENjGSn0EBUxVWsYg5C9x9
	 fp2YsrODOcuqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 145/238] drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
Date: Sun, 24 Mar 2024 19:38:53 -0400
Message-ID: <20240324234027.1354210-146-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 02feb0801fd30..50c7430f8cd33 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -826,7 +826,7 @@ int ni_init_microcode(struct radeon_device *rdev)
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


