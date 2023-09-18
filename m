Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB64A7A45F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240719AbjIRJcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 05:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240895AbjIRJbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B085FD3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695029459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K9mKfMs2axUjRk4VejYXL9YNHsofaFImODtn3an3J0Q=;
        b=HKnJ1Q1/Gmg8a2th+z+8irXMsfuEQTW+jOumgrPyD1+VaDEubvXo2+I+TowsWqYjyMhMRp
        PUHJlA7G50vaMsHLfvgIa7jxChI7k6KE9oI3rf9xbejy8PwcsMV4c+uEUH6ZKyWKujMcoV
        8m+WCqqMuuJl++W1oz0hNDD+74PS6sg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-TrEBaldwPOysCQFTNzSq8w-1; Mon, 18 Sep 2023 05:30:57 -0400
X-MC-Unique: TrEBaldwPOysCQFTNzSq8w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-32006e08483so966323f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 02:30:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695029456; x=1695634256;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K9mKfMs2axUjRk4VejYXL9YNHsofaFImODtn3an3J0Q=;
        b=FEaKQL3XXZMykAlykMmZmiXXUbhTQ2c5WDnnzJSEgpMxE9Jzk6rTHOEFKY+G3gKfNB
         l+s95PlkUUxaPGHe1EU9L3v8DikRBp7yplYe+AkVPbnNcxtnrmef1zZ0/oYTeM2cqJ7x
         wHMH1pS+TA0cHvmH+RzgnmdxK12+jJNzJbD3ZZDbiKSzyL0oOgTchqnD2J7zhhIVWBlI
         OJNiI45sFG50ng0hpqzB/WsmLpJaCzj6g+kf8uL5rvaqsw7SV62icvTYYVfWeIJewOTi
         HufL72AeH6Utcr6Ed2zTEPYx4c0Ch4HYGa+TeC4126ne9LBmY1AYNLOGEPOAqsJ2w/Nk
         Bqrw==
X-Gm-Message-State: AOJu0YzWIdvV05NAZwnt74QDcGaC81LKLaJnzoQ37o4Rj1Vu/XA6LyYt
        B7BdkhRCIyyXQemWSB7JkPLBcwppn7qFwLr7MhwqPU4MNMy009VhtTOz/iOeM/a1snu8DuxXYSc
        qC2+CnMpnw+KPZKsNj9rOzlx3
X-Received: by 2002:a5d:4152:0:b0:317:5182:7b55 with SMTP id c18-20020a5d4152000000b0031751827b55mr6601625wrq.42.1695029455962;
        Mon, 18 Sep 2023 02:30:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuVwKer/t6wO8e6EaqpLJk3xr8QAnbzNM6Ra4QUQXA+9orH05TCHII2aGbpDgbji3C7zRZ1Q==
X-Received: by 2002:a5d:4152:0:b0:317:5182:7b55 with SMTP id c18-20020a5d4152000000b0031751827b55mr6601614wrq.42.1695029455646;
        Mon, 18 Sep 2023 02:30:55 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q11-20020adff50b000000b0031c71693449sm12122610wro.1.2023.09.18.02.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 02:30:55 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        sam@ravnborg.org, arnd@arndb.de, rdunlap@infradead.org,
        glaubitz@physik.fu-berlin.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fbdev/sh7760fb: Depend on FB=y
In-Reply-To: <20230918090400.13264-1-tzimmermann@suse.de>
References: <20230918090400.13264-1-tzimmermann@suse.de>
Date:   Mon, 18 Sep 2023 11:30:54 +0200
Message-ID: <87o7hz4ylt.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Fix linker error if FB=m about missing fb_io_read and fb_io_write. The
> linker's error message suggests that this config setting has already
> been broken for other symbols.
>
>   All errors (new ones prefixed by >>):
>
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
>      sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
>      sh4-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
>      sh4-linux-ld: sh7760fb.c:(.text+0x39c): undefined reference to `fb_alloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
>      sh4-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
>      sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
>      sh4-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
>      sh4-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
>   >> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
>   >> sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
>      sh4-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202309130632.LS04CPWu-lkp@intel.com/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Agreed with your change.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

