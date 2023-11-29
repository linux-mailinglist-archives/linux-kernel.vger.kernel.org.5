Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F477FDAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbjK2PNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjK2PNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:13:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC8BA3;
        Wed, 29 Nov 2023 07:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hXMxOlO+RptZuf7tC18898oF9lCqJDluY9IAnxRZEqY=; b=iWaMT3ZK3Iq5szkDIHQIo4Q6zd
        uVOQ9+a5l+Vl2Ij58r3TItf3naUI4KsjPqD/Yc9tIT1v9d8UXxCBejPzm/jUw/9gjgLmYbuoY9F1r
        MUb4Sh5qWs+PJu9UPSTfudrSH8n6wHs+c2gW3IgzbfmHoQ7oLbjgN8yJFZNcAnDjred3oD7mwlFjl
        XJZvuQY2lHbpIt2ppnWcz65kd3Vwpd3RkJsNAbkvd5yITdCnRdTt7oE/mYRynXKjMLo/uwbupqz/Y
        gzCx/Vu6K0B93J1DlxrhXeexkpBhqJpa5sAu8NBXKFusS99SXc+mK6eejToEXlz7FOn0nIXhjZM+I
        cnpBEd1g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r8MFe-00DVZy-3D; Wed, 29 Nov 2023 15:13:22 +0000
Date:   Wed, 29 Nov 2023 15:13:22 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        rust-for-linux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <ZWdVEk4QjbpTfnbn@casper.infradead.org>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129-alice-file-v1-1-f81afe8c7261@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 12:51:07PM +0000, Alice Ryhl wrote:
> This introduces a struct for the EBADF error type, rather than just
> using the Error type directly. This has two advantages:
> * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
>   compiler will represent as a single pointer, with null being an error.
>   This is possible because the compiler understands that `BadFdError`
>   has only one possible value, and it also understands that the
>   `ARef<File>` smart pointer is guaranteed non-null.
> * Additionally, we promise to users of the method that the method can
>   only fail with EBADF, which means that they can rely on this promise
>   without having to inspect its implementation.
> That said, there are also two disadvantages:
> * Defining additional error types involves boilerplate.
> * The question mark operator will only utilize the `From` trait once,
>   which prevents you from using the question mark operator on
>   `BadFdError` in methods that return some third error type that the
>   kernel `Error` is convertible into. (However, it works fine in methods
>   that return `Error`.)

I haven't looked at how Rust-for-Linux handles errors yet, but it's
disappointing to see that it doesn't do something like the PTR_ERR /
ERR_PTR / IS_ERR C thing under the hood.

> @@ -157,6 +158,12 @@ void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
>  
> +struct file *rust_helper_get_file(struct file *f)
> +{
> +	return get_file(f);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_file);

This is ridiculous.  A function call instead of doing the
atomic_long_inc() in Rust?

