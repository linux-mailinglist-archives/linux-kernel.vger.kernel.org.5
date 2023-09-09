Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BAD3799A2E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 19:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbjIIRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 13:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjIIRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 13:05:33 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498A89C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 10:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1694279124; bh=n6XYvU0I6OlN6ZT+DVICFQ8YyaakTDFD13vykeRCZwQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ku0aRmJtm1PhKG+qBpkqcNXBUZtH9b6n/P95iS8G9gVzWBeegPildMRKwsigJtA0L
         iFSxJUUSvham7+EKS9diq+EMEaWDx9DpaJbjvRK40bclmsaEeDpEldllER0VF6RBDi
         RIeG7EtLkROU2KYkvFAc5ue/iTrG+IQcNuzrC/MY=
Received: from [192.168.9.172] (unknown [101.88.25.36])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id E2B8560117;
        Sun, 10 Sep 2023 01:05:23 +0800 (CST)
Message-ID: <fc0f52e0-99a7-bde7-6674-9c1c579c6bc7@xen0n.name>
Date:   Sun, 10 Sep 2023 01:05:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] kasan: Cleanup the __HAVE_ARCH_SHADOW_MAP usage
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Cc:     loongarch@lists.linux.dev, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20230909115450.1903218-1-chenhuacai@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20230909115450.1903218-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/9/23 19:54, Huacai Chen wrote:
> As Linus suggested, __HAVE_ARCH_XYZ is stupid and only for historical
> uses. So cleanup the __HAVE_ARCH_SHADOW_MAP usage and use self-defined

For the first sentence, I suggest adding quotation marks to make the 
opinion expression clearer. And paraphrasing a bit:

 > As Linus suggested, __HAVE_ARCH_XYZ is "stupid" and "having 
historical uses of it doesn't make it good".

What do you think?

> macros instead.
"self-defined macro" doesn't really make sense, at least to me. I'd 
suggest something like "migrate __HAVE_ARCH_SHADOW_MAP to separate 
macros named after the respective functions", what about this one?
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   arch/loongarch/include/asm/kasan.h | 10 ++++++++--
>   include/linux/kasan.h              |  2 +-
>   mm/kasan/kasan.h                   |  8 +++-----
>   3 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
> index deeff8158f45..a12ecab37da7 100644
> --- a/arch/loongarch/include/asm/kasan.h
> +++ b/arch/loongarch/include/asm/kasan.h
> @@ -10,8 +10,6 @@
>   #include <asm/io.h>
>   #include <asm/pgtable.h>
>   
> -#define __HAVE_ARCH_SHADOW_MAP
> -
>   #define KASAN_SHADOW_SCALE_SHIFT 3
>   #define KASAN_SHADOW_OFFSET	_AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>   
> @@ -68,6 +66,7 @@ static __always_inline bool kasan_arch_is_ready(void)
>   	return !kasan_early_stage;
>   }
>   
> +#define kasan_mem_to_shadow kasan_mem_to_shadow
>   static inline void *kasan_mem_to_shadow(const void *addr)
>   {
>   	if (!kasan_arch_is_ready()) {
> @@ -97,6 +96,7 @@ static inline void *kasan_mem_to_shadow(const void *addr)
>   	}
>   }
>   
> +#define kasan_shadow_to_mem kasan_shadow_to_mem
>   static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>   {
>   	unsigned long addr = (unsigned long)shadow_addr;
> @@ -119,6 +119,12 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>   	}
>   }
>   
> +#define addr_has_metadata addr_has_metadata
> +static __always_inline bool addr_has_metadata(const void *addr)
> +{
> +	return (kasan_mem_to_shadow((void *)addr) != NULL);
Drop the outermost pair of parens that's not necessary? It's only a 
simple comparison after all (although the left hand side is a bit "heavy").
> +}
> +
>   void kasan_init(void);
>   asmlinkage void kasan_early_init(void);
>   
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 3df5499f7936..842623d708c2 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -54,7 +54,7 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>   int kasan_populate_early_shadow(const void *shadow_start,
>   				const void *shadow_end);
>   
> -#ifndef __HAVE_ARCH_SHADOW_MAP
> +#ifndef kasan_mem_to_shadow
>   static inline void *kasan_mem_to_shadow(const void *addr)
>   {
>   	return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index f70e3d7a602e..d37831b8511c 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -291,7 +291,7 @@ struct kasan_stack_ring {
>   
>   #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>   
> -#ifndef __HAVE_ARCH_SHADOW_MAP
> +#ifndef kasan_shadow_to_mem
>   static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>   {
>   	return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET)
> @@ -299,15 +299,13 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>   }
>   #endif
>   
> +#ifndef addr_has_metadata
>   static __always_inline bool addr_has_metadata(const void *addr)
>   {
> -#ifdef __HAVE_ARCH_SHADOW_MAP
> -	return (kasan_mem_to_shadow((void *)addr) != NULL);
> -#else
>   	return (kasan_reset_tag(addr) >=
>   		kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> -#endif
>   }
> +#endif
>   
>   /**
>    * kasan_check_range - Check memory region, and report if invalid access.

The other parts look mechanical and okay to me. With the minor nits 
addressed (or justified):

Reviewed-by: WANG Xuerui <git@xen0n.name>

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

