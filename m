Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D2F7B6EC1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjJCQm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbjJCQmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:42:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F74A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xo4hUgm4YsHRQ2qw98bC1dyPM7VgjwYlR7ZQ4WpFcfU=; b=ZD7GKBNqmNR9dRzDRipFX5SmUQ
        Obb+7/jSLYYeaZ5NQUkvAjSIa58tfUDM8mNkoHzecAlXrhMzuDNATIShT8tmmf87CbeOGv3Z5ERFH
        FfBYW1uR3laHK943lq8oxAL7QpTiAGzfr8HoDoJpLy/CpdxoPYWPOk3nZ+9vUra8LN4QrQNiyGcCr
        DX57TBQDLymr0w75OAE28XQ7D6de8t6sZt7NQjX4SJ2KStFFXVCWaTZIi1Q66rntRRiNyGIezdxtE
        f74uOthTkUqdtyCVMGK98coES4jboe7WZojklJjOKiHiTkILiW7c/bEBN1bKDhcm7POi6gaG0rbWM
        FGMO1YGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qniT6-00A0bR-38;
        Tue, 03 Oct 2023 16:41:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A9FA300348; Tue,  3 Oct 2023 18:41:58 +0200 (CEST)
Date:   Tue, 3 Oct 2023 18:41:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Kaplan <David.Kaplan@amd.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: Re: Linux 6.6-rc3 (DEBUG_VIRTUAL is unhappy on x86)
Message-ID: <20231003164157.GH1539@noisy.programming.kicks-ass.net>
References: <CAHk-=wjrZgxjHZuXwrGeFnng_whUmtToCWE5GQ+HORhGSeiX8g@mail.gmail.com>
 <ZRhKq6e5nF/4ZIV1@fedora>
 <CAB=+i9QiJ=BXkQuCFJTh3dMXrkKQvVA2EM51Mj6SsDMimWQ71g@mail.gmail.com>
 <CAHk-=whosoBSLAWzSGUZ8s=UwAVG9rsQ9OVPvw97S2RRFGfk2A@mail.gmail.com>
 <5427bc3d-1e14-781a-53a2-f702774715f4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5427bc3d-1e14-781a-53a2-f702774715f4@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 05:36:27PM +0530, Sumit Garg wrote:
> Hi Linus,
> 
> On 10/2/23 02:18, Linus Torvalds wrote:
> > On Sun, 1 Oct 2023 at 07:17, Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
> > > > > Peter Zijlstra (1):
> > > > >        x86,static_call: Fix static-call vs return-thunk
> > > > Hello, the commit above caused a crash on x86 kernel with
> > > > CONFIG_DEBUG_VIRTUAL=y.
> > > OK, I looked into this a little bit, and it turns out that the problematic
> > > address here is from cleanup_trusted() in
> > > security/keys/trusted-keys/trusted_core.c.
> > > (and it's builtin due to CONFIG_TRUSTED_KEYS=y)
> > > 
> > > The function is marked as __exit, so it does not fall within the
> > > 'core kernel text address range,' which is between _stext and _etext
> > > (or between _sinittext and _einittext). and thus __text_poke() thinks that
> > > it's vmalloc/module area.
> > > 
> > > I think __text_poke() should be taught that functions marked as __exit
> > > also belong to kernel code just like __init.
> > I think your patch is fine (well, whitespace-damaged, but conceptually good).
> > 
> > But I also wonder about that
> > 
> >          static_call_cond(trusted_key_exit)();
> > 
> > in cleanup_trusted(). It seems all kinds of pointless to use static
> > calls for something that is done *once*. That's not an optimization,
> > that's honestly just _stupid_. It costs more to do the rewriting that
> > it does to just do the one dynamic indirect call.
> 
> That's true, there isn't any real performance benefit here. It is something
> which I mentioned when I was asked to incorporate it here [1]. However, on
> the flip side I think there are security benefits here. We wouldn't like any
> indirect branch speculation attack to leak the trusted key material contents
> here.

1) retpolines;
2) if you can unload modules, you've got bigger problems.
