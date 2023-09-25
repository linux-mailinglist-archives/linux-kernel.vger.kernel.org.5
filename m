Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FB97ADD85
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjIYRBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 13:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjIYRBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 13:01:06 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B0710D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695661255; x=1695920455;
        bh=dBleu0jN78l+uvIeZgOInZlyGwL7BuWHC8ozonaYPQY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=g6J/6X/fXeETdS++BX6h2ye9N4wqwJDwNBz+fgVOE3hSonkzZl3NO5tZg7h5P1n2v
         bBAeMKh/lUH0dbTi1/g+etgbwniH7EsapiFaATMPMmbCkSvPKAMYEc787xCesLxtDa
         SGdgDZ+jfCi6xgp5d57W1BqGrAwjqeXNTtfFtsqEEp54y+jG81W3TW6Y6ZwBxd1Hzw
         Gvxbx2H9DdVHopoQj+cu4VaovtPGQKYeneCSKsk/nidRaxPXxGNCbKwTd2fOEyXjgf
         +tcijNWCvDM8GPRgSdM/UBHuTOOjfzmvRn+fw4nVzQdduGk68kZs0mWCT4iSEkHecy
         4REm3i7mAyAUQ==
Date:   Mon, 25 Sep 2023 17:00:45 +0000
To:     Boqun Feng <boqun.feng@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Message-ID: <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me>
In-Reply-To: <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
References: <20230923144938.219517-1-wedsonaf@gmail.com> <20230923144938.219517-3-wedsonaf@gmail.com> <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com> <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me> <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home> <14513589-cc31-8985-8ff6-a97d2882f593@proton.me> <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
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

On 25.09.23 18:16, Boqun Feng wrote:
> On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
>> ```rust
>> struct MutatingDrop {
>>       value: i32,
>> }
>>
>> impl Drop for MutatingDrop {
>>       fn drop(&mut self) {
>>           self.value =3D 0;
>>       }
>> }
>>
>> let arc =3D Arc::new(MutatingDrop { value: 42 });
>> let wr =3D arc.as_with_ref(); // this creates a shared `&` reference to =
the MutatingDrop
>> let arc2: Arc<MutatingDrop> =3D wr.into(); // increments the reference c=
ount to 2
>=20
> More precisely, here we did a
>=20
> =09&WithRef<_> -> NonNull<WithRef<_>>
>=20
> conversion, and later on, we may use the `NonNull<WithRef<_>>` in
> `drop` to get a `Box<WithRef<_>>`.

Indeed.

>=20
>> drop(arc); // this decrements the reference count to 1
>> drop(arc2); // this decrements the reference count to 0, so it will drop=
 it
>> ```
>> When dropping `arc2` it will run the destructor for `MutatingDrop`,
>> which mutates `value`. This is a problem, because the mutable reference
>> supplied was derived from a `&`, that is not allowed in Rust.
>>
>=20
> Is this an UB? I kinda wonder what's the real damage we can get, because
> in this case, we just use a reference to carry a value of a pointer,
> i.e.
>=20
> =09ptr -> reference -> ptr
>=20
> I cannot think of any real damage compiler can make, but I'm happy to be
> surprised ;-)

This is UB, so anything can happen :)

--=20
Cheers,
Benno


