Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD37FED50
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbjK3KvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjK3KvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:51:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31910F3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 02:51:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0024AC433C7;
        Thu, 30 Nov 2023 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701341485;
        bh=Y4MoSY6O39Ift8abTx8Z8lmCpQSAiFIgx4bR6Skiwa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJKo8nB1AQXk6QtYFLkTPwieZ5ML5iWy502wIN/ce8cuJs2/iICs32sz7mj1bU1n3
         0NaYA0A6WJ19Z09FYGIzz4aQRtygI7H3LyP8gUCBurnyd8+f36CvekQc6Gbg0fd8+n
         5myFa4poG2p3b5gPWomtgtPaFUGPbI0UdY5+uRU/aBh+5pG5N+bAoIHTP+Q4o2i6py
         5KdPYLSK2sJbekBJtjNJpQ6pbo8P7w8whUKseINrRKSxs82IfkERnot9Uj7s3AQZTO
         IDssT1oQayf5MKifeI2Xrlr3fpp9U/inWCkl1kJM5JjVB+pmaHe8MAiq4e9I7EZoiF
         sjAe6JsiUOVmA==
Date:   Thu, 30 Nov 2023 11:51:17 +0100
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
Message-ID: <20231130-windungen-flogen-7b92c4013b82@brauner>
References: <20231130-lernziel-rennen-0a5450188276@brauner>
 <20231130091756.109655-1-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231130091756.109655-1-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:17:56AM +0000, Alice Ryhl wrote:
> Christian Brauner <brauner@kernel.org> writes:
> >>>> +    /// Prevent values of this type from being moved to a different task.
> >>>> +    ///
> >>>> +    /// This is necessary because the C FFI calls assume that `current` is set to the task that
> >>>> +    /// owns the fd in question.
> >>>> +    _not_send_sync: PhantomData<*mut ()>,
> >>> 
> >>> I don't fully understand this. Can you explain in a little more detail
> >>> what you mean by this and how this works?
> >> 
> >> Yeah, so, this has to do with the Rust trait `Send` that controls
> >> whether it's okay for a value to get moved from one thread to another.
> >> In this case, we don't want it to be `Send` so that it can't be moved to
> >> another thread, since current might be different there.
> >> 
> >> The `Send` trait is automatically applied to structs whenever *all*
> >> fields of the struct are `Send`. So to ensure that a struct is not
> >> `Send`, you add a field that is not `Send`.
> >> 
> >> The `PhantomData` type used here is a special zero-sized type.
> >> Basically, it says "pretend this struct has a field of type `*mut ()`,
> >> but don't actually add the field". So for the purposes of `Send`, it has
> >> a non-Send field, but since its wrapped in `PhantomData`, the field is
> >> not there at runtime.
> > 
> > This probably a stupid suggestion, question. But while PhantomData gives
> > the right hint of what is happening I wouldn't mind if that was very
> > explicitly called NoSendTrait or just add the explanatory comment. Yes,
> > that's a lot of verbiage but you'd help us a lot.
> 
> I suppose we could add a typedef:
> 
> type NoSendTrait = PhantomData<*mut ()>;
> 
> and use that as the field type. The way I did it here is the "standard"
> way of doing it, and if you look at code outside the kernel, you will
> also find them using `PhantomData` like this. However, I don't mind
> adding the typedef if you think it is helpful.

I'm fine with just a comment as well. I just need to be able to read
this a bit faster. I'm basically losing half a day just dealing with
this patchset and that's not realistic if I want to keep up with other
patches that get sent.

And if you resend and someone else review you might have to answer the
same question again.
