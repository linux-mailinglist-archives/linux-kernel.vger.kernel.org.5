Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7605376A157
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjGaTf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjGaTf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:35:26 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2B11998
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=6qASGIsrRTha6LW4nGlFz5hVK9QFyCgkRnIOH/MfmdI=;
        b=gbD2l+F4txZSKOikg9ULrRxYvmKpodr8viXTZBSfsyRhtbkseAGNq5G/j1Yjw/MChSfPAbovOOckO
         fDLnWkOt+KM0RrinBws0z3F8YDy4ZK+v8OA63YMgBDwno7Hos7KtKozzN1O0VOr+88mykbAMD9nyem
         JOtXu92SRr2bmjPmUpaS/v4CXn8TOlB/DULIqsm0bq8fQjbPCL4F1imrCWJD8+zw9e7BtI5nvLQGBr
         Vvw9pxE+uYxbtboGk5CCcL6EiLab9g7/w/44JEZWP4Pd2Wrvf/kbo+XywEiXBXQWvpKJz31cF8878D
         7E3htRYGp0KE2CAKyAhYuzmi55Lpy+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=6qASGIsrRTha6LW4nGlFz5hVK9QFyCgkRnIOH/MfmdI=;
        b=lbxy0fAhUsTGM7a0p9jw1JGKiT98vxHJLhFafsTjUZmjfLKS+bkQvy0jxq/0Be1QR1jiE0GoMXFoE
         wcLb15eBg==
X-HalOne-ID: 626809cf-2fd9-11ee-8694-c5367ef0e45e
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 626809cf-2fd9-11ee-8694-c5367ef0e45e;
        Mon, 31 Jul 2023 19:35:21 +0000 (UTC)
Date:   Mon, 31 Jul 2023 21:35:20 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, javierm@redhat.com,
        bagasdotme@gmail.com, rd.dunlab@gmail.com,
        regressions@leemhuis.info, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, regressions@lists.linux.dev,
        linux-next@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbdev/ps3fb: Build without kernel device
Message-ID: <20230731193520.GA1463201@ravnborg.org>
References: <20230731175535.11345-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731175535.11345-1-tzimmermann@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 07:55:00PM +0200, Thomas Zimmermann wrote:
> Use fb_info() to print status message at the end of the probe function,
> which avoids decoding the devices. fb_info() works with or without an
> fbdev kernel device. Fixes the following error:
> 
> ../drivers/video/fbdev/ps3fb.c: In function 'ps3fb_probe':
> ../drivers/video/fbdev/ps3fb.c:1172:40: error: 'struct fb_info' has no member named 'dev'
>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>       |                                        ^~
> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                                     ^~~~~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>       |         ^~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1172:61: error: 'struct fb_info' has no member named 'dev'
>  1172 |                  dev_driver_string(info->dev), dev_name(info->dev),
>       |                                                             ^~
> ../include/linux/dev_printk.h:110:37: note: in definition of macro 'dev_printk_index_wrap'
>   110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
>       |                                     ^~~~~~~~~~~
> ../drivers/video/fbdev/ps3fb.c:1171:9: note: in expansion of macro 'dev_info'
>  1171 |         dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>       |         ^~~~~~~~
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Closes: https://lore.kernel.org/lkml/ccc63065-2976-88ef-1211-731330bf2866@infradead.org/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 701d2054fa31 ("fbdev: Make support for userspace interfaces configurable")
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  drivers/video/fbdev/ps3fb.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
> index 5aedc30c5f7e..64d291d6b153 100644
> --- a/drivers/video/fbdev/ps3fb.c
> +++ b/drivers/video/fbdev/ps3fb.c
> @@ -1168,9 +1168,7 @@ static int ps3fb_probe(struct ps3_system_bus_device *dev)
>  
>  	ps3_system_bus_set_drvdata(dev, info);
>  
> -	dev_info(info->device, "%s %s, using %u KiB of video memory\n",
> -		 dev_driver_string(info->dev), dev_name(info->dev),
> -		 info->fix.smem_len >> 10);
> +	fb_info(info, "using %u KiB of video memory\n", info->fix.smem_len >> 10);
>  
>  	task = kthread_run(ps3fbd, info, DEVICE_NAME);
>  	if (IS_ERR(task)) {
> -- 
> 2.41.0
