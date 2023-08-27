Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7904178A0C1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjH0R4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjH0R4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:56:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259B102
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:56:08 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3CE0D6603102;
        Sun, 27 Aug 2023 18:56:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693158967;
        bh=n0kkcz8juKwSjNPbXLfDiIJlOKY0+tcGaJqGLsx5hTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Alg5JnsKjDIWjT6Aixw2aHXpBSqCqXy2+Ld4MIuRsWqHHxbUtCVRj7trHoq3wWblp
         oH8AfzkEZmEx3D+wXq+hXvIVU/qP/i0np8yK4SXRPeoJm7SQR4SnjAachAknuwYMtl
         s8eMuuR8I89BrP4ims1nhUn1/HcuIv0S+kJRufKPfxth0yN05hTwaIJnF4H5LdmC4f
         Nc40AnviggFijAcxyRSYhCJG34AhburJoG/83P8gQXTEvyBmoTpxAm8jmEVFJQ5SlV
         dmQsVfWs/wBLJdmin/+Q2EzhrvS7fYpilIgPK5oMzzGXbLQXkGvNDRdjno+LlEq5Dw
         /6UsLJdSonicw==
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
To:     David Airlie <airlied@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Qiang Yu <yuq825@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Emma Anholt <emma@anholt.net>, Melissa Wen <mwen@igalia.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, virtualization@lists.linux-foundation.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH v15 10/23] locking/refcount, kref: Add kref_put_ww_mutex()
Date:   Sun, 27 Aug 2023 20:54:36 +0300
Message-ID: <20230827175449.1766701-11-dmitry.osipenko@collabora.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
References: <20230827175449.1766701-1-dmitry.osipenko@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce kref_put_ww_mutex() helper that will handle the wait-wound
mutex auto-locking on kref_put(). This helper is wanted by DRM drivers
that extensively use dma-reservation locking which in turns uses ww-mutex.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/linux/kref.h     | 12 ++++++++++++
 include/linux/refcount.h |  5 +++++
 lib/refcount.c           | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)

diff --git a/include/linux/kref.h b/include/linux/kref.h
index d32e21a2538c..b2d8dc6e9ae0 100644
--- a/include/linux/kref.h
+++ b/include/linux/kref.h
@@ -90,6 +90,18 @@ static inline int kref_put_lock(struct kref *kref,
 	return 0;
 }
 
+static inline int kref_put_ww_mutex(struct kref *kref,
+				    void (*release)(struct kref *kref),
+				    struct ww_mutex *lock,
+				    struct ww_acquire_ctx *ctx)
+{
+	if (refcount_dec_and_ww_mutex_lock(&kref->refcount, lock, ctx)) {
+		release(kref);
+		return 1;
+	}
+	return 0;
+}
+
 /**
  * kref_get_unless_zero - Increment refcount for object unless it is zero.
  * @kref: object.
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index a62fcca97486..be9ad272bc77 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -99,6 +99,8 @@
 #include <linux/spinlock_types.h>
 
 struct mutex;
+struct ww_mutex;
+struct ww_acquire_ctx;
 
 /**
  * typedef refcount_t - variant of atomic_t specialized for reference counts
@@ -366,4 +368,7 @@ extern __must_check bool refcount_dec_and_lock(refcount_t *r, spinlock_t *lock)
 extern __must_check bool refcount_dec_and_lock_irqsave(refcount_t *r,
 						       spinlock_t *lock,
 						       unsigned long *flags) __cond_acquires(lock);
+extern __must_check bool refcount_dec_and_ww_mutex_lock(refcount_t *r,
+							struct ww_mutex *lock,
+							struct ww_acquire_ctx *ctx) __cond_acquires(&lock->base);
 #endif /* _LINUX_REFCOUNT_H */
diff --git a/lib/refcount.c b/lib/refcount.c
index a207a8f22b3c..3f6fd0ceed02 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -6,6 +6,7 @@
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/spinlock.h>
+#include <linux/ww_mutex.h>
 #include <linux/bug.h>
 
 #define REFCOUNT_WARN(str)	WARN_ONCE(1, "refcount_t: " str ".\n")
@@ -184,3 +185,36 @@ bool refcount_dec_and_lock_irqsave(refcount_t *r, spinlock_t *lock,
 	return true;
 }
 EXPORT_SYMBOL(refcount_dec_and_lock_irqsave);
+
+/**
+ * refcount_dec_and_ww_mutex_lock - return holding ww-mutex if able to
+ *                                  decrement refcount to 0
+ * @r: the refcount
+ * @lock: the ww-mutex to be locked
+ * @ctx: wait-wound context
+ *
+ * Similar to atomic_dec_and_lock(), it will WARN on underflow and fail to
+ * decrement when saturated at REFCOUNT_SATURATED.
+ *
+ * Provides release memory ordering, such that prior loads and stores are done
+ * before, and provides a control dependency such that free() must come after.
+ * See the comment on top.
+ *
+ * Return: true and hold ww-mutex lock if able to decrement refcount to 0,
+ *         false otherwise
+ */
+bool refcount_dec_and_ww_mutex_lock(refcount_t *r, struct ww_mutex *lock,
+				    struct ww_acquire_ctx *ctx)
+{
+	if (refcount_dec_not_one(r))
+		return false;
+
+	ww_mutex_lock(lock, ctx);
+	if (!refcount_dec_and_test(r)) {
+		ww_mutex_unlock(lock);
+		return false;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL(refcount_dec_and_ww_mutex_lock);
-- 
2.41.0

