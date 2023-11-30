Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4427FEB93
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjK3JMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjK3JMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:12:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0691F10C6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:12:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF7D7C433C8;
        Thu, 30 Nov 2023 09:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701335566;
        bh=JPV6b13s4BE9K43qIMvJGUS2I3VMsdnD+s5DD/fwO/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k7mpkg4FxPcikJWcHTVEQqBK0fm1ykp+sGDB++oVKIGUlvQWrWf5oAi2/y7yU7yO9
         BDYAivMUm1UfC5vLT8QxiQH91F6AbZarrb3NlPFA9c1NHjSpgEVYtuaa472HpWZsmy
         NblRin+CJv3g/Sh/0ortuk2KdX98PlkkKL+b61bcpZqjV15vQ7Dgu2OavodKjvtEPO
         hLP1t/a+lRl23inWPPsqMGkb3bpmLE+cZcJKNg08Tr5WPs8dQFKhPLY6QcP3BSeq0P
         zCiAVujI7aDqaDvgRhDYD355QfiI1iDZ8XK3gsXSanMClLzhRJZraWy7AcC3T7Pwi0
         QKOFo/0bdMRxA==
Date:   Thu, 30 Nov 2023 10:12:38 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, cmllamas@google.com,
        dan.j.williams@intel.com, dxu@dxuuu.xyz, gary@garyguo.net,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, maco@android.com, ojeda@kernel.org,
        peterz@infradead.org, rust-for-linux@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, tkjos@android.com,
        viro@zeniv.linux.org.uk, wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 4/7] rust: file: add `FileDescriptorReservation`
Message-ID: <20231130-neuwagen-balkon-aa1b34055fec@brauner>
References: <20231129-zwiespalt-exakt-f1446d88a62a@brauner>
 <20231129165551.3476910-1-aliceryhl@google.com>
 <CAH5fLgi6n6WiueLkzvZ7ywt5hXWAJFAyseRr3O=KRAHUQ=hNrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgi6n6WiueLkzvZ7ywt5hXWAJFAyseRr3O=KRAHUQ=hNrQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 06:14:24PM +0100, Alice Ryhl wrote:
> On Wed, Nov 29, 2023 at 5:55 PM Alice Ryhl <aliceryhl@google.com> wrote:
> 
> > >> +    pub fn commit(self, file: ARef<File>) {
> > >> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
> > >> +        // guaranteed to have an owned ref count by its type invariants.
> > >> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> > >
> > > Why file.0.get()? Where did that come from?
> >
> > This gets a raw pointer to the C type.
> >
> > The `.0` part is a field access. `ARef` struct is a tuple struct, so its
> > fields are unnamed. However, the fields can still be accessed by index.
> 
> Oh, sorry, this is wrong. Let me try again:
> 
> This gets a raw pointer to the C type. The `.0` part accesses the
> field of type `Opaque<bindings::file>` in the Rust wrapper. Recall
> that File is defined like this:
> 
> pub struct File(Opaque<bindings::file>);
> 
> The above syntax defines a tuple struct, which means that the fields
> are unnamed. The `.0` syntax accesses the first field of a tuple
> struct [1].
> 
> The `.get()` method is from the `Opaque` struct, which returns a raw
> pointer to the C type being wrapped.

It'd be nice if this could be written in a more obvious/elegant way. And
if not a comment would help. I know there'll be more text then code but
until this is second nature to read I personally won't mind... Because
searching for this specific syntax isn't really possible.
