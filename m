Return-Path: <linux-kernel+bounces-115699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F1F889721
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3F61F347AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8641135CC8F;
	Mon, 25 Mar 2024 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrWG97GW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7625920F24E;
	Sun, 24 Mar 2024 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321676; cv=none; b=ZxnsyqUfKr7YnWcpn9C6mAxT1FgNrMM9eFBqMU0UHzdv0EjZnrLSgPnZUiEpZ9rrrlgC82N7c6P9rXbEGoWdbsKPY7fv8CMci0w3zYHUa880BND3nKky5wrJyK5vHYlB2yz5Th9tllA/mz74DfS2vHzFXPFDLdqJ29pYCNdzcis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321676; c=relaxed/simple;
	bh=TOxIMIuCzooaGdneAUyjRJFFthztaLwmDcZWR3CwoCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyPrEtMdUogg9uw+SpYLjWiqgBEPBH3HnAjsAksYmuCxaDviFuSPocFRnz+HqOdBtWwgLGn6qD6ZlohRgsUFFS70TAPdQ8a3RgJknJzOG8du1wBmddUDjEsbAKP6upp0B2dGjTxQpKenDk94dCLkptxqLW5QLEmRdlQGpw7gWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrWG97GW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54A9C43394;
	Sun, 24 Mar 2024 23:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321675;
	bh=TOxIMIuCzooaGdneAUyjRJFFthztaLwmDcZWR3CwoCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrWG97GWmAdJdf6bo57jiw3wEVydes/lG9biTu0kI8N49TrFnezOhnxKYbinqOaZX
	 M2tlMEWfAd/HBJ+DLoVVU/zTxE6801BMy1SekRAQd0dAPHJ3ukPaIscijWMPoJc38j
	 EYA+EhIFiaGAqI0/zXsN/Tj3FVPA+GGjQF0kI6TZeyjAh1xwxvm19F7TvvvcA3YpdE
	 IZCPRX9xOO80O/FmGAbEO452+lbBAs5cpeiExIi7Cjvz+da+qo7pH4UwPzGZAQW8DW
	 DM4EkNNQU9sOFT3NXTHM6z+vnNpwfBjUpxodu0HtECBDtjEmq8gzhGWq7VuKIiiips
	 YnyiHoSDayLZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 404/638] drm/amd/display: fix NULL checks for adev->dm.dc in amdgpu_dm_fini()
Date: Sun, 24 Mar 2024 18:57:21 -0400
Message-ID: <20240324230116.1348576-405-sashal@kernel.org>
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
index 50444ab7b3cc0..53c05c41341fe 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1902,17 +1902,15 @@ static void amdgpu_dm_fini(struct amdgpu_device *adev)
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


