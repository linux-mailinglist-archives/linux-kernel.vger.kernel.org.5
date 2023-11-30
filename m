Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B68B7FF408
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346434AbjK3P4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346411AbjK3P4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:56:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B55910D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:56:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B66DDC433C7;
        Thu, 30 Nov 2023 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701359777;
        bh=Atqz2R8S5CFNofHmkfbPck2yrnj1PJGSJBWuitp3Lps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1xfiPH0vRvQNxh0H18ebsiz+QfXIO8h49qtn0BttXKyyJSgU0KjgGqV7EineszNcM
         YfXWi3JxZnBYtdyoZLPf+lHo4BaXOhVIFSsRS6ZLrN4JIawZIMxnELgiDZvOoDIXKG
         IS9mpPQxycqq6pikqdDmy03gNorSUfMJRnf9Zav0=
Date:   Thu, 30 Nov 2023 15:56:14 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <2023113010-situated-brunch-d52d@gregkh>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ksVe7fwt0AVWlCOtxIOb-g34okhYeBQUiXvpWLvqfxcyWXXuUuwWEIhUHigcAXJDFRCDr8drPYD1O1VTrDhaeZQ5mVxjCJqT32-2gHozHIo=@proton.me>
 <2023113041-bring-vagrancy-a417@gregkh>
 <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 03:46:55PM +0000, Benno Lossin wrote:
> On 11/30/23 15:59, Greg Kroah-Hartman wrote:
> > On Thu, Nov 30, 2023 at 02:53:35PM +0000, Benno Lossin wrote:
> >> On 11/29/23 13:51, Alice Ryhl wrote:
> >>> +/// Flags associated with a [`File`].
> >>> +pub mod flags {
> >>> +    /// File is opened in append mode.
> >>> +    pub const O_APPEND: u32 = bindings::O_APPEND;
> >>
> >> Why do all of these constants begin with `O_`?
> > 
> > Because that is how they are defined in the kernel in the C code.  Why
> > would they not be the same here?
> 
> Then why does the C side name them that way? Is it because `O_*` is
> supposed to mean something, or is it done due to namespacing?

Because this is a unix-like system, we all "know" what they mean. :)

See 'man 2 open' for details.

> In Rust we have namespacing, so we generally drop common prefixes.

Fine, but we know what this namespace is, please don't override it to be
something else.

thanks,

greg k-h
