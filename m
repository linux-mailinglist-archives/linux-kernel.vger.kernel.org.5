Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F12B7C4E86
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 11:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjJKJZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 05:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjJKJZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 05:25:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92028CC;
        Wed, 11 Oct 2023 02:25:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AE44C433C7;
        Wed, 11 Oct 2023 09:25:27 +0000 (UTC)
Message-ID: <69334bb8-c9e5-4387-b3c5-adc66ed9f825@xs4all.nl>
Date:   Wed, 11 Oct 2023 11:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 00/54] Add DELETE_BUF ioctl
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
References: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231003080704.43911-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin,

On 03/10/2023 10:06, Benjamin Gaignard wrote:
> Unlike when resolution change on keyframes, dynamic resolution change
> on inter frames doesn't allow to do a stream off/on sequence because
> it is need to keep all previous references alive to decode inter frames.
> This constraint have two main problems:
> - more memory consumption.
> - more buffers in use.
> To solve these issue this series introduce DELETE_BUFS ioctl and remove
> the 32 buffers limit per queue.
> 
> VP9 conformance tests using fluster give a score of 210/305.
> The 24 resize inter tests (vp90-2-21-resize_inter_* files) are ok
> but require to use postprocessor.
> 
> Kernel branch is available here:
> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v10
> 
> GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
> change is here:
> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc
> 

<snip>

I'm a bit unhappy about the order of these patches.

It mixes core and driver patches, making it hard to follow. Also, the
driver patches are missing CCs to the driver maintainers.

There are two types of driver patches:

1) switch to vb2_get_buffer()
2) switch to vb2_get_num_buffers(), or stop using num_buffers altogether.

I am not counting the patches for verisilicon and the test drivers that
add support for max_num_buffers, those are separate.

In order to support more than 32 buffers the first phase is to fix the
drivers.

I would suggest the following:

1) start with a videobuf2-core.h patch adding vb2_get_num_buffers()
   (so just the header part of patch 21/54).
2) then add all driver patches switching to vb2_get_buffer/vb2_get_num_buffers(),
   grouped by driver (so e.g. the two amphion patches are placed together).

Also add CCs to the driver maintainers for each driver patch, allowing them
to review the code.

Also include patches 10/54 and 22/54 (dvb-core).

The remaining patches for vb2 etc. and for drivers patches adding support for
the new features should be posted as a separate series on top of this.

I want to get the driver changes in first. That will greatly simplify the
remaining work.

What will also be very helpful if this approach is taken is that it should
be no problem to merge the initial patch adding the new vb2_get_num_buffers
function for v6.7. That makes it easier to convert drivers in phases, if
needed. And new upcoming drivers can start to use this function as well.

Regards,

	Hans

> Benjamin Gaignard (54):
>   media: videobuf2: Rework offset 'cookie' encoding pattern
>   media: videobuf2: Stop spamming kernel log with all queue counter
>   media: videobuf2: Use vb2_buffer instead of index
>   media: amphion: Use vb2_get_buffer() instead of directly access to
>     buffers array
>   media: mediatek: jpeg: Use vb2_get_buffer() instead of directly access
>     to buffers array
>   media: mediatek: vdec: Remove useless loop
>   media: sti: hva: Use vb2_get_buffer() instead of directly access to
>     buffers array
>   media: visl: Use vb2_get_buffer() instead of directly access to
>     buffers array
>   media: atomisp: Use vb2_get_buffer() instead of directly access to
>     buffers array
>   media: dvb-core: Use vb2_get_buffer() instead of directly access to
>     buffers array
>   media: videobuf2: Access vb2_queue bufs array through helper functions
>   media: videobuf2: Be more flexible on the number of queue stored
>     buffers
>   media: Report the maximum possible number of buffers for the queue
>   media: test-drivers: vivid: Increase max supported buffers for capture
>     queues
>   media: test-drivers: vicodec: Increase max supported capture queue
>     buffers
>   media: verisilicon: Refactor postprocessor to store more buffers
>   media: verisilicon: Store chroma and motion vectors offset
>   media: verisilicon: g2: Use common helpers to compute chroma and mv
>     offsets
>   media: verisilicon: vp9: Allow to change resolution while streaming
>   media: Remove duplicated index vs q->num_buffers check
>   media: core: Add helper to get queue number of buffers
>   media: dvb-core: Do not initialize twice queue num_buffer field
>   media: dvb-frontends: rtl2832_srd: Use queue min_buffers_needed field
>   media: video-i2c: Set min_buffers_needed to 2
>   media: pci: cx18: Set correct value to min_buffers_needed field
>   media: pci: dt3155: Remove useless check
>   media: pci: netup_unidvb: Remove useless number of buffers check
>   media: pci: tw68: Stop direct calls to queue num_buffers field
>   media: pci: tw686x: Set min_buffers_needed to 3
>   media: amphion: Stop direct calls to queue num_buffers field
>   media: coda: Stop direct calls to queue num_buffers field
>   media: mediatek: vcodec: Stop direct calls to queue num_buffers field
>   media: nxp: Stop direct calls to queue num_buffers field
>   media: renesas: Set min_buffers_needed to 16
>   media: ti: Use queue min_buffers_needed field to set the min number of
>     buffers
>   media: verisilicon: Stop direct calls to queue num_buffers field
>   media: test-drivers: Stop direct calls to queue num_buffers field
>   media: usb: airspy: Set min_buffers_needed to 8
>   media: usb: cx231xx: Set min_buffers_needed to CX231XX_MIN_BUF
>   media: usb: hackrf: Set min_buffers_needed to 8
>   media: usb: usbtv: Set min_buffers_needed to 2
>   media: atomisp: Stop direct calls to queue num_buffers field
>   media: imx: Stop direct calls to queue num_buffers field
>   media: meson: vdec: Stop direct calls to queue num_buffers field
>   touchscreen: sur40: Stop direct calls to queue num_buffers field
>   sample: v4l: Stop direct calls to queue num_buffers field
>   media: cedrus: Stop direct calls to queue num_buffers field
>   media: nuvoton: Stop direct calls to queue num_buffers field
>   media: core: Rework how create_buf index returned value is computed
>   media: core: Add bitmap manage bufs array entries
>   media: core: Free range of buffers
>   media: v4l2: Add DELETE_BUFS ioctl
>   media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
>   media: test-drivers: Use helper for DELETE_BUFS ioctl


