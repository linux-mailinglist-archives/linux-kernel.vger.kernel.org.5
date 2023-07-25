Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB31761E0B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjGYQHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 12:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGYQHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 12:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1ACE77
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690301219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n8WDoL0557ijucVnvFFhXFlCk91a1heL5kHgluQGr74=;
        b=gP1EUWJb6512h3UBcsR5ABj4T3U9X2xkkxIK+Am8Fq4qe8roZtOL+dO/kYNfOfuAV4m5lu
        2+kHLl5dsnflgFyhXT/A9eaWfrRexG05Jcx/kqAOS0sJd8FVF9/6gsswuHfYc61BGYOZmr
        35m/fHnFkYhChhlDOCH6DA7y4+dPqwo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-8WdKB3y_N6-izulTGti8Eg-1; Tue, 25 Jul 2023 12:06:57 -0400
X-MC-Unique: 8WdKB3y_N6-izulTGti8Eg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f5df65fa35so30265095e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 09:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690301211; x=1690906011;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n8WDoL0557ijucVnvFFhXFlCk91a1heL5kHgluQGr74=;
        b=QqmezVQi2l6rBR36Ob0teGvd/XCxQk86jSoxvnDmRrIHSb3GGRjolR+nwt1M+rGNjZ
         xsxRBInQh+o63OkzY8FfAk6fSZ5L/3wJTt2ETEwLz5lZ7GsFE4tRU9ITeRNH9wrjL120
         FGR+QvC65crzeAABE/2WmM1LoalsQMxdpQE7a3WFKn4l7CSJvoQjaGzOm4n2oCIswDIo
         4tGgm7vJM1j2bCGSboffzdGL1w4evGcWDuptNVnpsk1PZSB4xmZoDIyQ+kPVV+dMSwS4
         ow6RGYTtfnnuKXHPnUqfRMpU01xRsjfs7mxOyoK2/yDjzAx8u9tKu6eAe7dKGB2c4S6N
         Rvtg==
X-Gm-Message-State: ABy/qLZS7RyUROXOppGr+CrXFydx5jH/0KQNZdnzePQ1lhvBsG3t9LXj
        vF8QI1f5NQFkJYVIeUe9kdqd7Vfi77M45+JNThZG4i/a+9+AEq+PLytpIlB9EZOd0PNSB3982uq
        ihYj0pyS1nejKBS+2BHDRPvYS
X-Received: by 2002:a05:600c:2043:b0:3fa:934c:8350 with SMTP id p3-20020a05600c204300b003fa934c8350mr10062658wmg.27.1690301211264;
        Tue, 25 Jul 2023 09:06:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHhB4b1r6/9EKYpbymuXJFkp9iRDrryPS4kRN5/XpdtSoEVtQGo358UOoZiWwF6PdI9lwFdRA==
X-Received: by 2002:a05:600c:2043:b0:3fa:934c:8350 with SMTP id p3-20020a05600c204300b003fa934c8350mr10062636wmg.27.1690301210864;
        Tue, 25 Jul 2023 09:06:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a17-20020adffad1000000b003143cdc5949sm16909129wrs.9.2023.07.25.09.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 09:06:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] video: logo: LOGO should depend on FB_CORE i.s.o. FB
In-Reply-To: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
References: <5ab3d1fe7b67ab10e4bc1bdbc0fa7731f7960965.1690300189.git.geert+renesas@glider.be>
Date:   Tue, 25 Jul 2023 18:06:49 +0200
Message-ID: <87a5vkj7qe.fsf@minerva.mail-host-address-is-not-set>
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

Geert Uytterhoeven <geert+renesas@glider.be> writes:

Hello Geert,

Thanks a lot for your patch!

> If CONFIG_FB_CORE=y but CONFIG_FB=n, the frame buffer bootup logos can
> no longer be enabled.  Fix this by making CONFIG_LOGO depend on
> CONFIG_FB_CORE instead of CONFIG_FB, as there is no good reason for the
> logo code to depend on the presence of real frame buffer device drivers.
>

Indeed.

> Fixes: 55bffc8170bb5813 ("fbdev: Split frame buffer support in FB and FB_CORE symbols")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/video/Kconfig      | 2 +-
>  drivers/video/logo/Kconfig | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index e5b1cc54cafa10d5..b694d7669d3200b1 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -63,7 +63,7 @@ if VT
>  	source "drivers/video/console/Kconfig"
>  endif
>  
> -if FB || SGI_NEWPORT_CONSOLE
> +if FB_CORE || SGI_NEWPORT_CONSOLE
>  	source "drivers/video/logo/Kconfig"
>  
>  endif
> diff --git a/drivers/video/logo/Kconfig b/drivers/video/logo/Kconfig
> index 6d6f8c08792dc897..b7d94d1dd1585a84 100644
> --- a/drivers/video/logo/Kconfig
> +++ b/drivers/video/logo/Kconfig
> @@ -5,7 +5,7 @@
>  
>  menuconfig LOGO
>  	bool "Bootup logo"
> -	depends on FB || SGI_NEWPORT_CONSOLE
> +	depends on FB_CORE || SGI_NEWPORT_CONSOLE
>  	help
>  	  Enable and select frame buffer bootup logos.

Should then move this option to drivers/video/fbdev/core/Kconfig ?

Regardless, could be done as a follow-up and the fix looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

