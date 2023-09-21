Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8097A9934
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjIUSMN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Sep 2023 14:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjIUSLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:11:24 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A788485;
        Thu, 21 Sep 2023 10:38:54 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qjDkX-003HZ5-Oh; Thu, 21 Sep 2023 09:05:21 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qjDkX-0029eD-7S; Thu, 21 Sep 2023 09:05:21 +0200
Message-ID: <cea63c1eb47c9a438d21bc1fce5a48e4b3235342.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] fbdev: sh7760fb: require FB=y to build cleanly
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org
Date:   Thu, 21 Sep 2023 09:05:20 +0200
In-Reply-To: <20230921060228.29041-1-rdunlap@infradead.org>
References: <20230921060228.29041-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy!

On Wed, 2023-09-20 at 23:02 -0700, Randy Dunlap wrote:
> Fix build errors when CONFIG_FB=m and CONFIG_FB_SH7760=y:
> 
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
> sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
> sh2-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
> sh2-linux-ld: sh7760fb.c:(.text+0x3a0): undefined reference to `fb_alloc_cmap'
> sh2-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
> sh2-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
> sh2-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
> sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
> sh2-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
> sh2-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
> 
> Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> ---
>  drivers/video/fbdev/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -1762,7 +1762,7 @@ config FB_COBALT
>  
>  config FB_SH7760
>  	bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
> -	depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
> +	depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>  		|| CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
>  	select FB_IOMEM_HELPERS
>  	help

Actually, Thomas Zimmermann already posted the same patch already on Monday ;-).

See [1].

Adrian

> [1] https://marc.info/?l=dri-devel&m=169502772500717&w=2

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
