Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D931789B99
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 08:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjH0Gxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 02:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjH0Gxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 02:53:33 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB525197
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 23:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1693119206;
        bh=7/f9HZDcWpTm+KWXuTV1cEqG+DU+sNW+WMkzpr6jClg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H1EJW5sqShOMzzOf3dDiff+xRnNchf5cA24e7EW2t3YQTIKLQ5ZdvqGwZLID5vSDl
         UNuHlv9TgV3jjUiYHbCZbfDh4jSQdhl0SQubVVcUe/yCEEAOOyCg8NvchLsTkwZJ+0
         jwYwKq1qR8WCMRebSq3jLX4Alujbbpl5m20Ckk0c=
Date:   Sun, 27 Aug 2023 08:53:26 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, Zhangjin Wu <falcon@tinylab.org>,
        Nicholas Rosenberg <inori@vnlx.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] tools/nolibc: i386: Fix a stack misalign bug on
 _start
Message-ID: <f67cedfc-f275-4b26-b27d-c5c506fe0e85@t-8ch.de>
References: <20230826141632.1488740-1-ammarfaizi2@gnuweeb.org>
 <20230826141632.1488740-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230826141632.1488740-2-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ammar,

On 2023-08-26 21:16:32+0700, Ammar Faizi wrote:
> The ABI mandates that the %esp register must be a multiple of 16 when
> executing a call instruction.
> 
> Commit 2ab446336b17 simplified the _start function, but it didn't take

Afaik references to commits in commit messages are supposed to follow
the same format as in the Fixes: tag.

"Commit 2ab446336b17 ("tools/nolibc: i386: shrink _start with _start_c")
simplified the _start function, [...]"

> care of the %esp alignment, causing SIGSEGV on SSE and AVX programs that
> use aligned move instruction (e.g., movdqa, movaps, and vmovdqa).
> 
> Ensure the %esp is a multiple of 16 when executing the call instruction.
> 
> Cc: Zhangjin Wu <falcon@tinylab.org>
> Fixes: 2ab446336b17aad362c6decee29b4efd83a01979 ("tools/nolibc: i386: shrink _start with _start_c")
> Reported-by: Nicholas Rosenberg <inori@vnlx.org>
> Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> ---
>  tools/include/nolibc/arch-i386.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
> index 64415b9fac77f996..4edf238eeac67aa2 100644
> --- a/tools/include/nolibc/arch-i386.h
> +++ b/tools/include/nolibc/arch-i386.h
> @@ -167,7 +167,8 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
>  	__asm__ volatile (
>  		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
>  		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
> -		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned        */
> +		"and  $-16, %esp\n"       /* align stack to 16 bytes                             */
> +		"sub  $12, %esp\n"        /* last pushed argument must be 16-byte aligned        */
>  		"push %eax\n"             /* push arg1 on stack to support plain stack modes too */
>  		"call _start_c\n"         /* transfer to c runtime                               */
>  		"hlt\n"                   /* ensure it does not return                           */

Thanks for the fix!

In general:

Acked-by: Thomas Weißschuh <linux@weissschuh.net>


Though I'd like to have the following part of your follow-up mail as
part of the commit message [0]:

"""
When the call main is executed, the
%esp is 16 bytes aligned.

Then, on function entry (%esp mod 16) == 12
because the call instruction pushes 4 bytes
onto the stack.

subl $12, %esp will make (%esp mod 16) == 0
again.
"""

It's much clearer to someone not that familiar with ASM and its
intricacies; like me.

Also a Link: tag for the Reported-by: would be nice.

[0] https://lore.kernel.org/lkml/ZOoindMFj1UKqo+s@biznet-home.integral.gnuweeb.org/


Thomas
