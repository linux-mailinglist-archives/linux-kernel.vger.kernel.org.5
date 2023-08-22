Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934007840BC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235091AbjHVM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjHVLhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:37:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1ED3E7B;
        Tue, 22 Aug 2023 04:37:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D6AA6538F;
        Tue, 22 Aug 2023 11:36:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56497C433C7;
        Tue, 22 Aug 2023 11:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692704215;
        bh=RtM9u0uoMbgmNToEvBrFSxc6qVE4GpINtMqKgqKlNZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlCO8JILx2/sQU223bAHldomQVM4w/IogwmDZw5LZAafaJXhk5gwHMtl2U/mKmi2O
         o8PGj9NthuLDD9ueSxuM+Yr8xzLhHprMv+F18YRj9Nh9Uo8DwFrBUwza/F1b5PZ9Of
         Tr88vSSF9JEZJ4oBILgx+80anzfw0MQUSqgYoV0ks+xXa+VivImR7tkrYfk5U/dAuk
         8XhkZSaquEQUZc+E4fvCD3SVoI9VVhzDfMvvz4AWoEWBlw7DvOG+E6r6Bcjwi5fSKy
         pARUs6I8dMPwrrUizUQVrJnxctoszOk45WRPnmJ608C53B01NXpEFLlAvJT2K6yn0D
         b4ZpbOfzEyYKw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Mike Lothian <mike@fireburn.co.uk>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 09/10] drm/amdkfd: disable IOMMUv2 support for KV/CZ
Date:   Tue, 22 Aug 2023 07:36:27 -0400
Message-Id: <20230822113628.3551393-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113628.3551393-1-sashal@kernel.org>
References: <20230822113628.3551393-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.46
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 616f92d188ee7142a95a52068efdbea82645f859 ]

Use the dGPU path instead.  There were a lot of platform
issues with IOMMU in general on these chips due to windows
not enabling IOMMU at the time.  The dGPU path has been
used for a long time with newer APUs and works fine.  This
also paves the way to simplify the driver significantly.

v2: use the dGPU queue manager functions

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Tested-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c               | 6 ------
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 8 +-------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 27820f0a282d1..4cc5debdd119b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -216,10 +216,6 @@ static void kfd_device_info_init(struct kfd_dev *kfd,
 		    asic_type != CHIP_TONGA)
 			kfd->device_info.supports_cwsr = true;
 
-		if (asic_type == CHIP_KAVERI ||
-		    asic_type == CHIP_CARRIZO)
-			kfd->device_info.needs_iommu_device = true;
-
 		if (asic_type != CHIP_HAWAII && !vf)
 			kfd->device_info.needs_pci_atomics = true;
 	}
@@ -233,7 +229,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 	uint32_t gfx_target_version = 0;
 
 	switch (adev->asic_type) {
-#ifdef KFD_SUPPORT_IOMMU_V2
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_KAVERI:
 		gfx_target_version = 70000;
@@ -246,7 +241,6 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 		if (!vf)
 			f2g = &gfx_v8_kfd2kgd;
 		break;
-#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_HAWAII:
 		gfx_target_version = 70001;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c06ada0844ba1..5616a722578f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2335,18 +2335,12 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 	}
 
 	switch (dev->adev->asic_type) {
-	case CHIP_CARRIZO:
-		device_queue_manager_init_vi(&dqm->asic_ops);
-		break;
-
 	case CHIP_KAVERI:
-		device_queue_manager_init_cik(&dqm->asic_ops);
-		break;
-
 	case CHIP_HAWAII:
 		device_queue_manager_init_cik_hawaii(&dqm->asic_ops);
 		break;
 
+	case CHIP_CARRIZO:
 	case CHIP_TONGA:
 	case CHIP_FIJI:
 	case CHIP_POLARIS10:
-- 
2.40.1

