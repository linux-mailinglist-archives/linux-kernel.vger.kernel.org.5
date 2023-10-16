Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F627CA7A1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 14:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjJPMEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 08:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJPMD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 08:03:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC86FEA;
        Mon, 16 Oct 2023 05:03:56 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:e07f:e79d:cb73:481b] (unknown [IPv6:2a01:e0a:120:3210:e07f:e79d:cb73:481b])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83AFA66072A4;
        Mon, 16 Oct 2023 13:03:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697457834;
        bh=iYgCzRqO6Qa3b4Tby41RH9rHWkNCrR9Sd3PxDUSIk6o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZUsQXsRU/ZWAEB4W4JKw1q3xUkwMwYOmTpWwRgsajebGDLCxwm+kVy7Z8LHRoEJWc
         5xfTJWVevl///r91HTXqTFRlg2mweYUJztF0ccs2bsZEIePq19LseIg8R9byveKZHZ
         JbcGz+MEQ9d6S0R4tUVpUp3OJLfaU5g8DYvqax3062YQJK1vHL5B+c4w3TMyl/Z4Gx
         B4lq9C5gerNoy4Ky5ooCfhYEAZm4muUQ79ilmpWpEQgEVRwtvc5SAo+9OKUWMI/s58
         tWntcL/E8dKCwDg5jHDVMVHlsqObqv+ORG6QItg94/Vss/pud2pohKIX766C7z9UhY
         rsFwLTKpU8NNQ==
Message-ID: <3a4f6fc1-6632-43f0-a5ab-55694c3de55f@collabora.com>
Date:   Mon, 16 Oct 2023 14:03:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 00/56] Add DELETE_BUF ioctl
Content-Language: en-US
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>, mchehab@kernel.org,
        tfiga@chromium.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231012114642.19040-1-benjamin.gaignard@collabora.com>
 <14198188-3519-46fb-abb6-0b1376f30b9d@xs4all.nl>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <14198188-3519-46fb-abb6-0b1376f30b9d@xs4all.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 16/10/2023 à 12:39, Hans Verkuil a écrit :
> Hi Benjamin,
>
> On 12/10/2023 13:45, Benjamin Gaignard wrote:
>> Unlike when resolution change on keyframes, dynamic resolution change
>> on inter frames doesn't allow to do a stream off/on sequence because
>> it is need to keep all previous references alive to decode inter frames.
>> This constraint have two main problems:
>> - more memory consumption.
>> - more buffers in use.
>> To solve these issue this series introduce DELETE_BUFS ioctl and remove
>> the 32 buffers limit per queue.
>>
>> VP9 conformance tests using fluster give a score of 210/305.
>> The 20 resize inter tests (vp90-2-21-resize_inter_* files) are ok
>> but require to use postprocessor.
>>
>> Kernel branch is available here:
>> https://gitlab.collabora.com/benjamin.gaignard/for-upstream/-/commits/remove_vb2_queue_limit_v11
>>
>> GStreamer branch to use DELETE_BUF ioctl and testing dynamic resolution
>> change is here:
>> https://gitlab.freedesktop.org/benjamin.gaignard1/gstreamer/-/commits/VP9_drc
> I did another review. Mainly small stuff, but I realized in my review of 40/56 that
> the use of min_buffers_needed is a mess, and you will need to revisit any driver
> patches where you change that value, or where you drop the number of buffers check
> in queue_setup because you rely on min_buffers_needed.

Ok I will comeback to the version where I only use vb2_get_num_buffers() is these drivers.

Regards,
Benjamin

>
> I think it is likely that we need to take another very good look at this before we
> implement VIDIOC_DELETE_BUFS.
>
> I have also posted a PR where I ask Mauro to merge patch 07/56 for 6.7 to get
> the vb2_get_num_buffers helper in. We'll see if that will happen since it is a
> bit late for that.
>
> Regards,
>
> 	Hans
>
>> changes in version 11:
>> - Patches ordering:
>>    1 to 3: clean up
>>    3 to 42: use vb2_get_buffer() and vb2_get_num_buffers()
>>    43 to 46: allow to use more than 32 buffers per queue
>>    47 to 50: allow verisilicon driver to do VP9 dynamic resolution change
>>              (which was the main purpose of this work)
>>    51 to 56: prepare and introduce delete buffers feature.
>> - Add a patch to rename 'off' to offset.
>> - Add maintainers CC to drivers patches
>>
>> changes in version 10:
>> - Make BUFFER_INDEX_MASK definition more readable
>> - Rebase on media_stage/master branch and add a patch for nuvoton
>>    driver.
>> - Fix issue on patch 13
>>
>> changes in version 9:
>> - BUFFER_INDEX_MASK now depends on PAGE_SHIFT value to match
>>    architectures requirements.
>> - Correctly initialize max_num_buffers in vb2_core_queue_init()
>> - run 'test-media -kmemleak mc' on top of the series and on patches 1 to 47 without failures.
>> - fix compilation issue in patch 50
>>
>> changes in version 8:
>> - Add V4L2_BUF_CAP_SUPPORTS_SET_MAX_BUFS and new 'max_buffers' field in v4l2_create_buffers
>>    structure to report the maximum number of buffers that a queue could allocate.
>> - Add V4L2_BUF_CAP_SUPPORTS_DELETE_BUFS to indicate that a queue support
>>    DELETE_BUFS ioctl.
>> - Make some test drivers use more than 32 buffers and DELETE_BUFS ioctl.
>> - Fix remarks done by Hans
>> - Move "media: core: Rework how create_buf index returned value is
>>    computed" patch to the top of the serie.
>>
>> changes in version 7:
>> - Use a bitmap to know which entries are valid in queue bufs array.
>>    The number of buffers in the queue could must calculated from the
>>    bitmap so num_buffers becomes useless. This led to add quite few
>>    patches to remove it from all the drivers.
>>    Note: despiste my attention I may have miss some calls to
>>    num_buffers...
>> - Split patches to make them more readable.
>> - Run v4l2-compliance with additional delete-bufs tests.
>> - Run ./test-media -kmemleak vivid and no more failures.
>>    Note: I had to remove USERPTR streaming test because they to much
>>    frequentely hit get_framevec bug. It is not related to my series
>>    since this happens all the time on master branch.
>> - Fix Hans remarks on v6
>>
>> changes in version 6:
>> - Get a patch per driver to use vb2_get_buffer() instead of directly access
>>    to queue buffers array.
>> - Add lock in vb2_core_delete_buf()
>> - Use vb2_buffer instead of index
>> - Fix various comments
>> - Change buffer index name to BUFFER_INDEX_MASK
>> - Stop spamming kernel log with unbalanced counters
>>
>> Benjamin Gaignard (56):
>>    media: videobuf2: Rename offset parameter
>>    media: videobuf2: Rework offset 'cookie' encoding pattern
>>    media: videobuf2: Stop spamming kernel log with all queue counter
>>    media: videobuf2: Use vb2_buffer instead of index
>>    media: videobuf2: Access vb2_queue bufs array through helper functions
>>    media: videobuf2: Remove duplicated index vs q->num_buffers check
>>    media: videobuf2: Add helper to get queue number of buffers
>>    media: videobuf2: Use vb2_get_num_buffers() helper
>>    media: amphion: Use vb2_get_buffer() instead of directly access to
>>      buffers array
>>    media: amphion: Stop direct calls to queue num_buffers field
>>    media: mediatek: jpeg: Use vb2_get_buffer() instead of directly access
>>      to buffers array
>>    media: mediatek: vdec: Remove useless loop
>>    media: mediatek: vcodec: Stop direct calls to queue num_buffers field
>>    media: sti: hva: Use vb2_get_buffer() instead of directly access to
>>      buffers array
>>    media: visl: Use vb2_get_buffer() instead of directly access to
>>      buffers array
>>    media: atomisp: Use vb2_get_buffer() instead of directly access to
>>      buffers array
>>    media: atomisp: Stop direct calls to queue num_buffers field
>>    media: dvb-core: Use vb2_get_buffer() instead of directly access to
>>      buffers array
>>    media: dvb-core: Do not initialize twice queue num_buffer field
>>    media: dvb-frontends: rtl2832_srd: Use queue min_buffers_needed field
>>    media: video-i2c: Set min_buffers_needed to 2
>>    media: pci: cx18: Set correct value to min_buffers_needed field
>>    media: pci: dt3155: Remove useless check
>>    media: pci: netup_unidvb: Remove useless number of buffers check
>>    media: pci: tw68: Stop direct calls to queue num_buffers field
>>    media: pci: tw686x: Set min_buffers_needed to 3
>>    media: coda: Stop direct calls to queue num_buffers field
>>    media: nxp: Stop direct calls to queue num_buffers field
>>    media: renesas: Set min_buffers_needed to 16
>>    media: ti: Use queue min_buffers_needed field to set the min number of
>>      buffers
>>    media: verisilicon: Stop direct calls to queue num_buffers field
>>    media: test-drivers: Stop direct calls to queue num_buffers field
>>    media: usb: airspy: Set min_buffers_needed to 8
>>    media: usb: cx231xx: Set min_buffers_needed to CX231XX_MIN_BUF
>>    media: usb: hackrf: Set min_buffers_needed to 8
>>    media: usb: usbtv: Set min_buffers_needed to 2
>>    media: imx: Stop direct calls to queue num_buffers field
>>    media: meson: vdec: Stop direct calls to queue num_buffers field
>>    touchscreen: sur40: Stop direct calls to queue num_buffers field
>>    sample: v4l: Stop direct calls to queue num_buffers field
>>    media: cedrus: Stop direct calls to queue num_buffers field
>>    media: nuvoton: Stop direct calls to queue num_buffers field
>>    media: videobuf2: Be more flexible on the number of queue stored
>>      buffers
>>    media: core: Report the maximum possible number of buffers for the
>>      queue
>>    media: test-drivers: vivid: Increase max supported buffers for capture
>>      queues
>>    media: test-drivers: vicodec: Increase max supported capture queue
>>      buffers
>>    media: verisilicon: Refactor postprocessor to store more buffers
>>    media: verisilicon: Store chroma and motion vectors offset
>>    media: verisilicon: g2: Use common helpers to compute chroma and mv
>>      offsets
>>    media: verisilicon: vp9: Allow to change resolution while streaming
>>    media: core: Rework how create_buf index returned value is computed
>>    media: core: Add bitmap manage bufs array entries
>>    media: core: Free range of buffers
>>    media: v4l2: Add DELETE_BUFS ioctl
>>    media: v4l2: Add mem2mem helpers for DELETE_BUFS ioctl
>>    media: test-drivers: Use helper for DELETE_BUFS ioctl
>>
>>   .../userspace-api/media/v4l/user-func.rst     |   1 +
>>   .../media/v4l/vidioc-create-bufs.rst          |   8 +-
>>   .../media/v4l/vidioc-delete-bufs.rst          |  80 +++
>>   .../media/v4l/vidioc-reqbufs.rst              |   2 +
>>   drivers/input/touchscreen/sur40.c             |   5 +-
>>   .../media/common/videobuf2/videobuf2-core.c   | 567 +++++++++++-------
>>   .../media/common/videobuf2/videobuf2-v4l2.c   | 116 +++-
>>   drivers/media/dvb-core/dvb_vb2.c              |  17 +-
>>   drivers/media/dvb-frontends/rtl2832_sdr.c     |   9 +-
>>   drivers/media/i2c/video-i2c.c                 |   5 +-
>>   drivers/media/pci/cx18/cx18-streams.c         |  13 +-
>>   drivers/media/pci/dt3155/dt3155.c             |   2 -
>>   .../pci/netup_unidvb/netup_unidvb_core.c      |   4 +-
>>   drivers/media/pci/tw68/tw68-video.c           |   6 +-
>>   drivers/media/pci/tw686x/tw686x-video.c       |  13 +-
>>   drivers/media/platform/amphion/vpu_dbg.c      |  30 +-
>>   drivers/media/platform/amphion/vpu_v4l2.c     |   4 +-
>>   .../media/platform/chips-media/coda-common.c  |   2 +-
>>   .../platform/mediatek/jpeg/mtk_jpeg_core.c    |   7 +-
>>   .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c |   9 +-
>>   .../mediatek/vcodec/encoder/mtk_vcodec_enc.c  |   2 +-
>>   drivers/media/platform/nuvoton/npcm-video.c   |   2 +-
>>   drivers/media/platform/nxp/imx7-media-csi.c   |   7 +-
>>   drivers/media/platform/renesas/rcar_drif.c    |   8 +-
>>   drivers/media/platform/st/sti/hva/hva-v4l2.c  |   9 +-
>>   .../media/platform/ti/am437x/am437x-vpfe.c    |   7 +-
>>   drivers/media/platform/ti/cal/cal-video.c     |   5 +-
>>   .../media/platform/ti/davinci/vpif_capture.c  |   5 +-
>>   .../media/platform/ti/davinci/vpif_display.c  |   5 +-
>>   drivers/media/platform/ti/omap/omap_vout.c    |   5 +-
>>   drivers/media/platform/verisilicon/hantro.h   |   9 +-
>>   .../media/platform/verisilicon/hantro_drv.c   |   5 +-
>>   .../media/platform/verisilicon/hantro_g2.c    |  14 +
>>   .../platform/verisilicon/hantro_g2_hevc_dec.c |  18 +-
>>   .../platform/verisilicon/hantro_g2_vp9_dec.c  |  28 +-
>>   .../media/platform/verisilicon/hantro_hw.h    |   7 +-
>>   .../platform/verisilicon/hantro_postproc.c    |  93 ++-
>>   .../media/platform/verisilicon/hantro_v4l2.c  |  27 +-
>>   .../media/test-drivers/vicodec/vicodec-core.c |   3 +
>>   drivers/media/test-drivers/vim2m.c            |   2 +
>>   .../media/test-drivers/vimc/vimc-capture.c    |   2 +
>>   drivers/media/test-drivers/visl/visl-dec.c    |  32 +-
>>   drivers/media/test-drivers/visl/visl-video.c  |   2 +
>>   drivers/media/test-drivers/vivid/vivid-core.c |  14 +
>>   .../media/test-drivers/vivid/vivid-meta-cap.c |   3 -
>>   .../media/test-drivers/vivid/vivid-meta-out.c |   5 +-
>>   .../test-drivers/vivid/vivid-touch-cap.c      |   5 +-
>>   .../media/test-drivers/vivid/vivid-vbi-cap.c  |   5 +-
>>   .../media/test-drivers/vivid/vivid-vbi-out.c  |   5 +-
>>   .../media/test-drivers/vivid/vivid-vid-cap.c  |   5 +-
>>   .../media/test-drivers/vivid/vivid-vid-out.c  |   5 +-
>>   drivers/media/usb/airspy/airspy.c             |   9 +-
>>   drivers/media/usb/cx231xx/cx231xx-417.c       |   4 +-
>>   drivers/media/usb/cx231xx/cx231xx-video.c     |   4 +-
>>   drivers/media/usb/hackrf/hackrf.c             |   9 +-
>>   drivers/media/usb/usbtv/usbtv-video.c         |   3 +-
>>   drivers/media/v4l2-core/v4l2-dev.c            |   1 +
>>   drivers/media/v4l2-core/v4l2-ioctl.c          |  21 +-
>>   drivers/media/v4l2-core/v4l2-mem2mem.c        |  20 +
>>   .../staging/media/atomisp/pci/atomisp_ioctl.c |   4 +-
>>   drivers/staging/media/imx/imx-media-capture.c |   7 +-
>>   drivers/staging/media/meson/vdec/vdec.c       |  13 +-
>>   .../staging/media/sunxi/cedrus/cedrus_h264.c  |   8 +-
>>   .../staging/media/sunxi/cedrus/cedrus_h265.c  |   9 +-
>>   include/media/v4l2-ioctl.h                    |   4 +
>>   include/media/v4l2-mem2mem.h                  |  12 +
>>   include/media/videobuf2-core.h                |  65 +-
>>   include/media/videobuf2-v4l2.h                |  13 +
>>   include/uapi/linux/videodev2.h                |  24 +-
>>   samples/v4l/v4l2-pci-skeleton.c               |   5 +-
>>   70 files changed, 972 insertions(+), 507 deletions(-)
>>   create mode 100644 Documentation/userspace-api/media/v4l/vidioc-delete-bufs.rst
>>
>
