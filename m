Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAEA79B6C7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:05:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348490AbjIKV1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjIKKRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4EEEC103
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 03:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694427369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Idpm1MsTIMkQeLscANw6c5qO2H9vlf95D23Ujw5h12Y=;
        b=bjDF30/AlYxy/u1QjCf53mdtx7RslqenPcTVo4YDAyqQg4IhNfmBXaUVutm24N7tU6/tW+
        0oSFYCdXT1KvvrI1WeP9IoX3SogTH+dbJovqCIR3VyLx39ICerKDPyOorjrYBhRx3yows0
        blcKThhRy5PYDBoIJMdWQfI/tz8jarI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-140-ReNWdvrBOJOCrFLzcN4uOg-1; Mon, 11 Sep 2023 06:16:07 -0400
X-MC-Unique: ReNWdvrBOJOCrFLzcN4uOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 283503811F25;
        Mon, 11 Sep 2023 10:16:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.35])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 315D110F1BE9;
        Mon, 11 Sep 2023 10:16:05 +0000 (UTC)
Date:   Mon, 11 Sep 2023 18:16:02 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: mm: Re-add lost __ref to ioremap_prot() to fix
 modpost warning
Message-ID: <ZP7o4np4v0bth8dj@MiWiFi-R3L-srv>
References: <20230911093850.1517389-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230911093850.1517389-1-geert+renesas@glider.be>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/23 at 11:38am, Geert Uytterhoeven wrote:
> When __ioremap_caller() was replaced by ioremap_prot(), the __ref
> annotation added in commit af1415314a4190b8 ("sh: Flag
> __ioremap_caller() __init_refok.") was removed, causing a modpost
> warning:
> 
>     WARNING: modpost: vmlinux: section mismatch in reference: ioremap_prot+0x88 (section: .text) -> ioremap_fixed (section: .init.text)
> 
> ioremap_prot() calls ioremap_fixed() (which is marked __init), but only
> before mem_init_done becomes true, so this is safe.  Hence fix this by
> re-adding the lost __ref.
> 
> Fixes: 0453c9a78015cb22 ("sh: mm: convert to GENERIC_IOREMAP")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/sh/mm/ioremap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
> index c33b3daa4ad1a3e6..33d20f34560fd5cb 100644
> --- a/arch/sh/mm/ioremap.c
> +++ b/arch/sh/mm/ioremap.c
> @@ -72,8 +72,8 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
>  #define __ioremap_29bit(offset, size, prot)		NULL
>  #endif /* CONFIG_29BIT */
>  
> -void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
> -			   unsigned long prot)
> +void __iomem __ref *ioremap_prot(phys_addr_t phys_addr, size_t size,
> +				 unsigned long prot)

Sorry for the mistake, and I possibly missed the warning when building. 

Reviewed-by: Baoquan He <bhe@redhat.com>

>  {
>  	void __iomem *mapped;
>  	pgprot_t pgprot = __pgprot(prot);
> -- 
> 2.34.1
> 

