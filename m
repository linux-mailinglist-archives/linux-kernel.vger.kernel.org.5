Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72147A0AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237770AbjINQmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbjINQme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:42:34 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2E8401FDC;
        Thu, 14 Sep 2023 09:42:30 -0700 (PDT)
Received: from DESKTOP-4OLSCEK. (unknown [76.135.27.212])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6334D212BE5B;
        Thu, 14 Sep 2023 09:42:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6334D212BE5B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694709749;
        bh=iDGXYNvDUZyGPqG85pC0NeOYH73MS/LV4u3HMbaEDgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyqKzhLZpHt8HC8NJuqoBe7StMaxqjDz/IsXqKF3Z0ou4VcRzQJ+pnrsgc7xF+73G
         P0pn/ixo/EckvQB7WfEFbl6nlub6vAUFUxr43ceUjcTlwdMGePymFsxltSpB8D5QBp
         Q7+YYOb0P++J2YAHTlWQadajbccfv2n067z9rK3s=
Date:   Thu, 14 Sep 2023 09:42:18 -0700
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Message-ID: <20230914164218.GA450-beaub@linux.microsoft.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230914131102.179100-1-cleger@rivosinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 03:11:02PM +0200, Clément Léger wrote:
> enabler->uaddr can be aligned on 32 or 64 bits. If aligned on 32 bits,
> this will result in a misaligned access on 64 bits architectures since
> set_bit()/clear_bit() are expecting an unsigned long (aligned) pointer.
> On architecture that do not support misaligned access, this will crash
> the kernel. Align uaddr on unsigned long size to avoid such behavior.
> This bug was found while running kselftests on RISC-V.
> 
> Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
> Signed-off-by: Clément Léger <cleger@rivosinc.com>

Thanks for fixing! I have a few comments on this.

I unfortunately do not have RISC-V hardware to validate this on.

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

I think for future readers of this code it would be more clear to use
BITS_PER_BYTE instead of the hardcoded 8. Given we always align on a
"natural" boundary, I believe the bit_offset will always be 32 bits.

A comment here might help clarify why we do this as well in case folks
don't see the change description.

> +		uaddr &= ~(sizeof(unsigned long) - 1);

Shouldn't this uaddr change be done before calling pin_user_pages_remote()
to ensure things cannot go bad? (I don't think they can, but it looks a
little odd).

Thanks,
-Beau

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
>  
>  	kunmap_local(kaddr);
>  	unpin_user_pages_dirty_lock(&page, 1, true);
> -- 
> 2.40.1
