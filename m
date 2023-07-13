Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EDD752975
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 19:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGMRFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 13:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbjGMRFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 13:05:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10A82719
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689267886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDTzwir1/xdyBNXu4To8JOfNaRikhwJYnhsxVNPXgaw=;
        b=Wakcefu23tWIx6ahd1tY0mrPIwUD2QX8s9bhMkKG4R0j7jflxw1BgpiXrvA7b+KEn0lPnH
        Hv8SvMbv+bX9eRNK7pzTN7YyDuQM/ZxA9ziOUGcXWwja131LYY3V2/VWQoRw+ZoJxiWiDA
        WkyyThO3DIsGaMLQJ8Bl9cGKL21lWQA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-tNFUx6bfOZ2kzKYlWgZW-g-1; Thu, 13 Jul 2023 13:04:39 -0400
X-MC-Unique: tNFUx6bfOZ2kzKYlWgZW-g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-31443e13f9dso650537f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 10:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689267878; x=1691859878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDTzwir1/xdyBNXu4To8JOfNaRikhwJYnhsxVNPXgaw=;
        b=kVTc55h/kcZKxVWhIFkcYrSGHofrZcJ7gJZS0YOHYBBUl9TlCLURbbZHDi+EYlSzuy
         MsfuLtnKTMJ8vv8kofZJnYtTrizHyerNsDWrSDPWq5CX94cu4h0asrCKoXfEy/YeYr+M
         HsYHbMXz2g0Jde1ch7MuBuf/cuPYjHcnwMuMs4/otgUPssMbuL4wiEWHqtX3RKJ1Y2cU
         M1PtdeRV/mqTVP0XFNeDdkynpyV0sRmhOgh81/aoYJ1MxcmsYDD4wWZi+UkZtnZuNQ9z
         AmJn1uvyV50Yp5M4t0Swal6r5GvlZOBBDtRTuGzLdZ2oa4idQBPxHXvaqCbhze5CfCia
         fpwA==
X-Gm-Message-State: ABy/qLZDVG8H/G6jXDJt8i557X+EAqz96KAOfnxNEfS6RMI9AjbE6Vlj
        j1TmjqUdC7jxoEBrLGe89iCHdGyZz+Nwn6q8KpVCtDlrD+yee1LSQBdbC9zCfeA9bN+uDH41+4F
        jDF34bDsVS7vwXN9bp5y55+yg
X-Received: by 2002:a5d:5228:0:b0:314:1270:8fc with SMTP id i8-20020a5d5228000000b00314127008fcmr1954305wra.0.1689267878371;
        Thu, 13 Jul 2023 10:04:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGdojxciixdA1kDHsdmhWPrrAYX3yZUZD/gi5+RQojtGz94ju0bGu2dVpEPNE0bbJY3W0xGaA==
X-Received: by 2002:a5d:5228:0:b0:314:1270:8fc with SMTP id i8-20020a5d5228000000b00314127008fcmr1954275wra.0.1689267877949;
        Thu, 13 Jul 2023 10:04:37 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id kb3-20020a1709070f8300b00988dbbd1f7esm4174291ejc.213.2023.07.13.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 10:04:37 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net, donald.robson@imgtec.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH drm-next v7 01/13] drm: execution context for GEM buffers v7
Date:   Thu, 13 Jul 2023 19:03:56 +0200
Message-ID: <20230713170429.2964-2-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713170429.2964-1-dakr@redhat.com>
References: <20230713170429.2964-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian König <christian.koenig@amd.com>

This adds the infrastructure for an execution context for GEM buffers
which is similar to the existing TTMs execbuf util and intended to replace
it in the long term.

The basic functionality is that we abstracts the necessary loop to lock
many different GEM buffers with automated deadlock and duplicate handling.

v2: drop xarray and use dynamic resized array instead, the locking
    overhead is unnecessary and measurable.
v3: drop duplicate tracking, radeon is really the only one needing that.
v4: fixes issues pointed out by Danilo, some typos in comments and a
    helper for lock arrays of GEM objects.
v5: some suggestions by Boris Brezillon, especially just use one retry
    macro, drop loop in prepare_array, use flags instead of bool
v6: minor changes suggested by Thomas, Boris and Danilo
v7: minor typos pointed out by checkpatch.pl fixed

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Danilo Krummrich <dakr@redhat.com>
Tested-by: Danilo Krummrich <dakr@redhat.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230711133122.3710-2-christian.koenig@amd.com
---
 Documentation/gpu/drm-mm.rst |  12 ++
 drivers/gpu/drm/Kconfig      |   6 +
 drivers/gpu/drm/Makefile     |   2 +
 drivers/gpu/drm/drm_exec.c   | 333 +++++++++++++++++++++++++++++++++++
 include/drm/drm_exec.h       | 123 +++++++++++++
 5 files changed, 476 insertions(+)
 create mode 100644 drivers/gpu/drm/drm_exec.c
 create mode 100644 include/drm/drm_exec.h

diff --git a/Documentation/gpu/drm-mm.rst b/Documentation/gpu/drm-mm.rst
index a79fd3549ff8..a52e6f4117d6 100644
--- a/Documentation/gpu/drm-mm.rst
+++ b/Documentation/gpu/drm-mm.rst
@@ -493,6 +493,18 @@ DRM Sync Objects
 .. kernel-doc:: drivers/gpu/drm/drm_syncobj.c
    :export:
 
+DRM Execution context
+=====================
+
+.. kernel-doc:: drivers/gpu/drm/drm_exec.c
+   :doc: Overview
+
+.. kernel-doc:: include/drm/drm_exec.h
+   :internal:
+
+.. kernel-doc:: drivers/gpu/drm/drm_exec.c
+   :export:
+
 GPU Scheduler
 =============
 
diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index afb3b2f5f425..c2f3d234c89e 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -194,6 +194,12 @@ config DRM_TTM
 	  GPU memory types. Will be enabled automatically if a device driver
 	  uses it.
 
+config DRM_EXEC
+	tristate
+	depends on DRM
+	help
+	  Execution context for command submissions
+
 config DRM_BUDDY
 	tristate
 	depends on DRM
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 7a09a89b493b..414855e2a463 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -78,6 +78,8 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 #
 # Memory-management helpers
 #
+#
+obj-$(CONFIG_DRM_EXEC) += drm_exec.o
 
 obj-$(CONFIG_DRM_BUDDY) += drm_buddy.o
 
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
new file mode 100644
index 000000000000..ff69cf0fb42a
--- /dev/null
+++ b/drivers/gpu/drm/drm_exec.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+
+#include <drm/drm_exec.h>
+#include <drm/drm_gem.h>
+#include <linux/dma-resv.h>
+
+/**
+ * DOC: Overview
+ *
+ * This component mainly abstracts the retry loop necessary for locking
+ * multiple GEM objects while preparing hardware operations (e.g. command
+ * submissions, page table updates etc..).
+ *
+ * If a contention is detected while locking a GEM object the cleanup procedure
+ * unlocks all previously locked GEM objects and locks the contended one first
+ * before locking any further objects.
+ *
+ * After an object is locked fences slots can optionally be reserved on the
+ * dma_resv object inside the GEM object.
+ *
+ * A typical usage pattern should look like this::
+ *
+ *	struct drm_gem_object *obj;
+ *	struct drm_exec exec;
+ *	unsigned long index;
+ *	int ret;
+ *
+ *	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT);
+ *	drm_exec_until_all_locked(&exec) {
+ *		ret = drm_exec_prepare_obj(&exec, boA, 1);
+ *		drm_exec_retry_on_contention(&exec);
+ *		if (ret)
+ *			goto error;
+ *
+ *		ret = drm_exec_prepare_obj(&exec, boB, 1);
+ *		drm_exec_retry_on_contention(&exec);
+ *		if (ret)
+ *			goto error;
+ *	}
+ *
+ *	drm_exec_for_each_locked_object(&exec, index, obj) {
+ *		dma_resv_add_fence(obj->resv, fence, DMA_RESV_USAGE_READ);
+ *		...
+ *	}
+ *	drm_exec_fini(&exec);
+ *
+ * See struct dma_exec for more details.
+ */
+
+/* Dummy value used to initially enter the retry loop */
+#define DRM_EXEC_DUMMY ((void *)~0)
+
+/* Unlock all objects and drop references */
+static void drm_exec_unlock_all(struct drm_exec *exec)
+{
+	struct drm_gem_object *obj;
+	unsigned long index;
+
+	drm_exec_for_each_locked_object(exec, index, obj) {
+		dma_resv_unlock(obj->resv);
+		drm_gem_object_put(obj);
+	}
+
+	drm_gem_object_put(exec->prelocked);
+	exec->prelocked = NULL;
+}
+
+/**
+ * drm_exec_init - initialize a drm_exec object
+ * @exec: the drm_exec object to initialize
+ * @flags: controls locking behavior, see DRM_EXEC_* defines
+ *
+ * Initialize the object and make sure that we can track locked objects.
+ */
+void drm_exec_init(struct drm_exec *exec, uint32_t flags)
+{
+	exec->flags = flags;
+	exec->objects = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+	/* If allocation here fails, just delay that till the first use */
+	exec->max_objects = exec->objects ? PAGE_SIZE / sizeof(void *) : 0;
+	exec->num_objects = 0;
+	exec->contended = DRM_EXEC_DUMMY;
+	exec->prelocked = NULL;
+}
+EXPORT_SYMBOL(drm_exec_init);
+
+/**
+ * drm_exec_fini - finalize a drm_exec object
+ * @exec: the drm_exec object to finalize
+ *
+ * Unlock all locked objects, drop the references to objects and free all memory
+ * used for tracking the state.
+ */
+void drm_exec_fini(struct drm_exec *exec)
+{
+	drm_exec_unlock_all(exec);
+	kvfree(exec->objects);
+	if (exec->contended != DRM_EXEC_DUMMY) {
+		drm_gem_object_put(exec->contended);
+		ww_acquire_fini(&exec->ticket);
+	}
+}
+EXPORT_SYMBOL(drm_exec_fini);
+
+/**
+ * drm_exec_cleanup - cleanup when contention is detected
+ * @exec: the drm_exec object to cleanup
+ *
+ * Cleanup the current state and return true if we should stay inside the retry
+ * loop, false if there wasn't any contention detected and we can keep the
+ * objects locked.
+ */
+bool drm_exec_cleanup(struct drm_exec *exec)
+{
+	if (likely(!exec->contended)) {
+		ww_acquire_done(&exec->ticket);
+		return false;
+	}
+
+	if (likely(exec->contended == DRM_EXEC_DUMMY)) {
+		exec->contended = NULL;
+		ww_acquire_init(&exec->ticket, &reservation_ww_class);
+		return true;
+	}
+
+	drm_exec_unlock_all(exec);
+	exec->num_objects = 0;
+	return true;
+}
+EXPORT_SYMBOL(drm_exec_cleanup);
+
+/* Track the locked object in the array */
+static int drm_exec_obj_locked(struct drm_exec *exec,
+			       struct drm_gem_object *obj)
+{
+	if (unlikely(exec->num_objects == exec->max_objects)) {
+		size_t size = exec->max_objects * sizeof(void *);
+		void *tmp;
+
+		tmp = kvrealloc(exec->objects, size, size + PAGE_SIZE,
+				GFP_KERNEL);
+		if (!tmp)
+			return -ENOMEM;
+
+		exec->objects = tmp;
+		exec->max_objects += PAGE_SIZE / sizeof(void *);
+	}
+	drm_gem_object_get(obj);
+	exec->objects[exec->num_objects++] = obj;
+
+	return 0;
+}
+
+/* Make sure the contended object is locked first */
+static int drm_exec_lock_contended(struct drm_exec *exec)
+{
+	struct drm_gem_object *obj = exec->contended;
+	int ret;
+
+	if (likely(!obj))
+		return 0;
+
+	/* Always cleanup the contention so that error handling can kick in */
+	exec->contended = NULL;
+	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT) {
+		ret = dma_resv_lock_slow_interruptible(obj->resv,
+						       &exec->ticket);
+		if (unlikely(ret))
+			goto error_dropref;
+	} else {
+		dma_resv_lock_slow(obj->resv, &exec->ticket);
+	}
+
+	ret = drm_exec_obj_locked(exec, obj);
+	if (unlikely(ret))
+		goto error_unlock;
+
+	exec->prelocked = obj;
+	return 0;
+
+error_unlock:
+	dma_resv_unlock(obj->resv);
+
+error_dropref:
+	drm_gem_object_put(obj);
+	return ret;
+}
+
+/**
+ * drm_exec_lock_obj - lock a GEM object for use
+ * @exec: the drm_exec object with the state
+ * @obj: the GEM object to lock
+ *
+ * Lock a GEM object for use and grab a reference to it.
+ *
+ * Returns: -EDEADLK if a contention is detected, -EALREADY when object is
+ * already locked (can be suppressed by setting the DRM_EXEC_IGNORE_DUPLICATES
+ * flag), -ENOMEM when memory allocation failed and zero for success.
+ */
+int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
+{
+	int ret;
+
+	ret = drm_exec_lock_contended(exec);
+	if (unlikely(ret))
+		return ret;
+
+	if (exec->prelocked == obj) {
+		drm_gem_object_put(exec->prelocked);
+		exec->prelocked = NULL;
+		return 0;
+	}
+
+	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
+		ret = dma_resv_lock_interruptible(obj->resv, &exec->ticket);
+	else
+		ret = dma_resv_lock(obj->resv, &exec->ticket);
+
+	if (unlikely(ret == -EDEADLK)) {
+		drm_gem_object_get(obj);
+		exec->contended = obj;
+		return -EDEADLK;
+	}
+
+	if (unlikely(ret == -EALREADY) &&
+	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
+		return 0;
+
+	if (unlikely(ret))
+		return ret;
+
+	ret = drm_exec_obj_locked(exec, obj);
+	if (ret)
+		goto error_unlock;
+
+	return 0;
+
+error_unlock:
+	dma_resv_unlock(obj->resv);
+	return ret;
+}
+EXPORT_SYMBOL(drm_exec_lock_obj);
+
+/**
+ * drm_exec_unlock_obj - unlock a GEM object in this exec context
+ * @exec: the drm_exec object with the state
+ * @obj: the GEM object to unlock
+ *
+ * Unlock the GEM object and remove it from the collection of locked objects.
+ * Should only be used to unlock the most recently locked objects. It's not time
+ * efficient to unlock objects locked long ago.
+ */
+void drm_exec_unlock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
+{
+	unsigned int i;
+
+	for (i = exec->num_objects; i--;) {
+		if (exec->objects[i] == obj) {
+			dma_resv_unlock(obj->resv);
+			for (++i; i < exec->num_objects; ++i)
+				exec->objects[i - 1] = exec->objects[i];
+			--exec->num_objects;
+			drm_gem_object_put(obj);
+			return;
+		}
+
+	}
+}
+EXPORT_SYMBOL(drm_exec_unlock_obj);
+
+/**
+ * drm_exec_prepare_obj - prepare a GEM object for use
+ * @exec: the drm_exec object with the state
+ * @obj: the GEM object to prepare
+ * @num_fences: how many fences to reserve
+ *
+ * Prepare a GEM object for use by locking it and reserving fence slots.
+ *
+ * Returns: -EDEADLK if a contention is detected, -EALREADY when object is
+ * already locked, -ENOMEM when memory allocation failed and zero for success.
+ */
+int drm_exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
+			 unsigned int num_fences)
+{
+	int ret;
+
+	ret = drm_exec_lock_obj(exec, obj);
+	if (ret)
+		return ret;
+
+	ret = dma_resv_reserve_fences(obj->resv, num_fences);
+	if (ret) {
+		drm_exec_unlock_obj(exec, obj);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_exec_prepare_obj);
+
+/**
+ * drm_exec_prepare_array - helper to prepare an array of objects
+ * @exec: the drm_exec object with the state
+ * @objects: array of GEM object to prepare
+ * @num_objects: number of GEM objects in the array
+ * @num_fences: number of fences to reserve on each GEM object
+ *
+ * Prepares all GEM objects in an array, aborts on first error.
+ * Reserves @num_fences on each GEM object after locking it.
+ *
+ * Returns: -EDEADLOCK on contention, -EALREADY when object is already locked,
+ * -ENOMEM when memory allocation failed and zero for success.
+ */
+int drm_exec_prepare_array(struct drm_exec *exec,
+			   struct drm_gem_object **objects,
+			   unsigned int num_objects,
+			   unsigned int num_fences)
+{
+	int ret;
+
+	for (unsigned int i = 0; i < num_objects; ++i) {
+		ret = drm_exec_prepare_obj(exec, objects[i], num_fences);
+		if (unlikely(ret))
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_exec_prepare_array);
+
+MODULE_DESCRIPTION("DRM execution context");
+MODULE_LICENSE("Dual MIT/GPL");
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
new file mode 100644
index 000000000000..73205afec162
--- /dev/null
+++ b/include/drm/drm_exec.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+
+#ifndef __DRM_EXEC_H__
+#define __DRM_EXEC_H__
+
+#include <linux/ww_mutex.h>
+
+#define DRM_EXEC_INTERRUPTIBLE_WAIT	BIT(0)
+#define DRM_EXEC_IGNORE_DUPLICATES	BIT(1)
+
+struct drm_gem_object;
+
+/**
+ * struct drm_exec - Execution context
+ */
+struct drm_exec {
+	/**
+	 * @flags: Flags to control locking behavior
+	 */
+	uint32_t		flags;
+
+	/**
+	 * @ticket: WW ticket used for acquiring locks
+	 */
+	struct ww_acquire_ctx	ticket;
+
+	/**
+	 * @num_objects: number of objects locked
+	 */
+	unsigned int		num_objects;
+
+	/**
+	 * @max_objects: maximum objects in array
+	 */
+	unsigned int		max_objects;
+
+	/**
+	 * @objects: array of the locked objects
+	 */
+	struct drm_gem_object	**objects;
+
+	/**
+	 * @contended: contended GEM object we backed off for
+	 */
+	struct drm_gem_object	*contended;
+
+	/**
+	 * @prelocked: already locked GEM object due to contention
+	 */
+	struct drm_gem_object *prelocked;
+};
+
+/**
+ * drm_exec_for_each_locked_object - iterate over all the locked objects
+ * @exec: drm_exec object
+ * @index: unsigned long index for the iteration
+ * @obj: the current GEM object
+ *
+ * Iterate over all the locked GEM objects inside the drm_exec object.
+ */
+#define drm_exec_for_each_locked_object(exec, index, obj)	\
+	for (index = 0, obj = (exec)->objects[0];		\
+	     index < (exec)->num_objects;			\
+	     ++index, obj = (exec)->objects[index])
+
+/**
+ * drm_exec_until_all_locked - loop until all GEM objects are locked
+ * @exec: drm_exec object
+ *
+ * Core functionality of the drm_exec object. Loops until all GEM objects are
+ * locked and no more contention exists. At the beginning of the loop it is
+ * guaranteed that no GEM object is locked.
+ *
+ * Since labels can't be defined local to the loops body we use a jump pointer
+ * to make sure that the retry is only used from within the loops body.
+ */
+#define drm_exec_until_all_locked(exec)				\
+	for (void *__drm_exec_retry_ptr; ({			\
+		__label__ __drm_exec_retry;			\
+__drm_exec_retry:						\
+		__drm_exec_retry_ptr = &&__drm_exec_retry;	\
+		(void)__drm_exec_retry_ptr;			\
+		drm_exec_cleanup(exec);				\
+	});)
+
+/**
+ * drm_exec_retry_on_contention - restart the loop to grap all locks
+ * @exec: drm_exec object
+ *
+ * Control flow helper to continue when a contention was detected and we need to
+ * clean up and re-start the loop to prepare all GEM objects.
+ */
+#define drm_exec_retry_on_contention(exec)			\
+	do {							\
+		if (unlikely(drm_exec_is_contended(exec)))	\
+			goto *__drm_exec_retry_ptr;		\
+	} while (0)
+
+/**
+ * drm_exec_is_contended - check for contention
+ * @exec: drm_exec object
+ *
+ * Returns true if the drm_exec object has run into some contention while
+ * locking a GEM object and needs to clean up.
+ */
+static inline bool drm_exec_is_contended(struct drm_exec *exec)
+{
+	return !!exec->contended;
+}
+
+void drm_exec_init(struct drm_exec *exec, uint32_t flags);
+void drm_exec_fini(struct drm_exec *exec);
+bool drm_exec_cleanup(struct drm_exec *exec);
+int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj);
+void drm_exec_unlock_obj(struct drm_exec *exec, struct drm_gem_object *obj);
+int drm_exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
+			 unsigned int num_fences);
+int drm_exec_prepare_array(struct drm_exec *exec,
+			   struct drm_gem_object **objects,
+			   unsigned int num_objects,
+			   unsigned int num_fences);
+
+#endif
-- 
2.41.0

