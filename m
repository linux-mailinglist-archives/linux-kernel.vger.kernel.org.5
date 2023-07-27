Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62B7650F6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjG0KXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbjG0KXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4B6271C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690453359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=57Meadi7QFswEYNF22UlYnn+TVRooVmdRcPd9UdXeaw=;
        b=JKvxP6mDdiAAOoCqfBO5pDfdVwaWoeJDebYzsgGGp7A6aKnQDknHtzrTepTp0u4xhHuqSh
        xiXp4/al8eeZBKmr99ZLpHRexK4Wn3CC9kNeVlJWBoaFu4d+doL+BB46E9K/bPxTN9462o
        IHEEEn8G6Ac0k+dILnR2uCV4nyyGWB0=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-o4dkN_EZN6CJUT6ZaTBvsA-1; Thu, 27 Jul 2023 06:22:36 -0400
X-MC-Unique: o4dkN_EZN6CJUT6ZaTBvsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0598C3811F34;
        Thu, 27 Jul 2023 10:22:36 +0000 (UTC)
Received: from localhost (unknown [10.72.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2B98A140E949;
        Thu, 27 Jul 2023 10:22:34 +0000 (UTC)
Date:   Thu, 27 Jul 2023 18:22:31 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomem: remove __weak ioremap_cache helper
Message-ID: <ZMJFZ2uGJPpkPoLX@MiWiFi-R3L-srv>
References: <20230726145432.1617809-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726145432.1617809-1-arnd@kernel.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/23 at 04:54pm, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> No portable code calls into this function any more, and on
> architectures that don't use or define their own, it causes
> a warning:
> 
> kernel/iomem.c:10:22: warning: no previous prototype for 'ioremap_cache' [-Wmissing-prototypes]
>    10 | __weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
> 
> Fold it into the only caller that uses it on architectures
> without the #define.
> 
> Note that the fallback to ioremap is probably still wrong on
> those architectures, but this is what it's always done there.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/iomem.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/iomem.c b/kernel/iomem.c
> index 9682471e64717..dc2120776e1c3 100644
> --- a/kernel/iomem.c
> +++ b/kernel/iomem.c
> @@ -5,18 +5,14 @@
>  #include <linux/mm.h>
>  #include <linux/ioremap.h>
>  
> -#ifndef ioremap_cache
> -/* temporary while we convert existing ioremap_cache users to memremap */
> -__weak void __iomem *ioremap_cache(resource_size_t offset, unsigned long size)
> -{
> -	return ioremap(offset, size);
> -}
> -#endif
> -
>  #ifndef arch_memremap_wb
>  static void *arch_memremap_wb(resource_size_t offset, unsigned long size)
>  {
> +#ifdef ioremap_cache
>  	return (__force void *)ioremap_cache(offset, size);
> +#else
> +	return (__force void *)ioremap(offset, size);
> +#endif
>  }
>  #endif

This looks good to me, thanks.

Reviewed-by: Baoquan He <bhe@redhat.com>

