Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E74776F011
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjHCQxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbjHCQxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9A82126
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 09:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691081576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgiHBqQzhU+chwvVYY3OBnXGB70Uj4QupullLdrp3I8=;
        b=IcMbx66+LAolQntgVNUY5ViL4D7a0aqPc0JW97RcgxwfwoHp7oPsqDOv1MQj/YqlORirj2
        t/jIK8DcBIw4WK1JdJxZrCKC79VZxHz+Bz9velmPLJWxjOoTPYvaTtklerQdAbPmUZywXu
        fczq/G4f5lIty7yWZkhoB1/eBcxR+68=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-UGU_6AfWMSWc2kxeUVzn4w-1; Thu, 03 Aug 2023 12:52:54 -0400
X-MC-Unique: UGU_6AfWMSWc2kxeUVzn4w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-521f84b8c42so715841a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 09:52:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691081573; x=1691686373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WgiHBqQzhU+chwvVYY3OBnXGB70Uj4QupullLdrp3I8=;
        b=EjEk0cA1rWu0Shv5T6C0oZuKysuRrc1GVUF8RExkiE2Oru5J0YFAQOiAzn2pKKoa46
         XnUqdn5+80miZLEzY4ijWM8DPNwbX/N/IymAZ4eW89rUsUB0GPuqXPh8TyhBu84Gxct7
         BDK7IEcxXtK/kWCyrLIwxgP5Rc8YA0qR+I72dzwbLNFh2dJNlSlyCEW+SbDK/n5ZVMnO
         jp6YtMbqWsO/DcyH6XG6UfXvLp69ZnB9mZDeIVbHR5I2+U9fb42S6NsiOJYv1p4OkyD4
         YOz9L07EntiF70doqH+PrHIfn8GspExLldj67jBmO/X/2swwsPEM6dvYjWoWfPIWVfmx
         F3wA==
X-Gm-Message-State: ABy/qLY+Jg+KlK93O/oMKu6ByEOS175cNxQVwrNX9dn3edUncxBPY/ta
        Ua426FLxGos7mctqFIo7oE4mXMKotd2H2y9zkAr+mc2rOLbiDa8cVKiHWgi7mz7FAXZ+JSWztbZ
        uQ6Bs67RV4xifNkSDAhm/7sUtrIvQKpVc
X-Received: by 2002:a05:6402:31fa:b0:51e:2305:931 with SMTP id dy26-20020a05640231fa00b0051e23050931mr7760020edb.22.1691081573579;
        Thu, 03 Aug 2023 09:52:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHWOYsnn1oCn5gkeMLn4uDdQ4XDa+mZDkwB5BDZpkQE0Vx3/c9Z+CvMCA47o36BoMnEPa5E0g==
X-Received: by 2002:a05:6402:31fa:b0:51e:2305:931 with SMTP id dy26-20020a05640231fa00b0051e23050931mr7760014edb.22.1691081573325;
        Thu, 03 Aug 2023 09:52:53 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de9c:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id v24-20020aa7d818000000b005227f4530fdsm35668edq.37.2023.08.03.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 09:52:52 -0700 (PDT)
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
Subject: [PATCH drm-misc-next v9 01/11] drm/gem: fix lockdep check for dma-resv lock
Date:   Thu,  3 Aug 2023 18:52:20 +0200
Message-ID: <20230803165238.8798-2-dakr@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803165238.8798-1-dakr@redhat.com>
References: <20230803165238.8798-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When no custom lock is set to protect a GEMs GPUVA list, lockdep checks
should fall back to the GEM objects dma-resv lock. With the current
implementation we're setting the lock_dep_map of the GEM objects 'resv'
pointer (in case no custom lock_dep_map is set yet) on
drm_gem_private_object_init().

However, the GEM objects 'resv' pointer might still change after
drm_gem_private_object_init() is called, e.g. through
ttm_bo_init_reserved(). This can result in the wrong lock being tracked.

To fix this, call dma_resv_held() directly from
drm_gem_gpuva_assert_lock_held() and fall back to the GEMs lock_dep_map
pointer only if an actual custom lock is set.

Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 include/drm/drm_gem.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
index c0b13c43b459..bc9f6aa2f3fe 100644
--- a/include/drm/drm_gem.h
+++ b/include/drm/drm_gem.h
@@ -551,15 +551,17 @@ int drm_gem_evict(struct drm_gem_object *obj);
  * @lock: the lock used to protect the gpuva list. The locking primitive
  * must contain a dep_map field.
  *
- * Call this if you're not proctecting access to the gpuva list
- * with the dma-resv lock, otherwise, drm_gem_gpuva_init() takes care
- * of initializing lock_dep_map for you.
+ * Call this if you're not proctecting access to the gpuva list with the
+ * dma-resv lock, but with a custom lock.
  */
 #define drm_gem_gpuva_set_lock(obj, lock) \
-	if (!(obj)->gpuva.lock_dep_map) \
+	if (!WARN((obj)->gpuva.lock_dep_map, \
+		  "GEM GPUVA lock should be set only once.")) \
 		(obj)->gpuva.lock_dep_map = &(lock)->dep_map
 #define drm_gem_gpuva_assert_lock_held(obj) \
-	lockdep_assert(lock_is_held((obj)->gpuva.lock_dep_map))
+	lockdep_assert((obj)->gpuva.lock_dep_map ? \
+		       lock_is_held((obj)->gpuva.lock_dep_map) : \
+		       dma_resv_held((obj)->resv))
 #else
 #define drm_gem_gpuva_set_lock(obj, lock) do {} while (0)
 #define drm_gem_gpuva_assert_lock_held(obj) do {} while (0)
@@ -573,11 +575,12 @@ int drm_gem_evict(struct drm_gem_object *obj);
  *
  * Calling this function is only necessary for drivers intending to support the
  * &drm_driver_feature DRIVER_GEM_GPUVA.
+ *
+ * See also drm_gem_gpuva_set_lock().
  */
 static inline void drm_gem_gpuva_init(struct drm_gem_object *obj)
 {
 	INIT_LIST_HEAD(&obj->gpuva.list);
-	drm_gem_gpuva_set_lock(obj, &obj->resv->lock.base);
 }
 
 /**
-- 
2.41.0

