Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF697E6FBA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344165AbjKIQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjKIQz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:55:28 -0500
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9725C1AE;
        Thu,  9 Nov 2023 08:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1699548920;
 bh=oiGpLQFfupX4dQTf/iHqDMCKO+1QmogvFTKLT/9VDbU=;
 b=gxuByy2LJVUxrjyvbPXS1dDoZu/RcUyj2V9+6cq9e3mbjhYdk4fKJFsn5fO3t2CqVj7LE3y6R
 QifTXKPrdGofdaCZun4RLXTqmTQWeIw10Kaie4ss3aFz6/jpWpTwlbUjpRsHn7a1oFQmsvA0cPM
 ekuTI0U/wxY6POytiJBIG5SSUgyAcVmtJ4v9HDfl1hLAOrAsqq3df02ZymlB8UcD9yLGB5DxbQ+
 LZLy0YHPUhylhiKDotRLHoVSRyuchYveLMhDvuAwV6tafzABOR13l/mnDjzanq0AOkgBPtC+WNv
 yRXg8IyVmrSIgxngZGAWRSNbddJdSOzaHQ/oz3aFyOeg==
Message-ID: <b4cc5a65-ccae-41c0-af9c-04001116938a@kwiboo.se>
Date:   Thu, 9 Nov 2023 17:55:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] media: rkvdec: Add HEVC backend
Content-Language: en-US
To:     "=?UTF-8?Q?Heiko_St=C3=BCbner?=" <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-rockchip@lists.infradead.org
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231105233630.3927502-1-jonas@kwiboo.se>
 <5347734.aeNJFYEL58@diego>
From:   Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <5347734.aeNJFYEL58@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 654d0ef8a16ddfebde306c21
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 2023-11-06 10:22, Heiko Stübner wrote:
> Hi Jonas,
> 
> Am Montag, 6. November 2023, 00:36:07 CET schrieb Jonas Karlman:
>> This series add a HEVC backend to the Rockchip Video Decoder driver.
>>
>> A version of this HEVC backend has been in use by the LibreELEC distro
>> for the past 3+ years [1]. It was initially created based on a copy of
>> the H264 backend, unstable HEVC uAPI controls and a cabac table + scaling
>> matrix functions shamelessly copied 1:1 from the Rockchip mpp library.
>>
>> It has since then been extended to use the stable HEVC uAPI controls and
>> improved opon e.g. to include support for rk3288 and fix decoding issues
>> by Alex Bee and Nicolas Dufresne.
>>
>> The version submitted in this series is based on the code currently used
>> by the LibreELEC distro, excluding hard/soft reset, and with cabac table
>> and scaling matrix functions picked from Sebastian Fricke prior series
>> to add a HEVC backend [2].
>>
>> Big thanks to Alex Bee, Nicolas Dufresne and Sebastian Fricke for making
>> this series possible!
>>
>> Patch 1 add the new HEVC backend.
>> Patch 2-3 add variants support to the driver.
>> Patch 4 add support for a rk3288 variant.
>> Patch 5 add a rk3328 variant to work around hw quirks.
>> Patch 6-7 add device tree node for rk3288.
>> Patch 8-9 extend vdec node reg size to include cache/perf registers.
> 
> thanks a lot for working on this.
> 
> Looking at the rkvdec TODO file, isn't the hvec support the only thing
> keeping the driver in staging? So with this support using stable hevc
> uapi, shouldn't the driver then also move out of staging after this
> series is applied?

Yes, I agree, this driver should be moved out of staging now that uapi
is stable. Something for a follow-up series :-)

Regards,
Jonas

> 
> Heiko
> 
> 
>> This was tested on a ROCK Pi 4 (RK3399) and Rock64 (RK3328):
>>
>>   v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>>   ...
>>   Total for rkvdec device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
>>
>>   Running test suite JCT-VC-HEVC_V1 with decoder FFmpeg-H.265-V4L2-request
>>   ...
>>   Ran 135/147 tests successfully
>>
>>   Running test suite JCT-VC-MV-HEVC with decoder FFmpeg-H.265-V4L2-request
>>   ...
>>   Ran 9/9 tests successfully
>>
>> And on a TinkerBoard (RK3288):
>>
>>   v4l2-compliance 1.24.1, 32 bits, 32-bit time_t
>>   ...
>>   Total for rkvdec device /dev/video3: 47, Succeeded: 47, Failed: 0, Warnings: 0
>>
>>   Running test suite JCT-VC-HEVC_V1 with decoder FFmpeg-H.265-V4L2-request
>>   ...
>>   Ran 137/147 tests successfully
>>
>>   Running test suite JCT-VC-MV-HEVC with decoder FFmpeg-H.265-V4L2-request
>>   ...
>>   Ran 9/9 tests successfully
>>
>> This series depend on the following series:
>> - media: rkvdec: Add H.264 High 10 and 4:2:2 profile support [3]
>>
>> To fully runtime test this series you need above series and ffmpeg
>> patches from [4], this series and its depends is also available at [5].
>>
>> Full summary of fluster run can be found at [6].
>>
>> [1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/patches/linux/default/linux-2000-v4l2-wip-rkvdec-hevc.patch
>> [2] https://lore.kernel.org/linux-media/20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com/
>> [3] https://lore.kernel.org/linux-media/20231105165521.3592037-1-jonas@kwiboo.se/
>> [4] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-n6.1-dev/
>> [5] https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec-hevc-v1/
>> [6] https://gist.github.com/Kwiboo/4c0ed87774dede44ce6838451a1ec93d
>>
>> Regards,
>> Jonas
>>
>> Alex Bee (5):
>>   media: rkvdec: Add variants support
>>   media: rkvdec: Add RK3288 variant
>>   media: rkvdec: Disable QoS for HEVC and VP9 on RK3328
>>   ARM: dts: rockchip: Add vdec node for RK3288
>>   arm64: dts: rockchip: Expand reg size of vdec node for RK3399
>>
>> Jonas Karlman (4):
>>   media: rkvdec: Add HEVC backend
>>   media: rkvdec: Implement capability filtering
>>   media: dt-bindings: rockchip,vdec: Add RK3288 compatible
>>   arm64: dts: rockchip: Expand reg size of vdec node for RK3328
>>
>>  .../bindings/media/rockchip,vdec.yaml         |    4 +-
>>  arch/arm/boot/dts/rockchip/rk3288.dtsi        |   17 +-
>>  arch/arm64/boot/dts/rockchip/rk3328.dtsi      |    2 +-
>>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |    6 +-
>>  drivers/staging/media/rkvdec/Makefile         |    2 +-
>>  drivers/staging/media/rkvdec/TODO             |    7 -
>>  .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1848 +++++++++++++++++
>>  drivers/staging/media/rkvdec/rkvdec-hevc.c    |  823 ++++++++
>>  drivers/staging/media/rkvdec/rkvdec-regs.h    |    3 +
>>  drivers/staging/media/rkvdec/rkvdec-vp9.c     |   10 +
>>  drivers/staging/media/rkvdec/rkvdec.c         |  180 +-
>>  drivers/staging/media/rkvdec/rkvdec.h         |   15 +
>>  12 files changed, 2886 insertions(+), 31 deletions(-)
>>  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
>>  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
>>
>>
> 
> 
> 
> 

