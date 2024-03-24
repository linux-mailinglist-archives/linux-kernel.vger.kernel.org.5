Return-Path: <linux-kernel+bounces-114293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C2C88899E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12141C28284
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860511649CC;
	Sun, 24 Mar 2024 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHv+svm2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D220F246;
	Sun, 24 Mar 2024 23:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321675; cv=none; b=hPJ7x6zG6Suf2QcFiYtIOTajBsgkRxP7xlVtLq5j9vuEFWEJBGYq4E/OwmeUK9mniGJAEzD4yqaND8HAmWuKDY4roeadRF38vLnet2Ni/RAIse7DwYtCspEOUjkKD4kWt1wctdPr7dXDoDLSTYfxBle/k5/mXU0NE6KzpVw9BqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321675; c=relaxed/simple;
	bh=CrBC/CpoMhZxoAj0Biazm+a1TGHdkEOePqPGa6jE8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2oxKvpjnP5xr3Pwew5uVpyc6hPzIrGqf4dzIQKcTfpUezGVDG/ZKhYWlbEdDTQ11Ilv65FOFQjGvm6sfmqzrMDDjIdbtiBYNwIOu5g7Jspg8cTorEcMjZEI0cv3ghnhmwpyR7v6lun8l+qjGn+QRwmhsXrKCof9TtU1EHJJJko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHv+svm2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7A8C433F1;
	Sun, 24 Mar 2024 23:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321674;
	bh=CrBC/CpoMhZxoAj0Biazm+a1TGHdkEOePqPGa6jE8wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SHv+svm2qu6gdr5uzLH6aMapIDWVtIaaFmnNyZHjmSgnddvQOAck5OnJiqLyWKFHe
	 SLnX9yz9FcF5ZfPU7Ukg1FDOq7Q+plPEMv8OvZHOnH938ub/8/ZYHfoJJga/WT2UrF
	 /rkz1WdP63e2WbHh0WyvEUG6ghVRq5xePiMpPvKOIDjRmLBDdwXWJPPrkugOB89BBr
	 ZXt2snaxc/M8Ny2fZxkFP5zTqUH097F8ZiYK17JQV91nvO8qGZpQ4/kaAwLeZxCajW
	 tlwkbZZyrKmGDKFUXVAlXVSzzy6/SMKm+0U2NYWp/63zxj0yq6kOrbFIzVfMZGzTVo
	 ZwM+CvNYsjkEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 403/638] drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
Date: Sun, 24 Mar 2024 18:57:20 -0400
Message-ID: <20240324230116.1348576-404-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


