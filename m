Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE95770909
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjHDT2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHDT17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:27:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2363C1BE;
        Fri,  4 Aug 2023 12:27:58 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:15:bae9::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7146A66071C9;
        Fri,  4 Aug 2023 20:27:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691177277;
        bh=LMhH1wONP8tWsG5O7bN1Ursg3fodt2Yw3qtQ4QgE28o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kO/bGZBByva56tXgXep3stUzCOTEZd7QrH+nhQNG2r/9C2v1mBFRwMWow7BJLyWUA
         wkdP+wJtJJaS4ORjbyjWZS3RekHGYn0TPGLGu5Bbru8Zl1JLy+0n5/NsZFT7j5KjXy
         FdZbn3+JoXMbNM6bEh4AdTTcB8EWgBZEToX6sA5A5RSL1Qw4EmQEGgPMxXICJivKzp
         cmbRRNiKGbpSpBiviziniaJMdDeHmmJgVXZeMq8mysBd6tEKcmuMIpinO468/+eEWG
         54cYMcNWJIVfj1jh5K+JEfOqLNtDMVaDnPmTR2jOvrXP//CRYJYS8CfvgpWlooyeiu
         9prNN80hL+Esw==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] docs: uapi: media: Add common documentation of tiled NV15
Date:   Fri,  4 Aug 2023 15:27:35 -0400
Message-Id: <20230804192737.19016-4-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way we don't have to repeat over and over how the pixels are
packed in NV15.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 79 ++++++++++++++++---
 1 file changed, 68 insertions(+), 11 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 1d43532095c0..052927bd9396 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -373,10 +373,74 @@ two non-contiguous planes.
 Tiled NV15
 ----------
 
-``V4L2_PIX_FMT_NV15_4L4`` Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
-All components are packed without any padding between each other.
-As a side-effect, each group of 4 components are stored over 5 bytes
-(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
+Semi-planar 10-bit YUV 4:2:0 formats. All components are packed
+without any padding between each other. Each pixels occupy 15 bits
+and are usually stored in group of 4 components stored over 5 bytes
+(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes) or partitioned into
+upper 8 bit and lower 2 bits.
+
+.. flat-table:: Sample of 4 NV15 luma pixels
+    :header-rows:  2
+    :stub-columns: 0
+
+    * -
+      - 8
+      - 7
+      - 6
+      - 5
+      - 4
+      - 3
+      - 2
+      - 1
+      - 0
+    * - byte 0
+      - Y'\ :sub:`0:0`
+      - Y'\ :sub:`0:1`
+      - Y'\ :sub:`0:2`
+      - Y'\ :sub:`0:3`
+      - Y'\ :sub:`0:4`
+      - Y'\ :sub:`0:5`
+      - Y'\ :sub:`0:6`
+      - Y'\ :sub:`0:7`
+    * - byte 1
+      - Y'\ :sub:`0:8`
+      - Y'\ :sub:`0:9`
+      - Y'\ :sub:`1:0`
+      - Y'\ :sub:`1:1`
+      - Y'\ :sub:`1:2`
+      - Y'\ :sub:`1:3`
+      - Y'\ :sub:`1:4`
+      - Y'\ :sub:`1:5`
+    * - byte 2
+      - Y'\ :sub:`1:6`
+      - Y'\ :sub:`1:7`
+      - Y'\ :sub:`1:8`
+      - Y'\ :sub:`1:9`
+      - Y'\ :sub:`2:0`
+      - Y'\ :sub:`2:1`
+      - Y'\ :sub:`2:2`
+      - Y'\ :sub:`2:3`
+    * - byte 3
+      - Y'\ :sub:`2:4`
+      - Y'\ :sub:`2:5`
+      - Y'\ :sub:`2:6`
+      - Y'\ :sub:`2:7`
+      - Y'\ :sub:`2:8`
+      - Y'\ :sub:`2:9`
+      - Y'\ :sub:`3:0`
+      - Y'\ :sub:`3:1`
+    * - byte 4
+      - Y'\ :sub:`3:2`
+      - Y'\ :sub:`3:3`
+      - Y'\ :sub:`3:4`
+      - Y'\ :sub:`3:5`
+      - Y'\ :sub:`3:6`
+      - Y'\ :sub:`3:7`
+      - Y'\ :sub:`3:8`
+      - Y'\ :sub:`3:9`
+
+``V4L2_PIX_FMT_NV15_4L4`` stores pixels in 4x4 tiles, and stores tiles linearly
+in memory.
 
 ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
 10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
@@ -385,13 +449,6 @@ The image height must be aligned to a multiple of 128.
 The layouts of the luma and chroma planes are identical.
 Note the tile size is 8bytes multiplied by 128 bytes,
 it means that the low bits and high bits of one pixel may be in different tiles.
-The 10 bit pixels are packed, so 5 bytes contain 4 10-bit pixels layout like
-this (for luma):
-byte 0: Y0(bits 9-2)
-byte 1: Y0(bits 1-0) Y1(bits 9-4)
-byte 2: Y1(bits 3-0) Y2(bits 9-6)
-byte 3: Y2(bits 5-0) Y3(bits 9-8)
-byte 4: Y3(bits 7-0)
 
 ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
 two planes in one memory.
-- 
2.40.1

