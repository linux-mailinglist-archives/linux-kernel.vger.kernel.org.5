Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7FA801C2B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 11:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbjLBKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 05:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjLBKQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 05:16:49 -0500
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC1BF1;
        Sat,  2 Dec 2023 02:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701512213; x=1701771413;
        bh=EUYoWzRb2VtFg0qFU9eJFRQEz1z2lKS3+4nXPhxD9cc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ICKWZrBOiGZPy9i9e5mo+Xc0KA0Pgfj8HHU9nqvqiwdvXZAxbLc4NwpLv8IDz86Od
         Sd+6gz0BfDUaC/V/rFYJ8WMmaqjLbg0dS7eus4ygZDQdugCkiK25SiMJcp8NXudLfs
         5XKpsTTuloyw+ryvqsNjLAHNZpSA6WDshKGfMefYMF0ExT7ichsjE+IwBNMYEqsTSY
         5YsX/soqXn6/LhJU1kbnWHArxDOmXKRTCt3G9yTeP1R0CcdhzsztDStDX+XUDPhoVm
         UzK5zs/bwI38TYvNYq8LvVwvcLE+5+h4PHD9a9pULzylc31agMoZUskJWrqjH+fGLI
         eIDK4+9uEiYsA==
Date:   Sat, 02 Dec 2023 10:16:36 +0000
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     a.hindborg@samsung.com, alex.gaynor@gmail.com, arve@android.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, brauner@kernel.org,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 6/7] rust: file: add `DeferredFdCloser`
Message-ID: <bUU6jGtJ7KdkuVp8UPORb0cmDoU6sRjc1iVRMfgO34u5ySo44Z5MXrnYgE6pfQDFu4-V5CBAuhS8uZDoEA6CsIiLUiWJedNZ2CTf9cRATfQ=@proton.me>
In-Reply-To: <20231201113538.2202170-1-aliceryhl@google.com>
References: <LNSA8EeuwLGDBzY1W8GaP1L6gucAPE_34myHWuyg3ziYuheiFLk3WfVBPppzwDZwoGVTCqL8EBjAaxsNshTY6AQq_sNtK9hmea7FeaNJuCo=@proton.me> <20231201113538.2202170-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/23 12:35, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>>> +        // SAFETY: The `inner` pointer points at a valid and fully ini=
tialized task work that is
>>> +        // ready to be scheduled.
>>> +        unsafe { bindings::task_work_add(current, inner, TWA_RESUME) }=
;
>>
>> I am a bit confused, when does `do_close_fd` actually run? Does
>> `TWA_RESUME` mean that `inner` is scheduled to run after the current
>> task has been completed?
>=20
> When the current syscall returns to userspace.

What happens when I use `DeferredFdCloser` outside of a syscall? Will
it never run? Maybe add some documentation about that?

>>> +    // SAFETY: This function is an implementation detail of `close_fd`=
, so its safety comments
>>> +    // should be read in extension of that method.
>>> +    unsafe extern "C" fn do_close_fd(inner: *mut bindings::callback_he=
ad) {
>>> +        // SAFETY: In `close_fd` we use this method together with a po=
inter that originates from a
>>> +        // `Box<DeferredFdCloserInner>`, and we have just been given o=
wnership of that allocation.
>>> +        let inner =3D unsafe { Box::from_raw(inner as *mut DeferredFdC=
loserInner) };
>>
>> In order for this call to be sound, `inner` must be an exclusive
>> pointer (including any possible references into the `callback_head`).
>> Is this the case?
>=20
> Yes, when this is called, it's been removed from the linked list of task
> work. That's why we can kfree it.

Please add this to the SAFETY comment.

--=20
Cheers,
Benno
