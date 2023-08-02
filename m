Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89776C6E1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232712AbjHBHdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjHBHcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:32:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED4C11B;
        Wed,  2 Aug 2023 00:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF0C61820;
        Wed,  2 Aug 2023 07:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9D1AC433C7;
        Wed,  2 Aug 2023 07:32:38 +0000 (UTC)
Message-ID: <47d66c28-1eb2-07f5-d6f9-779d675aefe8@xs4all.nl>
Date:   Wed, 2 Aug 2023 09:32:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH v2 0/7] Add audio support in v4l2 framework
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, sakari.ailus@iki.fi,
        tfiga@chromium.org, m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On 25/07/2023 08:12, Shengjiu Wang wrote:
> Audio signal processing has the requirement for memory to
> memory similar as Video.
> 
> This patch is to add this support in v4l2 framework, defined
> new buffer type V4L2_BUF_TYPE_AUDIO_CAPTURE and
> V4L2_BUF_TYPE_AUDIO_OUTPUT, defined new format v4l2_audio_format
> for audio case usage.
> 
> The created audio device is named "/dev/audioX".
> 
> And add memory to memory support for two kinds of i.MX ASRC
> module

Before I spend time on this: are the audio maintainers OK with doing
this in V4L2?

I do want to have a clear statement on this as it is not something I
can decide.

Regards,

	Hans

> 
> changes in v2:
> - decouple the implementation in v4l2 and ALSA
> - implement the memory to memory driver as a platfrom driver
>   and move it to driver/media
> - move fsl_asrc_common.h to include/sound folder
> 
> Shengjiu Wang (7):
>   ASoC: fsl_asrc: define functions for memory to memory usage
>   ASoC: fsl_easrc: define functions for memory to memory usage
>   ASoC: fsl_asrc: move fsl_asrc_common.h to include/sound
>   media: v4l2: Add audio capture and output support
>   media: imx: fsl_asrc: Add memory to memory driver
>   ASoC: fsl_asrc: register m2m platform device
>   ASoC: fsl_easrc: register m2m platform device
> 
>  .../media/common/videobuf2/videobuf2-v4l2.c   |   4 +
>  drivers/media/platform/nxp/Kconfig            |  12 +
>  drivers/media/platform/nxp/Makefile           |   1 +
>  drivers/media/platform/nxp/fsl_asrc_m2m.c     | 962 ++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-dev.c            |  17 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |  52 +
>  include/media/v4l2-dev.h                      |   2 +
>  include/media/v4l2-ioctl.h                    |  34 +
>  .../fsl => include/sound}/fsl_asrc_common.h   |  48 +
>  include/uapi/linux/videodev2.h                |  19 +
>  sound/soc/fsl/fsl_asrc.c                      | 150 +++
>  sound/soc/fsl/fsl_asrc.h                      |   4 +-
>  sound/soc/fsl/fsl_asrc_dma.c                  |   2 +-
>  sound/soc/fsl/fsl_easrc.c                     | 227 +++++
>  sound/soc/fsl/fsl_easrc.h                     |   8 +-
>  15 files changed, 1539 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/media/platform/nxp/fsl_asrc_m2m.c
>  rename {sound/soc/fsl => include/sound}/fsl_asrc_common.h (63%)
> 

