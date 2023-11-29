Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8908A7FDD93
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjK2Qsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjK2Qst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:48:49 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C80AB6;
        Wed, 29 Nov 2023 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tiPBXf1kZm2l8+7WRSaX1GLajBl09o/Tkot6Kx1Gxo0=; b=o9BTJ3na+CayHjCSRZpl2hxliT
        eZWFH3ECXx+oJ7DlR9ag0VtHn0Z2tXkZTZiOvVe7bHtsuQ2Zk9r/lDdgnScTBopq4dC6DPa2dPJLe
        GESlCC6PcoctemBjNadjUc3b0BfqJynYCAP/nZ2+XcPvqv/AXjCMh8rDWbqRguQroRYlEihFRLapB
        WN7LI1bGNDmTpb6vOAozO/72c90oKSQmni3CfkKhnCbzWDdaoenV2KOOJIPzsP5kG6gXPdkT7oHQk
        N4a3SxtqtYwrH4xc8IqSk38EGJBCMQEF9RsKJuWJSCttRemeHKUGu9TW6jqf3w3QQiY15NlTOpSVL
        TMUlR9wg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1r8NjU-000QPZ-1K;
        Wed, 29 Nov 2023 16:48:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2EE9E30017D; Wed, 29 Nov 2023 17:48:15 +0100 (CET)
Date:   Wed, 29 Nov 2023 17:48:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
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
Message-ID: <20231129164815.GI23596@noisy.programming.kicks-ass.net>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231129-etappen-knapp-08e2e3af539f@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-etappen-knapp-08e2e3af539f@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:28:27PM +0100, Christian Brauner wrote:

> > +pid_t rust_helper_task_tgid_nr_ns(struct task_struct *tsk,
> > +				  struct pid_namespace *ns)
> > +{
> > +	return task_tgid_nr_ns(tsk, ns);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_task_tgid_nr_ns);
> 
> I'm a bit puzzled by all these rust_helper_*() calls. Can you explain
> why they are needed? Because they are/can be static inlines and that
> somehow doesn't work?

Correct, because Rust can only talk to C ABI, it cannot use C headers.
Bindgen would need to translate the full C headers into valid Rust for
that to work.

I really think the Rust peoples should spend more effort on that,
because you are quite right, all this wrappery is tedious at best.
