Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B947BFF22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjJJOZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbjJJOZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:25:28 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DBBC4;
        Tue, 10 Oct 2023 07:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6Nr/KkwCGn5Ob2JlgP9dTNdp/ZUel4tqnxZisHtdBY8=; b=jFy25iGwS0sUAyZWA/Iq77sqbD
        vaDE+eqrvqmxZhuavEE6oeqorEjpXEvh2VBYLoxOdQUuh/qIhev8rs9Nc14EHf8iGoTaJUzV8QWNS
        jfHc0SkqaCeo3yXFWAh9r8cSkCEub0amR2x/KNR2O7xCYoAoCRyADSD9Np4ErQr6gTRPP9W3A46zT
        lUg49GPjEXPZIHyD0vL2iXcJ6CfGXWj0WG/QmzkHoTx5jdDC+8PWsnJ1Dc1IJ3jX3IYFUuSsH2ws7
        WAWNXx2qASFWB/gmpGV62Io2BjGaSGnpQ4U1OHy+a1xN5MRUyJssyQVcxIE1s0v6zynn1v+am65dG
        Atg0BYsQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qqDfD-00Gu0i-1m;
        Tue, 10 Oct 2023 14:24:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A6EF0300392; Tue, 10 Oct 2023 16:24:48 +0200 (CEST)
Date:   Tue, 10 Oct 2023 16:24:48 +0200
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
Message-ID: <20231010142448.GN377@noisy.programming.kicks-ass.net>
References: <20231009224347.2076221-1-mmaurer@google.com>
 <20231010081220.GD377@noisy.programming.kicks-ass.net>
 <CAGSQo01=NRosJCzRCWcqZfvdHzH+d6dThN02SpvkF2EHsFXD-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGSQo01=NRosJCzRCWcqZfvdHzH+d6dThN02SpvkF2EHsFXD-g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 07:06:32AM -0700, Matthew Maurer wrote:

> > > +KBUILD_RUSTFLAGS += -Zcf-protection=branch -Zno-jump-tables
> >
> > One question, -Zcf-protection=branch, will that ever emit NOTRACK
> > prefix? The kernel very explicitly does not support (enable) NOTRACK.

> rustc does this via LLVM, so its code generation works very similarly to clang.
> It does not create its own explicit NOTRACKs, but LLVM will by default
> with just -Zcf-protection-branch.
> I've linked a godbolt showing that at least for the basic case, your
> no-jump-tables approach from clang ports over.
> https://godbolt.org/z/bc4n6sq5q
> Whether rust generates NOTRACK should end up being roughly equivalent
> to whether clang generates it, and if LLVM gains a code generation
> flag for NOTRACK being disallowed some day, we can pass that through
> as well.

IIRC C++ will also emit NOTRACK for things like catch/throw and other
stack/scope unwinds. Obviously C doesn't have that, but does Rust? (as
might be obvious, I *really* don't know the language).

ISTR HJL had a GCC patch to force-disable NOTRACK, but I've no idea what
happened to that.

