Return-Path: <linux-kernel+bounces-115470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6AD889F17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31465B45827
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2547A221924;
	Mon, 25 Mar 2024 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5P5EW+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8061C129A9C;
	Sun, 24 Mar 2024 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320886; cv=none; b=Ja3gDatJv2I4TY/1KdaNQk1dv4VOfa8RUkkGIum02nRNNy1kLnx0jPN+4OlEqxpE7cyEKHYyMoF+/KsWcfyv7J3Q5RPox0t+NEPIwytwdCTJDi7PrzqPLD4KTqVMR8BxrReVrCacUiKx7MfR9cbDdeSg21bYOVnaXr7/IddA19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320886; c=relaxed/simple;
	bh=CrBC/CpoMhZxoAj0Biazm+a1TGHdkEOePqPGa6jE8wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BS8p2GsWRZN1u+4zifTJD997z7dINOd0K4mw/JpIRCh89fZj+WF+24VmQhuuRM1UEjAPmuFdoiH3kAmfLbHlFBHz/6dUjwH1cIRD62GXI/jVjg1Q3xRi7alSaEAumz6juNW7rs4dSdh60BHMC06evJ3k48iV52LdeNS7t5Prwlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5P5EW+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE14C43399;
	Sun, 24 Mar 2024 22:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320886;
	bh=CrBC/CpoMhZxoAj0Biazm+a1TGHdkEOePqPGa6jE8wc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p5P5EW+YdIIjN4EntZ8xA0+XFePa0tNsGdAMI9NFH8hYMRKO7fryXA5z7UMISbpIz
	 5Wsnzs6dzNE07ndQt/LSFLDefG2BPQtdWfyvdLwkZSXswVPolR+cU+TpWswSMjOq/m
	 Vd8mv+F2u8By+G6qxQXqvoeRK1cG4bu/71TU/eAEaYYWxawUEEqYxxnJ9a375wNV2Q
	 i7mNfq0r1jECR67cF0o/xh1wrHwYU3DquK+nOYxVYbz+24aUKnkhTEL1Tb73pr5UBk
	 lMOskWI2NhqFoj4QBg7LenfzEJCiSELTIqBxTJtd3wqmYsffXzwUgVrZtyVyEAD+Sa
	 +u3sYFoyEE6/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 450/713] drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
Date: Sun, 24 Mar 2024 18:42:56 -0400
Message-ID: <20240324224720.1345309-451-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


