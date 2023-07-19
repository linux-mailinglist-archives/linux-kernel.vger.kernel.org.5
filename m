Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60FF2759C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGSRK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGSRK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:10:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4421731
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 10:10:55 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689786653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HirW/v5+b+1SdqjL/ANp5wg8zZf/k+V30O9KLgN/N70=;
        b=VCV7i/rq/r0OL4jnSJIIRL/zVJue6doxKGkZH+i7m0hs/Cfhjz/jegsB5NdLDGwXEHdjyw
        /ZOmHHfes+BqR6Q/h1EPFYzm20N5ipMdgPzOhtq+8js88qDlgxvA2bIonXFZ47B6CNNoyz
        7QOPGWnRjFfFC4KsRkXdKclpJJv3lNkO67MscLxuiabDWHqb+802i2C0vmdublGmeW77d4
        D56pKH3R562QDJpYiHlmAgMZYVPE6n+nOZjxo5n3xTHvmLLCtymhjdeN2F4frQi2fXqwoT
        EwehAjolwLasKc5mSGO1lQCoYL6m+d7AcG4Nv/uNFFyL03bOPpTarIRB+YSiHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689786653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HirW/v5+b+1SdqjL/ANp5wg8zZf/k+V30O9KLgN/N70=;
        b=D9aexrnqUIp5mA5MRwcJyGhIXmpsWaxRLo3Bkm64oVqLbuydeZ3Ed3SAlRECuCskCaNEmK
        2Nl6q/BAahE/TFBQ==
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/build: vdso linker warning for orphan sections
In-Reply-To: <87ttu0i095.fsf@mail.lhotse>
References: <20230609051002.3342-1-npiggin@gmail.com>
 <871qh6wcgb.fsf@jogness.linutronix.de> <871qh5jrz2.fsf@mail.lhotse>
 <87o7k9l2oj.fsf@jogness.linutronix.de> <87ttu0i095.fsf@mail.lhotse>
Date:   Wed, 19 Jul 2023 19:16:50 +0206
Message-ID: <87v8efu8rp.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On 2023-07-19, Michael Ellerman <mpe@ellerman.id.au> wrote:
> I regularly test with a gcc 5.5.0 / ld 2.29 toolchain and gcc 13.1.1 /
> ld 2.39, and I haven't seen the warning. I tried a bunch of others and
> can't reproduce it.

I will send my config in a separate email (without the lists in
CC). Building the vdso_prepare target is all that is needed.

> Can you confirm that this makes the warning go away?
>
> diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso/vdso64.lds.S
> index bda6c8cdd459..286e1597c548 100644
> --- a/arch/powerpc/kernel/vdso/vdso64.lds.S
> +++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
> @@ -85,7 +85,7 @@ SECTIONS
>  		*(.branch_lt)
>  		*(.data .data.* .gnu.linkonce.d.* .sdata*)
>  		*(.bss .sbss .dynbss .dynsbss)
> -		*(.opd)
> +		*(.opd .rela.opd)
>  		*(.glink .iplt .plt .rela*)

Hmmm. Not sure what that would change. And indeed it does not make the
warning go away.

Doing some testing it seems that previously .rela.opd was being silently
placed in the .rela.dyn section. So doing that explicitly obviously gets
rid of the warning:

Index: linux-6.5-rc2/arch/powerpc/kernel/vdso/vdso64.lds.S
===================================================================
--- linux-6.5-rc2.orig/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ linux-6.5-rc2/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -69,7 +69,7 @@ SECTIONS
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
 	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
 	.gcc_except_table : { *(.gcc_except_table) }
-	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
+	.rela.dyn ALIGN(8) : { *(.rela.dyn) *(.rela.opd) }
 
 	.got ALIGN(8)	: { *(.got .toc) }

But if the goal is to get rid of .rela.opd then the question is: why is
the linker complaining about it being discarded?

John
