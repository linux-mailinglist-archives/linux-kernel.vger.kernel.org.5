Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB8778164
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 21:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjHJTXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbjHJTXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 15:23:41 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D984E8E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 12:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=p+4Lz4h71OsyA9D86WY9FEQenAlc42K6ne4DSInxnAY=; b=Z81yca106DebrHrP6gRjrMV97R
        8va7s6on+iQV4muRZqQda/XXlj+3S1sTK1aRKOb4eFnXXpRVLDQ2GrQ2QaaxVVlUANp+cNSiQCnHw
        Vc+Ipn4Mt6Gkzm7IP09Yb5RQGaenUbqwdKHCKizrV5ix1tOSU3BPWV4MgNl28BWBceVyv3vHiCzoa
        qKEHHMg0SiaJqWpLI5EB23zBEFaIIil5l9+QMpITEnsRXhiv3ABqWK8qk0jlFA7WFSqXroWZqVzMW
        qfHWIQqfWZmGsnkCxeN8EZrtWy8DrlEUBmGK1pTO5S6bBAC3ubtOoRutsXSD+RSQyQhSFd0vEAUOt
        jjD8BY6w==;
Received: from [191.193.179.209] (helo=steammachine.lan)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1qUBFy-00Gp5H-JL; Thu, 10 Aug 2023 21:23:38 +0200
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To:     dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     kernel-dev@igalia.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
        =?UTF-8?q?=27Marek=20Ol=C5=A1=C3=A1k=27?= <maraeo@gmail.com>,
        Samuel Pitoiset <samuel.pitoiset@gmail.com>,
        Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
        =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [RESEND v3 1/5] drm/amdgpu: Create a module param to disable soft recovery
Date:   Thu, 10 Aug 2023 16:23:26 -0300
Message-ID: <20230810192330.198326-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810192330.198326-1-andrealmeid@igalia.com>
References: <20230810192330.198326-1-andrealmeid@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a module parameter to disable soft recoveries on amdgpu, making
every recovery go through the device reset path. This option makes
easier to force device resets for testing and debugging purposes.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 6 +++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2e3c7c15cb8e..9c6a332261ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -189,6 +189,7 @@ extern uint amdgpu_force_long_training;
 extern int amdgpu_lbpw;
 extern int amdgpu_compute_multipipe;
 extern int amdgpu_gpu_recovery;
+extern bool amdgpu_soft_recovery;
 extern int amdgpu_emu_mode;
 extern uint amdgpu_smu_memory_pool_size;
 extern int amdgpu_smu_pptable_id;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0fec81d6a7df..27e7fa36cc60 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -163,6 +163,7 @@ uint amdgpu_force_long_training;
 int amdgpu_lbpw = -1;
 int amdgpu_compute_multipipe = -1;
 int amdgpu_gpu_recovery = -1; /* auto */
+bool amdgpu_soft_recovery = true;
 int amdgpu_emu_mode;
 uint amdgpu_smu_memory_pool_size;
 int amdgpu_smu_pptable_id = -1;
@@ -538,6 +539,14 @@ module_param_named(compute_multipipe, amdgpu_compute_multipipe, int, 0444);
 MODULE_PARM_DESC(gpu_recovery, "Enable GPU recovery mechanism, (1 = enable, 0 = disable, -1 = auto)");
 module_param_named(gpu_recovery, amdgpu_gpu_recovery, int, 0444);
 
+/**
+ * DOC: gpu_soft_recovery (bool)
+ * Set true to allow the driver to try soft recoveries if a job get stuck. Set
+ * to false to always force a GPU reset during recovery.
+ */
+MODULE_PARM_DESC(gpu_soft_recovery, "Enable GPU soft recovery mechanism (default: true)");
+module_param_named(gpu_soft_recovery, amdgpu_soft_recovery, bool, 0644);
+
 /**
  * DOC: emu_mode (int)
  * Set value 1 to enable emulation mode. This is only needed when running on an emulator. The default is 0 (disabled).
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 80d6e132e409..40678d9fb17e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -434,8 +434,12 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 			       struct dma_fence *fence)
 {
 	unsigned long flags;
+	ktime_t deadline;
 
-	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
+	if (!amdgpu_soft_recovery)
+		return false;
+
+	deadline = ktime_add_us(ktime_get(), 10000);
 
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
 		return false;
-- 
2.41.0

