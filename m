Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16978E21F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbjH3WKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245157AbjH3WKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:10:44 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B67CDB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=s5b3JIGKv+IRuR82jvSbbKiUEIXZQN02jOcNSvcB+ks=; b=qdUuglmNpHEjwddBO35XMHmZx1
        7hlpnViD1e+/lld25QZ8+ik0F94EQ6Uk1rLRYD2QFG2nPHeGw/Uu9p2gcRP+FEUxCn0tGVBlS7RQt
        WWv5X/k5YY0ZRjZyiWkl5Uuj7+j18S9FOyzfLfeZB1tPoaokcks+512mS52tYZAtyaP20FKIMWuLB
        T1bO41HJI1JTqTbKeyPWhFvLF2Q/w118uSdkA8exi9Ou4Ib1zA7BMtdQXk+gyoyio5M5HZD4M8ZYz
        jIGi2fiu0fyDYmVTlPzl1rbpoV/i6lCDFT6KCo/tai+CP7kYfQB3upnXJTfoLp3q0Z+lijrabimTj
        njE0LdTQ==;
Received: from [191.193.15.45] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qbTMJ-00Ha7K-SZ; Thu, 31 Aug 2023 00:08:20 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 2/2] drm/amdgpu: Create an option to disable soft recovery
Date:   Wed, 30 Aug 2023 19:08:08 -0300
Message-ID: <20230830220808.421935-3-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830220808.421935-1-andrealmeid@igalia.com>
References: <20230830220808.421935-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a module option to disable soft recoveries on amdgpu, making
every recovery go through the device reset path. This option makes
easier to force device resets for testing and debugging purposes.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 6 +++++-
 drivers/gpu/drm/amd/include/amd_shared.h | 1 +
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 82eaccfce347..5f49e2c0ae7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1105,6 +1105,7 @@ struct amdgpu_device {
 	/* Debug */
 	bool                            debug_vm;
 	bool                            debug_largebar;
+	bool                            debug_disable_soft_recovery;
 };
 
 static inline struct amdgpu_device *drm_to_adev(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0cd48c025433..59e9fe594b51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -927,6 +927,7 @@ MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between graphics
  * - 0x2: Enable simulating large-bar capability on non-large bar system. This
  *   limits the VRAM size reported to ROCm applications to the visible
  *   size, usually 256MB.
+ * - 0x4: Disable GPU soft recovery
  */
 MODULE_PARM_DESC(debug_mask, "debug options for amdgpu, disabled by default");
 module_param_named(debug_mask, amdgpu_debug_mask, uint, 0444);
@@ -2046,6 +2047,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: enabled simulating large-bar capability on non-large bar system\n");
 		adev->debug_largebar = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY) {
+		pr_info("debug: soft reset for GPU recovery disabled\n");
+		adev->debug_disable_soft_recovery = true;
+	}
 }
 
 static int amdgpu_pci_probe(struct pci_dev *pdev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 80d6e132e409..6a80d3ec887e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -434,8 +434,12 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 			       struct dma_fence *fence)
 {
 	unsigned long flags;
+	ktime_t deadline;
 
-	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
+	if (unlikely(ring->adev->debug_disable_soft_recovery))
+		return false;
+
+	deadline = ktime_add_us(ktime_get(), 10000);
 
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
 		return false;
diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
index 2fd6af2183cc..32ee982be99e 100644
--- a/drivers/gpu/drm/amd/include/amd_shared.h
+++ b/drivers/gpu/drm/amd/include/amd_shared.h
@@ -263,6 +263,7 @@ enum amd_dpm_forced_level;
 enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_VM = BIT(0),
 	AMDGPU_DEBUG_LARGEBAR = BIT(1),
+	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
 };
 
 /**
-- 
2.41.0

