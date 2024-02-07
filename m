Return-Path: <linux-kernel+bounces-57132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 174DD84D457
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1C82821DF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF5F1509BC;
	Wed,  7 Feb 2024 21:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRUUUAdR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76FD151442;
	Wed,  7 Feb 2024 21:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341061; cv=none; b=Hv0OJeUHVorKxRkelx+2y1pDPb//Zusrn8viJcVGoBtLDbIb+hjVxSLcp844c6lNCNS7t3DsWtDSVbNpEgYc+iIUrD9DbAot3HBNqiGEMiTVkn2cxEBHnM7UGxX30JDz815JNX6rJCvF6VjBSRkQU8+WenOzsuoQYa7dggPp4dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341061; c=relaxed/simple;
	bh=YQMdPLT85u6VmS+BxkTgirUdZ3i3i9GOontpVmmubnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDS3FBvxCn8S3fXbrm3ArV0Rgvw9FzgB8FesjIOQPMvLDkP2vEbUWMFCV/kUu3IOMVL/vp4qq2XN46xmslQKLL6002LWzIQw0YNAoCDQ3Swk0q2nUWfhR+5BTCXFBclOLUTL/sLgQ2SgGMWeF0LqG5d3TfFmx4aYJRuijzY5Dyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRUUUAdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117F9C433F1;
	Wed,  7 Feb 2024 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341061;
	bh=YQMdPLT85u6VmS+BxkTgirUdZ3i3i9GOontpVmmubnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRUUUAdRSHaOKmuS2aC2QEDDxv4j0t2lleXEqfzEf/vwKVsevOPND0QsZJwWwruVm
	 5iwKuKwSIwKR5SCRlVjDIs5IUeEOUM3sJ7swbRoe3+TMk5f2+07pdCHGxY69ARu4PQ
	 eH/gnij+ydCnu6aIJeRb98EIZArxvaatikixDbF5KxN8Dp+Q6jGJjAFARdTykbXiYy
	 y5fVTMlU3dk32LvUrY9DlHSWgrmBNXgG0hn+Cgr8CHKP3Jg0/qM7tAwOaFxgdD32eC
	 t3Elcv+FlIAUCdaoFZThYe2hblsTIVhSv1RHewY1MaWgdD271tn30rTxdyDy1CTYwL
	 5rgcXdpruq9HA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mukul Joshi <mukul.joshi@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	Felix.Kuehling@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 22/38] drm/amdkfd: Use correct drm device for cgroup permission check
Date: Wed,  7 Feb 2024 16:23:08 -0500
Message-ID: <20240207212337.2351-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Mukul Joshi <mukul.joshi@amd.com>

[ Upstream commit 4119734e06a7f30e7e8eb666692a58b85dca0269 ]

On GFX 9.4.3, for a given KFD node, fetch the correct drm device from
XCP manager when checking for cgroup permissions.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3287a3961395..12ee273e87e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1482,10 +1482,15 @@ void kfd_dec_compute_active(struct kfd_node *dev);
 
 /* Cgroup Support */
 /* Check with device cgroup if @kfd device is accessible */
-static inline int kfd_devcgroup_check_permission(struct kfd_node *kfd)
+static inline int kfd_devcgroup_check_permission(struct kfd_node *node)
 {
 #if defined(CONFIG_CGROUP_DEVICE) || defined(CONFIG_CGROUP_BPF)
-	struct drm_device *ddev = adev_to_drm(kfd->adev);
+	struct drm_device *ddev;
+
+	if (node->xcp)
+		ddev = node->xcp->ddev;
+	else
+		ddev = adev_to_drm(node->adev);
 
 	return devcgroup_check_permission(DEVCG_DEV_CHAR, DRM_MAJOR,
 					  ddev->render->index,
-- 
2.43.0


