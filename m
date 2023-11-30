Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4347FEB7B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbjK3JJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:09:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3JJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:09:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF96CF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:09:18 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B788C433C7;
        Thu, 30 Nov 2023 09:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701335358;
        bh=xb51lgH3hhmGdIHdSPjYm+sLbGYQfwWqFrsqt0dVLWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YYOeoaJfkiDkKn0akU65fRx50iLnBadwLtcjp4awkfUOdAXFhvd65HUyXPoA7965H
         2649TBwBK5gBj3p0xM7DQ04pZdL4bfYWQWP0rDZrUY05CRFfxpkUXX/OBpxCfKFP51
         RZ11qlMzruEcZC7e+wyJNFv7LmSO3ePrdwIVHZRjK+/qYJ1PphncIVkAwha6ZU57cF
         fjanawuEejTGuho1/h/lw5rnmV/Rv0Dq7EaTMIfHB99TCLD+medEHQvcRlKNI8PFeq
         A2GaALvjHsyxl8mjMgUYI2n7vYXGHlL2YhjQQKSbFbnRSsLe1pZSpNms/MzraXuoQa
         /A9EkP7Chvu1g==
Date:   Thu, 30 Nov 2023 10:09:09 +0100
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
Message-ID: <20231130-lernziel-rennen-0a5450188276@brauner>
References: <20231129-zwiespalt-exakt-f1446d88a62a@brauner>
 <20231129165551.3476910-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231129165551.3476910-1-aliceryhl@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 04:55:51PM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> writes:
> > Can we follow the traditional file terminology, i.e.,
> > get_unused_fd_flags() and fd_install()? At least at the beginning this
> > might be quite helpful instead of having to mentally map new() and
> > commit() onto the C functions.
> 
> Sure, I'll do that in the next version.
> 
> >> +    /// Prevent values of this type from being moved to a different task.
> >> +    ///
> >> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
> >> +    /// owns the fd in question.
> >> +    _not_send_sync: PhantomData<*mut ()>,
> > 
> > I don't fully understand this. Can you explain in a little more detail
> > what you mean by this and how this works?
> 
> Yeah, so, this has to do with the Rust trait `Send` that controls
> whether it's okay for a value to get moved from one thread to another.
> In this case, we don't want it to be `Send` so that it can't be moved to
> another thread, since current might be different there.
> 
> The `Send` trait is automatically applied to structs whenever *all*
> fields of the struct are `Send`. So to ensure that a struct is not
> `Send`, you add a field that is not `Send`.
> 
> The `PhantomData` type used here is a special zero-sized type.
> Basically, it says "pretend this struct has a field of type `*mut ()`,
> but don't actually add the field". So for the purposes of `Send`, it has
> a non-Send field, but since its wrapped in `PhantomData`, the field is
> not there at runtime.

This probably a stupid suggestion, question. But while PhantomData gives
the right hint of what is happening I wouldn't mind if that was very
explicitly called NoSendTrait or just add the explanatory comment. Yes,
that's a lot of verbiage but you'd help us a lot.

> 
> >> +        Ok(Self {
> >> +            fd: fd as _,
> > 
> > This is a cast to a u32?
> 
> Yes.
> 
> > Can you please draft a quick example how that return value would be
> > expected to be used by a caller? It's really not clear
> 
> The most basic usage would look like this:
> 
> 	// First, reserve the fd.
> 	let reservation = FileDescriptorReservation::new(O_CLOEXEC)?;
> 
> 	// Then, somehow get a file to put in it.
> 	let file = get_file_using_fallible_operation()?;
> 
> 	// Finally, commit it to the fd.
> 	reservation.commit(file);

Ok, the reason I asked was that I was confused about the PhantomData and
how that would figure into using the return value as I hadn't seen that
Ok(Self { }) syntax before. Thanks.
  
> 
> In Rust Binder, reservations are used here:
> https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/allocation.rs#L199-L210
> https://github.com/Darksonn/linux/blob/dca45e6c7848e024709b165a306cdbe88e5b086a/drivers/android/allocation.rs#L512-L541
> 
> >> +    pub fn commit(self, file: ARef<File>) {
> >> +        // SAFETY: `self.fd` was previously returned by `get_unused_fd_flags`, and `file.ptr` is
> >> +        // guaranteed to have an owned ref count by its type invariants.
> >> +        unsafe { bindings::fd_install(self.fd, file.0.get()) };
> > 
> > Why file.0.get()? Where did that come from?
> 
> This gets a raw pointer to the C type.
> 
> The `.0` part is a field access. `ARef` struct is a tuple struct, so its

Ah, there we go. It's a bit ugly tbh.

> fields are unnamed. However, the fields can still be accessed by index.
