Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60EF77CD94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237393AbjHONyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbjHONxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:53:49 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987C2EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lP7TTHSd/pfP435EK09Z+JPBT8sWfbeG8myoxHwpcSw=; b=A2J7EJant3yrgnQ55x2huro/Fl
        YVpfF22Nlvk9pcdxm6CTkWPo3YO4LEqUOIwBquS84DehCtTI2kAPIBAZPWE0EjKi6LOkP4GZMZAkR
        i0ICgafFujreGMmHCUWJVr/kYIMTKAR+4qO3YTDyPxg5ZLMZma8KtsK8RC5+QZW1ULcWMpd3Wa5Mi
        gj0Nk6/i5QQi3QT/VVxJYsXkt2lk1m9OrI/iO7tGf3eLY+MBK+FndQ2sumkB6BokVqkMPQvDVWuse
        txm/9T6YBKyddZQtFegjadHgJCM59y7gUwZCGDaW1o65jivHg/Nyu43wlJfPJZ3GNRNMhlus/EyE0
        an1m8W4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qVuUO-00Bsmu-2v;
        Tue, 15 Aug 2023 13:53:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 11740300222;
        Tue, 15 Aug 2023 15:53:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EF329203B4388; Tue, 15 Aug 2023 15:53:39 +0200 (CEST)
Date:   Tue, 15 Aug 2023 15:53:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: cleanup: Make no_free_ptr() __must_check
Message-ID: <20230815135339.GA966323@hirez.programming.kicks-ass.net>
References: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
 <fcc8a158-f6e4-8963-782f-ba04b47350b8@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcc8a158-f6e4-8963-782f-ba04b47350b8@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 01:28:37PM +0200, Rasmus Villemoes wrote:
> On 15/08/2023 12.52, Peter Zijlstra wrote:
> > 
> > recent discussion brought about the realization that it makes sense for
> > no_free_ptr() to have __must_check semantics in order to avoid leaking
> > the resource.
> > 
> 
> > +static inline __must_check void * __no_free_ptr(void **pp)
> > +{ void *p = *pp; *pp = NULL; return p; }
> > +
> >  #define no_free_ptr(p) \
> > -	({ __auto_type __ptr = (p); (p) = NULL; __ptr; })
> > +	(({ void * __maybe_unused ___t = (p); }), \
> > +	 ((typeof(p))__no_free_ptr((void **)&(p))))
> 
> So this does seem to work as advertised, but it could perhaps use some
> comments. Because at first I read this as one big statement expression,
> and I had this memory of a __must_check function call being the last
> expression in such had no effect at all [1]. But this is actually a
> comma expression.

Right, I can into that as well, that was infact the first thing I tried.
Most vexing indeed.

> 
> Also, isn't it more complicated than necessary? Can we get rid of the
> inner stmt expr and tmp var by just making it
> 
>   ((void) (p), ((typeof(p))__no_free_ptr((void **)&(p)))
> 
> which is more or less the whole reason comma expressions is a thing.

Ah, so the point of the statement expression before the comma is to
validate that (p) is in fact a pointer, and to that effect we assign it
to a 'void *' temporary.

If that case is invalid, we'll get a compile fail with a dodgy message.

I did this, because (void **)&(p) looses type integrity due to the cast.

But yeah, I suppose it all needs a wee comment.
