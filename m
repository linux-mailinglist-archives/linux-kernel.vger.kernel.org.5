Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9B7EB3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 16:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjKNPke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 10:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233521AbjKNPkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:40:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B16D127;
        Tue, 14 Nov 2023 07:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=jt5Y5DJTQLPOXJN8Beqfd+8guMZO4ilEpveznFWpyRQ=; b=ABAK7Zk/jGV8iInT3x/fc7EiHU
        VjcCGnxxvobpPJYs89YyUFYS07sQHPDSFrQ4xUFr1czrRIWEY/k5SO/y4FswegOpPbLDbeULIozhx
        6sNoTazWUS7MI2khNxdAfsM9ViiWOjwysrWKrQlXO6zIf6UJpgDWnmXpAv2vLTPcTZD5B3+SJIN7G
        exkjy+iUjf6iEeOqw41ZhJdWybX8wcMYLOtj8QEZkwuB6Uym1BDv97zajtq6mBhsLuJK1kYUg3etZ
        flnNcHRQ869XzWvfhzy5IR2XYF29TfIVHC46c4SFkIbIdj6toQ8o1n2D+hxDhXcgG8Av+NF2uS+or
        O+VKNhBg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r2vWT-002X5L-2Q;
        Tue, 14 Nov 2023 15:40:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1EE74300581; Tue, 14 Nov 2023 16:40:17 +0100 (CET)
Date:   Tue, 14 Nov 2023 16:40:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Subject: Re: Several tst-robust* tests time out with recent Linux kernel
Message-ID: <20231114154017.GI4779@noisy.programming.kicks-ass.net>
References: <4bda9f2e06512e375e045f9e72edb205104af19c.camel@xry111.site>
 <d69d50445284a5e0d98a64862877c1e6ec22a9a8.camel@xry111.site>
 <20231114153100.GY8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114153100.GY8262@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 04:31:00PM +0100, Peter Zijlstra wrote:
> On Tue, Nov 14, 2023 at 05:46:43PM +0800, Xi Ruoyao wrote:
> > On Tue, 2023-11-14 at 02:33 +0800, Xi Ruoyao wrote:
> > > Hi,
> > > 
> > > With Linux 6.7.0-rc1, several tst-robust* tests time out on x86_64:
> > > 
> > > FAIL: nptl/tst-robust1
> > > FAIL: nptl/tst-robust3
> > > FAIL: nptl/tst-robust4
> > > FAIL: nptl/tst-robust6
> > > FAIL: nptl/tst-robust7
> > > FAIL: nptl/tst-robust9
> > > 
> > > This does not happen with Linux 6.6.0.  Do you have some clue about
> > > it?
> > 
> > Bisected to the kernel commit:
> > 
> > commit 5694289ce183bc3336407a78c8c722a0b9208f9b (HEAD)
> > Author: peterz@infradead.org <peterz@infradead.org>
> > Date:   Thu Sep 21 12:45:08 2023 +0200
> > 
> >     futex: Flag conversion
> >     
> >     Futex has 3 sets of flags:
> >     
> >      - legacy futex op bits
> >      - futex2 flags
> >      - internal flags
> >     
> >     Add a few helpers to convert from the API flags into the internal
> >     flags.
> >     
> >     Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> >     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> >     Reviewed-by: Andr<C3><A9> Almeida <andrealmeid@igalia.com>
> >     Link: https://lore.kernel.org/r/20230921105247.722140574@noisy.programming.kicks-ass.net
> 
> I can confirm. I'm also going crazy trying to figure out how this
> happens.
> 
> The below is sufficient to make it unhappy...
> 
> /me most puzzled
> 
> ---
> diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
> index b5379c0e6d6d..1a1f9301251f 100644
> --- a/kernel/futex/futex.h
> +++ b/kernel/futex/futex.h
> @@ -17,7 +17,7 @@
>   * restarts.
>   */
>  #ifdef CONFIG_MMU
> -# define FLAGS_SHARED		0x01
> +# define FLAGS_SHARED		0x10
>  #else
>  /*
>   * NOMMU does not have per process address space. Let the compiler optimize

Just the above seems sufficient.
