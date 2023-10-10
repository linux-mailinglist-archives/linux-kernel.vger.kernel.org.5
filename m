Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493447BFFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbjJJO4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjJJO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:56:37 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD43A7;
        Tue, 10 Oct 2023 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=2iYfz+2SfHgQ2iuztaA0vsSkKn3LIllWMFPKJv+Tu6w=; b=cj0pTKB1jcrNlXMRFKu/NgthTF
        YJ/ikOEA7by54fpgW8KGAIt4+n7aBQ7UAMUa3q5HmG9PlYO5m3l0Jl7wRQswgrLKE4ZgUrmE9rr2I
        PADmeUwPjWEugeXW7DYMr7UwtjrdhGxlBE1aoIXO4lTxct6rSrU9+7tXHd2z01zsqwQ4dceHcVwNh
        Q6v99QnsZxSW8O2eJU8Mp+KdrRAIDlptrWOnr385jiMfTiZJWE+MJfKc2BdBNPkRy+0WCBLIu1KwO
        vqAltO+2Iy8J9dkr4N3u4/Oey3xFyplUUXtpVVCEc97oc0Jgt5yYWmM1rYcvGIH255aKIYwPhrW7D
        8BdyZy6Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqE9Q-00Gvi2-14;
        Tue, 10 Oct 2023 14:56:01 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7175E3002E1; Tue, 10 Oct 2023 16:56:01 +0200 (CEST)
Date:   Tue, 10 Oct 2023 16:56:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] x86: Enable IBT in Rust if enabled in C
Message-ID: <20231010145601.GP377@noisy.programming.kicks-ass.net>
References: <20231009224347.2076221-1-mmaurer@google.com>
 <20231010081220.GD377@noisy.programming.kicks-ass.net>
 <CAGSQo01=NRosJCzRCWcqZfvdHzH+d6dThN02SpvkF2EHsFXD-g@mail.gmail.com>
 <20231010142448.GN377@noisy.programming.kicks-ass.net>
 <CAGSQo03wwtjzba-W9Vs4gOW3Jin=dnC937hNijxgHEd-jDev6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGSQo03wwtjzba-W9Vs4gOW3Jin=dnC937hNijxgHEd-jDev6w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:34:45AM -0700, Matthew Maurer wrote:
> On Tue, Oct 10, 2023 at 7:24 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Oct 10, 2023 at 07:06:32AM -0700, Matthew Maurer wrote:
> >
> > > > > +KBUILD_RUSTFLAGS += -Zcf-protection=branch -Zno-jump-tables
> > > >
> > > > One question, -Zcf-protection=branch, will that ever emit NOTRACK
> > > > prefix? The kernel very explicitly does not support (enable) NOTRACK.
> >
> > > rustc does this via LLVM, so its code generation works very similarly to clang.
> > > It does not create its own explicit NOTRACKs, but LLVM will by default
> > > with just -Zcf-protection-branch.
> > > I've linked a godbolt showing that at least for the basic case, your
> > > no-jump-tables approach from clang ports over.
> > > https://godbolt.org/z/bc4n6sq5q
> > > Whether rust generates NOTRACK should end up being roughly equivalent
> > > to whether clang generates it, and if LLVM gains a code generation
> > > flag for NOTRACK being disallowed some day, we can pass that through
> > > as well.
> >
> > IIRC C++ will also emit NOTRACK for things like catch/throw and other
> > stack/scope unwinds. Obviously C doesn't have that, but does Rust? (as
> > might be obvious, I *really* don't know the language).
> >
> That's fine - Rust does have stack/scope unwinds with the
> `panic=unwind` strategy. In the kernel, we use `panic=abort` and are
> unlikely to ever change this approach. There are a host of other
> complications that come from unwinding without NOTRACK getting
> involved :)
> 
> In case you find `catch_unwind` - this function only has an effect
> with `panic=unwind`. When `panic=abort`, there's nothing analogous to
> catch/throw anymore, and `catch_unwind` becomes a no-op.
> 
> Are there other features you expect might trigger NOTRACK?

I'm not sure -- if they happen, objtool should warn about them. So I
suppose we'll take it from there.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
