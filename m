Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7757ABC45
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjIVX1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbjIVX1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:27:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903001A5;
        Fri, 22 Sep 2023 16:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=e8yFnfvH8JKoyp3aR9fSLHVbC7SF8CuDkjkUeoufqfk=; b=JGXd2C0i6TG9hdIvK+EcQwcxjZ
        e2EbPtXPYbToivjN0PcBI+CpyX1tperD4GPzxUU0nQMjl6QpkTBufReIFGz4l8vL0UwsT8qPyJxKP
        d4qD20U98UCtEhtkJmFG8Vr+n0QAp5bB0jkdG7FR4yRr6UN1kTefoIJlauqPymdQk0rYsgiTkP5KN
        Vm5UhTOBP0QVNA0Blua6DaZnYsf8+bSTAdJQPxyDVDUVRqJuXcgN080eZGHlxEJDDeeb+j2PiszA+
        pOQEVatXhfFi9NAVF24VDGZZmFa9RtAFq1Z6B8Sp5S5zEfP3LELwI15MND2XhKIgU8WXKnjMwzBWW
        muRgYyKg==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qjpYG-009yq5-19;
        Fri, 22 Sep 2023 23:27:12 +0000
Message-ID: <a2537bfc-d7c6-4afc-acb3-f049ba82249e@infradead.org>
Date:   Fri, 22 Sep 2023 16:27:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: sh7760fb: require FB=y to build cleanly
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
References: <20230921060228.29041-1-rdunlap@infradead.org>
 <CAMuHMdWBhCcUJw00ZzeHJ=x62RGP2MJ8H-AXRHxBrfOaGeU8Dw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMuHMdWBhCcUJw00ZzeHJ=x62RGP2MJ8H-AXRHxBrfOaGeU8Dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,


On 9/22/23 00:23, Geert Uytterhoeven wrote:
> Hi Randy,
> 
> On Thu, Sep 21, 2023 at 10:43 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>> Fix build errors when CONFIG_FB=m and CONFIG_FB_SH7760=y:
>>
>> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_probe':
>> sh7760fb.c:(.text+0x374): undefined reference to `framebuffer_alloc'
>> sh2-linux-ld: sh7760fb.c:(.text+0x394): undefined reference to `fb_videomode_to_var'
>> sh2-linux-ld: sh7760fb.c:(.text+0x3a0): undefined reference to `fb_alloc_cmap'
>> sh2-linux-ld: sh7760fb.c:(.text+0x3a4): undefined reference to `register_framebuffer'
>> sh2-linux-ld: sh7760fb.c:(.text+0x3ac): undefined reference to `fb_dealloc_cmap'
>> sh2-linux-ld: sh7760fb.c:(.text+0x434): undefined reference to `framebuffer_release'
>> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o: in function `sh7760fb_remove':
>> sh7760fb.c:(.text+0x800): undefined reference to `unregister_framebuffer'
>> sh2-linux-ld: sh7760fb.c:(.text+0x804): undefined reference to `fb_dealloc_cmap'
>> sh2-linux-ld: sh7760fb.c:(.text+0x814): undefined reference to `framebuffer_release'
>> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0xc): undefined reference to `fb_io_read'
>> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x10): undefined reference to `fb_io_write'
>> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x2c): undefined reference to `cfb_fillrect'
>> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x30): undefined reference to `cfb_copyarea'
>> sh2-linux-ld: drivers/video/fbdev/sh7760fb.o:(.rodata+0x34): undefined reference to `cfb_imageblit'
>>
>> Fixes: 4a25e41831ee ("video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Thanks for your patch!
> 
>> --- a/drivers/video/fbdev/Kconfig
>> +++ b/drivers/video/fbdev/Kconfig
>> @@ -1762,7 +1762,7 @@ config FB_COBALT
>>
>>  config FB_SH7760
>>         bool "SH7760/SH7763/SH7720/SH7721 LCDC support"
>> -       depends on FB && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>> +       depends on FB=y && (CPU_SUBTYPE_SH7760 || CPU_SUBTYPE_SH7763 \
>>                 || CPU_SUBTYPE_SH7720 || CPU_SUBTYPE_SH7721)
>>         select FB_IOMEM_HELPERS
>>         help
> 
> Any reason this can't become tristate instead?
> drivers/video/fbdev/sh7760fb.c uses module_platform_driver(), and
> already has all needed MODULE_*().

That's what I tried to ask here:
  https://lore.kernel.org/all/feadd6a5-0f56-4575-9891-3a7d88e69e64@infradead.org/
but nobody replied to that.

-- 
~Randy
