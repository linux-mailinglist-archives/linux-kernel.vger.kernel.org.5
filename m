Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6226676BD92
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 21:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHATWE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 1 Aug 2023 15:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjHATWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 15:22:03 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B158C1BF1;
        Tue,  1 Aug 2023 12:21:58 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qQuwF-001bwY-Bp; Tue, 01 Aug 2023 21:21:47 +0200
Received: from p57ae5424.dip0.t-ipconnect.de ([87.174.84.36] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qQuwF-001Voi-33; Tue, 01 Aug 2023 21:21:47 +0200
Message-ID: <c48f6f3c742eaf35e35882064ccf4ed07d4e63fe.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v8 11/19] sh: add <asm-generic/io.h> including
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Date:   Tue, 01 Aug 2023 21:21:45 +0200
In-Reply-To: <09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com>
References: <20230706154520.11257-1-bhe@redhat.com>
         <20230706154520.11257-12-bhe@redhat.com>
         <CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com>
         <0f771b11539d5a3871691af901315ee2034b577c.camel@physik.fu-berlin.de>
         <09094baf-dadf-4bce-9f63-f2a1f255f9a8@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.174.84.36
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

On Mon, 2023-07-10 at 12:47 +0200, Arnd Bergmann wrote:
> It looks like only the "noioport" variant got some of the
> extra macro definitions, but the version for PCI still needs the
> same six macros, plus the ones of inb/outb etc, something like
> this:
> 
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index 24c560c065ec7..2135e32145c54 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -241,6 +241,26 @@ __BUILD_IOPORT_STRING(q, u64)
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
>         BUG();
>  }
>  
> -#define inb_p(addr)    inb(addr)
> -#define inw_p(addr)    inw(addr)
> -#define inl_p(addr)    inl(addr)
> -#define outb_p(x, addr)        outb((x), (addr))
> -#define outw_p(x, addr)        outw((x), (addr))
> -#define outl_p(x, addr)        outl((x), (addr))
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
>         BUG();

I am fine with this fix.

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

> I think ideally all the I/O port stuff in arch/sh/ could just be
> removed after the conversion to asm-generic/io.h, but the
> microdev_ioport_map() function oddity gets in the way of that,
> unless someone wants to clean up that platform. As far as I
> can tell, the ethernet, display, USB and PCI devices on it already
> broke at some point (afbb9d8d5266b, 46bc85872040a), so it might
> be easier to remove it entirely.

I don't have this particular hardware, so I cannot comment on this.

> > I'm not happy though that this patch is in linux-next without being Acked by me
> > or being reviewed by anyone. We should always make sure first that the code
> > actually builds and has been tested on real hardware.
> 
> I think that if the series has been posted eight times, you had
> your chance to do a review, especially since I pointed out that
> merging this one would have avoid the unxlate_dev_mem_ptr() bug
> as well.

I have only been the maintainer of arch/sh for a few weeks, so it's natural
that I am not doing a perfect job and might miss something. Also, I am not
getting paid for this work, I am doing this in my free time.

> Having the series go into linux-next sounds appropriate like this,
> the entire purpose of that is to find such bugs and Andrew can jus
> fold the fixup into the broken patch. 
> 
> Let me know if you prefer the simple version with the extra
> #defines or if we should just use the generic inb/outb implementation
> immediately and drop microdev in a separate patch.

Please go ahead with the simple version.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
