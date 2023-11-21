Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23847F313E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbjKUOjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbjKUOjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:39:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE01D79
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:39:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2F0C433C7;
        Tue, 21 Nov 2023 14:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700577551;
        bh=Rgwpz07c1q8jqP42LEJ6TqgBkDZM4Uyef1S2Y0dhmsU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zp8QyNqWjCLtTejwHUCnoJWacq53Ung0mqELDGYtnOmOYCyNeJ5qJL6d9w1B6Ir3X
         7HySK/PZwixEfIX/eUiV0DPp2oVfvi17uOyesJNuKJnkc9xUMAYd3etinpYvTVkwYz
         y1U9W3zy8NyJp6G6fk1MwLfVMloUOMRkzeu/mHbRpdk0Tr244F+vBR0d7r8x+29Wku
         NqvNQta9SfUFcHdJbGROSVrG0maunDyosKXbTxGsEF77OpP58Pm2H9YDrkv+40uL91
         qyctDoeK92L8NmlNpu7Nxc/p2npnysQQ4PTm/hxDm7Sh3kzUSU+YTaZlX9VSYGdClP
         QJcbMtdyBY2lg==
Message-ID: <1f38c998-93e9-4dbb-abc8-401d8175dad4@kernel.org>
Date:   Wed, 22 Nov 2023 00:39:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 32/34] m68k: rework get_mmu_context()
Content-Language: en-US
To:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-m68k@lists.linux-m68k.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
 <20231118155105.25678-33-yury.norov@gmail.com>
From:   Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20231118155105.25678-33-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yury,

On 19/11/23 01:51, Yury Norov wrote:
> ALSA code opencodes atomic find_and_set_bit_wrap(). Switch it to
   ^^^^
m68k?


> dedicated function.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Looks ok to me:

Acked-by: Greg Ungerer <gerg@linux-m68k.org>

Regards
Greg



> ---
>   arch/m68k/include/asm/mmu_context.h | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
> index 141bbdfad960..0419ad87a1c1 100644
> --- a/arch/m68k/include/asm/mmu_context.h
> +++ b/arch/m68k/include/asm/mmu_context.h
> @@ -35,12 +35,11 @@ static inline void get_mmu_context(struct mm_struct *mm)
>   		atomic_inc(&nr_free_contexts);
>   		steal_context();
>   	}
> -	ctx = next_mmu_context;
> -	while (test_and_set_bit(ctx, context_map)) {
> -		ctx = find_next_zero_bit(context_map, LAST_CONTEXT+1, ctx);
> -		if (ctx > LAST_CONTEXT)
> -			ctx = 0;
> -	}
> +
> +	do {
> +		ctx = find_and_set_bit_wrap(context_map, LAST_CONTEXT + 1, next_mmu_context);
> +	} while (ctx > LAST_CONTEXT);
> +
>   	next_mmu_context = (ctx + 1) & LAST_CONTEXT;
>   	mm->context = ctx;
>   	context_mm[ctx] = mm;
