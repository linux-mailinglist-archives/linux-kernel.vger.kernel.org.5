Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC3B7E6E39
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343640AbjKIQG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbjKIQG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:06:56 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B5A30FA;
        Thu,  9 Nov 2023 08:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699546010;
 bh=DI9I7e45GZv43PxZw1RhCeG/VkyNjaieZAPB6CbinL8=;
 b=p+jK5XE8PeJxjXI/BBTG/8O0J0XMCp/bW/yvifumjpYn+AYPaG1yrEhqgEmCOZis1xokjYo/l
 h7nhe/64DyaJzyfJ4Ck3IVTccxlgymbKHw+HUL88PdTLiw+07WcXIpDrU6BtLKsQ3NspL+NilO0
 0pIIr6GoFU8V/OAaBziaTYR4y6dDeyabeIWlHoqWNmpy4BnQ9tLAr7cpzcUSj+bMUDnFhQO3YxU
 ogikXHMhCO4cLHRrS5Vvf4IF8soGihvJQ6dqtyv22QEnJ6RCgD/YgXANkt20wO1TIqYtdmZ3QAc
 MkBVFtyggdKCmSZSSoCL8ibgkQQEiGrJZBhHLz2entWA==
Message-ID: <0763eeea-ac0f-4e07-9678-dd7567a0f3be@kwiboo.se>
Date:   Thu, 9 Nov 2023 17:06:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] docs: uapi: media: Add common documentation of
 tiled NV15
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230914150651.3114134-1-nicolas.dufresne@collabora.com>
 <20230914150651.3114134-4-nicolas.dufresne@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20230914150651.3114134-4-nicolas.dufresne@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 654d039ab32fff32884ed3f7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14 17:06, Nicolas Dufresne wrote:
> This way we don't have to repeat over and over how the pixels are
> packed in NV15.
> 
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  .../media/v4l/pixfmt-yuv-planar.rst           | 144 ++++++++++++++++--
>  1 file changed, 131 insertions(+), 13 deletions(-)
> 
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 1d43532095c07..2f0e0c97870b2 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -373,25 +373,143 @@ two non-contiguous planes.
>  Tiled NV15
>  ----------
>  
> -``V4L2_PIX_FMT_NV15_4L4`` Semi-planar 10-bit YUV 4:2:0 formats, using 4x4 tiling.
> -All components are packed without any padding between each other.
> -As a side-effect, each group of 4 components are stored over 5 bytes
> -(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes).
> +Semi-planar 10-bit YUV 4:2:0 formats. All components are packed
> +without any padding between each other. Each components group occupy 15

Each component (Y, Cb and Cr) is 10 bits in this format, the effective
bits per pixel is however 15 bits when number of pixels is aligned to 8.

For a 4x2 image:
8Y + 2Cb + 2Cr = 80 + 20 + 20 = 120 bits (15 bytes) => 15 bits per pixel

The 'Bits per component' in the table 'Overview of Semi-Planar YUV
Formats' is also showing 15, should be 10.

Regards,
Jonas

> +bits and are usually stored in group of 4 components stored over 5 bytes
> +(YYYY or UVUV = 4 * 10 bits = 40 bits = 5 bytes) or partitioned into
> +upper 8 bit and lower 2 bits. The final arrangement will vary depending if
> +the hardware operated in little or big endian.
> +

[...]
