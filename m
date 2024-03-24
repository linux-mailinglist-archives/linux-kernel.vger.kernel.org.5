Return-Path: <linux-kernel+bounces-113988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F688887C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29A51C26BCF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA6E1F23D8;
	Sun, 24 Mar 2024 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+7gY8xI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A31C14BF96;
	Sun, 24 Mar 2024 22:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321136; cv=none; b=kxOpfloBSZsuHtTSaWGuTEQsFY5ZOF8aCYKECA/9EsngXTe7rfKwVloDT0lCdYVXoEHsix46+Ce2p77gkQw9+sYOQdMFEwc6BUXNJt89toCTeDCjQhfHOADgsOt82+7kXgtqxvYsMS3g6oYEK64hwfj9b3/YOsHv+747icATnwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321136; c=relaxed/simple;
	bh=+gfGD22mjnzhNRULgZth3y7IpdDh67/7ZzicS4dW69c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GzWcl6Pv1o85u7Jv/ExENzhQCs8ADOEFeNKrRms0RrPye714LNzYTb15skXkhCH8YcB2LkK9IvE0CHAUIlEWvWiRmwnHtglOjIIvfHsjp4EKELGJ63HwGMiCfAq2kamF31pfhyrkQEukpi1+NyKEJk/NAMj+yNkqZw4xikDewTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+7gY8xI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21763C433C7;
	Sun, 24 Mar 2024 22:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321134;
	bh=+gfGD22mjnzhNRULgZth3y7IpdDh67/7ZzicS4dW69c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+7gY8xIjopcNEOze+3/knubEcOUIGYjqQirAFOGkxksDsRMjpln8WyKnPs3Exbmz
	 BHdUm09z/CSbSm09DscAzN8GeR8Gv5ViTsCsmRVAbyCh5QPefkCXCCLOd+9BpttAUj
	 uHVJutiAnkjAkEMm3Dcx6uu/t3rrSeq1Uc+E1EZm2ZvLu2twFLLxKL6BHkhsOoTIe0
	 1jbcDRSHiRsKdyOiLDNMfeamaxaQ+3YEOnV8lnn0ogSJFhXVILxwsyR/Rj8aBw5VK+
	 dMA3jEIcaSOsynZCq8EH3cPUyup46QfrlWgOIOc+tU2HZm/jWQOWj3nhkWSKPDNY+D
	 Fd+2Dl19N4J7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lang Yu <Lang.Yu@amd.com>,
	Yifan Zhang <yifan1.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 696/713] drm/amdgpu: fix mmhub client id out-of-bounds access
Date: Sun, 24 Mar 2024 18:47:02 -0400
Message-ID: <20240324224720.1345309-697-sashal@kernel.org>
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

From: Lang Yu <Lang.Yu@amd.com>

[ Upstream commit 6540ff6482c1a5a6890ae44b23d0852ba1986d9e ]

Properly handle cid 0x140.

Fixes: aba2be41470a ("drm/amdgpu: add mmhub 3.3.0 support")
Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
index b3961968c10c4..238ea40c24500 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_3.c
@@ -99,16 +99,15 @@ mmhub_v3_3_print_l2_protection_fault_status(struct amdgpu_device *adev,
 	switch (amdgpu_ip_version(adev, MMHUB_HWIP, 0)) {
 	case IP_VERSION(3, 3, 0):
 	case IP_VERSION(3, 3, 1):
-		mmhub_cid = mmhub_client_ids_v3_3[cid][rw];
+		mmhub_cid = cid < ARRAY_SIZE(mmhub_client_ids_v3_3) ?
+			    mmhub_client_ids_v3_3[cid][rw] :
+			    cid == 0x140 ? "UMSCH" : NULL;
 		break;
 	default:
 		mmhub_cid = NULL;
 		break;
 	}
 
-	if (!mmhub_cid && cid == 0x140)
-		mmhub_cid = "UMSCH";
-
 	dev_err(adev->dev, "\t Faulty UTCL2 client ID: %s (0x%x)\n",
 		mmhub_cid ? mmhub_cid : "unknown", cid);
 	dev_err(adev->dev, "\t MORE_FAULTS: 0x%lx\n",
-- 
2.43.0


