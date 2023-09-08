Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AF079857C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbjIHKLB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 8 Sep 2023 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjIHKLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:11:00 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBAA1BD3;
        Fri,  8 Sep 2023 03:10:56 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qeYRy-000jn3-Ay; Fri, 08 Sep 2023 12:10:54 +0200
Received: from p5b13a40a.dip0.t-ipconnect.de ([91.19.164.10] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qeYRy-001wF1-3O; Fri, 08 Sep 2023 12:10:54 +0200
Message-ID: <d737e5a40f7e2009222d98de7696cc78740869e3.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 4/4] sh: machvec: remove custom ioport_{un,}map()
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 08 Sep 2023 12:10:53 +0200
In-Reply-To: <20230802184849.1019466-4-arnd@kernel.org>
References: <20230802184849.1019466-1-arnd@kernel.org>
         <20230802184849.1019466-4-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.10
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd!

On Wed, 2023-08-02 at 20:48 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> These functions were only used on the microdev
> board that is now gone, so remove them to simplify
> the ioport handling.
> 
> This could be further simplified to use the generic
> I/O port accessors now.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sh/include/asm/io.h      |  4 ++--
>  arch/sh/include/asm/machvec.h |  5 -----
>  arch/sh/kernel/ioport.c       | 13 +------------
>  3 files changed, 3 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
> index f2f38e9d489ac..ac521f287fa59 100644
> --- a/arch/sh/include/asm/io.h
> +++ b/arch/sh/include/asm/io.h
> @@ -181,7 +181,7 @@ static inline void pfx##out##bwlq##p(type val, unsigned long port)	\
>  {									\
>  	volatile type *__addr;						\
>  									\
> -	__addr = __ioport_map(port, sizeof(type));			\
> +	__addr = (void __iomem *)sh_io_port_base + port;		\
>  	*__addr = val;							\
>  	slow;								\
>  }									\
> @@ -191,7 +191,7 @@ static inline type pfx##in##bwlq##p(unsigned long port)			\
>  	volatile type *__addr;						\
>  	type __val;							\
>  									\
> -	__addr = __ioport_map(port, sizeof(type));			\
> +	__addr = (void __iomem *)sh_io_port_base + port;		\
>  	__val = *__addr;						\
>  	slow;								\
>  									\
> diff --git a/arch/sh/include/asm/machvec.h b/arch/sh/include/asm/machvec.h
> index 2b4b085e8f219..4e5314b921f19 100644
> --- a/arch/sh/include/asm/machvec.h
> +++ b/arch/sh/include/asm/machvec.h
> @@ -19,11 +19,6 @@ struct sh_machine_vector {
>  	int (*mv_irq_demux)(int irq);
>  	void (*mv_init_irq)(void);
>  
> -#ifdef CONFIG_HAS_IOPORT_MAP
> -	void __iomem *(*mv_ioport_map)(unsigned long port, unsigned int size);
> -	void (*mv_ioport_unmap)(void __iomem *);
> -#endif
> -
>  	int (*mv_clk_init)(void);
>  	int (*mv_mode_pins)(void);
>  
> diff --git a/arch/sh/kernel/ioport.c b/arch/sh/kernel/ioport.c
> index f39446a658bdb..c8aff8a20164d 100644
> --- a/arch/sh/kernel/ioport.c
> +++ b/arch/sh/kernel/ioport.c
> @@ -12,15 +12,6 @@
>  unsigned long sh_io_port_base __read_mostly = -1;
>  EXPORT_SYMBOL(sh_io_port_base);
>  
> -void __iomem *__ioport_map(unsigned long addr, unsigned int size)
> -{
> -	if (sh_mv.mv_ioport_map)
> -		return sh_mv.mv_ioport_map(addr, size);
> -
> -	return (void __iomem *)(addr + sh_io_port_base);
> -}
> -EXPORT_SYMBOL(__ioport_map);
> -
>  void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
>  	void __iomem *ret;
> @@ -29,13 +20,11 @@ void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  	if (ret)
>  		return ret;
>  
> -	return __ioport_map(port, nr);
> +	return (void __iomem *)(port + sh_io_port_base);
>  }
>  EXPORT_SYMBOL(ioport_map);
>  
>  void ioport_unmap(void __iomem *addr)
>  {
> -	if (sh_mv.mv_ioport_unmap)
> -		sh_mv.mv_ioport_unmap(addr);
>  }
>  EXPORT_SYMBOL(ioport_unmap);

Why aren't you removing the function ioport_unmap(void __iomem *addr) completely
and just turn it into stub? Is it still referenced somewhere?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
