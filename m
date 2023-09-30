Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC467B3F86
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 10:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjI3Iwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 04:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3Iwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 04:52:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359801A5;
        Sat, 30 Sep 2023 01:52:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A244C433C7;
        Sat, 30 Sep 2023 08:52:42 +0000 (UTC)
Message-ID: <cf67b199-e6cb-4c49-8e88-f045ae9d1422@xs4all.nl>
Date:   Sat, 30 Sep 2023 10:52:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 01/53] media: videobuf2: Rework offset 'cookie'
 encoding pattern
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230927153558.159278-1-benjamin.gaignard@collabora.com>
 <20230927153558.159278-2-benjamin.gaignard@collabora.com>
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230927153558.159278-2-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 17:35, Benjamin Gaignard wrote:
> Change how offset 'cookie' field value is computed to make possible
> to use more buffers (up to 0x7fff)
> With this encoding pattern we know the maximum number that a queue
> could store so we can check ing at queue init time.
> It also make easier and faster to find buffer and plane from using
> the offset field.
> Change __find_plane_by_offset() prototype to return the video buffer
> itself rather than it index.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 74 +++++++++----------
>  1 file changed, 35 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index cf6727d9c81f..6eeddb3a01c7 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -31,6 +31,14 @@
>  
>  #include <trace/events/vb2.h>
>  
> +#define PLANE_INDEX_SHIFT	(PAGE_SHIFT + 3)
> +#define PLANE_INDEX_MASK	0x7
> +#define BUFFER_INDEX_MASK	0x7fff
> +
> +#if PAGE_SHIFT != 12
> +#error Expected PAGE_SHIFT to be 12

So it turns out this can actually be something other than 12.
Search for CONFIG_ARM64_PAGE_SHIFT and CONFIG_PPC_PAGE_SHIFT.

arm64 supports 12, 14, 16 and powerpc64 supports 12, 14, 16, 18.

I think we should calculate the BUFFER_INDEX_MASK based on the
PAGE_SHIFT value. Even with a PAGE_SHIFT of 18, you can still
allocate up to 512 buffers.

Regards,

	Hans
