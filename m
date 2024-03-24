Return-Path: <linux-kernel+bounces-115121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA399889318
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A8491F32CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA30A2FD89E;
	Mon, 25 Mar 2024 01:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmTX5IEM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8E181B9E;
	Sun, 24 Mar 2024 23:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324116; cv=none; b=XvcpjBs+HjHtB0Ap9SB7djQp69Xsw3BXaJhut3y38kD+GnHV9hJ1C9vCTU+sImwsa01iCaHgZZfaPN3b0EvwiFK0sF4bDTNSXlNqgi+KNUIPM6z9GLGM9fHdKL8MsGAq3jUXITw1j2NkUKllQ07cK+1zy6PZMYWEQXtXjVff9I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324116; c=relaxed/simple;
	bh=u0e++ePWbuatnqhuMRpq9QLbdz3k9Keaoa75jKdDe04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw6D2hdnuHKrzrTK/mV+/7d52wkB6ZHkJBh9VoVnavXgFqdBL8+hO+pvmKMQEOBThA8gjbUnFpQqwib/2hHfYX9VEjRzRoCksHMV2BikcH+pDpa67VKIobw0TtV8fDAo+TwHqTBvvuMLdS3YmGg3rcFtGL4WR9Q5/oKfNs8oLig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmTX5IEM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130E9C433C7;
	Sun, 24 Mar 2024 23:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324115;
	bh=u0e++ePWbuatnqhuMRpq9QLbdz3k9Keaoa75jKdDe04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmTX5IEMYg2o2ANHBX1Y/V231rfA03/cCOeRZw9wueY/PAUzapINZQt6ggz4P+CXb
	 iyuDPoV9D11vE0xt/POOYiyC7F6oSwbE5thJJLUIDxb1L47no+6XWxsrFWt/HDLusV
	 z1fhhzs2dHs+eqeEX2y+g0JCHAdIxec0ick3Fa+f1UpTVzS4fxxghUa/qxuzVOpNab
	 qMwL2jPF4KVspDUbno5k67g7PyUhAmhMRPWbFTkh5cdqOFo1ywId54u1nmpUhH6aeU
	 2lUje+fXlTPnY88HVWJ0ysUHjcPsNcVWkarfE2464bGuGmeTyg6UBaCA7BlMTUicBb
	 8NdUWIA465yAg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 114/183] drm/radeon/ni: Fix wrong firmware size logging in ni_init_microcode()
Date: Sun, 24 Mar 2024 19:45:27 -0400
Message-ID: <20240324234638.1355609-115-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 410f626a39d43..1fa48853b54e4 100644
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


