Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D947AD455
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjIYJPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232867AbjIYJPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:15:17 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FABFB;
        Mon, 25 Sep 2023 02:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695633306; x=1695892506;
        bh=Bp7NY2Xx3PzppdVd0zsY5m+Xu/tPLeGNpS34H/HEOi0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=EObWAm+DEfTVGivh9jvnACh5I5+ITxrqTq8ojwXQo6utLfMqc+r1a11UNsL/iroqr
         D+xvoGq/ua7rgCqrUQv90+MYovLlfFa1upYNpLJrsDGnwIkX60O78qR0lfz5xSTCxm
         aohDDe1Gz6eb9H4amoct52+rhrWadH2+IlK9TKVh9pRNHxAfHaEY2clD6bTS7J4+Po
         pNOgjLy7b1hR4ZwRnQCXPfyLALnbGCgyKxYiF/vR/1lbnq7nWc91x61u/r5ouEaiSE
         cOym8xCWh/HbIm1K09c4uhDgG23uZ+GILNKK43Wt1iiMETjI5um6CpVDvWdudpYDgt
         yvkd6qczDvjmA==
Date:   Mon, 25 Sep 2023 09:14:50 +0000
To:     Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Message-ID: <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
In-Reply-To: <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
References: <20230923144938.219517-1-wedsonaf@gmail.com> <20230923144938.219517-3-wedsonaf@gmail.com> <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.09.23 08:29, Alice Ryhl wrote:
> On Sat, Sep 23, 2023 at 4:50=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gm=
ail.com> wrote:
>>
>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>
>> With GATs, we don't need a separate type to represent a borrowed object
>> with a refcount, we can just use Rust's regular shared borrowing. In
>> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
>>
>> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>> ---
>>   rust/kernel/sync.rs     |   2 +-
>>   rust/kernel/sync/arc.rs | 134 ++++++++++++----------------------------
>>   2 files changed, 39 insertions(+), 97 deletions(-)
>=20
> I'm concerned about this change, because an `&WithRef<T>` only has
> immutable permissions for the allocation. No pointer derived from it
> may be used to modify the value in the Arc, however, the drop
> implementation of Arc will do exactly that.=20

That is indeed a problem. We could put the value in an `UnsafeCell`, but
that would lose us niche optimizations and probably also other optimization=
s.

> It also means that we
> can't convert an Arc with refcount 1 into a UniqueArc.

I think you still can, since to do that you would consume the `Arc<T>` by
value, thus guaranteeing that no references (and thus no `&WithRef<T>`) exi=
st.
So I think this would still be fine.

--=20
Cheers,
Benno


