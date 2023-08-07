Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E347722E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjHGLlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjHGLl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:41:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583321FFB;
        Mon,  7 Aug 2023 04:38:35 -0700 (PDT)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1653E66071CF;
        Mon,  7 Aug 2023 12:37:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691408246;
        bh=t//jemkWdtKHj5sMxR9vF0Gs1A+Rfx78G+6Cdqob5J8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SXjzRIVbLx6EDCQ99IH5MSa0Y+g88OqDaXKgfbeKD1QC8e7/2d0iLlF8lNQd2pv+7
         cbNusFO6FqUkq27+t/BiNXf0r+OrVfJrO5PsuBMwWSSFla/yN7w6+0973AJBzyRTmn
         xqKHZh1riUEzgfOrm8J0VcaY6TNrMHkBDQxsItErV50+2F+Hyf35C+q7CJi3ovUdjR
         OgSzyo3XcML4OQ5AWRuOFWfE9DfzdtLIsNyYSQr1Qu6YINJP8VP66hB5bE27Q8GvG3
         GLQ7M0i7z5QWiOsXYc6BbbpP9RZ+XhEbe4L/Xx55Jxt4IixH6ib8V+AD3ZekZDDZ+K
         8d+ZW+n4tyI2Q==
Message-ID: <f5ede7a6-66ee-cf69-e1c9-2d75d8f37a02@collabora.com>
Date:   Mon, 7 Aug 2023 13:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/5] docs: uapi: media: Add common documentation of tiled
 NV15
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
 <20230804192737.19016-4-nicolas.dufresne@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230804192737.19016-4-nicolas.dufresne@collabora.com>
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
> This way we don't have to repeat over and over how the pixels are
> packed in NV15.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>   .../media/v4l/pixfmt-yuv-planar.rst           | 79 ++++++++++++++++---
>   1 file changed, 68 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 1d43532095c0..052927bd9396 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -373,10 +373,74 @@ two non-contiguous planes.
>   Tiled NV15
>   ----------
>   
> -``V4L2_PIX_FMT_NV15_4L4`` Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
> -All components are packed without any padding between each other.
> -As a side-effect, each group of 4 components are stored over 5 bytes
> -(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
> +Semi-planar 10-bit YUV 4:2:0 formats. All components are packed
> +without any padding between each other. Each pixels occupy 15 bits

Maybe "Each pixel group"?



> +and are usually stored in group of 4 components stored over 5 bytes
> +(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes) or partitioned into
> +upper 8 bit and lower 2 bits.
> +
> +.. flat-table:: Sample of 4 NV15 luma pixels
> +    :header-rows:  2
> +    :stub-columns: 0
> +
> +    * -
> +      - 8
> +      - 7
> +      - 6
> +      - 5
> +      - 4
> +      - 3
> +      - 2
> +      - 1
> +      - 0
> +    * - byte 0
> +      - Y'\ :sub:`0:0`
> +      - Y'\ :sub:`0:1`
> +      - Y'\ :sub:`0:2`
> +      - Y'\ :sub:`0:3`
> +      - Y'\ :sub:`0:4`
> +      - Y'\ :sub:`0:5`
> +      - Y'\ :sub:`0:6`
> +      - Y'\ :sub:`0:7`

So byte 0 contains Y0, bits 0..7 but then...

> +    * - byte 1
> +      - Y'\ :sub:`0:8`
> +      - Y'\ :sub:`0:9`
> +      - Y'\ :sub:`1:0`
> +      - Y'\ :sub:`1:1`
> +      - Y'\ :sub:`1:2`
> +      - Y'\ :sub:`1:3`
> +      - Y'\ :sub:`1:4`
> +      - Y'\ :sub:`1:5`
> +    * - byte 2
> +      - Y'\ :sub:`1:6`
> +      - Y'\ :sub:`1:7`
> +      - Y'\ :sub:`1:8`
> +      - Y'\ :sub:`1:9`
> +      - Y'\ :sub:`2:0`
> +      - Y'\ :sub:`2:1`
> +      - Y'\ :sub:`2:2`
> +      - Y'\ :sub:`2:3`
> +    * - byte 3
> +      - Y'\ :sub:`2:4`
> +      - Y'\ :sub:`2:5`
> +      - Y'\ :sub:`2:6`
> +      - Y'\ :sub:`2:7`
> +      - Y'\ :sub:`2:8`
> +      - Y'\ :sub:`2:9`
> +      - Y'\ :sub:`3:0`
> +      - Y'\ :sub:`3:1`
> +    * - byte 4
> +      - Y'\ :sub:`3:2`
> +      - Y'\ :sub:`3:3`
> +      - Y'\ :sub:`3:4`
> +      - Y'\ :sub:`3:5`
> +      - Y'\ :sub:`3:6`
> +      - Y'\ :sub:`3:7`
> +      - Y'\ :sub:`3:8`
> +      - Y'\ :sub:`3:9`
> +
> +``V4L2_PIX_FMT_NV15_4L4`` stores pixels in 4x4 tiles, and stores tiles linearly
> +in memory.
>   
>   ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`` but stores
>   10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory.
> @@ -385,13 +449,6 @@ The image height must be aligned to a multiple of 128.
>   The layouts of the luma and chroma planes are identical.
>   Note the tile size is 8bytes multiplied by 128 bytes,
>   it means that the low bits and high bits of one pixel may be in different tiles.
> -The 10 bit pixels are packed, so 5 bytes contain 4 10-bit pixels layout like
> -this (for luma):
> -byte 0: Y0(bits 9-2)

...here it says byts 9-2? Is it a mistake or are you cleaning up the doc
and the table above is the correct version?

Regards,

Andrzej

> -byte 1: Y0(bits 1-0) Y1(bits 9-4)
> -byte 2: Y1(bits 3-0) Y2(bits 9-6)
> -byte 3: Y2(bits 5-0) Y3(bits 9-8)
> -byte 4: Y3(bits 7-0)
>   
>   ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_10BE_8L128`` but stores
>   two planes in one memory.

