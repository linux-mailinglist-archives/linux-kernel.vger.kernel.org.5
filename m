Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D237930EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244022AbjIEV1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjIEV1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:27:50 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02D3133
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:27:46 -0700 (PDT)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx1.riseup.net (Postfix) with ESMTPS id 4RgJWQ0hrJzDrFS;
        Tue,  5 Sep 2023 21:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1693949266; bh=O9DRZmRJ6X7Y0wx+dHoCRLlOLHCdEmlgHTvRhrgkZy4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pD7lLpgvfnO/A46Oxv3mKnnGPx4bPX02WDlKYGNflw0R4bWT1ktiCcCHHzUK6CFM7
         zOE0u9VAuxm+cmgWrMP2nasZJQ0AwlV4XyVSS836HKgfRx1GA/hzv+rfJiKx8oMZXb
         XXIeuBd3Fkfqx2Nj8+pT0Vjo88WwNnkRz8+caYc8=
X-Riseup-User-ID: C47F138DBD5AEB6B625973324429E158810355E60129A9403447C0A979A0EA8C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4RgJWK44qXzFpyg;
        Tue,  5 Sep 2023 21:27:41 +0000 (UTC)
From:   Arthur Grillo <arthurgrillo@riseup.net>
Date:   Tue, 05 Sep 2023 18:27:09 -0300
Subject: [PATCH v2 1/2] drm/tests: Add calls to drm_fb_blit() on supported
 format conversion tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-final-gsoc-v2-1-b52e8cb068ea@riseup.net>
References: <20230905-final-gsoc-v2-0-b52e8cb068ea@riseup.net>
In-Reply-To: <20230905-final-gsoc-v2-0-b52e8cb068ea@riseup.net>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     tales.aparecida@gmail.com, andrealmeid@riseup.net,
        mairacanal@riseup.net, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arthur Grillo <arthurgrillo@riseup.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a call to drm_fb_blit() on existing format conversion tests that
has support.

Signed-off-by: Arthur Grillo <arthurgrillo@riseup.net>
---
 drivers/gpu/drm/tests/drm_format_helper_test.c | 142 +++++++++++++++++++++++++
 1 file changed, 142 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 79bc9d4bbd71..b888f7334510 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -643,6 +643,18 @@ static void drm_test_fb_xrgb8888_to_rgb565(struct kunit *test)
 	drm_fb_xrgb8888_to_rgb565(&dst, &result->dst_pitch, &src, &fb, &params->clip, true);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected_swab, dst_size);
+
+	buf = dst.vaddr;
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result = 0;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGB565, &src, &fb, &params->clip);
+
+	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_xrgb1555(struct kunit *test)
@@ -677,6 +689,18 @@ static void drm_test_fb_xrgb8888_to_xrgb1555(struct kunit *test)
 	drm_fb_xrgb8888_to_xrgb1555(&dst, dst_pitch, &src, &fb, &params->clip);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result = 0;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB1555, &src, &fb, &params->clip);
+
+	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_argb1555(struct kunit *test)
@@ -711,6 +735,18 @@ static void drm_test_fb_xrgb8888_to_argb1555(struct kunit *test)
 	drm_fb_xrgb8888_to_argb1555(&dst, dst_pitch, &src, &fb, &params->clip);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result = 0;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB1555, &src, &fb, &params->clip);
+
+	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_rgba5551(struct kunit *test)
@@ -745,6 +781,18 @@ static void drm_test_fb_xrgb8888_to_rgba5551(struct kunit *test)
 	drm_fb_xrgb8888_to_rgba5551(&dst, dst_pitch, &src, &fb, &params->clip);
 	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result = 0;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGBA5551, &src, &fb, &params->clip);
+
+	buf = le16buf_to_cpu(test, (__force const __le16 *)buf, dst_size / sizeof(__le16));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_rgb888(struct kunit *test)
@@ -782,6 +830,16 @@ static void drm_test_fb_xrgb8888_to_rgb888(struct kunit *test)
 
 	drm_fb_xrgb8888_to_rgb888(&dst, dst_pitch, &src, &fb, &params->clip);
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result = 0;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_RGB888, &src, &fb, &params->clip);
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_argb8888(struct kunit *test)
@@ -816,6 +874,18 @@ static void drm_test_fb_xrgb8888_to_argb8888(struct kunit *test)
 	drm_fb_xrgb8888_to_argb8888(&dst, dst_pitch, &src, &fb, &params->clip);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result = 0;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB8888, &src, &fb, &params->clip);
+
+	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
@@ -850,6 +920,17 @@ static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
 	drm_fb_xrgb8888_to_xrgb2101010(&dst, dst_pitch, &src, &fb, &params->clip);
 	buf = le32buf_to_cpu(test, buf, dst_size / sizeof(u32));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result = 0;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB2101010, &src, &fb,
+				  &params->clip);
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_argb2101010(struct kunit *test)
@@ -884,6 +965,19 @@ static void drm_test_fb_xrgb8888_to_argb2101010(struct kunit *test)
 	drm_fb_xrgb8888_to_argb2101010(&dst, dst_pitch, &src, &fb, &params->clip);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result = 0;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_ARGB2101010, &src, &fb,
+				  &params->clip);
+
+	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 static void drm_test_fb_xrgb8888_to_mono(struct kunit *test)
@@ -951,6 +1045,41 @@ static void drm_test_fb_swab(struct kunit *test)
 	drm_fb_swab(&dst, dst_pitch, &src, &fb, &params->clip, false);
 	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
 	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr; /* restore original value of buf */
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	int blit_result;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB8888 | DRM_FORMAT_BIG_ENDIAN,
+				  &src, &fb, &params->clip);
+	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr;
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_BGRX8888, &src, &fb, &params->clip);
+	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
+
+	buf = dst.vaddr;
+	memset(buf, 0, TEST_BUF_SIZE);
+
+	struct drm_format_info mock_format = *fb.format;
+
+	mock_format.format |= DRM_FORMAT_BIG_ENDIAN;
+	fb.format = &mock_format;
+
+	blit_result = drm_fb_blit(&dst, dst_pitch, DRM_FORMAT_XRGB8888, &src, &fb, &params->clip);
+	buf = le32buf_to_cpu(test, (__force const __le32 *)buf, dst_size / sizeof(u32));
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
 }
 
 struct clip_offset_case {
@@ -1543,6 +1672,19 @@ static void drm_test_fb_memcpy(struct kunit *test)
 		KUNIT_EXPECT_MEMEQ_MSG(test, buf[i], expected[i], dst_size[i],
 				       "Failed expectation on plane %zu", i);
 	}
+
+	memset(*buf, 0, TEST_BUF_SIZE * DRM_FORMAT_MAX_PLANES);
+
+	int blit_result;
+
+	blit_result = drm_fb_blit(dst, dst_pitches, params->format, src, &fb, &params->clip);
+
+	KUNIT_EXPECT_FALSE(test, blit_result);
+	for (size_t i = 0; i < fb.format->num_planes; i++) {
+		expected[i] = cpubuf_to_le32(test, params->expected[i], TEST_BUF_SIZE);
+		KUNIT_EXPECT_MEMEQ_MSG(test, buf[i], expected[i], dst_size[i],
+				       "Failed expectation on plane %zu", i);
+	}
 }
 
 static struct kunit_case drm_format_helper_test_cases[] = {

-- 
2.41.0

