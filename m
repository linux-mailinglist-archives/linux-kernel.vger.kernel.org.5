Return-Path: <linux-kernel+bounces-115471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183608893FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E871C2EC3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F0221921;
	Mon, 25 Mar 2024 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVW6IX1q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF231E8E2B;
	Sun, 24 Mar 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320887; cv=none; b=PWK0Nw+9mQLyGOX+WIT2CfPM4Ks9HdwrMBvl98d1q0x1FNvy50SWm5oKpOT1I1FjZRzAj0ylGeXoSIUTOe5baHgZL8S+teuZmC8TOwCYO+36VKyfdEVynhte8zVB/LgB26Xqufzs8wFbEt2Zy065LPbNmdiHRIgNyma+fr8Y7iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320887; c=relaxed/simple;
	bh=KjTWMrY3+yGfYp9jn+KYpHGG16il/MOGYQ7VOTN0fXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0DKuFSb29U956VDBFdzc79uS4CBdseltSxUVlMBeoQcWAAU2hWrbskoGyVXzMgQHNUjDalH2ofr9jbAvz1j8aKMafqjjxaRXfpNaGUH/RLfugUENEnQH9VXNlZx/i6T2obpFrrfXQP7vf+HeC/TnTtOG/7k82gGKTNjVUNlpzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVW6IX1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E5DC43141;
	Sun, 24 Mar 2024 22:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320887;
	bh=KjTWMrY3+yGfYp9jn+KYpHGG16il/MOGYQ7VOTN0fXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVW6IX1qIAfsldBQjyD3nMoPKB+3R8Cr2rsmtmJSdEOfDtvH9CGIXxwneAfEMUKaC
	 hoR0s2rHH8Y9k5LLEQ94j7M2pDZJv1UMu0P5sOJwJpw+tC8WUPQGf08Aj6uAzpfPQO
	 INUw+ufOIUH4FCRBn67IyqRCRZ5aaLBKVMn2IOVr7T0+gV2FLtO2f9tYXWBW1EzCaT
	 zuWpiN5XH89U+F0wApSZBYPefwhRnok88vCSMBSgebRETyAP1kBUl3Kaj0gXav7k/Z
	 38fyz6H7XXud1uZeEOKccpZ0BYLE0tw3TNDhxeoZ6Z0jHMWQiPxuLsile/VDVj0Yw6
	 1OatJR57X0OXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 451/713] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Sun, 24 Mar 2024 18:42:57 -0400
Message-ID: <20240324224720.1345309-452-sashal@kernel.org>
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
index 272c27495ede6..49f0c9454a6e6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1896,17 +1896,15 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
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


