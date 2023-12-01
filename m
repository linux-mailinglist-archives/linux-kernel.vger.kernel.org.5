Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9C800651
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377943AbjLAIyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377930AbjLAIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:54:36 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62854171B;
        Fri,  1 Dec 2023 00:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vKnBzxozdWGnbst5MfQIf7+dcwp9ORvwYNVmV8gAJa4=; b=O93ILxbmPEQqoZHpPZGIxT73YX
        Ws5I1XRxugT5Keh77aOXi8td3S1Njs/BHg90kcQL/c6NvAJYe64sKiLvtQ/GWtJ6SDi49vgpyzP6F
        2XCZYR8+lst5QCL8VQQtupxDV9YiltQ7cK+1ub8OKr6PFSSyO13DnLVj0GhfAjPtugE0njegR/8zM
        uxqO2oJiKmecPxGFBgU+/P7arSmdeuj4hulfDyq5zqp2t72mPl8XgtWYFInQz8Oke/uEdd4KCJg8z
        J7xSPs6UxEVZklWRo+luSJrjgrvbUMqqhNcFHY1bChjFr42ChlcO3bFtUiwbfw+hRKwtekgUd2oER
        aJDNePNg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8zH7-0029rP-2X;
        Fri, 01 Dec 2023 08:53:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id BB6A93004AB; Fri,  1 Dec 2023 09:53:28 +0100 (CET)
Date:   Fri, 1 Dec 2023 09:53:28 +0100
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
Message-ID: <20231201085328.GE3818@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ZWdVEk4QjbpTfnbn@casper.infradead.org>
 <20231129152305.GB23596@noisy.programming.kicks-ass.net>
 <ZWdv_jsaDFJxZk7G@Boquns-Mac-mini.home>
 <20231130104226.GB20191@noisy.programming.kicks-ass.net>
 <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWipTZysC2YL7qsq@Boquns-Mac-mini.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 07:25:01AM -0800, Boqun Feng wrote:
> On Thu, Nov 30, 2023 at 11:42:26AM +0100, Peter Zijlstra wrote:
> > On Wed, Nov 29, 2023 at 09:08:14AM -0800, Boqun Feng wrote:
> > 
> > > But but but, I then realized we have asm goto in C but Rust doesn't
> > > support them, and I haven't thought through how hard tht would be..
> > 
> > You're kidding right?
> > 
> 
> I'm not, but I've found this:
> 
> 	https://github.com/Amanieu/rfcs/blob/inline-asm/text/0000-inline-asm.md#asm-goto

Reading that makes all this even worse, apparently rust can't even use
memops.

So to summarise, Rust cannot properly interop with C, it cannot do
inline asm from this side of the millenium. Why are we even trying to
use it again?
