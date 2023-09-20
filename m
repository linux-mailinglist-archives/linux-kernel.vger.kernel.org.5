Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7857A8771
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjITOpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236384AbjITOou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A37ADC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695221039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=teKSA/CYnBKR/nhHsoNvbfNEz6ctyEw/xwjCLcFoikc=;
        b=Lm+bisNvslbCwcn8Graz9dNFoF6Y7TDsiC/1fWZdfU2JwnsPBPKAv2Eav8FC7E+0IBSkor
        BoSovd7kQ8FUS3HadKWf5MeZrJYXFCItI0ihKEFSnezxs8pRRfBNw4Ccr43FzkxD4mI8mB
        GHCyutwWYv5rXv+EPjPoux2IIRQKd3k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-wp7ed_lFM1ey-E_Yvm0Zug-1; Wed, 20 Sep 2023 10:43:58 -0400
X-MC-Unique: wp7ed_lFM1ey-E_Yvm0Zug-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9a9f282713fso503070566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 07:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695221037; x=1695825837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teKSA/CYnBKR/nhHsoNvbfNEz6ctyEw/xwjCLcFoikc=;
        b=l3l7rIOMfxgo5EdRMb+7BSFrSk9xgVvZVGj5TPmVk1gcNoXVXmhZIp80XqVsXuV3C6
         GuE/lSS7MKwH866Y/V8SPclHrrL+brUI1HjvMWyrmyEMiZlaz579116TRHjXB/+ydjVa
         DiYyL0hREqUvunnkxjV+l9Co5I5aDPfdp2ts47JoBOtCJGnbVuRAT4x3fbD0tmv0D1tb
         rX0CEuuQuzg3f7nvk+pXZzglXheItMy/S0sCWfSJaRfqvvBICK/Xcuq8cqVgtzzvzk+w
         2DQOCTRCnwot9KDneRvRDI+fEoqrUAkwzvV0CUAqQckauemAahp02uVZxfQS7etneiY5
         SBFQ==
X-Gm-Message-State: AOJu0YyQjfm+9KQ9W8ONghPJBa8JdFuK4qX3CBAYfhNV6mqMkserl9Wx
        88VLH8TBsVb5jS84cGYy4RXtEiTjBUjxgc6OVkzBRYFyL45JK7QYeEkiySC4gbp2e05N3X7DrZ8
        c8M5Em2zYchNt0M/ZCICy6TV+
X-Received: by 2002:a17:907:75f8:b0:9ae:381a:6c55 with SMTP id jz24-20020a17090775f800b009ae381a6c55mr2155906ejc.15.1695221036914;
        Wed, 20 Sep 2023 07:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnaHW60Dc5balSdXu08W+wuqyr34BCUy5AOQEdXimdxPZX7mS86BNMJpr+l5YTNyRpQOSFCw==
X-Received: by 2002:a17:907:75f8:b0:9ae:381a:6c55 with SMTP id jz24-20020a17090775f800b009ae381a6c55mr2155893ejc.15.1695221036661;
        Wed, 20 Sep 2023 07:43:56 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id e10-20020a170906248a00b00993928e4d1bsm9337658ejb.24.2023.09.20.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:43:56 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v4 2/8] drm/gpuvm: allow building as module
Date:   Wed, 20 Sep 2023 16:42:35 +0200
Message-ID: <20230920144343.64830-3-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230920144343.64830-1-dakr@redhat.com>
References: <20230920144343.64830-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Currently, the DRM GPUVM does not have any core dependencies preventing
a module build.

Also, new features from subsequent patches require helpers (namely
drm_exec) which can be built as module.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/Kconfig         | 7 +++++++
 drivers/gpu/drm/Makefile        | 2 +-
 drivers/gpu/drm/drm_gpuvm.c     | 3 +++
 drivers/gpu/drm/nouveau/Kconfig | 1 +
 4 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index ab9ef1c20349..0f78a03e4e84 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -216,6 +216,13 @@ config DRM_EXEC
 	help
 	  Execution context for command submissions
 
+config DRM_GPUVM
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
index 7a84b3cddeab..8e1bde059170 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -45,7 +45,6 @@ drm-y := \
 	drm_vblank.o \
 	drm_vblank_work.o \
 	drm_vma_manager.o \
-	drm_gpuvm.o \
 	drm_writeback.o
 drm-$(CONFIG_DRM_LEGACY) += \
 	drm_agpsupport.o \
@@ -81,6 +80,7 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 #
 #
 obj-$(CONFIG_DRM_EXEC) += drm_exec.o
+obj-$(CONFIG_DRM_GPUVM) += drm_gpuvm.o
 
 obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
 
diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index 7074bcad5b28..bfea4a8a19ec 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1723,3 +1723,6 @@ drm_gpuva_ops_free(struct drm_gpuvm *gpuvm,
 	kfree(ops);
 }
 EXPORT_SYMBOL_GPL(drm_gpuva_ops_free);
+
+MODULE_DESCRIPTION("DRM GPUVM");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/nouveau/Kconfig b/drivers/gpu/drm/nouveau/Kconfig
index c52e8096cca4..1e6aaf95ff7c 100644
--- a/drivers/gpu/drm/nouveau/Kconfig
+++ b/drivers/gpu/drm/nouveau/Kconfig
@@ -11,6 +11,7 @@ config DRM_NOUVEAU
 	select DRM_TTM
 	select DRM_TTM_HELPER
 	select DRM_EXEC
+	select DRM_GPUVM
 	select DRM_SCHED
 	select I2C
 	select I2C_ALGOBIT
-- 
2.41.0

