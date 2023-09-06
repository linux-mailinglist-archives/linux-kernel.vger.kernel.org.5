Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C3D793AE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbjIFLP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbjIFLPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:15:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455C81730;
        Wed,  6 Sep 2023 04:15:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C571FC433C7;
        Wed,  6 Sep 2023 11:15:13 +0000 (UTC)
Message-ID: <ffcb655c-3016-d8bc-2e85-67eb34588d27@xs4all.nl>
Date:   Wed, 6 Sep 2023 13:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/3] Google Chameleon v3 video driver
Content-Language: en-US, nl
To:     =?UTF-8?Q?Pawe=c5=82_Anikiel?= <pan@semihalf.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mchehab@kernel.org, upstream@semihalf.com, amstan@chromium.org,
        ribalda@chromium.org
References: <20230630144006.1513270-1-pan@semihalf.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20230630144006.1513270-1-pan@semihalf.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

Apologies for the much-too-long delay, but I finally had time to look at this.

On 30/06/2023 16:40, Paweł Anikiel wrote:
> The Google Chameleon v3 is a testing device for external displays. It
> is based on an Arria 10 SoCFPGA. This patch adds a V4L2 driver for the
> video system. The video system consists of:
>   * Six video interfaces (DMA ping pong buffers) in the FPGA, called
>   "framebuffers".
>   * Two Intel DisplayPort DPRX IP cores in the FPGA, one MST x4, one SST
>   * IT68051 chip, handled by EC firmware
> 
> The driver is implemented as a single device driver, because the video
> interface devices need to talk to the DisplayPort IP core devices
> (e.g. to configure the EDID). This has the effect of the DPRX driver
> being in the chameleonv3 directory even though it's an Intel IP.
> 
> The DPRX code handles all the AUX communication (DPCD, sideband messages,
> message transfers). There is similarity to what's already present in
> the DRM subsystem, but I found it hard to reuse that code effectively.
> 
> My main concern is with the overall structure of the driver - how it's
> divided into parts, the interfaces and APIs used, etc. Any feedback is
> greately appreciated.

I need to see the v4l2-compliance output for this new driver. Typically
'v4l2-compliance -s -d /dev/videoX' should be enough. You have to compile
v4l2-compliance from the git repo (git://linuxtv.org/v4l-utils.git) to ensure
you use the latest and greatest version.

Obviously any failures should be fixed. Just copy-and-paste the v4l2-compliance
output to the cover letter.

Regards,

	Hans

> 
> Paweł Anikiel (3):
>   media: Add 10, 12, and 16 bit RGB formats
>   media: Add Google Chameleon v3 video driver
>   ARM: dts: Add Chameleon v3 video node
> 
>  .../socfpga/socfpga_arria10_chameleonv3.dts   |  54 ++
>  drivers/media/platform/Kconfig                |   1 +
>  drivers/media/platform/Makefile               |   1 +
>  drivers/media/platform/google/Kconfig         |   4 +
>  drivers/media/platform/google/Makefile        |   2 +
>  .../media/platform/google/chameleonv3/Kconfig |   9 +
>  .../platform/google/chameleonv3/Makefile      |  15 +
>  .../platform/google/chameleonv3/chv3-core.c   | 292 ++++++++++
>  .../platform/google/chameleonv3/chv3-core.h   |  17 +
>  .../platform/google/chameleonv3/chv3-fb.c     | 539 ++++++++++++++++++
>  .../platform/google/chameleonv3/chv3-fb.h     |  34 ++
>  .../platform/google/chameleonv3/dprx-aux.c    |  77 +++
>  .../platform/google/chameleonv3/dprx-dp.c     |  82 +++
>  .../platform/google/chameleonv3/dprx-dpcd.c   | 424 ++++++++++++++
>  .../platform/google/chameleonv3/dprx-dprx.c   | 262 +++++++++
>  .../platform/google/chameleonv3/dprx-edid.c   |  39 ++
>  .../platform/google/chameleonv3/dprx-i2c.c    |  41 ++
>  .../platform/google/chameleonv3/dprx-mt.c     | 184 ++++++
>  .../platform/google/chameleonv3/dprx-sbmsg.c  | 162 ++++++
>  .../media/platform/google/chameleonv3/dprx.h  | 128 +++++
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   5 +
>  include/uapi/linux/videodev2.h                |   5 +
>  22 files changed, 2377 insertions(+)
>  create mode 100644 drivers/media/platform/google/Kconfig
>  create mode 100644 drivers/media/platform/google/Makefile
>  create mode 100644 drivers/media/platform/google/chameleonv3/Kconfig
>  create mode 100644 drivers/media/platform/google/chameleonv3/Makefile
>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-core.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-core.h
>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/chv3-fb.h
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-aux.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dp.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dpcd.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-dprx.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-edid.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-i2c.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-mt.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx-sbmsg.c
>  create mode 100644 drivers/media/platform/google/chameleonv3/dprx.h
> 

