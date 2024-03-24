Return-Path: <linux-kernel+bounces-113309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACED88834C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1EC1C23640
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBEC192715;
	Sun, 24 Mar 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdgNSGa2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC11926F8;
	Sun, 24 Mar 2024 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320110; cv=none; b=RlaxpLEvYU/PSxSyVE64XhSHP2MBi6vHXwMePLEWy9UXq5LaO20D+YvT3JqWifGu1gZpanXqfk7hCRzXYIhYbVOassSUeJNP+twbRrcFfFzTxmuTviuzjYYqhRgI2pmB4kNC075QF6mWzP/U0ciFI+/4fkVjDfRjc37bf4Rx6A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320110; c=relaxed/simple;
	bh=CrBC/CpoMhZxoAj0Biazm+a1TGHdkEOePqPGa6jE8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abSxZCAi+e0hwzfgXAB+6iASr8+pHrcn6veyscUzbj7gjLWmuVBgEwqzCwtGQcTkq5/8rJUzXjj9Toj6LNNYWAID4CLWUE29SrqNezGC/qOTyTl4XcxrhC6gn7pCvuer6AOhrvsRBjT2hiBzJkIo2e7ghGwsVbtyWbUsTfJ8MEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdgNSGa2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A791BC433C7;
	Sun, 24 Mar 2024 22:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320110;
	bh=CrBC/CpoMhZxoAj0Biazm+a1TGHdkEOePqPGa6jE8wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tdgNSGa2oPus+Ni5kgY/ZzUClCw3EsulzoAN+JxHUCy12HLmU8yl5kUlvsvN+wSyt
	 GsR5hZY5AY6x8fyD1y1+EaIQonKvsTTsebTnoFYAc8/QPxvWXitJu/LzbmkVGa77kz
	 4z+/ZATX6cudFDvvaYRuxntuIhBfxDI5LCwK4DjIrFBDIGHx+i/pfx/XuaR64ZFrWp
	 6VEy3oTWJalApqRDxSObAvgGZL4g79dNNjARXERZG64aoM9ahs30LwT3krWVYPv40j
	 Q7QHIU0ivT+BGXDRc7mzKaGUG1TfZxe0vGvXV7osmpgr0UXBxaEDGvLPV7k8ShXdc3
	 BV5tFx92Nm00Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 418/715] drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
Date: Sun, 24 Mar 2024 18:29:57 -0400
Message-ID: <20240324223455.1342824-419-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


