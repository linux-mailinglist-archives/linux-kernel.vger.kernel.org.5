Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704D175D7AB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:47:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGUWrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjGUWrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:47:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85553A8F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689979584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yE0bLtRIMwP7QfCtqHUeTr/4KJnDlp9DaWfvJbs40ac=;
        b=aynbRl4ALQALvptvePvVRymntUfAw8aIMSCWLYnC2mdI6VbCPoqX2xPsL3KsqTcn/tvdLF
        p/xYWgiSxCL2C0OkORLa55q3pp34gq8n6DDig0wIpIRMw+J7C9SioC/I0Gh5SK/0brkSPo
        kT3fD++KLL4k5bQmI2sI4Crlorjb8Pw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-GdtZPFLiMdq-Ag_JFMjqGA-1; Fri, 21 Jul 2023 18:46:20 -0400
X-MC-Unique: GdtZPFLiMdq-Ag_JFMjqGA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc08d6a40cso12580625e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689979578; x=1690584378;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yE0bLtRIMwP7QfCtqHUeTr/4KJnDlp9DaWfvJbs40ac=;
        b=je3hstsF4Qyuh8ky5thA00cg2hc633QaQh6e+do7mngJwpJnVL2MdVSoX8cl2WzlTQ
         xaBRUfGpYf37M9LkPl8HgnNCpuFU1Rp5aAGXVE1sgwJbMPrSdNYt0dPpawV9vWYwy6bm
         lCyV2t/LlKcJVI4VSrChOZrGoQg9T+ILcgqChd1MyOPl8sTm+8pbJQbOuNAVoXERmfv4
         vbpNEH3IE9B8HhuUClh71Co429fcC31lzE8D/gJuOsutj4pb0dNTHvMvGPXfWUNaXBN2
         HMf5+aNGYTB2naOe4Ehtf4qMTqLE9AKpfWYwPwd3AHlN2tNpPW90xiOW3yFNBYLvXCED
         Zqxg==
X-Gm-Message-State: ABy/qLZrpWU7ZxlzkiX1UVGNfm3pzLnDWIlQXcFb/XhKezVdXXRg/YA5
        00vdgQa1bMJm8WfzWwCjhZ1mjXzFFI9Mcu03MiYkC6V21JNWYBwYSj1x2pXWpTWcFNBSseMQcfa
        O4ItlSt4fJUWWC2Lex/RiaNWk/I2kHTd/18rQ9nLd4p6JNalhbXbGR/Z2ZFVBT6fH0dNPJLT4T0
        KTp9cKEkyw
X-Received: by 2002:a05:600c:224b:b0:3fb:b34f:6cd4 with SMTP id a11-20020a05600c224b00b003fbb34f6cd4mr2241631wmm.36.1689979578608;
        Fri, 21 Jul 2023 15:46:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG4o1OxvRmpHFoaNAuc4QqPQ+HeK/yygxg+TEil6F/L2at/FUadRCLQ5fAQrswO0An7WjzHsw==
X-Received: by 2002:a05:600c:224b:b0:3fb:b34f:6cd4 with SMTP id a11-20020a05600c224b00b003fbb34f6cd4mr2241612wmm.36.1689979578118;
        Fri, 21 Jul 2023 15:46:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s19-20020a1cf213000000b003fbaade072dsm4099955wmc.23.2023.07.21.15.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:46:17 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 1/4] video: Add auxiliary display drivers to Graphics
 support menu
In-Reply-To: <20230719081544.741051-2-javierm@redhat.com>
References: <20230719081544.741051-1-javierm@redhat.com>
 <20230719081544.741051-2-javierm@redhat.com>
Date:   Sat, 22 Jul 2023 00:46:16 +0200
Message-ID: <87sf9gublz.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

[adding Miguel Ojeda who was not in the Cc list]

Hello Miguel, could you please ack this patch so that I can take the whole
patch-set through the drm-misc tree?

> The drivers in this subsystem are for character-based LCD displays, which
> can fall into the same category of the DRM/KMS and fbdev drivers that are
> located under the "Graphics support" menu. Add auxdisplay there as well.
>
> Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Tested-by: Arnd Bergmann <arnd@arndb.de>
> ---
>
> (no changes since v5)
>
> Changes in v5:
> - Take the auxdisplay/Kconfig source out of "if HAS_IOMEM" (Geert Uytterhoeven).
>
>  drivers/Kconfig       | 2 --
>  drivers/video/Kconfig | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index 514ae6b24cb2..496ca02ee18f 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -129,8 +129,6 @@ source "drivers/dma-buf/Kconfig"
>  
>  source "drivers/dca/Kconfig"
>  
> -source "drivers/auxdisplay/Kconfig"
> -
>  source "drivers/uio/Kconfig"
>  
>  source "drivers/vfio/Kconfig"
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 8b2b9ac37c3d..e5b1cc54cafa 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -25,6 +25,8 @@ config VIDEO_NOMODESET
>  	bool
>  	default n
>  
> +source "drivers/auxdisplay/Kconfig"
> +
>  if HAS_IOMEM
>  
>  config HAVE_FB_ATMEL
> -- 
> 2.41.0
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

