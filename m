Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E69D7FDD0A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 17:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjK2Qbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 11:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjK2Qbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 11:31:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A1B10A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 08:31:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540D9C433C7;
        Wed, 29 Nov 2023 16:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701275513;
        bh=oeU9mJXNv22m4r52x0N8/9ZuPInwmlkw3ATWm9P9Cuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5uUeUH6sjnbA0eYQEji83M7RGbEQEXqKlIRrMRKUNcZ3ttH2/9R9LJZprO9hdZB0
         OOChZr5JhbaymIJdJn2tYG5isatJ0BEXr5KMMvlvlfv08My8gB7DggTN/mV6zCgkal
         bP8nZ3cx3julG9+bzIDhu8ojwiSI5Kv5K0FrVZnPB6pYdqkd7rCm04oktDx6V/bgWY
         L1/eZnzL30J/+ydZezISNuByuKguIKo/1XqIFsbVbUmAf0FoZJzE2d2tKkSAVYiDwZ
         2KHlT6dSSuXsCIhbMuKs+z1oceVjPMrETSIy0qNnM+sTXSxK6sPT5qIdbRvtgeJktc
         fAqEGaWUUYgIA==
Date:   Wed, 29 Nov 2023 17:31:44 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH 0/7] File abstractions needed by Rust Binder
Message-ID: <20231129-mitsingen-umweltschutz-c6f8d9569234@brauner>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:51:06PM +0000, Alice Ryhl wrote:
> This patchset contains the file abstractions needed by the Rust
> implementation of the Binder driver.
> 
> Please see the Rust Binder RFC for usage examples:
> https://lore.kernel.org/rust-for-linux/20231101-rust-binder-v1-0-08ba9197f637@google.com/
> 
> Users of "rust: file: add Rust abstraction for `struct file`":
> 	[PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
> 	[PATCH RFC 03/20] rust_binder: add threading support
> 
> Users of "rust: cred: add Rust abstraction for `struct cred`":
> 	[PATCH RFC 05/20] rust_binder: add nodes and context managers
> 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> 	[PATCH RFC 11/20] rust_binder: send nodes in transaction
> 	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> 
> Users of "rust: security: add abstraction for security_secid_to_secctx":
> 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: file: add `FileDescriptorReservation`":
> 	[PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
> 	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
> 
> Users of "rust: file: add kuid getters":
> 	[PATCH RFC 05/20] rust_binder: add nodes and context managers
> 	[PATCH RFC 06/20] rust_binder: add oneway transactions
> 
> Users of "rust: file: add `DeferredFdCloser`":
> 	[PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
> 
> Users of "rust: file: add abstraction for `poll_table`":
> 	[PATCH RFC 07/20] rust_binder: add epoll support
> 
> This patchset has some uses of read_volatile in place of READ_ONCE.
> Please see the following rfc for context on this:
> https://lore.kernel.org/all/20231025195339.1431894-1-boqun.feng@gmail.com/
> 
> This was previously sent as an rfc:
> https://lore.kernel.org/all/20230720152820.3566078-1-aliceryhl@google.com/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (4):
>       rust: security: add abstraction for security_secid_to_secctx
>       rust: file: add `Kuid` wrapper
>       rust: file: add `DeferredFdCloser`
>       rust: file: add abstraction for `poll_table`
> 
> Wedson Almeida Filho (3):
>       rust: file: add Rust abstraction for `struct file`
>       rust: cred: add Rust abstraction for `struct cred`
>       rust: file: add `FileDescriptorReservation`
> 
>  rust/bindings/bindings_helper.h |   9 ++
>  rust/bindings/lib.rs            |   1 +
>  rust/helpers.c                  |  94 +++++++++++
>  rust/kernel/cred.rs             |  73 +++++++++
>  rust/kernel/file.rs             | 345 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/file/poll_table.rs  |  97 +++++++++++

That's pretty far away from the subsystem these wrappers belong to. I
would prefer if wrappers such as this would live directly in fs/rust/
and so live within the subsystem they belong to. I think I mentioned
that before. Maybe I missed some sort of agreement here?

>  rust/kernel/lib.rs              |   3 +
>  rust/kernel/security.rs         |  78 +++++++++
>  rust/kernel/sync/condvar.rs     |   2 +-
>  rust/kernel/task.rs             |  71 ++++++++-
>  10 files changed, 771 insertions(+), 2 deletions(-)
> ---
> base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
> change-id: 20231123-alice-file-525b98e8a724
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 
