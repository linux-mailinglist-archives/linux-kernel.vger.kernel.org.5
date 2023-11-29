Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5D87FE41F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343609AbjK2XR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2XR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:17:58 -0500
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688D6D54
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 15:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1701299880; x=1701559080;
        bh=ioPvELIdRThD715hd8zdKjIZrjzPAQE7wm474WJAqF4=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=AwPlFmo/rkoaSEPLXDBUp5RYZFXhpXPmSN6/Sm6NfyJ+oigu8XxK4W/gqsAM1FEqU
         fhrkTv5wjXZgD7Aq+B5tak0rHosBg877xvVCiaGbHI4JOcVwGc6ECWq42tjDcBc936
         HcNJC2aaJQxe4qrvtg+gj+CWdXuJTMrbdcXS99DIiSf2sX9h1Njl+xvIrgrUlDpJgZ
         ECqqyFTfFyLl5pTQtR9LACRlHFZZQSHFfVzylMJeRMvi4V+9gekLxNnCy07U0exkYw
         X1hjuGlRj/Ebqqy68A6T0xpwvuprtuwAD4a462iDagk8Mi7gGhB0Dkkjur7lB1SmXb
         ts/cDgCkDR89w==
Date:   Wed, 29 Nov 2023 23:17:48 +0000
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     brauner@kernel.org, a.hindborg@samsung.com, alex.gaynor@gmail.com,
        arve@android.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
        cmllamas@google.com, dan.j.williams@intel.com, dxu@dxuuu.xyz,
        gary@garyguo.net, gregkh@linuxfoundation.org,
        joel@joelfernandes.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        maco@android.com, ojeda@kernel.org, peterz@infradead.org,
        rust-for-linux@vger.kernel.org, surenb@google.com,
        tglx@linutronix.de, tkjos@android.com, viro@zeniv.linux.org.uk,
        wedsonaf@gmail.com, willy@infradead.org
Subject: Re: [PATCH 1/7] rust: file: add Rust abstraction for `struct file`
Message-ID: <1cT5uqAdTaJ2sJVCILPrVHczVq1z2BZfCXy3wOHJKhMx7RFSATPcdAFpYT9y6h6nZBvHcQsYbeJMXMqB6u3i85yDRIO6iGwUoerIaSWdEn4=@proton.me>
In-Reply-To: <20231129212707.3520214-1-aliceryhl@google.com>
References: <20231129-geleckt-verebben-04ea0c08a53c@brauner> <20231129212707.3520214-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.11.23 22:27, Alice Ryhl wrote:
> Another example:
>=20
> =09void set_nonblocking_and_fput(struct file *file) {
> =09=09// Let's just ignore the lock for this example.
> =09=09file->f_flags |=3D O_NONBLOCK;
>=20
> =09=09fput(file);
> =09}
>=20
> This method takes a file, sets it to non-blocking, and then destroys the
> ref-count. What are the ownership semantics? Well, the caller should own
> an `fget` ref-count, and we consume that ref-count. The equivalent Rust
> code would be to take an `ARef<File>`:
>=20
> =09fn set_nonblocking_and_fput(file: ARef<File>) {
> =09=09file.set_flag(O_NONBLOCK);
>=20
> =09=09// When `file` goes out of scope here, the destructor
> =09=09// runs and calls `fput`. (Since that's what we defined
> =09=09// `ARef` to do on drop in `fn dec_ref`.)
> =09}
>=20
> You can also explicitly call the destructor with `drop(file)`:
>=20
> =09fn set_nonblocking_and_fput(file: ARef<File>) {
> =09=09file.set_flag(O_NONBLOCK);
> =09=09drop(file);
>=20
> =09=09// When `file` goes out of scope, the destructor does
> =09=09// *not* run. This is because `drop(file)` is a move
> =09=09// (due to the signature of drop), and if you perform a
> =09=09// move, then the destructor no longer runs at the end
> =09=09// of the scope.

I want to note that while the destructor does not run at the end of the
scope, it still *does* run: the `drop(file)` call runs the destructor.

> =09}
>=20
> And note that this would not compile, because we give up ownership of
> the `ARef` by passing it to `drop`:
>=20
> =09fn set_nonblocking_and_fput(file: ARef<File>) {
> =09=09drop(file);
> =09=09file.set_flag(O_NONBLOCK);
> =09}
>

[...]

>>> +// SAFETY: The type invariants guarantee that `File` is always ref-cou=
nted.
>>> +unsafe impl AlwaysRefCounted for File {
>>> +    fn inc_ref(&self) {
>>> +        // SAFETY: The existence of a shared reference means that the =
refcount is nonzero.
>>> +        unsafe { bindings::get_file(self.0.get()) };
>>> +    }
>>
>> Why inc_ref() and not just get_file()?
>=20
> Whenever you see an impl block that uses the keyword "for", then the
> code is implementing a trait. In this case, the trait being implemented
> is AlwaysRefCounted, which allows File to work with ARef.
>=20
> It has to be `inc_ref` because that's what AlwaysRefCounted calls this
> method.

I am not sure if the Rust term "trait" is well-known, so for a bit more
context, I am quoting the Rust Book [1]:

    A *trait* defines functionality a particular type has and can share
    with other types. We can use traits to define shared behavior in an
    abstract way. We can use *trait bounds* to specify that a generic type
    can be any type that has certain behavior.

[1]: https://doc.rust-lang.org/book/ch10-02-traits.html

We have created an abstraction over reference counting:
the trait `AlwaysRefCounted` and the struct `ARef<T>` where `T`
implements `AlwaysRefCounted`.
As Alice already explained, `ARef<T>` is a pointer that owns a refcount
on the object. Because `ARef<T>` needs to know how to increment and
decrement that counter. For example, when you want to create another
`ARef<T>` you can `clone()` it and therefore `ARef<T>` needs to
increment the refcount. And when you drop it, `ARef<T>` needs to
decrement it.
The "`ARef<T>` knows how to inc/dec the refcount" part is done by the
`AlwaysRefCounted` trait. And there we chose to name the functions
`inc_ref` and `dec_ref`, since these are the *general*/*abstract*
operations and not any specific refcount adjustment.



Hope that also helped and did not create confusion.

--
Cheers,
Benno

