Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF2772DF1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjHGSfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjHGSfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:35:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F27171A;
        Mon,  7 Aug 2023 11:35:40 -0700 (PDT)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7FD7866071D9;
        Mon,  7 Aug 2023 19:35:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691433337;
        bh=dPnDNV7LmH7OYgmsw2Nn/NUMcXyai/QmLxO1CX3FTIs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WcVy0f++PYVX6fMJ4f1NB1VDa++tfy8JTOdOFw1tZSHHpCqCNmG1PPjU0ivsDpa+o
         a+FhmYk9Bi/bOpofFg8r/fSHe5I4kePk+TEO9j7Tz+QhgQ7WzvYJFaycbTTVEyG5uE
         ZNZD0BzlGNhHD4e0TACRHBc7/fH5J5J4CbBF21u1E2NEnIK51icHxPf1HFnYQPmIav
         gGpgvhxEn6+50P5cApntkvAMy1WowjGt3+lz6XGH3ALsarfsZeHoz6pPSirlG1q7wq
         pBcmj5xUu4yWR8Oo/+NiUSdmtK4JLp/oxnnJn6LJf/D4b7yMDYiPlVEtH5dO7h1R2n
         bXXE8S3jNUUjw==
Message-ID: <c26a69d9-5fd4-365f-9291-ae223158a662@collabora.com>
Date:   Mon, 7 Aug 2023 20:35:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/5] docs: uapi: media: Document Mediatek 10bit tiled
 formats
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
 <20230804192737.19016-6-nicolas.dufresne@collabora.com>
Content-Language: en-US
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230804192737.19016-6-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

W dniu 4.08.2023 o 21:27, Nicolas Dufresne pisze:
> Document V4L2_PIX_FMT_MT2110T and V4L2_PIX_FMT_MT2110R. These two
> formats are nearly identical, reusing MM21 format and expending it
> by inserting chunk of 16 bytes of lower 2 bit pixel data after each
> chunk of 64 bytes higher 8 bit of data.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>   .../media/v4l/pixfmt-reserved.rst             |  13 --
>   .../media/v4l/pixfmt-yuv-planar.rst           | 122 ++++++++++++++++++
>   2 files changed, 122 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index 296ad2025e8d..58f6ae25b2e7 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -275,19 +275,6 @@ please make a proposal on the linux-media mailing list.
>   
>           Decoder's implementation can be found here,
>           `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`__
> -    * .. _V4L2-PIX-FMT-MT2110T:
> -
> -      - ``V4L2_PIX_FMT_MT2110T``
> -      - 'MT2110T'
> -      - This format is two-planar 10-Bit tile mode and having similitude with
> -        ``V4L2_PIX_FMT_MM21`` in term of alignment and tiling. Used for VP9, AV1
> -        and HEVC.
> -    * .. _V4L2-PIX-FMT-MT2110R:
> -
> -      - ``V4L2_PIX_FMT_MT2110R``
> -      - 'MT2110R'
> -      - This format is two-planar 10-Bit raster mode and having similitude with
> -        ``V4L2_PIX_FMT_MM21`` in term of alignment and tiling. Used for AVC.
>   .. raw:: latex
>   
>       \normalsize
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 052927bd9396..6ef5cd6bd9e2 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -144,6 +144,20 @@ All components are stored with the same number of bits per component.
>         - Cb, Cr
>         - Yes
>         - 4x4 tiles
> +    * - V4L2_PIX_FMT_MT2110T
> +      - 'MT2T'
> +      - 15
> +      - 4:2:0
> +      - Cb, Cr
> +      - No
> +      - 16x32 / 16x16 tiles tiled low bits
> +    * - V4L2_PIX_FMT_MT2110R
> +      - 'MT2R'
> +      - 15
> +      - 4:2:0
> +      - Cb, Cr
> +      - No
> +      - 16x32 / 16x16 tiles raster low bits
>       * - V4L2_PIX_FMT_NV16
>         - 'NV16'
>         - 8
> @@ -369,6 +383,8 @@ two non-contiguous planes.
>   .. _V4L2-PIX-FMT-NV15-4L4:
>   .. _V4L2-PIX-FMT-NV12M-10BE-8L128:
>   .. _V4L2-PIX-FMT-NV12-10BE-8L128:
> +.. _V4L2-PIX-FMT-MT2110T:
> +.. _V4L2-PIX-FMT-MT2110R:
>   
>   Tiled NV15
>   ----------
> @@ -453,6 +469,112 @@ it means that the low bits and high bits of one pixel may be in different tiles.
>   ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
>   two planes in one memory.
>   
> +``V4L2_PIX_FMT_MT2110T``` is one of Mediatek packed 10bit YUV 4:2:0 formats.
> +It is fully packed 10bit 4:2:0 format like NV15 (15 bits per pixel), except
> +that the lower two bits data is stored in separate partitions. The format is
> +composed of 16x32 luma tiles, and 16x16 chroma tiles. Each tiles have 640

Each tile is 640 bytes long, divided into 8 partitions of 80 bytes?

> +bytes separate in 8 partitions of 80 bytes each. The first 64 bytes represents

bytes represent? (plural)

> +the 8 most significant bits of pixel data. The remaining 16 bytes contains the

contain? (plural)

> +2 least significant of pixel data.

least significant bits?

Regards,

Andrzej


> +
> +.. kernel-figure:: mt2110t.svg
> +    :alt:    mt2110t.svg
> +    :align:  center
> +
> +    Layout of Example MT2110T Chroma Tile
> +
> +Filtering out the lower part of each partitions results in a valid
> +``V4L2_PIX_FMT_MM21`` frame. A partition is a sub-tile of size 16 x 4. The
> +lower two bits is said to be tiled since each bytes contains the lower two
> +bits of the column of for pixel matching the same index. The chroma tiles
> +only have 4 partitions.
> +
> +.. flat-table:: MT2110T LSB bits layout
> +    :header-rows:  1
> +    :stub-columns: 0
> +
> +    * -
> +      - start + 0
> +      - start + 1
> +      - . . .
> +      - start\ +\ 15
> +    * - bits 0:2
> +      - Y'\ :sub:`0:0`
> +      - Y'\ :sub:`0:1`
> +      - . . .
> +      - Y'\ :sub:`0:15`
> +    * - bits 2:3
> +      - Y'\ :sub:`1:0`
> +      - Y'\ :sub:`1:1`
> +      - . . .
> +      - Y'\ :sub:`1:15`
> +    * - bits 4:5
> +      - Y'\ :sub:`2:0`
> +      - Y'\ :sub:`2:1`
> +      - . . .
> +      - Y'\ :sub:`2:15`
> +    * - bits 6:7
> +      - Y'\ :sub:`3:0`
> +      - Y'\ :sub:`3:1`
> +      - . . .
> +      - Y'\ :sub:`3:15`
> +
> +``V4L2_PIX_FMT_MT2110R`` is identical to ``V4L2_PIX_FMT_MT2110T`` except that
> +the least significant two bits layout is in raster order. This means the first byte
> +contains 4 pixels of the first row, with 4 bytes per line.
> +
> +.. flat-table:: MT2110R LSB bits layout
> +    :header-rows:  1
> +    :stub-columns: 0
> +
> +    * -
> +      - b0
> +      -
> +      -
> +      -
> +      - ...
> +      - b3
> +    * - start + 0
> +      - Y'\ :sub:`0:0`
> +      - Y'\ :sub:`0:1`
> +      - Y'\ :sub:`0:2`
> +      - Y'\ :sub:`0:3`
> +      - ...
> +      - Y'\ :sub:`0:12`
> +      - Y'\ :sub:`0:13`
> +      - Y'\ :sub:`0:14`
> +      - Y'\ :sub:`0:15`
> +    * - start + 4
> +      - Y'\ :sub:`1:0`
> +      - Y'\ :sub:`1:1`
> +      - Y'\ :sub:`1:2`
> +      - Y'\ :sub:`1:3`
> +      - ...
> +      - Y'\ :sub:`1:12`
> +      - Y'\ :sub:`1:13`
> +      - Y'\ :sub:`1:14`
> +      - Y'\ :sub:`1:15`
> +    * - start + 8
> +      - Y'\ :sub:`2:0`
> +      - Y'\ :sub:`2:1`
> +      - Y'\ :sub:`2:2`
> +      - Y'\ :sub:`2:3`
> +      - ...
> +      - Y'\ :sub:`2:12`
> +      - Y'\ :sub:`2:13`
> +      - Y'\ :sub:`2:14`
> +      - Y'\ :sub:`2:15`
> +    * - start\ +\ 12
> +      - Y'\ :sub:`3:0`
> +      - Y'\ :sub:`3:1`
> +      - Y'\ :sub:`3:2`
> +      - Y'\ :sub:`3:3`
> +      - ...
> +      - Y'\ :sub:`3:12`
> +      - Y'\ :sub:`3:13`
> +      - Y'\ :sub:`3:14`
> +      - Y'\ :sub:`3:15`
> +
>   
>   .. _V4L2-PIX-FMT-NV16:
>   .. _V4L2-PIX-FMT-NV61:

