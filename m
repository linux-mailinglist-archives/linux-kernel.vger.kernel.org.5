Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE51A7ADCD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjIYQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjIYQMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:12:19 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089ECB6;
        Mon, 25 Sep 2023 09:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695658328; x=1695917528;
        bh=p+y8Uvz3T+M8u/ypH3Z3Elqa3JxcnYzJ7Axg24zZQR8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=aI95lrsHAPKHpHbHX9eL8V8iPAQRjeWonfYapialCoypgs09+B+hOPiZUK5UpFbK3
         /FvX1Ps6f/JoByvWINUGMFh4gEby2cPGBXtMrgYbvWVDq8cfPhUPkJ00pdbv4cuP7s
         Y5q3xJ9T9bbUuTc+kR+ppQb2jpDRsQiiTzBnrfAeKqd8odcBhwOyoWFzUIYVIbHjoz
         knFKGlvfKkqeRXNL//S2O6aTEHfeuGh6VgOEOv+Zk29294m+hMJmYgAQ5WqWP3KsCz
         eirjxam8AndTi36sGdDULbOm0w6F00h1+qfbkiXNSXRTskjp+2pCFz+KrYR6FiqTKz
         083vbnt+SRKsA==
Date:   Mon, 25 Sep 2023 16:11:51 +0000
To:     Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>, a.hindborg@samsung.com,
        alex.gaynor@gmail.com, bjorn3_gh@protonmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, walmeida@microsoft.com,
        wedsonaf@gmail.com
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Message-ID: <88c86434-f9af-6fc7-0fdc-ec1265aed94f@proton.me>
In-Reply-To: <ZRGvKPhgJXWfluyZ@Boquns-Mac-mini.home>
References: <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home> <20230925150047.1961646-1-aliceryhl@google.com> <ZRGknJCB6tFgX3Gr@Boquns-Mac-mini.home> <0b7fc71c-b3c7-4c29-92a9-587daa46ad59@ryhl.io> <ZRGvKPhgJXWfluyZ@Boquns-Mac-mini.home>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.23 18:02, Boqun Feng wrote:
> On Mon, Sep 25, 2023 at 05:30:05PM +0200, Alice Ryhl wrote:
>> On 9/25/23 17:17, Boqun Feng wrote:
>>> On Mon, Sep 25, 2023 at 03:00:47PM +0000, Alice Ryhl wrote:
>>>>>>> I'm concerned about this change, because an `&WithRef<T>` only has
>>>>>>> immutable permissions for the allocation. No pointer derived from i=
t
>>>>>>> may be used to modify the value in the Arc, however, the drop
>>>>>>> implementation of Arc will do exactly that.
>>>>>>
>>>>>> That is indeed a problem. We could put the value in an `UnsafeCell`,=
 but
>>>>>> that would lose us niche optimizations and probably also other optim=
izations.
>>>>>>
>>>>>
>>>>> Not sure I understand the problem here, why do we allow modifying the
>>>>> value in the Arc if you only have a shared ownership?
>>>>
>>>> Well, usually it's when you have exclusive access even though the valu=
e
>>>> is in an `Arc`.
>>>>
>>>> The main example of this is the destructor of the `Arc`. When the last
>>>> refcount drops to zero, this gives you exclusive access. This lets you
>>>> run the destructor. The destructor requires mutable access.
>>>>
>>>> Another example would be converting the `Arc` back into an `UniqueArc`
>>>> by checking that the refcount is 1. Once you have a `UniqueArc`, you c=
an
>>>> use it to mutate the inner value.
>>>>
>>>> Finally, there are methods like `Arc::get_mut_unchecked`, where you
>>>> unsafely assert that nobody else is using the value while you are
>>>> modifying it. We don't have that in our version of `Arc` right now, bu=
t
>>>> we might want to add it later.
>>>>
>>>
>>> Hmm.. but the only way to get an `Arc` from `&WithRef` is
>>>
>>> =09impl From<&WithRef<T>> for Arc<T> {
>>> =09    ...
>>> =09}
>>>
>>> , and we clone `Arc` in the that function (i.e. copying the raw
>>> pointer), so we are still good?
>>>
>>
>> No, the raw pointer in the Arc was created from the immutable reference,=
 so
>> the raw pointer has the same restrictions as the immutable reference did=
.
>>
>=20
> I see, this was the part I was missing. Thanks!
>=20
> Looks like the only fix is replacing `&WithRef<T>` with
> `&UnsafeCell<WithRef<T>>`? But that's a bit wordy and I'm not sure
> whether it's better than `ArcBorrow<'_, T>`...

It should be sufficient to change only the type of the field
within `WithRef`, so no visible API change needed.

--
Cheers,
Benno


