Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5661B7E1D22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 10:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjKFJXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 04:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjKFJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 04:23:09 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145AAB;
        Mon,  6 Nov 2023 01:23:02 -0800 (PST)
Received: from i5e861912.versanet.de ([94.134.25.18] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1qzvol-0006tf-Az; Mon, 06 Nov 2023 10:22:47 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-rockchip@lists.infradead.org
Cc:     Alex Bee <knaerzche@gmail.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonas Karlman <jonas@kwiboo.se>,
        Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH 0/9] media: rkvdec: Add HEVC backend
Date:   Mon, 06 Nov 2023 10:22:46 +0100
Message-ID: <5347734.aeNJFYEL58@diego>
In-Reply-To: <20231105233630.3927502-1-jonas@kwiboo.se>
References: <20231105233630.3927502-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

Am Montag, 6. November 2023, 00:36:07 CET schrieb Jonas Karlman:
> This series add a HEVC backend to the Rockchip Video Decoder driver.
> 
> A version of this HEVC backend has been in use by the LibreELEC distro
> for the past 3+ years [1]. It was initially created based on a copy of
> the H264 backend, unstable HEVC uAPI controls and a cabac table + scaling
> matrix functions shamelessly copied 1:1 from the Rockchip mpp library.
> 
> It has since then been extended to use the stable HEVC uAPI controls and
> improved opon e.g. to include support for rk3288 and fix decoding issues
> by Alex Bee and Nicolas Dufresne.
> 
> The version submitted in this series is based on the code currently used
> by the LibreELEC distro, excluding hard/soft reset, and with cabac table
> and scaling matrix functions picked from Sebastian Fricke prior series
> to add a HEVC backend [2].
> 
> Big thanks to Alex Bee, Nicolas Dufresne and Sebastian Fricke for making
> this series possible!
> 
> Patch 1 add the new HEVC backend.
> Patch 2-3 add variants support to the driver.
> Patch 4 add support for a rk3288 variant.
> Patch 5 add a rk3328 variant to work around hw quirks.
> Patch 6-7 add device tree node for rk3288.
> Patch 8-9 extend vdec node reg size to include cache/perf registers.

thanks a lot for working on this.

Looking at the rkvdec TODO file, isn't the hvec support the only thing
keeping the driver in staging? So with this support using stable hevc
uapi, shouldn't the driver then also move out of staging after this
series is applied?

Heiko


> This was tested on a ROCK Pi 4 (RK3399) and Rock64 (RK3328):
> 
>   v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>   ...
>   Total for rkvdec device /dev/video1: 46, Succeeded: 46, Failed: 0, Warnings: 0
> 
>   Running test suite JCT-VC-HEVC_V1 with decoder FFmpeg-H.265-V4L2-request
>   ...
>   Ran 135/147 tests successfully
> 
>   Running test suite JCT-VC-MV-HEVC with decoder FFmpeg-H.265-V4L2-request
>   ...
>   Ran 9/9 tests successfully
> 
> And on a TinkerBoard (RK3288):
> 
>   v4l2-compliance 1.24.1, 32 bits, 32-bit time_t
>   ...
>   Total for rkvdec device /dev/video3: 47, Succeeded: 47, Failed: 0, Warnings: 0
> 
>   Running test suite JCT-VC-HEVC_V1 with decoder FFmpeg-H.265-V4L2-request
>   ...
>   Ran 137/147 tests successfully
> 
>   Running test suite JCT-VC-MV-HEVC with decoder FFmpeg-H.265-V4L2-request
>   ...
>   Ran 9/9 tests successfully
> 
> This series depend on the following series:
> - media: rkvdec: Add H.264 High 10 and 4:2:2 profile support [3]
> 
> To fully runtime test this series you need above series and ffmpeg
> patches from [4], this series and its depends is also available at [5].
> 
> Full summary of fluster run can be found at [6].
> 
> [1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockchip/patches/linux/default/linux-2000-v4l2-wip-rkvdec-hevc.patch
> [2] https://lore.kernel.org/linux-media/20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com/
> [3] https://lore.kernel.org/linux-media/20231105165521.3592037-1-jonas@kwiboo.se/
> [4] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-n6.1-dev/
> [5] https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec-hevc-v1/
> [6] https://gist.github.com/Kwiboo/4c0ed87774dede44ce6838451a1ec93d
> 
> Regards,
> Jonas
> 
> Alex Bee (5):
>   media: rkvdec: Add variants support
>   media: rkvdec: Add RK3288 variant
>   media: rkvdec: Disable QoS for HEVC and VP9 on RK3328
>   ARM: dts: rockchip: Add vdec node for RK3288
>   arm64: dts: rockchip: Expand reg size of vdec node for RK3399
> 
> Jonas Karlman (4):
>   media: rkvdec: Add HEVC backend
>   media: rkvdec: Implement capability filtering
>   media: dt-bindings: rockchip,vdec: Add RK3288 compatible
>   arm64: dts: rockchip: Expand reg size of vdec node for RK3328
> 
>  .../bindings/media/rockchip,vdec.yaml         |    4 +-
>  arch/arm/boot/dts/rockchip/rk3288.dtsi        |   17 +-
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi      |    2 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |    6 +-
>  drivers/staging/media/rkvdec/Makefile         |    2 +-
>  drivers/staging/media/rkvdec/TODO             |    7 -
>  .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1848 +++++++++++++++++
>  drivers/staging/media/rkvdec/rkvdec-hevc.c    |  823 ++++++++
>  drivers/staging/media/rkvdec/rkvdec-regs.h    |    3 +
>  drivers/staging/media/rkvdec/rkvdec-vp9.c     |   10 +
>  drivers/staging/media/rkvdec/rkvdec.c         |  180 +-
>  drivers/staging/media/rkvdec/rkvdec.h         |   15 +
>  12 files changed, 2886 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
>  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
> 
> 




