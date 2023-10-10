Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CD57BF8EF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjJJKpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjJJKpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:45:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A139E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 03:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1696934716;
        bh=Keye6tp09f7AaDHq21s2ZPcLTfXNXkaJSM26tkcvZns=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GsNX9efb9iY0prGMW73Nnj2xFLseuu4l7MCN1wgrNZDmeA+S6RNDOlNnD2F74dUgf
         vz8QECYtcFm/dK2WZTyBng84y3YC+pjMqUNLPAdeU1+T4mhhZTW0ew/nQuSV7NpPLz
         kNQSsL/MmeeJiWmRl6S1hPkejirK4ww6v8DbmbcPbgM3BvbPv/2MNkgKgPe5ezANIN
         JGtpQJC74sCjuuAKv3l3H19pOubSP+3xvvpGysgB1iuBQq18SuQpc3UvygEwvKCcTg
         jrtHxcqN58MAtgbyod/FQiXGd7QJ1pi1mnTyk4KqRZCmd7Nin3BVFdcox+7OaXGr1H
         V1oWgFlnJ7fuQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4Xbw1xFYz4xWL;
        Tue, 10 Oct 2023 21:45:14 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/85xx: Fix math emulation exception
In-Reply-To: <066caa6d9480365da9b8ed83692d7101e10ac5f8.1695657339.git.christophe.leroy@csgroup.eu>
References: <066caa6d9480365da9b8ed83692d7101e10ac5f8.1695657339.git.christophe.leroy@csgroup.eu>
Date:   Tue, 10 Oct 2023 21:45:10 +1100
Message-ID: <8734yisqmh.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Booting mpc85xx_defconfig kernel on QEMU leads to:

What machine/CPU model are you using for that?

I tried ppce500/e500 and that is working OK for me, ie. boots to
userspace and I see math instructions being emulated via the emulated
stats.

cheers

> Bad trap at PC: fe9bab0, SR: 2d000, vector=800
> awk[82]: unhandled trap (5) at 0 nip fe9bab0 lr fe9e01c code 5 in libc-2.27.so[fe5a000+17a000]
> awk[82]: code: 3aa00000 3a800010 4bffe03c 9421fff0 7ca62b78 38a00000 93c10008 83c10008
> awk[82]: code: 38210010 4bffdec8 9421ffc0 7c0802a6 <fc00048e> d8010008 4815190d 93810030
> Trace/breakpoint trap
> WARNING: no useful console
>
> This is because allthough CONFIG_MATH_EMULATION is selected,
> Exception 800 calls unknown_exception().
>
> Call emulation_assist_interrupt() instead.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/head_85xx.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/head_85xx.S b/arch/powerpc/kernel/head_85xx.S
> index 97e9ea0c7297..0f1641a31250 100644
> --- a/arch/powerpc/kernel/head_85xx.S
> +++ b/arch/powerpc/kernel/head_85xx.S
> @@ -395,7 +395,7 @@ interrupt_base:
>  #ifdef CONFIG_PPC_FPU
>  	FP_UNAVAILABLE_EXCEPTION
>  #else
> -	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, unknown_exception)
> +	EXCEPTION(0x0800, FP_UNAVAIL, FloatingPointUnavailable, emulation_assist_interrupt)
>  #endif
>  
>  	/* System Call Interrupt */
> -- 
> 2.41.0
