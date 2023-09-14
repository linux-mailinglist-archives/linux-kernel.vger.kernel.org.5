Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A067A0896
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbjINPHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240760AbjINPHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:07:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0072E1AE;
        Thu, 14 Sep 2023 08:07:42 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:15:bae9::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B9916607346;
        Thu, 14 Sep 2023 16:07:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694704061;
        bh=Z1TdW3UGd+wLMJ7r5K88qHk1ygH+lB8tB04DHSYcEAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fez6uwEM/0+sbgrGWw24hDtX7QRinNJs7rz8YHNRjsccYwp+fGOoCxBEG6LhBWYJa
         miJU8QfvFEJVZ+J4EaVdJhKw8FEtfgss3SW7vsMvY1LmgYSmbRgA/z6C/lc1/m79qA
         MeLJ58m2VccgSys5dMZiGmycx82jHpuiw5+nB/VFXeEaqED29n6hpY9BThUeF1/M8p
         atRmUdprKV9eFdZ6k5bJ0WuymIaSbsKfCBKQPNEh9kMpTXo812nXq9oLdDSuJOcnsE
         TVms6Qm0TurM7tmTjydLX0h/BrTBSyb/Vd0LKDC7Y7XxXF7MFkuYSG3/BMUz1TKFgA
         ofc5KILqWYUTQ==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] docs: uapi: media: Add common documentation of tiled NV15
Date:   Thu, 14 Sep 2023 11:06:49 -0400
Message-Id: <20230914150651.3114134-4-nicolas.dufresne@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
References: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This way we don't have to repeat over and over how the pixels are
packed in NV15.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../media/v4l/pixfmt-yuv-planar.rst           | 144 ++++++++++++++++--
 1 file changed, 131 insertions(+), 13 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 1d43532095c07..2f0e0c97870b2 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -373,25 +373,143 @@ two non-contiguous planes.
 Tiled NV15
 ----------
 
-``V4L2_PIX_FMT_NV15_4L4`` Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
-All components are packed without any padding between each other.
-As a side-effect, each group of 4 components are stored over 5 bytes
-(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
+Semi-planar 10-bit YUV 4:2:0 formats. All components are packed
+without any padding between each other. Each components group occupy 15
+bits and are usually stored in group of 4 components stored over 5 bytes
+(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes) or partitioned into
+upper 8 bit and lower 2 bits. The final arrangement will vary depending if
+the hardware operated in little or big endian.
+
+.. flat-table:: Little endian sample of 4 NV15 luma pixels
+    :header-rows:  1
+    :stub-columns: 1
+
+    * - Bit
+      - 7
+      - 6
+      - 5
+      - 4
+      - 3
+      - 2
+      - 1
+      - 0
+    * - Byte 0
+      - Y'\ :sub:`0:7`
+      - Y'\ :sub:`0:6`
+      - Y'\ :sub:`0:5`
+      - Y'\ :sub:`0:4`
+      - Y'\ :sub:`0:3`
+      - Y'\ :sub:`0:2`
+      - Y'\ :sub:`0:1`
+      - Y'\ :sub:`0:0`
+    * - Byte 1
+      - Y'\ :sub:`1:5`
+      - Y'\ :sub:`1:4`
+      - Y'\ :sub:`1:3`
+      - Y'\ :sub:`1:2`
+      - Y'\ :sub:`1:1`
+      - Y'\ :sub:`1:0`
+      - Y'\ :sub:`0:9`
+      - Y'\ :sub:`0:8`
+    * - Byte 2
+      - Y'\ :sub:`2:3`
+      - Y'\ :sub:`2:2`
+      - Y'\ :sub:`2:1`
+      - Y'\ :sub:`2:0`
+      - Y'\ :sub:`1:9`
+      - Y'\ :sub:`1:8`
+      - Y'\ :sub:`1:7`
+      - Y'\ :sub:`1:6`
+    * - Byte 3
+      - Y'\ :sub:`3:1`
+      - Y'\ :sub:`3:0`
+      - Y'\ :sub:`2:9`
+      - Y'\ :sub:`2:8`
+      - Y'\ :sub:`2:7`
+      - Y'\ :sub:`2:6`
+      - Y'\ :sub:`2:5`
+      - Y'\ :sub:`2:4`
+    * - Byte 4
+      - Y'\ :sub:`3:9`
+      - Y'\ :sub:`3:8`
+      - Y'\ :sub:`3:7`
+      - Y'\ :sub:`3:6`
+      - Y'\ :sub:`3:5`
+      - Y'\ :sub:`3:4`
+      - Y'\ :sub:`3:3`
+      - Y'\ :sub:`3:2`
+
+.. flat-table:: Big endian sample of 4 NV15 luma pixels
+    :header-rows:  1
+    :stub-columns: 1
+
+    * - Bit
+      - 7
+      - 6
+      - 5
+      - 4
+      - 3
+      - 2
+      - 1
+      - 0
+    * - Byte 0
+      - Y'\ :sub:`0:9`
+      - Y'\ :sub:`0:8`
+      - Y'\ :sub:`0:7`
+      - Y'\ :sub:`0:6`
+      - Y'\ :sub:`0:5`
+      - Y'\ :sub:`0:4`
+      - Y'\ :sub:`0:3`
+      - Y'\ :sub:`0:2`
+    * - Byte 1
+      - Y'\ :sub:`0:1`
+      - Y'\ :sub:`0:0`
+      - Y'\ :sub:`1:9`
+      - Y'\ :sub:`1:8`
+      - Y'\ :sub:`1:7`
+      - Y'\ :sub:`1:6`
+      - Y'\ :sub:`1:5`
+      - Y'\ :sub:`1:4`
+    * - Byte 2
+      - Y'\ :sub:`1:3`
+      - Y'\ :sub:`1:2`
+      - Y'\ :sub:`1:1`
+      - Y'\ :sub:`1:0`
+      - Y'\ :sub:`2:9`
+      - Y'\ :sub:`2:8`
+      - Y'\ :sub:`2:7`
+      - Y'\ :sub:`2:6`
+    * - Byte 3
+      - Y'\ :sub:`2:5`
+      - Y'\ :sub:`2:4`
+      - Y'\ :sub:`2:3`
+      - Y'\ :sub:`2:2`
+      - Y'\ :sub:`2:1`
+      - Y'\ :sub:`2:0`
+      - Y'\ :sub:`3:9`
+      - Y'\ :sub:`3:8`
+    * - Byte 4
+      - Y'\ :sub:`3:7`
+      - Y'\ :sub:`3:6`
+      - Y'\ :sub:`3:5`
+      - Y'\ :sub:`3:4`
+      - Y'\ :sub:`3:3`
+      - Y'\ :sub:`3:2`
+      - Y'\ :sub:`3:1`
+      - Y'\ :sub:`3:0`
+
+``V4L2_PIX_FMT_NV15_4L4`` stores pixels in 4x4 tiles, and stores tiles linearly
+in memory. The tiles contains little endian NV15 data.
 
 ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
 10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
 the data is arranged in big endian order.
+
 The image height must be aligned to a multiple of 128.
 The layouts of the luma and chroma planes are identical.
-Note the tile size is 8bytes multiplied by 128 bytes,
-it means that the low bits and high bits of one pixel may be in different tiles.
-The 10 bit pixels are packed, so 5 bytes contain 4 10-bit pixels layout like
-this (for luma):
-byte 0: Y0(bits 9-2)
-byte 1: Y0(bits 1-0) Y1(bits 9-4)
-byte 2: Y1(bits 3-0) Y2(bits 9-6)
-byte 3: Y2(bits 5-0) Y3(bits 9-8)
-byte 4: Y3(bits 7-0)
+Note the tile size is 8 bytes multiplied by 128 bytes,
+it means that the low bits and high bits of one pixel may
+be in different tiles.
 
 ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
 two planes in one memory.
-- 
2.40.1

