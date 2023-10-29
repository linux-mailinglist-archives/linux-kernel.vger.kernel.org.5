Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7807DAF4D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 23:58:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjJ2W60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjJ2W6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 18:58:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C4F1720;
        Sun, 29 Oct 2023 15:57:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151A4C4339A;
        Sun, 29 Oct 2023 22:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620224;
        bh=7Q9FhoPe2eraIBXpik0bjdEAkFsAsPzqbrBnYZf+BvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=po0gwspoSZ5pO/MJmwPXzmQ56RsbCmcAZpleQa06FQZDpN7vaPo7JRZb7hueLpaXG
         GlBvIO7dW11mlsKT3Yd2M03rU+KX+JHROpsOviA0C75nknDEslVMQllHSO6LGd1hZ3
         aRLxkAzFfklD+gxghbXBNLDeOCPG/dYHv6t2mkxTHr9v+JcpR8VZXG17RkNUNkRUYI
         N6AKB9T+O1Aa938/ojAeAhEABCbTAKwTnC/DbG044fyBcPz0NU+k0dLFB/aDOC07fU
         Lz6wDhcW9gglm2TuB3LxvKPZA58GsVKpu889ZL4ABouoTyIH2A4RFg+i1ne8klzpdf
         Pbyo7OaT/S4IQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Karol Wachowski <karol.wachowski@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>,
        jacek.lawrynowicz@linux.intel.com, ogabbay@kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 50/52] Revert "accel/ivpu: Use cached buffers for FW loading"
Date:   Sun, 29 Oct 2023 18:53:37 -0400
Message-ID: <20231029225441.789781-50-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

[ Upstream commit 610b5d219d1ccac8064556310cc0e62e3c202389 ]

This reverts commit 645d694559cab36fe6a57c717efcfa27d9321396.

The commit cause issues with memory access from the device side.
Switch back to write-combined memory mappings until the issues
will be properly addressed.

Add extra wmb() needed when boot_params->save_restore_ret_address() is
modified.

Reviewed-by: Karol Wachowski <karol.wachowski@linux.intel.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231017121353.532466-1-stanislaw.gruszka@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_fw.c  | 9 ++++-----
 drivers/accel/ivpu/ivpu_gem.h | 5 -----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_fw.c b/drivers/accel/ivpu/ivpu_fw.c
index 93c69aaa6218d..34e4026c77589 100644
--- a/drivers/accel/ivpu/ivpu_fw.c
+++ b/drivers/accel/ivpu/ivpu_fw.c
@@ -195,8 +195,7 @@ static int ivpu_fw_mem_init(struct ivpu_device *vdev)
 	if (ret)
 		return ret;
 
-	fw->mem = ivpu_bo_alloc_internal(vdev, fw->runtime_addr, fw->runtime_size,
-					 DRM_IVPU_BO_CACHED | DRM_IVPU_BO_NOSNOOP);
+	fw->mem = ivpu_bo_alloc_internal(vdev, fw->runtime_addr, fw->runtime_size, DRM_IVPU_BO_WC);
 	if (!fw->mem) {
 		ivpu_err(vdev, "Failed to allocate firmware runtime memory\n");
 		return -ENOMEM;
@@ -273,7 +272,7 @@ int ivpu_fw_load(struct ivpu_device *vdev)
 		memset(start, 0, size);
 	}
 
-	clflush_cache_range(fw->mem->kvaddr, fw->mem->base.size);
+	wmb(); /* Flush WC buffers after writing fw->mem */
 
 	return 0;
 }
@@ -375,7 +374,7 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
 	if (!ivpu_fw_is_cold_boot(vdev)) {
 		boot_params->save_restore_ret_address = 0;
 		vdev->pm->is_warmboot = true;
-		clflush_cache_range(vdev->fw->mem->kvaddr, SZ_4K);
+		wmb(); /* Flush WC buffers after writing save_restore_ret_address */
 		return;
 	}
 
@@ -430,7 +429,7 @@ void ivpu_fw_boot_params_setup(struct ivpu_device *vdev, struct vpu_boot_params
 	boot_params->punit_telemetry_sram_size = ivpu_hw_reg_telemetry_size_get(vdev);
 	boot_params->vpu_telemetry_enable = ivpu_hw_reg_telemetry_enable_get(vdev);
 
-	clflush_cache_range(vdev->fw->mem->kvaddr, SZ_4K);
+	wmb(); /* Flush WC buffers after writing bootparams */
 
 	ivpu_fw_boot_params_print(vdev, boot_params);
 }
diff --git a/drivers/accel/ivpu/ivpu_gem.h b/drivers/accel/ivpu/ivpu_gem.h
index f4130586ff1b2..6b0ceda5f2537 100644
--- a/drivers/accel/ivpu/ivpu_gem.h
+++ b/drivers/accel/ivpu/ivpu_gem.h
@@ -8,8 +8,6 @@
 #include <drm/drm_gem.h>
 #include <drm/drm_mm.h>
 
-#define DRM_IVPU_BO_NOSNOOP       0x10000000
-
 struct dma_buf;
 struct ivpu_bo_ops;
 struct ivpu_file_priv;
@@ -85,9 +83,6 @@ static inline u32 ivpu_bo_cache_mode(struct ivpu_bo *bo)
 
 static inline bool ivpu_bo_is_snooped(struct ivpu_bo *bo)
 {
-	if (bo->flags & DRM_IVPU_BO_NOSNOOP)
-		return false;
-
 	return ivpu_bo_cache_mode(bo) == DRM_IVPU_BO_CACHED;
 }
 
-- 
2.42.0

