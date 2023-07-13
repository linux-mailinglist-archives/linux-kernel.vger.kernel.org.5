Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E9752971
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbjGMRFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjGMRFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:05:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C3E270A
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689267889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDBNWdVA4hQ8PRBsFs3dd+X68qTkUgeiN1mzO/5EjB0=;
        b=R3kce4/dNBdM1Z0ljwdbQcmpxhM5jdBVIEHbt2iGDmgm9o3IiH3bQbCDzqa9jD9i6cgg69
        WoIF16GJzTMndD/yu/PZZ7qxoony/uvMlD2n70+3C4/wdwzFsGNvL1GAd/5HUkzgtWQ4nF
        XX6kS0habKrNlY7AgZ9fbXJ7z+LfaBU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-MXMQRA3gNj-MDfKYagzkPw-1; Thu, 13 Jul 2023 13:04:48 -0400
X-MC-Unique: MXMQRA3gNj-MDfKYagzkPw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-992e6840901so117472666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:04:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267887; x=1691859887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDBNWdVA4hQ8PRBsFs3dd+X68qTkUgeiN1mzO/5EjB0=;
        b=BbV1m+osciw24lHbEvM+9R3TMzdsJedv+h8qcbsW6psEcEvkrQWCj+WFMD1KtpA+8d
         kRMZUjkxCtMYoMJFpJ9g5Mia+YUo0t7e4G7dPL7nYJwOLhvhNS7li8nYfKnBXoJmcugN
         2ZMRg9pwDZ4uGwQHSXgmREyp4Egv+8wbIK0h34cZAy/KSukZCLvdWPoYHPFVTVtkmWY3
         jIK5pH6Y68zR59tPD0sRJpJVWpLQ7M8IO+jReRcqWgxfDOcogu7qxuJlgsYLidlFqsMz
         /0DlAQFLlHs9mz+S235pi+t+7mda1vWFdTdR41wp8ETvzU2rPV7UVfqYUlXct22R5YCJ
         Sbqg==
X-Gm-Message-State: ABy/qLbdtHGccUuywSSwWIAj3AOxOvL62w/n8vb89oQemIYisqdy6xdy
        quhwW/OMQrHD3JRQ8PuYMas1b1WEKexz0ar8ZVCA54OoUha/tW4yr8+yACHupT/69ICDpGh8Fpj
        P4rcO/LODrALWqNObHPENR/vH
X-Received: by 2002:a17:907:3e16:b0:994:fec:e1b7 with SMTP id hp22-20020a1709073e1600b009940fece1b7mr518186ejc.0.1689267887000;
        Thu, 13 Jul 2023 10:04:47 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGEK9zwgwIvcV78kzBO+an/C8r29yGgBppuA0+fFB5RqHcVSTcqkMZhih2uvBUHUCcn0UY5eQ==
X-Received: by 2002:a17:907:3e16:b0:994:fec:e1b7 with SMTP id hp22-20020a1709073e1600b009940fece1b7mr518148ejc.0.1689267886716;
        Thu, 13 Jul 2023 10:04:46 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id x25-20020a170906135900b00992acab8c45sm4266461ejb.12.2023.07.13.10.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:04:46 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v7 03/13] drm: debugfs: provide infrastructure to dump a DRM GPU VA space
Date:   Thu, 13 Jul 2023 19:03:58 +0200
Message-ID: <20230713170429.2964-4-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713170429.2964-1-dakr@redhat.com>
References: <20230713170429.2964-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a function to dump a DRM GPU VA space and a macro for
drivers to register the struct drm_info_list 'gpuvas' entry.

Most likely, most drivers might maintain one DRM GPU VA space per struct
drm_file, but there might also be drivers not having a fixed relation
between DRM GPU VA spaces and a DRM core infrastructure, hence we need the
indirection via the driver iterating it's maintained DRM GPU VA spaces.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_debugfs.c | 40 +++++++++++++++++++++++++++++++++++
 include/drm/drm_debugfs.h     | 25 ++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 4855230ba2c6..c90dbcffa0dc 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -39,6 +39,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_gpuva_mgr.h>
 
 #include "drm_crtc_internal.h"
 #include "drm_internal.h"
@@ -175,6 +176,45 @@ static const struct file_operations drm_debugfs_fops = {
 	.release = single_release,
 };
 
+/**
+ * drm_debugfs_gpuva_info - dump the given DRM GPU VA space
+ * @m: pointer to the &seq_file to write
+ * @mgr: the &drm_gpuva_manager representing the GPU VA space
+ *
+ * Dumps the GPU VA mappings of a given DRM GPU VA manager.
+ *
+ * For each DRM GPU VA space drivers should call this function from their
+ * &drm_info_list's show callback.
+ *
+ * Returns: 0 on success, -ENODEV if the &mgr is not initialized
+ */
+int drm_debugfs_gpuva_info(struct seq_file *m,
+			   struct drm_gpuva_manager *mgr)
+{
+	struct drm_gpuva *va, *kva = &mgr->kernel_alloc_node;
+
+	if (!mgr->name)
+		return -ENODEV;
+
+	seq_printf(m, "DRM GPU VA space (%s) [0x%016llx;0x%016llx]\n",
+		   mgr->name, mgr->mm_start, mgr->mm_start + mgr->mm_range);
+	seq_printf(m, "Kernel reserved node [0x%016llx;0x%016llx]\n",
+		   kva->va.addr, kva->va.addr + kva->va.range);
+	seq_puts(m, "\n");
+	seq_puts(m, " VAs | start              | range              | end                | object             | object offset\n");
+	seq_puts(m, "-------------------------------------------------------------------------------------------------------------\n");
+	drm_gpuva_for_each_va(va, mgr) {
+		if (unlikely(va == kva))
+			continue;
+
+		seq_printf(m, "     | 0x%016llx | 0x%016llx | 0x%016llx | 0x%016llx | 0x%016llx\n",
+			   va->va.addr, va->va.range, va->va.addr + va->va.range,
+			   (u64)va->gem.obj, va->gem.offset);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_debugfs_gpuva_info);
 
 /**
  * drm_debugfs_create_files - Initialize a given set of debugfs files for DRM
diff --git a/include/drm/drm_debugfs.h b/include/drm/drm_debugfs.h
index 7616f457ce70..cb2c1956a214 100644
--- a/include/drm/drm_debugfs.h
+++ b/include/drm/drm_debugfs.h
@@ -34,6 +34,22 @@
 
 #include <linux/types.h>
 #include <linux/seq_file.h>
+
+#include <drm/drm_gpuva_mgr.h>
+
+/**
+ * DRM_DEBUGFS_GPUVA_INFO - &drm_info_list entry to dump a GPU VA space
+ * @show: the &drm_info_list's show callback
+ * @data: driver private data
+ *
+ * Drivers should use this macro to define a &drm_info_list entry to provide a
+ * debugfs file for dumping the GPU VA space regions and mappings.
+ *
+ * For each DRM GPU VA space drivers should call drm_debugfs_gpuva_info() from
+ * their @show callback.
+ */
+#define DRM_DEBUGFS_GPUVA_INFO(show, data) {"gpuvas", show, DRIVER_GEM_GPUVA, data}
+
 /**
  * struct drm_info_list - debugfs info list entry
  *
@@ -134,6 +150,9 @@ void drm_debugfs_add_file(struct drm_device *dev, const char *name,
 
 void drm_debugfs_add_files(struct drm_device *dev,
 			   const struct drm_debugfs_info *files, int count);
+
+int drm_debugfs_gpuva_info(struct seq_file *m,
+			   struct drm_gpuva_manager *mgr);
 #else
 static inline void drm_debugfs_create_files(const struct drm_info_list *files,
 					    int count, struct dentry *root,
@@ -155,6 +174,12 @@ static inline void drm_debugfs_add_files(struct drm_device *dev,
 					 const struct drm_debugfs_info *files,
 					 int count)
 {}
+
+static inline int drm_debugfs_gpuva_info(struct seq_file *m,
+					 struct drm_gpuva_manager *mgr)
+{
+	return 0;
+}
 #endif
 
 #endif /* _DRM_DEBUGFS_H_ */
-- 
2.41.0

