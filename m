Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75C17A9BB5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjIUTDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjIUTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:03:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4BF80F98;
        Thu, 21 Sep 2023 10:36:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9BDC116AA;
        Thu, 21 Sep 2023 08:03:43 +0000 (UTC)
Message-ID: <fb74f6b8-3139-4652-b36a-1de396d0ca23@xs4all.nl>
Date:   Thu, 21 Sep 2023 10:03:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 7/7] media: nuvoton: Add driver for NPCM video capture
 and encoding engine
Content-Language: en-US, nl
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com
References: <20230920022812.601800-1-milkfafa@gmail.com>
 <20230920022812.601800-8-milkfafa@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230920022812.601800-8-milkfafa@gmail.com>
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

Hi Marvin,

Just one small comment:

On 20/09/2023 04:28, Marvin Lin wrote:
> Add driver for Video Capture/Differentiation Engine (VCD) and Encoding
> Compression Engine (ECE) present on Nuvoton NPCM SoCs. As described in
> the datasheet NPCM750D_DS_Rev_1.0, the VCD can capture frames from
> digital video input and compare two frames in memory, and then the ECE
> can compress the frame data into HEXTILE format. This driver implements
> V4L2 interfaces and provides user controls to support KVM feature, also
> tested with VNC Viewer ver.6.22.826 and openbmc/obmc-ikvm.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  MAINTAINERS                                 |   12 +
>  drivers/media/platform/Kconfig              |    1 +
>  drivers/media/platform/Makefile             |    1 +
>  drivers/media/platform/nuvoton/Kconfig      |   15 +
>  drivers/media/platform/nuvoton/Makefile     |    2 +
>  drivers/media/platform/nuvoton/npcm-regs.h  |  152 ++
>  drivers/media/platform/nuvoton/npcm-video.c | 1830 +++++++++++++++++++
>  7 files changed, 2013 insertions(+)
>  create mode 100644 drivers/media/platform/nuvoton/Kconfig
>  create mode 100644 drivers/media/platform/nuvoton/Makefile
>  create mode 100644 drivers/media/platform/nuvoton/npcm-regs.h
>  create mode 100644 drivers/media/platform/nuvoton/npcm-video.c
> 

<snip>

> diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
> new file mode 100644
> index 000000000000..aabb6077a128
> --- /dev/null
> +++ b/drivers/media/platform/nuvoton/npcm-video.c
> @@ -0,0 +1,1830 @@

<snip>

> +
> +/*
> + * This control value is set when a buffer is dequeued by userspace, i.e. in
> + * npcm_video_buf_finish function.
> + */
> +static const struct v4l2_ctrl_config npcm_ctrl_rect_count = {
> +	.id = V4L2_CID_NPCM_RECT_COUNT,
> +	.name = "NPCM Compressed Hextile Rectangle Count",

This name is too long, it should be max 31 characters. Dropping the "Compressed " part
might be best, I think that word isn't needed.

> +	.type = V4L2_CTRL_TYPE_INTEGER,
> +	.min = 0,
> +	.max = (MAX_WIDTH / RECT_W) * (MAX_HEIGHT / RECT_H),
> +	.step = 1,
> +	.def = 0,
> +};

With this fixed, and the sparse warnings fixed, it should be ready for merging.

Regards,

	Hans

