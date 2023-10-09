Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16C27BD50A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjJIIXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbjJIIW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:22:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E745A6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:22:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D66BF1F381;
        Mon,  9 Oct 2023 08:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1696839772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ltim8RkRSSqPgm0ql2XAEhJ6hUxAtgiV2v1yn1uhPQM=;
        b=Dnp9qdIkDf2OXVviSN1s+N/4/lXQO89UbuJsLcH0zIqIDaWyQPlRxUDnV/mjeQhyf6qFYC
        0ELbIZJNi5Tqvg9BY8+Y4+f4BihLv1RyKBeOPP/V3vk8o21eRzK583DhmEGexY2D3GgDjL
        y33/+gBBASG4oaEF8quNzihBeNZtrQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1696839772;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ltim8RkRSSqPgm0ql2XAEhJ6hUxAtgiV2v1yn1uhPQM=;
        b=Jf2niAiYSKt+zb609/CfRb5OzE2JbOUud7bw+DR6dAyIF359So3j+SgdFtIO/Wg65uDdNg
        W+cv6vXq63XUlYDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1E4B13586;
        Mon,  9 Oct 2023 08:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JjK5Kly4I2WkPwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 09 Oct 2023 08:22:52 +0000
Message-ID: <a09a6fe5-2352-8922-e575-54bf74ae64e5@suse.cz>
Date:   Mon, 9 Oct 2023 10:22:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RESEND PATCH] mm: slab: Do not create kmalloc caches smaller
 than arch_slab_minalign()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>
References: <20231006163934.3273940-1-catalin.marinas@arm.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20231006163934.3273940-1-catalin.marinas@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 18:39, Catalin Marinas wrote:
> Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
> if DMA bouncing possible") allows architectures with non-coherent DMA to
> define a small ARCH_KMALLOC_MINALIGN (e.g. sizeof(unsigned long long))
> and this has been enabled on arm64. With KASAN_HW_TAGS enabled, however,
> ARCH_SLAB_MINALIGN becomes 16 on arm64 (arch_slab_minalign() dynamically
> selects it since commit d949a8155d13 ("mm: make minimum slab alignment a
> runtime property")). This can lead to a situation where kmalloc-8 caches
> are attempted to be created with a kmem_caches.size aligned to 16. When
> the cache is mergeable, it can lead to kernel warnings like:
> 
> sysfs: cannot create duplicate filename '/kernel/slab/:d-0000016'
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc1-00001-gda98843cd306-dirty #5
> Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
> Call trace:
>  dump_backtrace+0x90/0xe8
>  show_stack+0x18/0x24
>  dump_stack_lvl+0x48/0x60
>  dump_stack+0x18/0x24
>  sysfs_warn_dup+0x64/0x80
>  sysfs_create_dir_ns+0xe8/0x108
>  kobject_add_internal+0x98/0x264
>  kobject_init_and_add+0x8c/0xd8
>  sysfs_slab_add+0x12c/0x248
>  slab_sysfs_init+0x98/0x14c
>  do_one_initcall+0x6c/0x1b0
>  kernel_init_freeable+0x1c0/0x288
>  kernel_init+0x24/0x1e0
>  ret_from_fork+0x10/0x20
> kobject: kobject_add_internal failed for :d-0000016 with -EEXIST, don't try to register things with the same name in the same directory.
> SLUB: Unable to add boot slab dma-kmalloc-8 to sysfs
> 
> Limit the __kmalloc_minalign() return value (used to create the
> kmalloc-* caches) to arch_slab_minalign() so that kmalloc-8 caches are
> skipped when KASAN_HW_TAGS is enabled (both config and runtime).
> 
> Fixes: b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment if DMA bouncing possible")
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: <stable@vger.kernel.org> # 6.5.x
> ---
> 
> The previous post was messed up by my git send-email configuration, so
> sending it again. Also cc'ing Vlastimil since he reviewed the previous
> slab changes for ARCH_KMALLOC_MINALIGN. Thanks.

It also touches only slab files so I can take it via slab tree.

>  mm/slab_common.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index cd71f9581e67..8b45922ed295 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -895,10 +895,13 @@ void __init setup_kmalloc_cache_index_table(void)
>  
>  static unsigned int __kmalloc_minalign(void)
>  {
> +	unsigned int minalign = dma_get_cache_alignment();
> +
>  	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
>  	    is_swiotlb_allocated())
> -		return ARCH_KMALLOC_MINALIGN;
> -	return dma_get_cache_alignment();
> +		minalign = ARCH_KMALLOC_MINALIGN;
> +
> +	return ALIGN(minalign, arch_slab_minalign());

Could it be max() instead of ALIGN()? It would be more obvious, at least to
me :)

>  }
>  
>  void __init

