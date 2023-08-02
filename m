Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4458A76D5AB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjHBRkR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Aug 2023 13:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjHBRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:40:06 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E33583;
        Wed,  2 Aug 2023 10:39:42 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qRFfp-002UL6-Dq; Wed, 02 Aug 2023 19:30:13 +0200
Received: from p5b13a085.dip0.t-ipconnect.de ([91.19.160.133] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qRFfp-000el0-6B; Wed, 02 Aug 2023 19:30:13 +0200
Message-ID: <373656535c754006ca1abe736fffa2be3925b0aa.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: fix asm-generic/io.h inclusion
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Baoquan He <bhe@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 02 Aug 2023 19:30:11 +0200
In-Reply-To: <20230802141658.2064864-1-arnd@kernel.org>
References: <20230802141658.2064864-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.160.133
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On Wed, 2023-08-02 at 16:16 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> A recent cleanup patch started using the generic asm/io.h header from
> the sh version, but unfortunately this caused build regressions in many
> configurations, such as:
> 
> include/asm-generic/io.h:636:15: error: redefinition of ‘inb_p’
> 
> I added some of the missing defines that are needed to keep using the
> sh specific implementations rather than the generic ones where they
> clash. I build all sh defconfig files to catch the various combinations
> of CONFIG_MMU, CONFIG_GENERIC_IOMAP and CONFIG_NO_IOPORT_MAP, this should
> cover them all.
> 
> A lot of the sh specific functions are equivalent to the generic ones
> and could in fact be removed, but it would be best to only do that with
> actual runtime testing.
> 
> In particular, the indirect ioport_map() implementation is only used
> for the "microdev" platform that appears to be broken beyond repair
> for as long as the git history goes, so removing both microdev and the
> custom ioport handling in favor of the asm-generic/io.h version would
> be a great cleanup, but this can be done another time if anyone feels
> motivated to clean up arch/sh.

Clean-up will happen with the device tree conversion.

> Fixes: e41f1f7ff6c2b ("sh: add <asm-generic/io.h> including")
> Link: https://lore.kernel.org/lkml/09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com/
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Andrew, can you pick this up into the mm tree on top of the
> "sh: add <asm-generic/io.h> including" patch?
> ---
>  arch/sh/include/asm/io.h          | 24 ++++++++++++++++++++++++
>  arch/sh/include/asm/io_noioport.h | 14 --------------
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index 24c560c065ec7..f2f38e9d489ac 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -119,6 +119,10 @@ void __raw_readsl(const void __iomem *addr, void *data, int longlen);
>  
>  __BUILD_MEMORY_STRING(__raw_, q, u64)
>  
> +#define ioport_map ioport_map
> +#define ioport_unmap ioport_unmap
> +#define pci_iounmap pci_iounmap
> +
>  #define ioread8 ioread8
>  #define ioread16 ioread16
>  #define ioread16be ioread16be
> @@ -241,6 +245,26 @@ __BUILD_IOPORT_STRING(q, u64)
>  
>  #endif
>  
> +#define inb(addr)      inb(addr)
> +#define inw(addr)      inw(addr)
> +#define inl(addr)      inl(addr)
> +#define outb(x, addr)  outb((x), (addr))
> +#define outw(x, addr)  outw((x), (addr))
> +#define outl(x, addr)  outl((x), (addr))
> +
> +#define inb_p(addr)    inb(addr)
> +#define inw_p(addr)    inw(addr)
> +#define inl_p(addr)    inl(addr)
> +#define outb_p(x, addr)        outb((x), (addr))
> +#define outw_p(x, addr)        outw((x), (addr))
> +#define outl_p(x, addr)        outl((x), (addr))
> +
> +#define insb insb
> +#define insw insw
> +#define insl insl
> +#define outsb outsb
> +#define outsw outsw
> +#define outsl outsl
>  
>  #define IO_SPACE_LIMIT 0xffffffff
>  
> diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
> index 5ba4116b4265c..12dad91f41c1e 100644
> --- a/arch/sh/include/asm/io_noioport.h
> +++ b/arch/sh/include/asm/io_noioport.h
> @@ -46,20 +46,6 @@ static inline void ioport_unmap(void __iomem *addr)
>  	BUG();
>  }
>  
> -#define inb_p(addr)	inb(addr)
> -#define inw_p(addr)	inw(addr)
> -#define inl_p(addr)	inl(addr)
> -#define outb_p(x, addr)	outb((x), (addr))
> -#define outw_p(x, addr)	outw((x), (addr))
> -#define outl_p(x, addr)	outl((x), (addr))
> -
> -#define insb insb
> -#define insw insw
> -#define insl insl
> -#define outsb outsb
> -#define outsw outsw
> -#define outsl outsl
> -
>  static inline void insb(unsigned long port, void *dst, unsigned long count)
>  {
>  	BUG();

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
