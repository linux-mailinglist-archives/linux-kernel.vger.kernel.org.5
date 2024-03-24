Return-Path: <linux-kernel+bounces-113588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFBB888586
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971AB1F23F3E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F261CB68E;
	Sun, 24 Mar 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfJ9uSj3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65861CB672;
	Sun, 24 Mar 2024 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320391; cv=none; b=BcAgevJuCoIn31jvyRQNQMQXzFV3teUMQQxksiNK+0G0XGD6fe2AbCcoqkgGs766M4C0yQ7tzYBgv3PF1JgKHTS4X9ghfWrOLCdES826SlRrpCg92XaCRnkP6/YBcO48K9bQlzqcmLxZ01zwP/+f9qjRozLHZExKM0Vob5Jap2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320391; c=relaxed/simple;
	bh=VbR4fQBjLC7Rzjg/ep21s0JziHQ4SL9IpGKzUXBLVfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/+su2rOOz7Cmqi3X2+qCNajl34naRq4gsjw3ZEMXHvu550IifrIcRVh5PrC2RI+uxrGY/P9/7JiWJ21GuxhkFZRxWPJamSpfEoiYvOCRfg0jiyyOl/k+4UtPcjwa7zVgaafKEM/563I4YNjL9Ccbk30Yt3FC7wULVgIuE+rYnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfJ9uSj3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9283BC433B1;
	Sun, 24 Mar 2024 22:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320391;
	bh=VbR4fQBjLC7Rzjg/ep21s0JziHQ4SL9IpGKzUXBLVfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BfJ9uSj3iKg5qCrrLS/ZpCCfBHIucYe784CABv4KZX/CsWEWSVSz0d4tKyutkcxy/
	 hSzIUkiYxdxYJ7OC1f3tSSaFWrgIVeABlo+ACPyOI87H1dWkpJJUksRdv5J8/70JL7
	 JuMbmlxSkng9wq9waKcfo4CxAfjdkHpAUFQy9Q/njx+XJKRPEgARW0kJdFAuAkZfEn
	 5ihzR1z5ZrpgzlOdBp5cC3sVVVAlzP1BkNCSQ4I+BEGVahlyRy5ceKGTwlY+n5x609
	 FClPCDsgg7/R9HXGO3j0n4/uXOGZ/NKxOEMBOTSFOmR20JsmqaeLD+IWi1jjOFYqfb
	 zqewtez7UIahg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yifan Zhang <yifan1.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 697/715] drm/amdgpu: add MMHUB 3.3.1 support
Date: Sun, 24 Mar 2024 18:34:36 -0400
Message-ID: <20240324223455.1342824-698-sashal@kernel.org>
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

From: Yifan Zhang <yifan1.zhang@amd.com>

[ Upstream commit 31e0a586f3385134bcad00d8194eb0728cb1a17d ]

This patch to add MMHUB 3.3.1 support.

v2: squash in fault info fix (Alex)

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 6540ff6482c1 ("drm/amdgpu: fix mmhub client id out-of-bounds access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 1 +
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index c9c653cfc765b..3f1692194b7ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -570,6 +570,7 @@ static void gmc_v11_0_set_mmhub_funcs(struct amdgpu_device *adev)
 		adev->mmhub.funcs = &mmhub_v3_0_2_funcs;
 		break;
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
 		adev->mmhub.funcs = &mmhub_v3_3_funcs;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index dc4812ecc98d6..b3961968c10c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -98,6 +98,7 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 3, 0):
+	case IP_VERSION(3, 3, 1):
 		mmhub_cid = mmhub_client_ids_v3_3[cid][rw];
 		break;
 	default:
-- 
2.43.0


