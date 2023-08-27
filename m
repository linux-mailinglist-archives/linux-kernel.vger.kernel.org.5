Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB4878A0C2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 19:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjH0R4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 13:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjH0R4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 13:56:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1462102
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 10:56:10 -0700 (PDT)
Received: from workpc.. (109-252-153-31.dynamic.spd-mgts.ru [109.252.153.31])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 07E93660729C;
        Sun, 27 Aug 2023 18:56:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693158969;
        bh=M5/xgmgYN0s36JVYHmGw/X427TQVf2NMGXsEGCVdXvc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=auSupVBWNLHWAWDVXWjgaW/AZJUx8stY7+syvdibV1xVrcSxOL5j4DHNZBO9JXHKJ
         iqALbtRa7tjggEC4KHp+M0/5uS+w0FnG1c6zwai1Eois9bFQRHq6ZxJlIz/gEvbwxV
         xIwLk4Nqs0yutZZ0BVs4gyRz6O2inG8QTQi01tA4D4Ov/q2H1DbjmY32nfDYDEToim
         yDj3RQSqElgNj+9SRbx0D9FS0IKfT+SoH59si8XXKTmqVo5OrGJenUBhVs7U1EcGZw
         LI1VPszTF93y5GByRJxiEzLnp6xM/g2rEJb3yLQ1gRu3j41GNIMmRzTLDgnLwBQkFM
         9rzLK43Ye7clw==
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
Subject: [PATCH v15 11/23] dma-resv: Add kref_put_dma_resv()
Date:   Sun, 27 Aug 2023 20:54:37 +0300
Message-ID: <20230827175449.1766701-12-dmitry.osipenko@collabora.com>
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

Add simple kref_put_dma_resv() helper that wraps around kref_put_ww_mutex()
for drivers that needs to lock dma-resv on kref_put().

It's not possible to easily add this helper to kref.h because of the
headers inclusion dependency, hence add it to dma-resv.h.

Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
---
 include/linux/dma-resv.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index 8d0e34dad446..c5cf302e4194 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -41,6 +41,7 @@
 
 #include <linux/ww_mutex.h>
 #include <linux/dma-fence.h>
+#include <linux/kref.h>
 #include <linux/slab.h>
 #include <linux/seqlock.h>
 #include <linux/rcupdate.h>
@@ -464,6 +465,14 @@ static inline void dma_resv_unlock(struct dma_resv *obj)
 	ww_mutex_unlock(&obj->lock);
 }
 
+static inline int kref_put_dma_resv(struct kref *kref,
+				    void (*release)(struct kref *kref),
+				    struct dma_resv *resv,
+				    struct ww_acquire_ctx *ctx)
+{
+	return kref_put_ww_mutex(kref, release, &resv->lock, ctx);
+}
+
 void dma_resv_init(struct dma_resv *obj);
 void dma_resv_fini(struct dma_resv *obj);
 int dma_resv_reserve_fences(struct dma_resv *obj, unsigned int num_fences);
-- 
2.41.0

