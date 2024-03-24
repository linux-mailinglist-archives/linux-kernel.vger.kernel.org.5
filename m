Return-Path: <linux-kernel+bounces-113310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B6988834E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E81A1F2279B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD9013CDEE;
	Sun, 24 Mar 2024 22:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aw7By5aA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5A192716;
	Sun, 24 Mar 2024 22:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320111; cv=none; b=EVLPJmJUN4s1NIj8qlpfGPj6/3XsQT6eXUYO0zK6Wfs832tmZ0hCTpvvIHPYc3rPUq9JRrlP9jxzM3KInqgfVHtJhOYF+Mk/B1+shB1fgt5HC/hjTloOuebd66djCA1OUUau556GdGQ3QXxFSY9Sv6wcM0ZRqNulYp0kQQqAfZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320111; c=relaxed/simple;
	bh=RwvNd7l2AEUCXjEWxoRmWTdoNHcz76iSxEq2t5vJVXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R9cmiIW/95oMwnIdj/eyIwQn4OgGaWGqGiF9IjaEwGxo9cc/ucvLEATAWzcLO2bQw77kDRXFdtclNkQqwQhqMb3bGqT1o/zHjpu7wpQHLOs6aZ//ZwOr7RpsFlPWSKsF+pUfR5tyXp8hLvswVDlKFbuKVx+556Axkv3YoIszAy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aw7By5aA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91539C433F1;
	Sun, 24 Mar 2024 22:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320111;
	bh=RwvNd7l2AEUCXjEWxoRmWTdoNHcz76iSxEq2t5vJVXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aw7By5aAKGU/JBpFdKP2AzfGXN/RTZDzHp9+WNRSdqQew1fNIvD51gH32x+43QQcp
	 8DYBZKyFSJTEuxTFSX7VRu6crW53VOrtMmXOH09uXIHvIvT0ouDkLtx+ikRHnxXZ0r
	 MMi5bz9TVu1xI8ozNHzg8U40w8L9PcWV6jyEB+hu/hxvEd/1b0fqtODZxReAOxiyQ7
	 RomgiLkNx80LcJ62/MzZhv6FpgiLZl2Loy9jo5UWWhIbp+mhBoY2RY//NNzfDxQFRf
	 os401OlSp1LQfqNrGWTB0gGtFhlELRc2axzvNf8KA4YXpLipnAdvGyRfPHuo0lOb99
	 /jqUWkHTynyPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 419/715] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Sun, 24 Mar 2024 18:29:58 -0400
Message-ID: <20240324223455.1342824-420-sashal@kernel.org>
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

[ Upstream commit 2a3cfb9a24a28da9cc13d2c525a76548865e182c ]

Since 'adev->dm.dc' in amdgpu_dm_fini() might turn out to be NULL
before the call to dc_enable_dmub_notifications(), check
beforehand to ensure there will not be a possible NULL-ptr-deref
there.

Also, since commit 1e88eb1b2c25 ("drm/amd/display: Drop
CONFIG_DRM_AMD_DC_HDCP") there are two separate checks for NULL in
'adev->dm.dc' before dc_deinit_callbacks() and dc_dmub_srv_destroy().
Clean up by combining them all under one 'if'.

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 81927e2808be ("drm/amd/display: Support for DMUB AUX")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1a9bbb04bd5e2..8083e7156afcf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1929,17 +1929,15 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
 		adev->dm.hdcp_workqueue = NULL;
 	}
 
-	if (adev->dm.dc)
+	if (adev->dm.dc) {
 		dc_deinit_callbacks(adev->dm.dc);
-
-	if (adev->dm.dc)
 		dc_dmub_srv_destroy(&adev->dm.dc->ctx->dmub_srv);
-
-	if (dc_enable_dmub_notifications(adev->dm.dc)) {
-		kfree(adev->dm.dmub_notify);
-		adev->dm.dmub_notify = NULL;
-		destroy_workqueue(adev->dm.delayed_hpd_wq);
-		adev->dm.delayed_hpd_wq = NULL;
+		if (dc_enable_dmub_notifications(adev->dm.dc)) {
+			kfree(adev->dm.dmub_notify);
+			adev->dm.dmub_notify = NULL;
+			destroy_workqueue(adev->dm.delayed_hpd_wq);
+			adev->dm.delayed_hpd_wq = NULL;
+		}
 	}
 
 	if (adev->dm.dmub_bo)
-- 
2.43.0


