Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C28808D54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443577AbjLGPtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 10:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443596AbjLGPth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 10:49:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A3B10F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 07:49:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35047C433CA;
        Thu,  7 Dec 2023 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701964182;
        bh=o+4LyKPBmfDMs1sf7aMWTAE6JRxkm0AE05nsfg2fljw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=XZqQ+ka+/MlIBjCY3EYHiMES5EhgKGNft2/dTIBPu2nBkophRfwKfoT1OGxqueaIe
         8mGPxFSlXKfPXncPUhYaMQPz+47hGmB79XpkIciIgSM0987VxkQ6UCieNZ7UJtFMpx
         MNImHJbfcBxxiWqqnHi8t+EjngpAY8ryBGU9ItAILrPxkG+Rp+VE/G4O192OT+Hv7K
         pjS5+cZeCJXwO9VS5/oVkFSqIe2gkI2M9lj+Z2cULPwXSbbcsQ3vO16S+WTecMYdgw
         E8cfDOJ/3/Bv8V8ZDTrWOjzwrv9Db5wVtmHenh1vE4K0VZqfge+ImBiLgG+Nusndxm
         B38q0NcK0TDAw==
From:   Maxime Ripard <mripard@kernel.org>
Date:   Thu, 07 Dec 2023 16:49:27 +0100
Subject: [PATCH v5 04/44] drm/tests: Add helper to create mock crtc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231207-kms-hdmi-connector-state-v5-4-6538e19d634d@kernel.org>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
In-Reply-To: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3793; i=mripard@kernel.org;
 h=from:subject:message-id; bh=o+4LyKPBmfDMs1sf7aMWTAE6JRxkm0AE05nsfg2fljw=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDKmFL1sszny8KnR1GddFp59bU0J2Gh+JfLaN61tH1O3w/
 mBR3/0/O0pZGMS4GGTFFFlihM2XxJ2a9bqTjW8ezBxWJpAhDFycAjAR92yG/wXne76WJdYyzd7m
 OfGL/VPWRxvrOLWzHX6Xavb47GgJ5Wf47/LjSFLOYq7cSYyljWrL5TrvFm+a7X2zXnLrBVY196e
 pLAA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're going to need a full-blown, functional, KMS device to test more
components of the atomic modesetting infrastructure.

Let's add a new helper to create a dumb, mocked, CRTC. By default it
will create a CRTC relying only on the default helpers, but drivers are
free to deviate from that.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tests/drm_kunit_helpers.c | 62 +++++++++++++++++++++++++++++++
 include/drm/drm_kunit_helpers.h           | 10 +++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_kunit_helpers.c b/drivers/gpu/drm/tests/drm_kunit_helpers.c
index e0778a7ec260..ca513235b5e2 100644
--- a/drivers/gpu/drm/tests/drm_kunit_helpers.c
+++ b/drivers/gpu/drm/tests/drm_kunit_helpers.c
@@ -321,5 +321,67 @@ drm_kunit_helper_create_primary_plane(struct kunit *test,
 }
 EXPORT_SYMBOL_GPL(drm_kunit_helper_create_primary_plane);
 
+static const struct drm_crtc_helper_funcs default_crtc_helper_funcs = {
+};
+
+static const struct drm_crtc_funcs default_crtc_funcs = {
+	.atomic_destroy_state   = drm_atomic_helper_crtc_destroy_state,
+	.atomic_duplicate_state = drm_atomic_helper_crtc_duplicate_state,
+	.reset                  = drm_atomic_helper_crtc_reset,
+};
+
+/**
+ * drm_kunit_helper_create_crtc - Creates a mock CRTC for a KUnit test
+ * @test: The test context object
+ * @drm: The device to alloc the plane for
+ * @primary: Primary plane for CRTC
+ * @cursor: Cursor plane for CRTC. Optional.
+ * @funcs: Callbacks for the new plane. Optional.
+ * @helper_funcs: Helpers callbacks for the new plane. Optional.
+ *
+ * This allocates and initializes a mock struct &drm_crtc meant to be
+ * part of a mock device for a KUnit test.
+ *
+ * Resources will be cleaned up automatically.
+ *
+ * @funcs will default to the default helpers implementations.
+ * @helper_funcs will default to an empty implementation.
+ *
+ * Returns:
+ * A pointer to the new CRTC, or an ERR_PTR() otherwise.
+ */
+struct drm_crtc *
+drm_kunit_helper_create_crtc(struct kunit *test,
+			     struct drm_device *drm,
+			     struct drm_plane *primary,
+			     struct drm_plane *cursor,
+			     const struct drm_crtc_funcs *funcs,
+			     const struct drm_crtc_helper_funcs *helper_funcs)
+{
+	struct drm_crtc *crtc;
+	int ret;
+
+	if (!funcs)
+		funcs = &default_crtc_funcs;
+
+	if (!helper_funcs)
+		helper_funcs = &default_crtc_helper_funcs;
+
+	crtc = drmm_kzalloc(drm, sizeof(*crtc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, crtc);
+
+	ret = drmm_crtc_init_with_planes(drm, crtc,
+					 primary,
+					 cursor,
+					 funcs,
+					 NULL);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	drm_crtc_helper_add(crtc, helper_funcs);
+
+	return crtc;
+}
+EXPORT_SYMBOL_GPL(drm_kunit_helper_create_crtc);
+
 MODULE_AUTHOR("Maxime Ripard <maxime@cerno.tech>");
 MODULE_LICENSE("GPL");
diff --git a/include/drm/drm_kunit_helpers.h b/include/drm/drm_kunit_helpers.h
index 38667d624aa8..6e99627edf45 100644
--- a/include/drm/drm_kunit_helpers.h
+++ b/include/drm/drm_kunit_helpers.h
@@ -9,6 +9,8 @@
 
 #include <kunit/test.h>
 
+struct drm_crtc_funcs;
+struct drm_crtc_helper_funcs;
 struct drm_device;
 struct drm_plane_funcs;
 struct drm_plane_helper_funcs;
@@ -110,4 +112,12 @@ drm_kunit_helper_create_primary_plane(struct kunit *test,
 				      unsigned int num_formats,
 				      const uint64_t *modifiers);
 
+struct drm_crtc *
+drm_kunit_helper_create_crtc(struct kunit *test,
+			     struct drm_device *drm,
+			     struct drm_plane *primary,
+			     struct drm_plane *cursor,
+			     const struct drm_crtc_funcs *funcs,
+			     const struct drm_crtc_helper_funcs *helper_funcs);
+
 #endif // DRM_KUNIT_HELPERS_H_

-- 
2.43.0

