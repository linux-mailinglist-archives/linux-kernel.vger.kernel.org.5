Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD74F7ADB00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbjIYPJr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjIYPJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:09:45 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02E710C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 08:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=y7eej5fl4jd6vjgp4a2o7ly5qi.protonmail; t=1695654576; x=1695913776;
        bh=FHZe6kdKIqazFPSKKhdkgcbV19fe0HcjGBTZ7ywLRWA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=a2uK+brsqwOWC0ALmAmVM/RFq1+BFpG5Z6GFcrllZWUa9DLTRMbFO4oRS8TzVEUW5
         vj1Cm8b/jq5SbdtapHFsHxLuWHuGp6XuslwziMeiCx1X+BpaptCBhQbIscjwQPRRVD
         Al3FA+HnOcqsn2kEq3bSc6jAWVth0pjGNSNHhk67EFcn/rp8K7hje9nBbIiTkYmcIk
         yLQImqY1n660lJge1/5HabzqAiUW+E0TGnLljLzsCv1kNimdTmGdxr+ZzTj3npvCXE
         xp8L5sRHQqSmi3KnZy6wYeoIGq6kF8N4lk6CMhA27R5cqTa1o0k5aRzUHvcprMpVjp
         BfDz5mTnuQrvA==
Date:   Mon, 25 Sep 2023 15:07:44 +0000
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
Message-ID: <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
In-Reply-To: <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
References: <20230923144938.219517-1-wedsonaf@gmail.com> <20230923144938.219517-3-wedsonaf@gmail.com> <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com> <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me> <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
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

On 25.09.23 16:49, Boqun Feng wrote:
> On Mon, Sep 25, 2023 at 09:14:50AM +0000, Benno Lossin wrote:
>> On 25.09.23 08:29, Alice Ryhl wrote:
>>> On Sat, Sep 23, 2023 at 4:50=E2=80=AFPM Wedson Almeida Filho <wedsonaf@=
gmail.com> wrote:
>>>>
>>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>>>
>>>> With GATs, we don't need a separate type to represent a borrowed objec=
t
>>>> with a refcount, we can just use Rust's regular shared borrowing. In
>>>> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
>>>>
>>>> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
>>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>>>> ---
>>>>    rust/kernel/sync.rs     |   2 +-
>>>>    rust/kernel/sync/arc.rs | 134 ++++++++++++-------------------------=
---
>>>>    2 files changed, 39 insertions(+), 97 deletions(-)
>>>
>>> I'm concerned about this change, because an `&WithRef<T>` only has
>>> immutable permissions for the allocation. No pointer derived from it
>>> may be used to modify the value in the Arc, however, the drop
>>> implementation of Arc will do exactly that.
>>
>> That is indeed a problem. We could put the value in an `UnsafeCell`, but
>> that would lose us niche optimizations and probably also other optimizat=
ions.
>>
>=20
> Not sure I understand the problem here, why do we allow modifying the
> value in the Arc if you only have a shared ownership? Also I fail to see
> why `ArcBorrow` doesn't have the problem. Maybe I'm missing something
> subtle here? Could you provide an example?

Sure, here is the problem:

```rust
struct MutatingDrop {
     value: i32,
}

impl Drop for MutatingDrop {
     fn drop(&mut self) {
         self.value =3D 0;
     }
}

let arc =3D Arc::new(MutatingDrop { value: 42 });
let wr =3D arc.as_with_ref(); // this creates a shared `&` reference to the=
 MutatingDrop
let arc2: Arc<MutatingDrop> =3D wr.into(); // increments the reference coun=
t to 2
drop(arc); // this decrements the reference count to 1
drop(arc2); // this decrements the reference count to 0, so it will drop it
```
When dropping `arc2` it will run the destructor for `MutatingDrop`,
which mutates `value`. This is a problem, because the mutable reference
supplied was derived from a `&`, that is not allowed in Rust.

--=20
Cheers,
Benno


