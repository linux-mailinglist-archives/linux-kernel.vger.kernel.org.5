Return-Path: <linux-kernel+bounces-113589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E522E888588
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DD91C24E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DCE1CBDE7;
	Sun, 24 Mar 2024 22:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV7VEQ4f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C71CB68D;
	Sun, 24 Mar 2024 22:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320392; cv=none; b=HPzbafQgaGzAIdyQU3mx1rJDTC3zeqh+aSkXkywPOG6wffA+wNS6DHQeu5d2RKiOJYYJq7/sr5y4zSn0z9JcgFGuO/cv7rY2zcwczyHmB/ztc+JIu6UQzDrQ3zSv+4P0a47xiCcyoeTf+YS/2omcac96CqhAdmoRh4AWkN1jXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320392; c=relaxed/simple;
	bh=+gfGD22mjnzhNRULgZth3y7IpdDh67/7ZzicS4dW69c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHGGAXiHEBXo6VYyZrX8yEtP4Ay3yfWMXkijOrYoul5XdAEokJcvSFoOzx41CZgssDcmEF6C+WE45/zbU2ioQhKzadJTwnPgln8vnc6C2ofhNcOSQ0xmMgMBEnhwqTQn2Ol927M5KQza4hZN0fOqVpcVdjt30EOOtrlHtZHE3s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV7VEQ4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88157C43390;
	Sun, 24 Mar 2024 22:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320392;
	bh=+gfGD22mjnzhNRULgZth3y7IpdDh67/7ZzicS4dW69c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JV7VEQ4fnjL0YoVJZzQfi68t+A/xsuRO5B995SD+bsW/g8mh3SVeLyD/2yRhO6B6z
	 txMsKKqYzqiGv+z1/7oKLN+4BF/Aaq1Pj94tTp6BHeJyY1v7GYJU8urbdC1s1l2vfF
	 3SJ7rKEOhdnJZgJ3cxFp+SB7a5LyD5cCtXpzv1FRfbJde8nrbworRRVPA2duQCziFW
	 0VtqCKRP7uFoW+gA5ZUXHkL/tPh1r2/CLuZhO+W4pupNi8nNgKfwLvNYVBsFjUHM6f
	 JfaiU7XLDe1HowvqvTpkNmyTE4mxzL0qJtQ8YMW0Z4Vxk1TFJzQp7jS60IMOSWLslt
	 lDKypHAMcIRUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lang Yu <Lang.Yu@amd.com>,
	Yifan Zhang <yifan1.zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 698/715] drm/amdgpu: fix mmhub client id out-of-bounds access
Date: Sun, 24 Mar 2024 18:34:37 -0400
Message-ID: <20240324223455.1342824-699-sashal@kernel.org>
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


