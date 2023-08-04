Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D007707E2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHDSZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbjHDSZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56E4C02
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691173466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vYr3+FrZbnstJX6FCxlFaxYgyvWfpTU29Ge9cFia7wg=;
        b=jECXY4MgnaWFXvLR49J7GpH5++twtT52nNCEOb8ntMFWVVm+7WGah4MOJ5eu5xfOpmRbh7
        sq/6f49lpAZA/C5UxXYe+/ddKjSUa0amd8qOpr/EOYMsNdt0mpuFwGxk/wdsnZuH59BUKF
        LwJS3hMiTjTEIuF1sdqv4uVhWLM/32c=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-u6hJJtjePemo-vpZAKoslw-1; Fri, 04 Aug 2023 14:24:22 -0400
X-MC-Unique: u6hJJtjePemo-vpZAKoslw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5223854ef71so1574986a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 11:24:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691173461; x=1691778261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYr3+FrZbnstJX6FCxlFaxYgyvWfpTU29Ge9cFia7wg=;
        b=Q+cNROIf6JIbvA7W7/rq12lYui09kRVNAG3WccIM9aLEb9FgrSvhUIx/v05xJwo3E9
         81NcZ3lN+p/BdpGUg8SIu1nc94bV9JwgeETbJGO28HawnTPzyr+0eFXU9oC7v2ZjQs0E
         HGDeNmsbuePMJlSsvUKgiTpZ8W5irXj7rqjnTs1ZGNfOX+4nsB/VFRJ9UZ7ZzRB4KWb5
         477Wq7JFYd9IVYnOXQEgyrh41Jt+RNCArO5me0VXfD6Ut+xidcX3EIi2DJwAoSxcZPh/
         1hNA7WlqydQDtYKrDCUiPAyqJZuTOeN/F8XIyI86euVZwNVQMwdEZqdArRf3NbjwA0Ex
         f6tg==
X-Gm-Message-State: AOJu0YxnD2mOTm11lM2CTyoQYiVPEph3T2sZsi5i5ISW9UXMaUBmrpUf
        dz4l1EPfR7kdeNBvzAMbf2FQoi+7nfNi2TFqKiix0KD0JJlVtSLPgONddtqI1DTMsheiBsa+mb0
        5A/unyHv6RfNTvcMv4yLhV2WP
X-Received: by 2002:aa7:c7cf:0:b0:522:cc6c:e25e with SMTP id o15-20020aa7c7cf000000b00522cc6ce25emr2173053eds.3.1691173460976;
        Fri, 04 Aug 2023 11:24:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYwqoyfpXcrYR9IMcAg0lOW6P6JfwYfmJygD6Vz4g0MxSOiUeQmHphbK1k+ilBMnmDS9mG+w==
X-Received: by 2002:aa7:c7cf:0:b0:522:cc6c:e25e with SMTP id o15-20020aa7c7cf000000b00522cc6ce25emr2173047eds.3.1691173460822;
        Fri, 04 Aug 2023 11:24:20 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id d13-20020a50fe8d000000b0051e1660a34esm1557805edt.51.2023.08.04.11.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 11:24:20 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v10 02/12] drm/nouveau: fixup the uapi header file.
Date:   Fri,  4 Aug 2023 20:23:42 +0200
Message-ID: <20230804182406.5222-3-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804182406.5222-1-dakr@redhat.com>
References: <20230804182406.5222-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Airlie <airlied@redhat.com>

nouveau > 10 years ago had a plan for new multiplexer inside a multiplexer
API using nvif. It never fully reached fruition, fast forward 10 years,
and the new vulkan driver is avoiding libdrm and calling ioctls, and
these 3 ioctls, getparam, channel alloc + free don't seem to be things
we'd want to use nvif for.

Undeprecate and put them into the uapi header so we can just copy it
into mesa later.

v2: use uapi types.

Reviewed-by: Faith Ekstrand <faith.ekstrand@collabora.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.h | 41 ---------------------
 include/uapi/drm/nouveau_drm.h          | 48 +++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.h b/drivers/gpu/drm/nouveau/nouveau_abi16.h
index 27eae85f33e6..d5d80d0d9011 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.h
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.h
@@ -43,28 +43,6 @@ int  nouveau_abi16_usif(struct drm_file *, void *data, u32 size);
 #define NOUVEAU_GEM_DOMAIN_VRAM      (1 << 1)
 #define NOUVEAU_GEM_DOMAIN_GART      (1 << 2)
 
-struct drm_nouveau_channel_alloc {
-	uint32_t     fb_ctxdma_handle;
-	uint32_t     tt_ctxdma_handle;
-
-	int          channel;
-	uint32_t     pushbuf_domains;
-
-	/* Notifier memory */
-	uint32_t     notifier_handle;
-
-	/* DRM-enforced subchannel assignments */
-	struct {
-		uint32_t handle;
-		uint32_t grclass;
-	} subchan[8];
-	uint32_t nr_subchan;
-};
-
-struct drm_nouveau_channel_free {
-	int channel;
-};
-
 struct drm_nouveau_grobj_alloc {
 	int      channel;
 	uint32_t handle;
@@ -83,31 +61,12 @@ struct drm_nouveau_gpuobj_free {
 	uint32_t handle;
 };
 
-#define NOUVEAU_GETPARAM_PCI_VENDOR      3
-#define NOUVEAU_GETPARAM_PCI_DEVICE      4
-#define NOUVEAU_GETPARAM_BUS_TYPE        5
-#define NOUVEAU_GETPARAM_FB_SIZE         8
-#define NOUVEAU_GETPARAM_AGP_SIZE        9
-#define NOUVEAU_GETPARAM_CHIPSET_ID      11
-#define NOUVEAU_GETPARAM_VM_VRAM_BASE    12
-#define NOUVEAU_GETPARAM_GRAPH_UNITS     13
-#define NOUVEAU_GETPARAM_PTIMER_TIME     14
-#define NOUVEAU_GETPARAM_HAS_BO_USAGE    15
-#define NOUVEAU_GETPARAM_HAS_PAGEFLIP    16
-struct drm_nouveau_getparam {
-	uint64_t param;
-	uint64_t value;
-};
-
 struct drm_nouveau_setparam {
 	uint64_t param;
 	uint64_t value;
 };
 
-#define DRM_IOCTL_NOUVEAU_GETPARAM           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GETPARAM, struct drm_nouveau_getparam)
 #define DRM_IOCTL_NOUVEAU_SETPARAM           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SETPARAM, struct drm_nouveau_setparam)
-#define DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC      DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_ALLOC, struct drm_nouveau_channel_alloc)
-#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
 #define DRM_IOCTL_NOUVEAU_GROBJ_ALLOC        DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GROBJ_ALLOC, struct drm_nouveau_grobj_alloc)
 #define DRM_IOCTL_NOUVEAU_NOTIFIEROBJ_ALLOC  DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_NOTIFIEROBJ_ALLOC, struct drm_nouveau_notifierobj_alloc)
 #define DRM_IOCTL_NOUVEAU_GPUOBJ_FREE        DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_GPUOBJ_FREE, struct drm_nouveau_gpuobj_free)
diff --git a/include/uapi/drm/nouveau_drm.h b/include/uapi/drm/nouveau_drm.h
index 853a327433d3..ca917e55b38f 100644
--- a/include/uapi/drm/nouveau_drm.h
+++ b/include/uapi/drm/nouveau_drm.h
@@ -33,6 +33,44 @@
 extern "C" {
 #endif
 
+#define NOUVEAU_GETPARAM_PCI_VENDOR      3
+#define NOUVEAU_GETPARAM_PCI_DEVICE      4
+#define NOUVEAU_GETPARAM_BUS_TYPE        5
+#define NOUVEAU_GETPARAM_FB_SIZE         8
+#define NOUVEAU_GETPARAM_AGP_SIZE        9
+#define NOUVEAU_GETPARAM_CHIPSET_ID      11
+#define NOUVEAU_GETPARAM_VM_VRAM_BASE    12
+#define NOUVEAU_GETPARAM_GRAPH_UNITS     13
+#define NOUVEAU_GETPARAM_PTIMER_TIME     14
+#define NOUVEAU_GETPARAM_HAS_BO_USAGE    15
+#define NOUVEAU_GETPARAM_HAS_PAGEFLIP    16
+struct drm_nouveau_getparam {
+	__u64 param;
+	__u64 value;
+};
+
+struct drm_nouveau_channel_alloc {
+	__u32     fb_ctxdma_handle;
+	__u32     tt_ctxdma_handle;
+
+	__s32     channel;
+	__u32     pushbuf_domains;
+
+	/* Notifier memory */
+	__u32     notifier_handle;
+
+	/* DRM-enforced subchannel assignments */
+	struct {
+		__u32 handle;
+		__u32 grclass;
+	} subchan[8];
+	__u32 nr_subchan;
+};
+
+struct drm_nouveau_channel_free {
+	__s32 channel;
+};
+
 #define NOUVEAU_GEM_DOMAIN_CPU       (1 << 0)
 #define NOUVEAU_GEM_DOMAIN_VRAM      (1 << 1)
 #define NOUVEAU_GEM_DOMAIN_GART      (1 << 2)
@@ -126,10 +164,10 @@ struct drm_nouveau_gem_cpu_fini {
 	__u32 handle;
 };
 
-#define DRM_NOUVEAU_GETPARAM           0x00 /* deprecated */
+#define DRM_NOUVEAU_GETPARAM           0x00
 #define DRM_NOUVEAU_SETPARAM           0x01 /* deprecated */
-#define DRM_NOUVEAU_CHANNEL_ALLOC      0x02 /* deprecated */
-#define DRM_NOUVEAU_CHANNEL_FREE       0x03 /* deprecated */
+#define DRM_NOUVEAU_CHANNEL_ALLOC      0x02
+#define DRM_NOUVEAU_CHANNEL_FREE       0x03
 #define DRM_NOUVEAU_GROBJ_ALLOC        0x04 /* deprecated */
 #define DRM_NOUVEAU_NOTIFIEROBJ_ALLOC  0x05 /* deprecated */
 #define DRM_NOUVEAU_GPUOBJ_FREE        0x06 /* deprecated */
@@ -188,6 +226,10 @@ struct drm_nouveau_svm_bind {
 #define NOUVEAU_SVM_BIND_TARGET__GPU_VRAM               (1UL << 31)
 
 
+#define DRM_IOCTL_NOUVEAU_GETPARAM           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_GETPARAM, struct drm_nouveau_getparam)
+#define DRM_IOCTL_NOUVEAU_CHANNEL_ALLOC      DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_ALLOC, struct drm_nouveau_channel_alloc)
+#define DRM_IOCTL_NOUVEAU_CHANNEL_FREE       DRM_IOW (DRM_COMMAND_BASE + DRM_NOUVEAU_CHANNEL_FREE, struct drm_nouveau_channel_free)
+
 #define DRM_IOCTL_NOUVEAU_SVM_INIT           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_INIT, struct drm_nouveau_svm_init)
 #define DRM_IOCTL_NOUVEAU_SVM_BIND           DRM_IOWR(DRM_COMMAND_BASE + DRM_NOUVEAU_SVM_BIND, struct drm_nouveau_svm_bind)
 
-- 
2.41.0

