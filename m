Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9324D77E98F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbjHPTVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 15:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345831AbjHPTVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 15:21:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EDF270C;
        Wed, 16 Aug 2023 12:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3tq/tr7dRLKiddiWuXxwS4UTK4ays7CzePLhmrFnHow=; b=IfPVmMiDqG0cYsRAXuFJUqjjQl
        QtgcHpi3PxdlxxrB4ROFWr2+Y7c0g1P0xS+s50HC473CkK+iVzExZVMuKv976c2ULKNvDaIAR0jlh
        uR4a80B/Z/QIZ5bT7Vqx/UbKn4QmkQR8Rr2IKSo0FClC9xwtYr1UMPs6DQxcTGozKvsf7zi4L7zOS
        Uy21zokYpcRqaQ9IDlp7ffjIs+/cSskrEQoXRq9HwfXS0hSvD0E76l11rTKzTDE+0Oy3LfV2jRzBc
        +AmwL6XkCo4NrxreQFpzTPc67L+/+kxQNrgMBUtkxoiRXE0+4UhJ+m/3l6wLgR3aUei8P5FPDCLcN
        FW14oLfw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWM5D-004sgv-2x;
        Wed, 16 Aug 2023 19:21:31 +0000
Message-ID: <363d77a7-ee1a-f4c4-941a-7737568a8042@infradead.org>
Date:   Wed, 16 Aug 2023 12:21:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] media: v4l: usb: Use correct dependency for camera
 sensor drivers
Content-Language: en-US
To:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next@vger.kernel.org, Wentong Wu <wentong.wu@intel.com>,
        Zhifeng Wang <zhifeng.wang@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20230816133526.3859456-1-sakari.ailus@linux.intel.com>
 <20230816133526.3859456-2-sakari.ailus@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230816133526.3859456-2-sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On 8/16/23 06:35, Sakari Ailus wrote:
> The Kconfig option that enables compiling camera sensor drivers is
> VIDEO_CAMERA_SENSOR rather than MEDIA_CAMERA_SUPPORT as it was previously.
> Fix this.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 7d3c7d2a2914 ("media: i2c: Add a camera sensor top level menu")
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  drivers/media/usb/em28xx/Kconfig | 4 ++--
>  drivers/media/usb/go7007/Kconfig | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

This patch reduces the number of kconfig warnings from 4 to 2. I still see these
(and these appear to be duplicates, so only one):

WARNING: unmet direct dependencies detected for VIDEO_OV7670
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [y]:
  - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP || COMPILE_TEST [=y]) && COMMON_CLK [=y]

WARNING: unmet direct dependencies detected for VIDEO_OV7670
  Depends on [n]: MEDIA_SUPPORT [=y] && VIDEO_DEV [=y] && VIDEO_CAMERA_SENSOR [=n]
  Selected by [y]:
  - VIDEO_MMP_CAMERA [=y] && MEDIA_SUPPORT [=y] && MEDIA_PLATFORM_SUPPORT [=y] && MEDIA_PLATFORM_DRIVERS [=y] && V4L_PLATFORM_DRIVERS [=y] && I2C [=y] && VIDEO_DEV [=y] && (ARCH_MMP || COMPILE_TEST [=y]) && COMMON_CLK [=y]

Thanks.

> diff --git a/drivers/media/usb/em28xx/Kconfig b/drivers/media/usb/em28xx/Kconfig
> index b3c472b8c5a9..cb61fd6cc6c6 100644
> --- a/drivers/media/usb/em28xx/Kconfig
> +++ b/drivers/media/usb/em28xx/Kconfig
> @@ -12,8 +12,8 @@ config VIDEO_EM28XX_V4L2
>  	select VIDEO_SAA711X if MEDIA_SUBDRV_AUTOSELECT
>  	select VIDEO_TVP5150 if MEDIA_SUBDRV_AUTOSELECT
>  	select VIDEO_MSP3400 if MEDIA_SUBDRV_AUTOSELECT
> -	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
> -	select VIDEO_OV2640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
> +	select VIDEO_MT9V011 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
> +	select VIDEO_OV2640 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
>  	help
>  	  This is a video4linux driver for Empia 28xx based TV cards.
>  
> diff --git a/drivers/media/usb/go7007/Kconfig b/drivers/media/usb/go7007/Kconfig
> index 4ff79940ad8d..b2a15d9fb1f3 100644
> --- a/drivers/media/usb/go7007/Kconfig
> +++ b/drivers/media/usb/go7007/Kconfig
> @@ -12,8 +12,8 @@ config VIDEO_GO7007
>  	select VIDEO_TW2804 if MEDIA_SUBDRV_AUTOSELECT
>  	select VIDEO_TW9903 if MEDIA_SUBDRV_AUTOSELECT
>  	select VIDEO_TW9906 if MEDIA_SUBDRV_AUTOSELECT
> -	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && MEDIA_CAMERA_SUPPORT
>  	select VIDEO_UDA1342 if MEDIA_SUBDRV_AUTOSELECT
> +	select VIDEO_OV7640 if MEDIA_SUBDRV_AUTOSELECT && VIDEO_CAMERA_SENSOR
>  	help
>  	  This is a video4linux driver for the WIS GO7007 MPEG
>  	  encoder chip.

-- 
~Randy
