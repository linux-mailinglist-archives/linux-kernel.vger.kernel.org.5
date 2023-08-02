Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6060A76DBAC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 01:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjHBXjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 19:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjHBXjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 19:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A3630C3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 16:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691019532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KiRvUGIiUnMag28jDPEEXHJmYiUaV/9Rk0O8AAXGo3Q=;
        b=Kbkz/9nVx2PF7EjD2Ca/CCRpBX20b/HuKftNA6zccidcEv/Sx8bqkF3nfBVVmv+ZIZ0zXa
        RKwl73EbleqPHixXKMOknZ+8odz7bfRvvw2+syUsJMb0i3lL1dgfqyR2lFI/lqD7saZTv5
        5IF/k8ceTXNoC/YfDGL24XBZ2vwnmKc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-543-1lo3QONUPdqoULmts557vw-1; Wed, 02 Aug 2023 19:38:49 -0400
X-MC-Unique: 1lo3QONUPdqoULmts557vw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA0B8280D208;
        Wed,  2 Aug 2023 23:38:48 +0000 (UTC)
Received: from localhost (ovpn-12-41.pek2.redhat.com [10.72.12.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E3B3940C2063;
        Wed,  2 Aug 2023 23:38:47 +0000 (UTC)
Date:   Thu, 3 Aug 2023 07:38:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: fix asm-generic/io.h inclusion
Message-ID: <ZMrpBDJYcLwrMJ2y@MiWiFi-R3L-srv>
References: <20230802141658.2064864-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230802141658.2064864-1-arnd@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/23 at 04:16pm, Arnd Bergmann wrote:
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
> 
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

Thanks for this fixing.

Reviewed-by: Baoquan He <bhe@redhat.com>

