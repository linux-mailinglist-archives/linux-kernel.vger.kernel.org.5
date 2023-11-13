Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA67E9669
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 06:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjKMFBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 00:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMFBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 00:01:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4DF107
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 21:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699851645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0H6pBIlKItgej+nMcwGiXmrehlEQnc5Kln2hfEgiJXg=;
        b=IBJXk8IWUX5fDEu98bJ4b7sTemAj81Y0p3cJXDnekkUxTOuyM+Za1pdRDEzwAIIknz2H9V
        JmXWbKzq3x355ZrYbRCeMMYHZxiVqYTU3L7HA68wEqXKUab/QjlRYY8YKcelJ0PA9CkK+y
        ViXEvruFt5ib4LHLLczLslv5gWufJSU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-xhPcS1UqMAS1YtMMFYkbtQ-1; Mon, 13 Nov 2023 00:00:40 -0500
X-MC-Unique: xhPcS1UqMAS1YtMMFYkbtQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B0C0828CE8;
        Mon, 13 Nov 2023 05:00:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66658502C;
        Mon, 13 Nov 2023 05:00:37 +0000 (UTC)
Date:   Mon, 13 Nov 2023 13:00:34 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
Subject: Re: [PATCH] x86/setup: Make relocated_ramdisk a local variable of
 relocate_initrd()
Message-ID: <ZVGtclq4f33e/TWZ@MiWiFi-R3L-srv>
References: <20231113034026.130679-1-ytcoode@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113034026.130679-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/23 at 11:40am, Yuntao Wang wrote:
> After commit 0b62f6cb0773 ("x86/microcode/32: Move early loading after
> paging enable"), the global variable relocated_ramdisk is no longer used
> anywhere except for the relocate_initrd() function. Make it a local
> variable of that function.

It's true.

Reviewed-by: Baoquan He <bhe@redhat.com>

> ---
>  arch/x86/include/asm/setup.h | 2 --
>  arch/x86/kernel/setup.c      | 4 +---
>  2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
> index bf483fcb4e57..5c83729c8e71 100644
> --- a/arch/x86/include/asm/setup.h
> +++ b/arch/x86/include/asm/setup.h
> @@ -31,8 +31,6 @@
>  #include <asm/bootparam.h>
>  #include <asm/x86_init.h>
>  
> -extern u64 relocated_ramdisk;
> -
>  /* Interrupt control for vSMPowered x86_64 systems */
>  #ifdef CONFIG_X86_64
>  void vsmp_init(void);
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 1526747bedf2..ec2c21a1844e 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -226,8 +226,6 @@ static void __init reserve_brk(void)
>  	_brk_start = 0;
>  }
>  
> -u64 relocated_ramdisk;
> -
>  #ifdef CONFIG_BLK_DEV_INITRD
>  
>  static u64 __init get_ramdisk_image(void)
> @@ -261,7 +259,7 @@ static void __init relocate_initrd(void)
>  	u64 area_size     = PAGE_ALIGN(ramdisk_size);
>  
>  	/* We need to move the initrd down into directly mapped mem */
> -	relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
> +	u64 relocated_ramdisk = memblock_phys_alloc_range(area_size, PAGE_SIZE, 0,
>  						      PFN_PHYS(max_pfn_mapped));
>  	if (!relocated_ramdisk)
>  		panic("Cannot find place for new RAMDISK of size %lld\n",
> -- 
> 2.42.1
> 

