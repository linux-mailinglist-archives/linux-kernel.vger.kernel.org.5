Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2E7E70D6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344881AbjKIRwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbjKIRwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:52:03 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD24387F;
        Thu,  9 Nov 2023 09:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699552317;
 bh=erw3AGuB8ubO0tUACDJoBZw5alNFB6YDgPN2mZ8q69A=;
 b=aCL+f1l37bwcGuOWKmTkfCMpdpntUdgmvvqSipw4kM7qmStPBYq4khry7TnDBSpvb3fetETL5
 tDWgWER16mtOrHF3Q/xDU33qTbV4hLpfDqDz7wsQ1yUktAZzjBl90ymR1L+ILPIWG/Gbw8EOnur
 V4fpTkRfEIZtQIMpV1bYSz+NDQ5SQxqWuyNiEUUuwuQ0iFxJ2oaWUDUlUk5WaWEEFJs1DZJbVp0
 OgsFwphnhLjl29LE4zX6gS3iWZLSliN1TEMCvJqbl/ohAAkzEtRCr6iuM7TEQCLbxoK2ZIzKQZ1
 sH20lkDe4QgLqS1/boLO2Df69lvgOmVQxAWRxs0ZWD6Q==
Message-ID: <33a24dca-b523-4015-bea6-cbdd92b9e6b7@kwiboo.se>
Date:   Thu, 9 Nov 2023 18:51:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/11] media: rkvdec: Add H.264 High 10 and 4:2:2
 profile support
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231105165521.3592037-1-jonas@kwiboo.se>
 <874b6ea3309ff302dcdd9ff92f9098130b979c27.camel@collabora.com>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <874b6ea3309ff302dcdd9ff92f9098130b979c27.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 654d1c3da16ddfebde306cb5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

On 2023-11-07 22:43, Nicolas Dufresne wrote:
> Hi Jonas,
> 
> thanks for this work.
> 
> Le dimanche 05 novembre 2023 à 16:54 +0000, Jonas Karlman a écrit :
>> This is a revival of a 3 year old series [1] now that NV15/NV20/NV30 support
>> for display driver have landed in mainline tree.
>>
>> This series adds H.264 High 10 and 4:2:2 profile support to the Rockchip
>> Video Decoder driver.
>>
>> Patch 1 adds helpers for calculating plane bytesperline and sizeimage.
>> Patch 2 adds two new pixelformats for semi-planer 10-bit 4:2:0/4:2:2 YUV.
>>
>> Patch 3 change to use bytesperline and buffer height to configure strides.
>> Patch 4 change to use values from SPS/PPS control to configure the HW.
>> Patch 5 remove an unnecessary call to validate sps at streaming start.
>>
>> Patch 6-10 refactor code to support filtering of CAPUTRE formats based
>> on the image format returned from a get_image_fmt ops.
>>
>> Patch 11 adds final bits to support H.264 High 10 and 4:2:2 profiles.
>>
>> Tested on a ROCK Pi 4 (RK3399) and Rock64 (RK3328):
>>
>>   v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>>   ...
>>   Total for rkvdec device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
>>
>>   Running test suite JVT-FR-EXT with decoder FFmpeg-H.264-V4L2-request
>>   ...
>>   Ran 65/69 tests successfully
> 
> I added GStreamer support for these formats and could confirm this
> results with GStreamer too.
> 
> https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5612

Nice!

> 
> 
> For the set:
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> 
>>
>>   Running test suite JVT-AVC_V1 with decoder FFmpeg-H.264-V4L2-request
>>   ...
>>   Ran 127/135 tests successfully
> 
> I'm getting 129 with GStreamer, which matches also with FFMpeg software
> decoder.

Great, I was able to track down a long term ref idx issue in the ffmpeg
v4l2-request implementation and can now also get to 129 :-)

> 
>>
>> Before this series:
>>
>>   Running test suite JVT-FR-EXT with decoder FFmpeg-H.264-V4L2-request
>>   ...
>>   Ran 44/69 tests successfully
> 
> I had 43 with GStreamer, but then I notice you fixed something in
> fluster. The good news this is now upstream, thanks for spotting.
> 
> https://github.com/fluendo/fluster/pull/148

Thanks for sending the PR!

Regards,
Jonas

> 
>>
>> Changes in v4:
>> - Fix failed v4l2-compliance tests related to CAPTURE queue
>> - Rework CAPTURE format filter anv validate to use an image format
>> - Run fluster test suite JVT-FR-EXT [4] and JVT-AVC_V1 [5]
>> Link to v3: https://lore.kernel.org/linux-media/20231029183427.1781554-1-jonas@kwiboo.se/
>>
>> Changes in v3:
>> - Drop merged patches
>> - Use bpp and bpp_div instead of prior misuse of block_w/block_h
>> - New patch to use values from SPS/PPS control to configure the HW
>> - New patch to remove an unnecessary call to validate sps at streaming start
>> - Reworked pixel format validation
>> Link to v2: https://lore.kernel.org/linux-media/20200706215430.22859-1-jonas@kwiboo.se/
>>
>> Changes in v2:
>> - Collect r-b tags
>> - SPS pic width and height in mbs validation moved to rkvdec_try_ctrl
>> - New patch to not override output buffer sizeimage
>> - Reworked pixel format validation
>> - Only align decoded buffer instead of changing frmsize step_width
>> Link to v1: https://lore.kernel.org/linux-media/20200701215616.30874-1-jonas@kwiboo.se/
>>
>> Following commits adds support for NV15/NV20/NV30 to VOP driver:
>> 728c15b4b5f3 ("drm/fourcc: Add NV20 and NV30 YUV formats")
>> d4b384228562 ("drm/rockchip: vop: Add NV15, NV20 and NV30 support")
>>
>> To fully runtime test this series you may need above drm commits and ffmpeg
>> patches from [2], this series and drm patches is also available at [3].
>>
>> [1] https://lore.kernel.org/linux-media/20200706215430.22859-1-jonas@kwiboo.se/
>> [2] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-n6.1-dev/
>> [3] https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec-high-10-v4/
>> [4] https://gist.github.com/Kwiboo/f4ac15576b2c72887ae2bc5d58b5c865
>> [5] https://gist.github.com/Kwiboo/459a1c8f1dcb56e45dc7a7a29cc28adf
>>
>> Regards,
>> Jonas
>>
>> Alex Bee (1):
>>   media: rkvdec: h264: Don't hardcode SPS/PPS parameters
>>
>> Jonas Karlman (10):
>>   media: v4l2-common: Add helpers to calculate bytesperline and
>>     sizeimage
>>   media: v4l2: Add NV15 and NV20 pixel formats
>>   media: rkvdec: h264: Use bytesperline and buffer height as virstride
>>   media: rkvdec: h264: Remove SPS validation at streaming start
>>   media: rkvdec: Extract rkvdec_fill_decoded_pixfmt into helper
>>   media: rkvdec: Move rkvdec_reset_decoded_fmt helper
>>   media: rkvdec: Extract decoded format enumeration into helper
>>   media: rkvdec: Add image format concept
>>   media: rkvdec: Add get_image_fmt ops
>>   media: rkvdec: h264: Support High 10 and 4:2:2 profiles
>>
>>  .../media/v4l/pixfmt-yuv-planar.rst           | 128 +++++++++++
>>  drivers/media/v4l2-core/v4l2-common.c         |  80 +++----
>>  drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
>>  drivers/staging/media/rkvdec/rkvdec-h264.c    |  83 +++----
>>  drivers/staging/media/rkvdec/rkvdec.c         | 217 +++++++++++++-----
>>  drivers/staging/media/rkvdec/rkvdec.h         |  18 +-
>>  include/uapi/linux/videodev2.h                |   2 +
>>  7 files changed, 396 insertions(+), 134 deletions(-)
>>
> 

