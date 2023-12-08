Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B9380AD6C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233986AbjLHT6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 14:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjLHT6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 14:58:12 -0500
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B6173B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 11:58:16 -0800 (PST)
Date:   Fri, 8 Dec 2023 14:58:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702065495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TsaD7mhW8SXQP1nbpaw4AQMft3LLxjzczN7R3X3tAxQ=;
        b=r8wNqSd/u9g5IyjKN6ZrfGfi8UvmYzVZvDTBKpMA8L/A0HyY8PSd9pb9uqtoc8VJzsAm5h
        NUJSsXmCtd0WZcMtOCo+G6RmAn7Deo0J4prFrniY3miadYKZ1B7nX9m6iODDWndhIpOXF5
        MTwcc2S3heTAvuFucv4fGqpPHv3sGkw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/7] rust: file: add `Kuid` wrapper
Message-ID: <20231208195809.fzpezhcntqsm2ub3@moria.home.lan>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
 <20231129164815.GI23596@noisy.programming.kicks-ass.net>
 <20231130-wohle-einfuhr-1708e9c3e596@brauner>
 <20231206195911.vcp3c6q57zvkm7bf@moria.home.lan>
 <20231208162616.GH28727@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208162616.GH28727@noisy.programming.kicks-ass.net>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 05:26:16PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 06, 2023 at 02:59:11PM -0500, Kent Overstreet wrote:
> 
> > I suspect even if the manpower existed to go that route we'd end up
> > regretting it, because then the Rust compiler would need to be able to
> > handle _all_ the craziness a modern C compiler knows how to do -
> > preprocessor magic/devilry isn't even the worst of it, it gets even
> > worse when you start to consider things like bitfields and all the crazy
> > __attributes__(()) people have invented.
> 
> Dude, clang can already handle all of that. Both rust and clang are
> build on top of llvm, they generate the same IR, you can simply feed a
> string into libclang and get IR out of it, which you can splice into
> your rust generated IR.

If only it were that simple :)

This is struct definitions we're talking about, not code, so what you
want isn't even IR, what you're generating is a memory layout for a
type, linked in with all your other type information.

And people critize Linux for being a giant monorepo that makes no
considerations for making our code reusable in other contexts; clang and
LLVM are no different. But that's not really the issue because you're
going to need a huge chunk of clang to even parse this stuff, what you
really want is a way to invoke clang and dump _type information_ in a
standardized, easy to consume way. What you want is actually more akin
to the debug info that's generated today.

So... yeah, sure, lovely if it existed, but not the world we live in :)

(As an aside, I've actually got an outstanding bug filed with rustc
because it needs to be able to handle types that are marked both packed
and aligned... if anyone in this thread _does_ know some rust compiler
folks, we need that for bcachefs on disk format types).
