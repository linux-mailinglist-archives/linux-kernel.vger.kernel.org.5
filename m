Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E687F7FF434
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbjK3QAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbjK3P77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:59:59 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB45710EF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:00:05 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AUFwk8W004285
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 10:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1701359933; bh=BjVDdMUb3qZehcj6DA8wvdpKegLaOPtxZqO2+/FFhb0=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=a8gcQNdfZkXjAbUuRvU06ckniT0U6Xq0/voW7hMdkEM9H3q0zuODL+kjJVJQ5fxXC
         MEJqEYXOsoPo622TQy8bxCXIfC2GbnO6mbJJwBpXxCEhp5adqzt2hHMetUNmAcMnJV
         kyC7rSorNTxzd2fjsms3A6HkL/jpQ0LVY6JcOZJNUjXKTIvUgrP6fz0Y/0Rw2ZDjtT
         6+SG8BuPnrdnWTwHxq9TAvLmwHcJeIHdq6qg2WrCHzVXaaSYWLTVW4Ue3oCAALCzT7
         PKd0tUFJKnRi9I1XW7D0/KLmQIkfaWp9FpaU8dlQnzkJqjiB4mCwKfesDKwYN6JOmX
         JlWDigUCUH05w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6A78815C027C; Thu, 30 Nov 2023 10:58:46 -0500 (EST)
Date:   Thu, 30 Nov 2023 10:58:46 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
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
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <20231130155846.GA534667@mit.edu>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ksVe7fwt0AVWlCOtxIOb-g34okhYeBQUiXvpWLvqfxcyWXXuUuwWEIhUHigcAXJDFRCDr8drPYD1O1VTrDhaeZQ5mVxjCJqT32-2gHozHIo=@proton.me>
 <2023113041-bring-vagrancy-a417@gregkh>
 <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:46:55PM +0000, Benno Lossin wrote:
> >>> +    pub const O_APPEND: u32 = bindings::O_APPEND;
> >>
> >> Why do all of these constants begin with `O_`?
> > 
> > Because that is how they are defined in the kernel in the C code.  Why
> > would they not be the same here?
> 
> Then why does the C side name them that way? Is it because `O_*` is
> supposed to mean something, or is it done due to namespacing?

It's because these sets of constants were flags passed to the open(2)
system call, and so they are dictated by the POSIX specification.  So
O_ means that they are a set of integer values which are used by
open(2), and they are defined when userspace #include's the fcntl.h
header file.  One could consider it be namespacing --- we need to
distinguish these from other constants: MAY_APPEND, RWF_APPEND,
ESCAPE_APPEND, STATX_ATTR_APPEND, BTRFS_INODE_APPEND.

But it's also a convention that dates back for ***decades*** and if we
want code to be understandable by kernel programmers, we need to obey
standard kernel naming conventions.  

> In Rust we have namespacing, so we generally drop common prefixes.

I don't know about Rust namespacing, but in other languages, how you
have to especify namespaces tend to be ***far*** more verbose than
just adding an O_ prefix.

Cheers,

					- Ted
