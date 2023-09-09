Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3C07999B8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 18:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbjIIQZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 12:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345187AbjIIPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 11:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A89139
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 08:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694273499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oAExJk9wXPRBLR7Aww0xIvaSzJwaJausSAN7Idxt57s=;
        b=d2LxIZq5xNSD+Cbtt+Jz6YBnem+mYlpTMlVzeCkZ5OfnPuZb0fSrVrII1oCSzc/o37hFYz
        4BmfOytaU7pIXGXkTkbHxTIzQLzWSUTvDq1T7GromufMhIRe0BE8f1RDEDdewkW3qyiADE
        A8bFdbZC5HfxiniKQP5lVYCmszmo7UA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-luT_Or9pP1eZSgY3W9jJPg-1; Sat, 09 Sep 2023 11:31:38 -0400
X-MC-Unique: luT_Or9pP1eZSgY3W9jJPg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a57ec840e2so578175066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 08:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694273497; x=1694878297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAExJk9wXPRBLR7Aww0xIvaSzJwaJausSAN7Idxt57s=;
        b=G8u1FF1Alh6OcfDZb584FWy4IAQN+sevcUaSTrcLhdq28MTrKDwtnLQKj61feBRtoG
         InxOSGrsDuqjd7VdjJD+ydMboVZBeAdmhSuUxQXOBt89we3j+h4/djVjxNgE2YijtT1p
         LxayY7Or1WU/BlKwekQT4d+wPkYjRYoN01ghrgAAG9XbWClCOq++hLnUn6bwxlmKZGO/
         x18bbJMqILoR90PxUKNhfbQnogt4yfLR/IQxLfKmrpNHMTpYSlcuYySGKDHkHt6iIbAu
         Uj3QkU02YZT8lof5y2F0Py68iRgeKAEpknNBP7O0GC7DIJPXQZhevNOpErtYuYiKdbPy
         lmFw==
X-Gm-Message-State: AOJu0YxnohWsYmm58vPBnADdx6X+UQr+JVkWoMjopVG6DAmUeEEgTJKx
        jwpdEq3Ud7IXzsrekqy/c3oKDC8Z7qLsfIQLK0804P9cZE4nEt7TlGscAuOfK6KaiXPHs7aKD8I
        w6JYpd97I95fvvoE+99StfP2c
X-Received: by 2002:a05:6402:4405:b0:52e:83d0:203e with SMTP id y5-20020a056402440500b0052e83d0203emr11091380eda.10.1694273497227;
        Sat, 09 Sep 2023 08:31:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwPKi9Ud3OSKETkcxe+CEqSSk4EkOZGAiwxnfz5HH0ThoHyvULsXX5HGNPbCGCDHOpytWyvw==
X-Received: by 2002:a05:6402:4405:b0:52e:83d0:203e with SMTP id y5-20020a056402440500b0052e83d0203emr11091364eda.10.1694273497067;
        Sat, 09 Sep 2023 08:31:37 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id d32-20020a056402402000b00521d2f7459fsm712898eda.49.2023.09.09.08.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 08:31:36 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, matthew.brost@intel.com,
        thomas.hellstrom@linux.intel.com, sarah.walker@imgtec.com,
        donald.robson@imgtec.com, boris.brezillon@collabora.com,
        christian.koenig@amd.com, faith.ekstrand@collabora.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 2/7] drm/gpuvm: allow building as module
Date:   Sat,  9 Sep 2023 17:31:09 +0200
Message-ID: <20230909153125.30032-3-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230909153125.30032-1-dakr@redhat.com>
References: <20230909153125.30032-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the DRM GPUVM does not have any core dependencies preventing
a module build.

Also, new features from subsequent patches require helpers (namely
drm_exec) which can be built as module.

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
index de1a69bc4a44..aae086deaa2b 100644
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

