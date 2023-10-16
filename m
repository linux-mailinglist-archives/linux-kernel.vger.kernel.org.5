Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39F7CA56C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJPKcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPKcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:32:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743ADB4;
        Mon, 16 Oct 2023 03:32:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29066C433C7;
        Mon, 16 Oct 2023 10:32:04 +0000 (UTC)
Message-ID: <0ca82921-b71a-4d87-a1f1-6a6158f07c8c@xs4all.nl>
Date:   Mon, 16 Oct 2023 12:32:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 45/56] media: test-drivers: vivid: Increase max
 supported buffers for capture queues
Content-Language: en-US, nl
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
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <20231012114642.19040-46-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231012114642.19040-46-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2023 13:46, Benjamin Gaignard wrote:
> Change the maximum number of buffers of some capture queues in order
> to test max_num_buffers field.
> 
> Allow to allocate up to:
> - 64 buffers for video capture queue.
> - 1024 buffers for sdr capture queue.
> - 32768 buffers for vbi capture queue.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/test-drivers/vivid/vivid-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/media/test-drivers/vivid/vivid-core.c b/drivers/media/test-drivers/vivid/vivid-core.c
> index 394c9f81ea72..b5656330578d 100644
> --- a/drivers/media/test-drivers/vivid/vivid-core.c
> +++ b/drivers/media/test-drivers/vivid/vivid-core.c
> @@ -876,6 +876,13 @@ static int vivid_create_queue(struct vivid_dev *dev,
>  	q->type = buf_type;
>  	q->io_modes = VB2_MMAP | VB2_DMABUF;
>  	q->io_modes |= V4L2_TYPE_IS_OUTPUT(buf_type) ?  VB2_WRITE : VB2_READ;
> +	if (buf_type == V4L2_BUF_TYPE_VIDEO_CAPTURE)
> +		q->max_num_buffers = 64;
> +	if (buf_type == V4L2_BUF_TYPE_SDR_CAPTURE)
> +		q->max_num_buffers = 1024;
> +	if (buf_type == V4L2_BUF_TYPE_VBI_CAPTURE)
> +		q->max_num_buffers = 32768;

This should use the same calculation as MAX_BUFFER_INDEX.

I wonder if those defines should move to videobuf2-core.h instead.

Regards,

	Hans

> +
>  	if (allocators[dev->inst] != 1)
>  		q->io_modes |= VB2_USERPTR;
>  	q->drv_priv = dev;

