Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C978000E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 02:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjLABRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 20:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjLABRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 20:17:10 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A255010D1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 17:17:16 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-111-98.bstnma.fios.verizon.net [173.48.111.98])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3B11GGe6007037
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Nov 2023 20:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1701393382; bh=eB5eDO+vECqQRDjfKoIQyjkESeeuGdTFuGWP5Rh7dm0=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=IEyq4LA47yO+iAFcZJ9YNLbfpgNQR9d58STuOP8rIoCCvZHJeLZ1+rRr5pJLhqVFM
         kwfvp8PgYglVC2B504CLxRUn2dZTo0FZT16qLRo+w4s5ROEaLf7ObNyine3YC50GS+
         p+KtCUWNtZnRaaqTqwQr71wHpTmw8DgqOXlxECfm2p4Pv5fAuQi2vHJ08gAf843Llf
         uGHMR4v7H23FB3H9YU4fSk+/bs7u3Jh+y5j8WKy0TsV+2CDWScvrmlxBnm2uBDy2qc
         2bAtF5OxVyrb44uT1Qdc++tp9G+A2aG8rIvp7affUd/QtG96/DBTKJOWBawn2sp3hW
         3lvntBLAbZbGw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F3DDF15C027C; Thu, 30 Nov 2023 20:16:15 -0500 (EST)
Date:   Thu, 30 Nov 2023 20:16:15 -0500
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
Message-ID: <20231201011615.GB509422@mit.edu>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com>
 <20231129-alice-file-v1-1-f81afe8c7261@google.com>
 <ksVe7fwt0AVWlCOtxIOb-g34okhYeBQUiXvpWLvqfxcyWXXuUuwWEIhUHigcAXJDFRCDr8drPYD1O1VTrDhaeZQ5mVxjCJqT32-2gHozHIo=@proton.me>
 <2023113041-bring-vagrancy-a417@gregkh>
 <2gTL0hxPpSCcVa7uvDLOLcjqd_sgtacZ_6XWaEANBH9Gnz72M1JDmjcWNO9Z7UbIeWNoNqx8y-lb3MAq75pEXL6EQEIED0XLxuHvqaQ9K-g=@proton.me>
 <20231130155846.GA534667@mit.edu>
 <25TYokAJ6urAw9GygDDgCcp2mDZT42AF6l8v_u5y-0XZONnHa9kr4Tz_zh30URNuaT-8Q0JnTXgZqeAiinxPEZqzS8StBKyjizZ9e5mysS8=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25TYokAJ6urAw9GygDDgCcp2mDZT42AF6l8v_u5y-0XZONnHa9kr4Tz_zh30URNuaT-8Q0JnTXgZqeAiinxPEZqzS8StBKyjizZ9e5mysS8=@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:12:14PM +0000, Benno Lossin wrote:
> > I don't know about Rust namespacing, but in other languages, how you
> > have to especify namespaces tend to be ***far*** more verbose than
> > just adding an O_ prefix.
> 
> In this case we already have the `flags` namespace, so I thought about
> just dropping the `O_` prefix altogether.

Note that in C code, the flags are known to be an integer, and there
are times when we assume that it's possible to take the bitfield, and
then either (a) or'ing in bitfields from some other "namespace",
because it's known that the open flags only use a certain number of
the low bits of the integer, or even that O_RDONLY, O_WRONLY, and
O_RDWR are 0, 1, and 2, repsectively, and so you can do something like
((flags & 0x03) + 1) such that 1 means "read access", 2 means "write
access", and 3 (1|2) is read and write.

This may make a programmer used to a type-strict language feel a
little dirty, but again, this is a convention going back deckades,
back when a PDP-11 had only 32k of words in its address space....

Cheers,


     	    	       	    	- Ted
