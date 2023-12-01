Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B9D80094B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378460AbjLALGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378403AbjLALF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:05:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F7193;
        Fri,  1 Dec 2023 03:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W/R8UYys4SGiq+EL0cKD7bv2DTCPsH+ysS3QMINnXNI=; b=vFeFsAAuEBm7doVSgHeCiN4mbf
        zFz7Ek0nWIBL9GmXQ4924mMJxfvTAcJzAmMKfFiaVhjxbATGsvPAUYltCUrEN6SqodKtHcsdx7XjW
        icIW6qO2Tq9ggJmAxw74G/NR0KDNuX6sSrc3IzVMtaYbDIMwGhU3XEskgsvpKnRLIlhwr7P4/zX02
        t/ntG1SecxFyMcctuunNFXGI5P92zX3KLjdePAJQMdGQ4rL8zRM/JODW99dLD1nm6YOhGFw1O5JNz
        J8TgFytunO7NrPL8+hFngLedaz+ITnQNudOp+FgAQuz5Mi/HrmObAcI3wmH33ajDGUxVDycJlPFgx
        LztV0+sQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r91Ks-00FSO0-UK; Fri, 01 Dec 2023 11:05:31 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCAA530040C; Fri,  1 Dec 2023 12:05:29 +0100 (CET)
Date:   Fri, 1 Dec 2023 12:05:29 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231201110529.GK3818@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
 <20231130104226.GB20191@noisy.programming.kicks-ass.net>
 <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
 <20231201085328.GE3818@noisy.programming.kicks-ass.net>
 <ZWmlEiiPXAIOYsM1@Boquns-Mac-mini.home>
 <20231201094037.GI3818@noisy.programming.kicks-ass.net>
 <ZWm3OGWWhIWmB9gV@Boquns-Mac-mini.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWm3OGWWhIWmB9gV@Boquns-Mac-mini.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 02:36:40AM -0800, Boqun Feng wrote:

> I don't speak for the Rust langauge community, but I think this is
> something that they should improve. I understand it could be frustrating
> that we find out the new stuff doesn't support good old tools we use
> (trust me, I do!), but I believe you also understand that a higher level
> language can help in some places, for example, SBRM is naturally
> supported ;-) This answers half of the question: "Why are we even trying
> to use it again?".

C++ does that too (and a ton of other languages), and has a much less
craptastic syntax (not claiming C++ syntax doesn't have problems, but at
least its the same language family). Now I realize C++ isn't ideal, it
inherits much of the safety issues from C. But gah, rust is such a royal
pain.

> The other half is how languages are designed is different in these days:
> a language community may do a better job on listening to the users and
> the real use cases can affect the language design in return. While we
> are doing our own experiment, we might well give that a shot too.

Well, rust was clearly not designed to interact with C/C++ sanely. Given
the kernel is a giant C project, this is somewhat of an issue IMO.

IIRC the way Chrome makes it work with C++ is by defining the interface
in a *third* language which compiles into 'compatible' Rust and C++,
which is total idiocy if you ask me.

Some langauges (Zig IIUC) can consume regular C headers and are much
less painful to interact with (I know very little about Zig, no
endorsement beyond it integrating much better with C).

> And at least the document admits these are "future possibilities", so
> they should be more motivated to implement these.
> 
> It's never perfect, but we gotta start somewhere.

How about they start by using this LLVM goodness to implement the rust
equivalent of Zig's @cImport? Have it use clang to munge the C/C++
headers into IR and squash the lot into the rust thing.

The syntax is ofcourse unfixable :-(
