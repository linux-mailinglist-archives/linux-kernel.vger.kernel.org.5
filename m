Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF7E798F30
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbjIHTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbjIHTat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 15:30:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEFF19C;
        Fri,  8 Sep 2023 12:30:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129C2C433C9;
        Fri,  8 Sep 2023 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694201380;
        bh=jWYE1FYgCZNk9oNLEEZRlHn7HEsT+q9KH2uiKJE9EN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sBnMaDfOecAbJzQl1ohxDDowLXNBHdlJi8Ojt/GrVGrvKEU3kL7xHU3URWQu0gTJA
         2V0WWURZx4YnAKuCU6HpJqEr+c+CMzVDdGVlcAQLtWPwtyBSPw9f7uaCBdA9hBQ1oO
         cE3A9Eg8DPypryDA8wKeDxHSWcvtcBj7Yi99JWiqi5NWstKXWikGVMd/xYnt2OaTQb
         mYWStBSyn4F/U8XX19EqPNXnb4M+YBqI3Y14I6OLYaJfm5FNmZ88XGJFv4BN9dcEbz
         eQgwEWLavtz5xtBRDYmmFHG/qsXE6dAE9ngJWm1uuEO84rssQxEJtnazkAwa3UNDo0
         soFxTCG5GCdTQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        aaron.liu@amd.com, le.ma@amd.com, Xiaomeng.Hou@amd.com,
        HaoPing.Liu@amd.com, srinivasan.shanmugam@amd.com,
        tzimmermann@suse.de, Jun.Ma2@amd.com, sunran001@208suo.com,
        lee@kernel.org, lijo.lazar@amd.com, Hawking.Zhang@amd.com,
        mukul.joshi@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 10/36] drm/amdgpu: Increase soft IH ring size
Date:   Fri,  8 Sep 2023 15:28:21 -0400
Message-Id: <20230908192848.3462476-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908192848.3462476-1-sashal@kernel.org>
References: <20230908192848.3462476-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philip Yang <Philip.Yang@amd.com>

[ Upstream commit bf80d34b6c58ad1c4f76067ecd460a148eab9d39 ]

Retry faults are delegated to soft IH ring and then processed by
deferred worker. Current soft IH ring size PAGE_SIZE can store 128
entries, which may overflow and drop retry faults, causes HW stucks
because the retry fault is not recovered.

Increase soft IH ring size to 8KB, enough to store 256 CAM entries
because we clear the CAM entry after handling the retry fault from soft
ring.

Define macro IH_RING_SIZE and IH_SW_RING_SIZE to remove duplicate
constant.

Show warning message if soft IH ring overflows with CAM enabled because
this should not happen.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c  | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 7 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 4 ++--
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 4 ++--
 7 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index fceb3b384955a..f3b0aaf3ebc69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -138,6 +138,7 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
 /**
  * amdgpu_ih_ring_write - write IV to the ring buffer
  *
+ * @adev: amdgpu_device pointer
  * @ih: ih ring to write to
  * @iv: the iv to write
  * @num_dw: size of the iv in dw
@@ -145,8 +146,8 @@ void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih)
  * Writes an IV to the ring buffer using the CPU and increment the wptr.
  * Used for testing and delegating IVs to a software ring.
  */
-void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
-			  unsigned int num_dw)
+void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
+			  const uint32_t *iv, unsigned int num_dw)
 {
 	uint32_t wptr = le32_to_cpu(*ih->wptr_cpu) >> 2;
 	unsigned int i;
@@ -161,6 +162,9 @@ void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
 	if (wptr != READ_ONCE(ih->rptr)) {
 		wmb();
 		WRITE_ONCE(*ih->wptr_cpu, cpu_to_le32(wptr));
+	} else if (adev->irq.retry_cam_enabled) {
+		dev_warn_once(adev->dev, "IH soft ring buffer overflow 0x%X, 0x%X\n",
+			      wptr, ih->rptr);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
index dd1c2eded6b9d..6c6184f0dbc17 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
@@ -27,6 +27,9 @@
 /* Maximum number of IVs processed at once */
 #define AMDGPU_IH_MAX_NUM_IVS	32
 
+#define IH_RING_SIZE	(256 * 1024)
+#define IH_SW_RING_SIZE	(8 * 1024)	/* enough for 256 CAM entries */
+
 struct amdgpu_device;
 struct amdgpu_iv_entry;
 
@@ -97,8 +100,8 @@ struct amdgpu_ih_funcs {
 int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 			unsigned ring_size, bool use_bus_addr);
 void amdgpu_ih_ring_fini(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
-void amdgpu_ih_ring_write(struct amdgpu_ih_ring *ih, const uint32_t *iv,
-			  unsigned int num_dw);
+void amdgpu_ih_ring_write(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
+			  const uint32_t *iv, unsigned int num_dw);
 int amdgpu_ih_wait_on_checkpoint_process_ts(struct amdgpu_device *adev,
 					    struct amdgpu_ih_ring *ih);
 int amdgpu_ih_process(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 5273decc5753b..fa6d0adcec206 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -493,7 +493,7 @@ void amdgpu_irq_delegate(struct amdgpu_device *adev,
 			 struct amdgpu_iv_entry *entry,
 			 unsigned int num_dw)
 {
-	amdgpu_ih_ring_write(&adev->irq.ih_soft, entry->iv_entry, num_dw);
+	amdgpu_ih_ring_write(adev, &adev->irq.ih_soft, entry->iv_entry, num_dw);
 	schedule_work(&adev->irq.ih_soft_work);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index b02e1cef78a76..980b241200803 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -535,7 +535,7 @@ static int ih_v6_0_sw_init(void *handle)
 	 * use bus address for ih ring by psp bl */
 	use_bus_addr =
 		(adev->firmware.load_type == AMDGPU_FW_LOAD_PSP) ? false : true;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -548,7 +548,7 @@ static int ih_v6_0_sw_init(void *handle)
 	/* initialize ih control register offset */
 	ih_v6_0_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index eec13cb5bf758..b6a8478dabf43 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -565,7 +565,7 @@ static int navi10_ih_sw_init(void *handle)
 		use_bus_addr = false;
 	else
 		use_bus_addr = true;
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -578,7 +578,7 @@ static int navi10_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	navi10_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 1e83db0c5438d..d364c6dd152c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -485,7 +485,7 @@ static int vega10_ih_sw_init(void *handle)
 	if (r)
 		return r;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, true);
 	if (r)
 		return r;
 
@@ -510,7 +510,7 @@ static int vega10_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega10_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, true);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, true);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 4d719df376a72..544ee55a22da6 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -539,7 +539,7 @@ static int vega20_ih_sw_init(void *handle)
 	    (adev->ip_versions[OSSSYS_HWIP][0] == IP_VERSION(4, 4, 2)))
 		use_bus_addr = false;
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, 256 * 1024, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih, IH_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
@@ -565,7 +565,7 @@ static int vega20_ih_sw_init(void *handle)
 	/* initialize ih control registers offset */
 	vega20_ih_init_register_offset(adev);
 
-	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, PAGE_SIZE, use_bus_addr);
+	r = amdgpu_ih_ring_init(adev, &adev->irq.ih_soft, IH_SW_RING_SIZE, use_bus_addr);
 	if (r)
 		return r;
 
-- 
2.40.1

