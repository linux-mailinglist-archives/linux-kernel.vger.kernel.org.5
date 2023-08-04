Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F6977090D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjHDT2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHDT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:28:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFA5E7;
        Fri,  4 Aug 2023 12:28:00 -0700 (PDT)
Received: from whitebuilder.lan (unknown [IPv6:2606:6d00:15:bae9::c73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EF8C066071BD;
        Fri,  4 Aug 2023 20:27:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691177279;
        bh=8/5SfF/HBdqSJinGjaWZ6eEDcCeD+eygD3VveqLdlW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDS9zxe6VkDNgulJeiUhBZEPGxDSDv2Ktwo1iGTdIvlSJ85EmuVbacN8+IPKaDnpH
         bDqG1t4jeWsLwZJ8inhBIhQ3VaABIGPqcviXVkfvzza7dsVMM9VKk7biAK6OGQPZip
         RIdB9drDytFeGiPw8xxghBAWCQdRqN9SLOCNF6N4kkJBNVLuD3ciLNDEWaRon8DUGY
         fcmgNASVLzlOgs805N3fdyz6ce/vGqlxWJbmZHc10/N1PO/x9eHSqcPQjZOijy1lU4
         mtvfxTJnCsnz8oHEiDWEyhVz1RHo+nA0a1m7XA1aQPICnJ6FxS4vHCYLTOxMj3X0dE
         Mf2u+g4VJaHiA==
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] docs: uapi: media: Document Mediatek 10bit tiled formats
Date:   Fri,  4 Aug 2023 15:27:37 -0400
Message-Id: <20230804192737.19016-6-nicolas.dufresne@collabora.com>
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

Document V4L2_PIX_FMT_MT2110T and V4L2_PIX_FMT_MT2110R. These two
formats are nearly identical, reusing MM21 format and expending it
by inserting chunk of 16 bytes of lower 2 bit pixel data after each
chunk of 64 bytes higher 8 bit of data.

Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
---
 .../media/v4l/pixfmt-reserved.rst             |  13 --
 .../media/v4l/pixfmt-yuv-planar.rst           | 122 ++++++++++++++++++
 2 files changed, 122 insertions(+), 13 deletions(-)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index 296ad2025e8d..58f6ae25b2e7 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -275,19 +275,6 @@ please make a proposal on the linux-media mailing list.
 
         Decoder's implementation can be found here,
         `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
-    * .. _V4L2-PIX-FMT-MT2110T:
-
-      - ``V4L2_PIX_FMT_MT2110T``
-      - 'MT2110T'
-      - This format is two-planar 10-Bit tile mode and having similitude with
-        ``V4L2_PIX_FMT_MM21`` in term of alignment and tiling. Used for VP9, AV1
-        and HEVC.
-    * .. _V4L2-PIX-FMT-MT2110R:
-
-      - ``V4L2_PIX_FMT_MT2110R``
-      - 'MT2110R'
-      - This format is two-planar 10-Bit raster mode and having similitude with
-        ``V4L2_PIX_FMT_MM21`` in term of alignment and tiling. Used for AVC.
 .. raw:: latex
 
     \normalsize
diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
index 052927bd9396..6ef5cd6bd9e2 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
@@ -144,6 +144,20 @@ All components are stored with the same number of bits per component.
       - Cb, Cr
       - Yes
       - 4x4 tiles
+    * - V4L2_PIX_FMT_MT2110T
+      - 'MT2T'
+      - 15
+      - 4:2:0
+      - Cb, Cr
+      - No
+      - 16x32 / 16x16 tiles tiled low bits
+    * - V4L2_PIX_FMT_MT2110R
+      - 'MT2R'
+      - 15
+      - 4:2:0
+      - Cb, Cr
+      - No
+      - 16x32 / 16x16 tiles raster low bits
     * - V4L2_PIX_FMT_NV16
       - 'NV16'
       - 8
@@ -369,6 +383,8 @@ two non-contiguous planes.
 .. _V4L2-PIX-FMT-NV15-4L4:
 .. _V4L2-PIX-FMT-NV12M-10BE-8L128:
 .. _V4L2-PIX-FMT-NV12-10BE-8L128:
+.. _V4L2-PIX-FMT-MT2110T:
+.. _V4L2-PIX-FMT-MT2110R:
 
 Tiled NV15
 ----------
@@ -453,6 +469,112 @@ it means that the low bits and high bits of one pixel may be in different tiles.
 ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
 two planes in one memory.
 
+``V4L2_PIX_FMT_MT2110T``` is one of Mediatek packed 10bit YUV 4:2:0 formats.
+It is fully packed 10bit 4:2:0 format like NV15 (15 bits per pixel), except
+that the lower two bits data is stored in separate partitions. The format is
+composed of 16x32 luma tiles, and 16x16 chroma tiles. Each tiles have 640
+bytes separate in 8 partitions of 80 bytes each. The first 64 bytes represents
+the 8 most significant bits of pixel data. The remaining 16 bytes contains the
+2 least significant of pixel data.
+
+.. kernel-figure:: mt2110t.svg
+    :alt:    mt2110t.svg
+    :align:  center
+
+    Layout of Example MT2110T Chroma Tile
+
+Filtering out the lower part of each partitions results in a valid
+``V4L2_PIX_FMT_MM21`` frame. A partition is a sub-tile of size 16 x 4. The
+lower two bits is said to be tiled since each bytes contains the lower two
+bits of the column of for pixel matching the same index. The chroma tiles
+only have 4 partitions.
+
+.. flat-table:: MT2110T LSB bits layout
+    :header-rows:  1
+    :stub-columns: 0
+
+    * -
+      - start + 0
+      - start + 1
+      - . . .
+      - start\ +\ 15
+    * - bits 0:2
+      - Y'\ :sub:`0:0`
+      - Y'\ :sub:`0:1`
+      - . . .
+      - Y'\ :sub:`0:15`
+    * - bits 2:3
+      - Y'\ :sub:`1:0`
+      - Y'\ :sub:`1:1`
+      - . . .
+      - Y'\ :sub:`1:15`
+    * - bits 4:5
+      - Y'\ :sub:`2:0`
+      - Y'\ :sub:`2:1`
+      - . . .
+      - Y'\ :sub:`2:15`
+    * - bits 6:7
+      - Y'\ :sub:`3:0`
+      - Y'\ :sub:`3:1`
+      - . . .
+      - Y'\ :sub:`3:15`
+
+``V4L2_PIX_FMT_MT2110R`` is identical to ``V4L2_PIX_FMT_MT2110T`` except that
+the least significant two bits layout is in raster order. This means the first byte
+contains 4 pixels of the first row, with 4 bytes per line.
+
+.. flat-table:: MT2110R LSB bits layout
+    :header-rows:  1
+    :stub-columns: 0
+
+    * -
+      - b0
+      -
+      -
+      -
+      - ...
+      - b3
+    * - start + 0
+      - Y'\ :sub:`0:0`
+      - Y'\ :sub:`0:1`
+      - Y'\ :sub:`0:2`
+      - Y'\ :sub:`0:3`
+      - ...
+      - Y'\ :sub:`0:12`
+      - Y'\ :sub:`0:13`
+      - Y'\ :sub:`0:14`
+      - Y'\ :sub:`0:15`
+    * - start + 4
+      - Y'\ :sub:`1:0`
+      - Y'\ :sub:`1:1`
+      - Y'\ :sub:`1:2`
+      - Y'\ :sub:`1:3`
+      - ...
+      - Y'\ :sub:`1:12`
+      - Y'\ :sub:`1:13`
+      - Y'\ :sub:`1:14`
+      - Y'\ :sub:`1:15`
+    * - start + 8
+      - Y'\ :sub:`2:0`
+      - Y'\ :sub:`2:1`
+      - Y'\ :sub:`2:2`
+      - Y'\ :sub:`2:3`
+      - ...
+      - Y'\ :sub:`2:12`
+      - Y'\ :sub:`2:13`
+      - Y'\ :sub:`2:14`
+      - Y'\ :sub:`2:15`
+    * - start\ +\ 12
+      - Y'\ :sub:`3:0`
+      - Y'\ :sub:`3:1`
+      - Y'\ :sub:`3:2`
+      - Y'\ :sub:`3:3`
+      - ...
+      - Y'\ :sub:`3:12`
+      - Y'\ :sub:`3:13`
+      - Y'\ :sub:`3:14`
+      - Y'\ :sub:`3:15`
+
 
 .. _V4L2-PIX-FMT-NV16:
 .. _V4L2-PIX-FMT-NV61:
-- 
2.40.1

