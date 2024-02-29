Return-Path: <linux-kernel+bounces-87253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2FC86D1C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F51AB25A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 334E414404F;
	Thu, 29 Feb 2024 18:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2yCqsHZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733812EBD0
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230271; cv=none; b=rVXTeCTZNsWvtZ6Tw+im9GWbSzGvu9dJNopGHgmgZ1J7I3EtJ80nFd0owGO7HAbHxv6eMouZyO58UN7d3rnfc/2SbJWGd/8g34wj25o+k0/KwafxjTFueasI3igJQbH/ssUoBE19DmZg0ZflSkEglAtILNVz45aOAz7p2Fo55c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230271; c=relaxed/simple;
	bh=a5/6+2LTn+N0eUr8eiV1Ty/edBikw63mMsI6aVDC6Ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p7GtFBF0BiX6Uy58JamtlJhrZNc3yvV2WRbgHcMWRcEwpxJNpSIxuEvOWnI2fX6ffZbLv/XUBtkARssaBvxq4ehgjF+y+1KLA8SpEKjMCP5h0FP4ODvfLyxLY+t/vuCCx7DOjDX6l6lJeg+W9VixceZvuQk5GJwWEza5ZqPWMLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2yCqsHZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA85BC433A6;
	Thu, 29 Feb 2024 18:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230270;
	bh=a5/6+2LTn+N0eUr8eiV1Ty/edBikw63mMsI6aVDC6Ss=;
	h=From:To:Cc:Subject:Date:From;
	b=l2yCqsHZ6H7hX115YD1FwHAzweYh5q7rp1bnWXvWvqrMjEQtBO2S0OD5YHzjg5IKz
	 vlixsoeEX2ykU/3WRJwPYUvU+1fpah+SIV71lDnHmKF8PrsdwRQGAf8ohE8ofyHJI5
	 FOE8hk15AEsB6Ro8NiO7Yc0eAvDJuxkY1jVw5//stvK+juNOWsKfJ1n5LuUoH7uHqD
	 sf8a1P/b7FW4B1JEtGpT0DlsTU4TWbqplGvLDnKRGN27VEiUnmno+SgUS5/BQb6Alc
	 M1A7GbDAcMkaBC2U82NaxG21HYa06KamZAS0PHt6qDrRcEp0zKHrQSOPrwEhccmOAs
	 WKMpWj5S6D8gA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pan@web.codeaurora.org, Xinhui <Xinhui.Pan@amd.com>,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] drm/amdgpu: remove misleading amdgpu_pmops_runtime_idle() comment
Date: Thu, 29 Feb 2024 12:11:06 -0600
Message-Id: <20240229181106.351877-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

After 4020c2280233 ("drm/amdgpu: don't runtime suspend if there are
displays attached (v3)"), "ret" is unconditionally set later before being
used, so there's point in initializing it and the associated comment is no
longer meaningful.

Remove the comment and the unnecessary initialization.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index cc69005f5b46..68416e2a9130 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2744,8 +2744,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
-	/* we don't want the main rpm_idle to call suspend - we want to autosuspend */
-	int ret = 1;
+	int ret;
 
 	if (adev->pm.rpm_mode == AMDGPU_RUNPM_NONE) {
 		pm_runtime_forbid(dev);
-- 
2.34.1


