Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D40C77DD7C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243441AbjHPJkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243501AbjHPJkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:40:13 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03FFE74
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 02:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nCpaF+yFv7R/HZspZvxJFUcPqelTnXtB7QEVWkJ/ffo=; b=qnXnUqofN8ubejlGo/4dSjoKBJ
        TK2igdHd63rQ7EFmJF64fuMOvu6om2eSSsVMzTPstGhu1t/tcr30CPVOPyX4pgVA/vkp8wklPB5Fx
        k0mUSdDtsyC226qc2HSJyom8b+rGcnIhzuyZnD/cQu+S8zF/FbUt1BH2c33/uty7uQQECEKBXrf7Y
        4DhPYNEL85IrwdSVuCACEryJH0UP7jRpy/Du5dlHoA2VHiPafW/ZnFcoQVnfArP5XtYO7OpzBEo/T
        6ZFJzKH8k7wkTy4SA0gwIvAfwqQ4L8O2J7cNao/PVqeueR9O30wuuVM2RGoSPGnPZt/vBij9iP5zd
        cvcSJU+A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qWD0N-00CtvQ-2H;
        Wed, 16 Aug 2023 09:39:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F36D30020C;
        Wed, 16 Aug 2023 11:39:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5092E2C8D7C6E; Wed, 16 Aug 2023 11:39:55 +0200 (CEST)
Date:   Wed, 16 Aug 2023 11:39:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     jpoimboe@kernel.org, x86@kernel.org, baron@akamai.com,
        ardb@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, christian@bricart.de,
        song@kernel.org, mcgrof@kernel.org
Subject: Re: [PATCH] x86/static_call: Fix __static_call_fixup()
Message-ID: <20230816093955.GD980931@hirez.programming.kicks-ass.net>
References: <20230815230809.GA973560@hirez.programming.kicks-ass.net>
 <20230815204112.1f7ab2bf@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230815204112.1f7ab2bf@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 08:41:12PM -0400, Steven Rostedt wrote:
> On Wed, 16 Aug 2023 01:08:09 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> 
> > diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
> > index b70670a98597..2e67512d7104 100644
> > --- a/arch/x86/kernel/static_call.c
> > +++ b/arch/x86/kernel/static_call.c
> > @@ -186,6 +186,16 @@ EXPORT_SYMBOL_GPL(arch_static_call_transform);
> >   */
> >  bool __static_call_fixup(void *tramp, u8 op, void *dest)
> >  {
> > +	/*
> > +	 * Not all .return_sites are a static_call trampoline (most are not).
> > +	 * Check if the next 3 bytes are still kernel text, if not, then this
> > +	 * definitely is not a trampoline and we need not worry further.
> > +	 *
> > +	 * This avoids the memcmp() below tripping over pagefaults etc..
> > +	 */
> > +	if (!kernel_text_address(tramp+7))
> 
> The comment says "next 3 bytes" and the test is "tramp+7". Why the magic 7 number?
> 
> If the tramp is 5 bytes, shouldn't it be +8?

0 based, 7 is the last of the 8 bytes. +8 would be one beyond.
