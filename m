Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A9179455F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbjIFVsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjIFVsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E8DAE7C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 14:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694036853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bmrcb2oq50rZlpGWQfTXaOIClgXSoOriMS7Nyz+ms1c=;
        b=fqvWiuc0UogNR0rvhcNZp8v352zze0GjqDGFd5Wh4+T3z1N+k5fviNniVIl2sw0GQUFLEj
        OauRlX+AVzw39L4Ju+VLRysGAWHr5mTOmNOeWa2kwLJ73RfiK0oznKKEfg+KbwnCJwI0pD
        TUul4MJ2+Zdrou8gcRUofaYHRZKqD1w=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-_7myus7LPiOR4xIbJdRx5A-1; Wed, 06 Sep 2023 17:47:32 -0400
X-MC-Unique: _7myus7LPiOR4xIbJdRx5A-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-500b0aa547eso226100e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 14:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694036851; x=1694641651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bmrcb2oq50rZlpGWQfTXaOIClgXSoOriMS7Nyz+ms1c=;
        b=S7kG8SXsM/eSQZnfTSyIpxHQtyIgsYcgjKMJo8+jeIfNvc54lKDk9LBkuz1RYD3Dxl
         eAv6+/2zn5WmOjDRICT95BQjMNo3DxKLhULgGgijh988SPX7ki8hfY9574rjspg1c9ZA
         YdI7o+k71EbB9+t4OU0q7gZ7JTDpCUGPg2XGuDZ/vgf4AJFIf+NRvyJfD1rhI3zCI1jf
         6OgWLHUaw84dXaxGXIdGwS6NeHBqb6qYBKhMD45Zsc8+gDKuPvV5eMJ8KdDhobLogF/v
         EfPy0xDPr/MaabAMIZCb7fy5QWSUBNxyetyjoUFakWbpyQMvcG4PMPvBFE86clhrp1ly
         cbLQ==
X-Gm-Message-State: AOJu0YyOE3qwEpt8jpgJX4ndDFsbHLmE2jWPaszpssyyZF9cU3VrfPgU
        FYNSbTMGsAzYdLsJVMePL4DKMy1ITGIRsh6mU9CdAVN84Xj+36s5NPKgsS5VM9ibGnK7LGyznIQ
        K+JcW5a+1tUm4n5bdLyYEgxjt
X-Received: by 2002:a05:6512:47c:b0:4fd:bdf8:930d with SMTP id x28-20020a056512047c00b004fdbdf8930dmr3397712lfd.22.1694036851084;
        Wed, 06 Sep 2023 14:47:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZOvUjQotqVmw5dq+H1cGrTwf3v11lzqe++IgrCUjU4OD92LBUiS/v0WDNutLYEF1h43q/IQ==
X-Received: by 2002:a05:6512:47c:b0:4fd:bdf8:930d with SMTP id x28-20020a056512047c00b004fdbdf8930dmr3397700lfd.22.1694036850791;
        Wed, 06 Sep 2023 14:47:30 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b005232c051605sm8829288edt.19.2023.09.06.14.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 14:47:30 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 1/7] drm: gpuva_mgr: allow building as module
Date:   Wed,  6 Sep 2023 23:47:09 +0200
Message-ID: <20230906214723.4393-2-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230906214723.4393-1-dakr@redhat.com>
References: <20230906214723.4393-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DRM GPUVA manager does not have any core dependencies
preventing a module build.

Also, new features from subsequent patches require helpers (namely
drm_exec) which can be built as module.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/Kconfig         | 7 +++++++
 drivers/gpu/drm/Makefile        | 2 +-
 drivers/gpu/drm/drm_gpuva_mgr.c | 3 +++
 drivers/gpu/drm/nouveau/Kconfig | 1 +
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index ab9ef1c20349..3f2577e10c07 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -216,6 +216,13 @@ config DRM_EXEC
 	help
 	  Execution context for command submissions
 
+config DRM_GPUVA_MGR
+	tristate
+	depends on DRM && DRM_EXEC
+	help
+	  GPU-VM representation providing helpers to manage a GPUs virtual
+	  address space
+
 config DRM_BUDDY
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 215e78e79125..5c10243d77fe 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -45,7 +45,6 @@ drm-y := \
 	drm_vblank.o \
 	drm_vblank_work.o \
 	drm_vma_manager.o \
-	drm_gpuva_mgr.o \
 	drm_writeback.o
 drm-$(CONFIG_DRM_LEGACY) += \
 	drm_agpsupport.o \
@@ -81,6 +80,7 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 #
 #
 obj-$(CONFIG_DRM_EXEC) += drm_exec.o
+obj-$(CONFIG_DRM_GPUVA_MGR) += drm_gpuva_mgr.o
 
 obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
 
diff --git a/drivers/gpu/drm/drm_gpuva_mgr.c b/drivers/gpu/drm/drm_gpuva_mgr.c
index f86bfad74ff8..6b5e12e142df 100644
--- a/drivers/gpu/drm/drm_gpuva_mgr.c
+++ b/drivers/gpu/drm/drm_gpuva_mgr.c
@@ -1723,3 +1723,6 @@ drm_gpuva_ops_free(struct drm_gpuva_manager *mgr,
 	kfree(ops);
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_ops_free);
+
+MODULE_DESCRIPTION("DRM GPUVA Manager");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index c52e8096cca4..bf73f6b1ccad 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -11,6 +11,7 @@ config DRM_NOUVEAU
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select DRM_EXEC
+	select DRM_GPUVA_MGR
 	select DRM_SCHED
 	select I2C
 	select I2C_ALGOBIT
-- 
2.41.0

