Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2207F0033
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 15:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjKROyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 09:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKROyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 09:54:10 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1153C0;
        Sat, 18 Nov 2023 06:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700319222; x=1700924022; i=wahrenst@gmx.net;
        bh=vrX+/zAoYBDvwn793PvAorGO1HvG2Y9PGd3B39cEv2c=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=EyJQH5MBu6m9r0TcbjFTL9bTbryaKcq4Yr1UJfpVhu503q90hjjGTjanQbCMhCTl
         YpdBRKZ6iOK2+17UBbI0cv+EXCFzuv9gtCrm5WreM6S6aPf0j/s7BC4t8VggYZnXE
         0KvPN4eoCEUWBcY964F/iE7fAVEMt6U2R02eNrh4FXPYi9DLgtRVpONUv1oJL5qbK
         YBNIdjVxUFpE4AqK1R2iCrgEn2NxbmfhVT2nPfdEeghOxZGqVAnXNk8/I0vJqCDt0
         vj4wd0+rQ+yaFxnwmhNY0u9JNf1j5S84npQ4CFoigRP84BRr1Wnk6ni4RfvQoJlIb
         7mscZ4s6oJwwHpT86A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1qo4Ch06k9-00J4dN; Sat, 18
 Nov 2023 15:53:42 +0100
Message-ID: <414ba478-3a96-48e6-a3a7-88c920a20960@gmx.net>
Date:   Sat, 18 Nov 2023 15:53:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/15] staging: vc04_services: bcm2835-isp: Add a more
 complex ISP processing component
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev
Cc:     Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Ricardo B . Marliere" <ricardo@marliere.net>,
        Dan Carpenter <error27@gmail.com>,
        Naushir Patuck <naush@raspberrypi.com>
References: <20231109210309.638594-1-umang.jain@ideasonboard.com>
 <20231109210309.638594-11-umang.jain@ideasonboard.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20231109210309.638594-11-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bYX/bXT9lHSSeS0sGD/JPIs0v6N8KWrXYQ+qvxKfjHr8DcNo0yG
 py5C66TqLhYI3HLHjWcad917V/IF1XYF6JA5uSqFYTP9rG88ykNlIAdc78QwZFw4/y7BFK/
 teDgHYp23LPkjvPaKpNAnO0HRLrDFz8jZYpCNfMyZ87W64aGs+baCg/vuZMnjp6Qchw9C2R
 BVJRTPWMElu8zryuQqKaA==
UI-OutboundReport: notjunk:1;M01:P0:jyppdFM0iw4=;0kO2VBOg/giUwUGsswlFWFqvyHO
 iCdqACN5hLtvYQmRMI9IpSEDuilI0KVgwES+CfmgnJ5XYsg72fzU3+1OK99NMIWwhGAjJi966
 T+T2KjSrqmFlnlIm6JpMRHmnyfa+gd5nJGvNjuzh4QdntphywWkxZ72bNNsua7pYPkgOAuZgd
 oc3TmilvbResm46EdvWN/SIcOMhdT5BXazaEHumY6JHz88cmbhBqST37qH5u5Vf85qlJICS1c
 7MdfIxvl90cabkMfqzyWX9duTREonzuMNjk3B/E8juzLw5XgoeFzZTOlGJsIH4ZBMWWCBJkBc
 kyhDnRac14lzcVomkzKQLPVDiOQtH33vNOxATDEQ3u0vluKXS02mEYP3Plov7d0wxpeFnlyZD
 PZGngWB+1xDWc1JE3oH3yYIMB9T+jbx1DuPXMgPuVRrUZMDnxPb/X2Qxgw0C6MQcnUssTtj4Z
 omrjQpGGYJoPxs140tHLuVuPPQaaK0DyGE9okuxD1Bxu+qcj7MUMCzd+HeG4J8HxCUaHYkMdx
 l8oOnvyT5ggJM5rCH0EQEfSgTd2GcBJ8hJZQ+07mTF9v+ZBiOY6uKb9+Ez/rZkNlBqnnUQBeU
 cKJq/VY0dgB3xMT+P8QmJqjd0kPL4pcr3uIxovooYKYBdmTvIS9FlRQaHUrsvb2K2sMrFtwWv
 XtGAgljzu5wLvD42bYXrJZvGHGb8PB8OSMEJEoy/193V/G4GerAnYbVdU4JDsdkS97kwoPYfA
 3UGAH+RKQPUqPeA6gIeGwP/BXkil+2bep90hCfQnG8LyKUvUEtihp9x04O00WO2XaFY/WbbRJ
 gkCCNKtxc3VbUx0s84Okg36HxOzhvQrKy8ZDUtBEqqT0SZISNfZmFa+motzLFICMe9tm+CsAQ
 TzqY8QfIbW87lNwtD3gjakw6FYOoEVL4y+6rhFdjCvBZK4owRD9Q6YmSfeu3C5/RcE0Kxbc+e
 Hs9p5/BRj6foreJnVN+q03UxhBQ=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

Am 09.11.23 um 22:03 schrieb Umang Jain:
> From: Naushir Patuck <naush@raspberrypi.com>
>
> Driver for the BCM2835 ISP hardware block.  This driver uses the MMAL
> component to program the ISP hardware through the VC firmware.
>
> The ISP component can produce two video stream outputs, and Bayer
> image statistics. This can't be encompassed in a simple V4L2
> M2M device, so create a new device that registers 4 video nodes.

sorry, i don't have much knowledge about V4L2, so someone else should
review this in depth.

But from my PoV, patch 11, 12, 13 and 15 should be squash into this one.

>
> Signed-off-by: Naushir Patuck <naush@raspberrypi.com>
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   MAINTAINERS                                   |    9 +
>   drivers/staging/vc04_services/Kconfig         |    2 +
>   drivers/staging/vc04_services/Makefile        |    1 +
>   .../staging/vc04_services/bcm2835-isp/Kconfig |   14 +
>   .../vc04_services/bcm2835-isp/Makefile        |    4 +
>   .../bcm2835-isp/bcm2835-isp-ctrls.h           |   72 +
>   .../bcm2835-isp/bcm2835-isp-fmts.h            |  482 +++++
>   .../bcm2835-isp/bcm2835-v4l2-isp.c            | 1712 +++++++++++++++++
>   .../vc04_services/vchiq-mmal/mmal-encodings.h |    4 +
>   .../vchiq-mmal/mmal-parameters.h              |  165 +-
>   include/uapi/linux/bcm2835-isp.h              |   27 +
>   11 files changed, 2491 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Kconfig
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/Makefile
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-i=
sp-ctrls.h
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-i=
sp-fmts.h
>   create mode 100644 drivers/staging/vc04_services/bcm2835-isp/bcm2835-v=
4l2-isp.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0748cc15588c..8670a8d95400 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3976,6 +3976,15 @@ F:	Documentation/devicetree/bindings/mips/brcm/
>   F:	arch/mips/bcm47xx/*
>   F:	arch/mips/include/asm/mach-bcm47xx/*
>
> +BROADCOM BCM2835 ISP DRIVER
> +M:	Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/media/uapi/v4l/pixfmt-meta-bcm2835-isp-stats.rst
> +F:	Documentation/media/v4l-drivers/bcm2835-isp.rst
> +F:	drivers/staging/vc04_services/bcm2835-isp
> +F:	include/uapi/linux/bcm2835-isp.h
> +
>   BROADCOM BCM4908 ETHERNET DRIVER
>   M:	Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broa=
dcom.com>
> diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc0=
4_services/Kconfig
> index 6c0e77d64376..e71e5a8b820a 100644
> --- a/drivers/staging/vc04_services/Kconfig
> +++ b/drivers/staging/vc04_services/Kconfig
> @@ -44,6 +44,8 @@ source "drivers/staging/vc04_services/bcm2835-audio/Kc=
onfig"
>
>   source "drivers/staging/vc04_services/bcm2835-camera/Kconfig"
>
> +source "drivers/staging/vc04_services/bcm2835-isp/Kconfig"
> +
>   source "drivers/staging/vc04_services/vchiq-mmal/Kconfig"
>
>   source "drivers/staging/vc04_services/vc-sm-cma/Kconfig"
> diff --git a/drivers/staging/vc04_services/Makefile b/drivers/staging/vc=
04_services/Makefile
> index 1f61a263f22d..2cebf92525a0 100644
> --- a/drivers/staging/vc04_services/Makefile
> +++ b/drivers/staging/vc04_services/Makefile
> @@ -16,3 +16,4 @@ obj-$(CONFIG_SND_BCM2835)		+=3D bcm2835-audio/
>   obj-$(CONFIG_VIDEO_BCM2835)		+=3D bcm2835-camera/
>   obj-$(CONFIG_BCM2835_VCHIQ_MMAL)	+=3D vchiq-mmal/
>   obj-$(CONFIG_BCM_VC_SM_CMA)		+=3D vc-sm-cma/
> +obj-$(CONFIG_VIDEO_ISP_BCM2835) 	+=3D bcm2835-isp/
> diff --git a/drivers/staging/vc04_services/bcm2835-isp/Kconfig b/drivers=
/staging/vc04_services/bcm2835-isp/Kconfig
> new file mode 100644
> index 000000000000..6222799ebe16
> --- /dev/null
> +++ b/drivers/staging/vc04_services/bcm2835-isp/Kconfig
> @@ -0,0 +1,14 @@
> +config VIDEO_ISP_BCM2835
> +	tristate "BCM2835 ISP support"
> +	depends on MEDIA_SUPPORT
> +	depends on VIDEO_DEV && (ARCH_BCM2835 || COMPILE_TEST)
> +	depends on MEDIA_CONTROLLER
> +	select BCM2835_VCHIQ_MMAL
> +	select VIDEOBUF2_DMA_CONTIG
> +	help
> +	  This is the V4L2 driver for the Broadcom BCM2835 ISP hardware.

I think the description is not helpful for all users. Not everybody
knows what ISP is for. Please describe it more for an end user.

Best regards

> +	  This operates over the VCHIQ interface to a service running on
> +	  VideoCore.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called bcm2835-isp.
