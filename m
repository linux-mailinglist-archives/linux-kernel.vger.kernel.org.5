Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6B1808224
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378029AbjLGHqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377955AbjLGHqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:46:33 -0500
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB0D44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 23:46:39 -0800 (PST)
Date:   Thu, 7 Dec 2023 02:46:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1701935197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kbU/WpF0mWyAkPnbK/9TxKMOYVzl+goNFSGyzE87t/g=;
        b=fCbIeUO4ItcAfnqfIF+XXPX1AnclYQ6+DKLE2NX9GJ3J09uGxc59qXr3qcpfgIYjj8Snkp
        GyJj4LgVG+WnLfR5EHeMuX9ZUUfQcfq6kBRbVGFd6pTMNG0gyoulQOkHlDg6MPj9hiN7LC
        eww02zMQXQct8BLVZ2FSwOWUnMkw9hI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
Message-ID: <20231207074631.7xjqkkn4oaw32xm6@moria.home.lan>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-5-f81afe8c7261@google.com>
 <20231130103635.GA20191@noisy.programming.kicks-ass.net>
 <20231206200224.rkdkuozztzg2wusj@moria.home.lan>
 <2023120716-ferocious-saffron-c595@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120716-ferocious-saffron-c595@gregkh>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 08:18:37AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Dec 06, 2023 at 03:02:24PM -0500, Kent Overstreet wrote:
> > On Thu, Nov 30, 2023 at 11:36:35AM +0100, Peter Zijlstra wrote:
> > > On Wed, Nov 29, 2023 at 01:12:17PM +0000, Alice Ryhl wrote:
> > > 
> > > > diff --git a/rust/helpers.c b/rust/helpers.c
> > > > index fd633d9db79a..58e3a9dff349 100644
> > > > --- a/rust/helpers.c
> > > > +++ b/rust/helpers.c
> > > > @@ -142,6 +142,51 @@ void rust_helper_put_task_struct(struct task_struct *t)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> > > >  
> > > > +kuid_t rust_helper_task_uid(struct task_struct *task)
> > > > +{
> > > > +	return task_uid(task);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_task_uid);
> > > > +
> > > > +kuid_t rust_helper_task_euid(struct task_struct *task)
> > > > +{
> > > > +	return task_euid(task);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(rust_helper_task_euid);
> > > 
> > > Aren't these like ideal speculation gadgets? And shouldn't we avoid
> > > functions like this for exactly that reason?
> > 
> > I think asking the Rust people to care about that is probably putting
> > too many constraints on them, unless you actually have an idea for
> > something better to do...
> 
> It's not a constraint, it is a "we can not do this as it is buggy
> because cpus are broken and we need to protect users from those bugs."
> 
> If we were to accept this type of code, then the people who are going
> "it's safer to write kernel code in Rust" would be "pleasantly
> surprised" when it turns out that their systems are actually more
> insecure.
> 
> Hint, when "known broken" code is found in code review, it can not just
> be ignored.

We're talking about a CPU bug, not a Rust bug, and maybe try a nm
--size-sort and see what you find before throwing stones at them...
