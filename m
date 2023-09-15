Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192A7A140E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 04:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjIOCy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 22:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjIOCy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 22:54:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D82703;
        Thu, 14 Sep 2023 19:54:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76176C433C8;
        Fri, 15 Sep 2023 02:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694746493;
        bh=BaCEONwWbgZdViDwOmp0Htr99OIatdc7tnMiHomcjCw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NxB8WjdQNtjwfyEehGuYUdRSjJNsIkR3oqVdYBLoFceBdnF+/Rpbmx+Bqkh0zKNj4
         ZJFRescK9cXsVXU2WG5BjNaYHk+5OPmK/foHi8Ev74tIUR5CcglyYhevcUc76Dy1Gc
         1HOtUl4/tYnyFe5ecdeS8nv5C/OjKVB4Fb1yWOv6owpAJl7wf1pD0EbAnTKgcND3kS
         EN5rYsomC0JHmeoOWeeLN0F2Vwxrb8CGbBMPw76+dOvBdiDNYNalYrjR8casLMKHhg
         VV06lxPVWcEkiCVmXBMHCN2kjkPkoqVG9AmGsnbCb5eiqOQ8/76sWYOq7PQliUANIM
         /tASxJU7FEdCw==
Date:   Fri, 15 Sep 2023 11:54:49 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Message-Id: <20230915115449.3d7103b841cd593d1a09a129@kernel.org>
In-Reply-To: <20230914131102.179100-1-cleger@rivosinc.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 15:11:02 +0200
Clément Léger <cleger@rivosinc.com> wrote:

> enabler->uaddr can be aligned on 32 or 64 bits. If aligned on 32 bits,
> this will result in a misaligned access on 64 bits architectures since
> set_bit()/clear_bit() are expecting an unsigned long (aligned) pointer.
> On architecture that do not support misaligned access, this will crash
> the kernel. Align uaddr on unsigned long size to avoid such behavior.
> This bug was found while running kselftests on RISC-V.
> 
> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---
>  kernel/trace/trace_events_user.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
> index 6f046650e527..580c0fe4b23e 100644
> --- a/kernel/trace/trace_events_user.c
> +++ b/kernel/trace/trace_events_user.c
> @@ -479,7 +479,7 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  				    bool fixup_fault, int *attempt)
>  {
>  	unsigned long uaddr = enabler->addr;
> -	unsigned long *ptr;
> +	unsigned long *ptr, bit_offset;
>  	struct page *page;
>  	void *kaddr;
>  	int ret;
> @@ -511,13 +511,19 @@ static int user_event_enabler_write(struct user_event_mm *mm,
>  	}
>  
>  	kaddr = kmap_local_page(page);
> +
> +	bit_offset = uaddr & (sizeof(unsigned long) - 1);
> +	if (bit_offset) {
> +		bit_offset *= 8;
> +		uaddr &= ~(sizeof(unsigned long) - 1);
> +	}
>  	ptr = kaddr + (uaddr & ~PAGE_MASK);
>  
>  	/* Update bit atomically, user tracers must be atomic as well */
>  	if (enabler->event && enabler->event->status)
> -		set_bit(ENABLE_BIT(enabler), ptr);
> +		set_bit(ENABLE_BIT(enabler) + bit_offset, ptr);
>  	else
> -		clear_bit(ENABLE_BIT(enabler), ptr);
> +		clear_bit(ENABLE_BIT(enabler) + bit_offset, ptr);

What we need are generic set_bit_aligned() and clear_bit_aligned(), which align the ptr
by unsigned long. (I think it should be done in set_bit/clear_bit, for architecture
which requires aligned access...)

#define LONG_ALIGN_DIFF(p)	(p) & (sizeof(long) -1)
#define LONG_ALINGNED(p)		(p) & ~(sizeof(long) - 1)

static inline void set_bit_aligned(int bit, unsigned long *ptr)
{
	int offs = LONG_ALIGN_DIFF(ptr) * 8;

#ifdef __BIGENDIAN
	if (bit >= offs) {
		set_bit(bit - offs, LONG_ALIGNED(ptr));
	} else {
		set_bit(bit + BITS_PER_LONG - offs, LONG_ALIGNED(ptr) + 1);
	}
#else
	if (bit < BITS_PER_LONG - offs) {
		set_bit(bit + offs, LONG_ALIGNED(ptr));
	} else {
		set_bit(bit - BITS_PER_LONG + offs, LONG_ALIGNED(ptr) + 1);
	}
#endif
}

And use it.

Thank you,

>  
>  	kunmap_local(kaddr);
>  	unpin_user_pages_dirty_lock(&page, 1, true);
> -- 
> 2.40.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
