Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1CC7FF322
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 16:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbjK3PCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 10:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjK3PCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 10:02:21 -0500
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39F61A4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 07:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701356545; x=1701615745;
        bh=uo2vqq/xcRDYM6o4gUKdCIhET5kcnBqayNRuV/1IFZY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=bqW4S8ABCR3oUPVl1gnYRytnSkn8znO+ZjOvjkZXuN3fewQK/9el9fndFgKOY0Igh
         soPaRM72dS+exH3qAMUp+teBMOiNFRjfzKtEBHMtD8f5BLG/FteB8PhalP+zdGE+Xz
         cZkPHR5xpZeIUitKd3zrO9biSOIfu5xp8cdyLuqGKn4WpXH9zhOi/7HocLwu7wCItW
         pbvA+B7SwXq57f0QQnePsuJKy3CVaxM391XEEtzi1kEpxmwZrGwiESzZMeI4CgtMn5
         AoYsbTT2ZY/DbpwIdDEgGmpixtghJGotnDrmsukaH9atODdyP5gMsclqLBHVr8QMmg
         K0fyn3KHoVRjQ==
Date:   Thu, 30 Nov 2023 15:02:06 +0000
To:     Matthew Wilcox <willy@infradead.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
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
Message-ID: <gCUdcb9uUpv_4hv0AbhQ4V8q5t25Aia9QWHVS8rRmqi7sQHWKSY2ucSiYBmnej98lEWs3WB2oumjDts9reSos9UFkxxBWlAGUsJn51pXRaQ=@proton.me>
In-Reply-To: <ZWdVEk4QjbpTfnbn@casper.infradead.org>
References: <20231129-alice-file-v1-0-f81afe8c7261@google.com> <20231129-alice-file-v1-1-f81afe8c7261@google.com> <ZWdVEk4QjbpTfnbn@casper.infradead.org>
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

On 11/29/23 16:13, Matthew Wilcox wrote:
> On Wed, Nov 29, 2023 at 12:51:07PM +0000, Alice Ryhl wrote:
>> This introduces a struct for the EBADF error type, rather than just
>> using the Error type directly. This has two advantages:
>> * `File::from_fd` returns a `Result<ARef<File>, BadFdError>`, which the
>>   compiler will represent as a single pointer, with null being an error.
>>   This is possible because the compiler understands that `BadFdError`
>>   has only one possible value, and it also understands that the
>>   `ARef<File>` smart pointer is guaranteed non-null.
>> * Additionally, we promise to users of the method that the method can
>>   only fail with EBADF, which means that they can rely on this promise
>>   without having to inspect its implementation.
>> That said, there are also two disadvantages:
>> * Defining additional error types involves boilerplate.
>> * The question mark operator will only utilize the `From` trait once,
>>   which prevents you from using the question mark operator on
>>   `BadFdError` in methods that return some third error type that the
>>   kernel `Error` is convertible into. (However, it works fine in methods
>>   that return `Error`.)
>=20
> I haven't looked at how Rust-for-Linux handles errors yet, but it's
> disappointing to see that it doesn't do something like the PTR_ERR /
> ERR_PTR / IS_ERR C thing under the hood.

In this case we are actually doing that: `ARef<T>` is a non-null pointer
to a `T` and since `BadFdError` is a unit struct (i.e. there exists only
a single value it can take) `Result<ARef<T>, BadFdError>` has the same
size as a pointer. This is because the Rust compiler represents the
`Err` variant as null.

We also do have support for `ERR_PTR`, but that requires `unsafe`, since
we do not know which kind of pointer the C side returned (was it an
`ARef<T>`, `&mut T`, `&T` etc.?) and can therefore only support `*mut T`.

--=20
Cheers,
Benno
