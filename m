Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A107ADCE1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjIYQQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:16:20 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6768B6;
        Mon, 25 Sep 2023 09:16:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-503f39d3236so11014625e87.0;
        Mon, 25 Sep 2023 09:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695658570; x=1696263370; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=D91jQq70A+URlVXyjILvwYovkk9Wp5hFZGtxcOFay7A=;
        b=EC8fU5vkRwxGW6Z6Uc7zN6K9D3+NrL80ZrcpUWUocAz46uuYdqjn5HBpfC2qy7eRN2
         RxL0Fvrrco0B5h3Nzsm2QzFQ/U+usDxCoEKWFn98xSCQaeJqLerl3AgYUypvQYz0QXcj
         iGV/9sSl6qJ9dGPdSf05JkbA2KQ2k/uN9mrB3TbT6nGvSP503XcGrbqTg3wMYEHNrY3O
         wnUIV7UkcBLZQcIjMOXd8ukxzSzwcG+xaebhQ2nhtoBgMOj7mrhE7H98xvMx3T1HN5DO
         dnoCI0xuQdKbYa6P/zYMZQ6i/+pr+soMWRTZXJ2TEV31O3L0kDcdmyOfIOws9JPj6L5q
         7JYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695658570; x=1696263370;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D91jQq70A+URlVXyjILvwYovkk9Wp5hFZGtxcOFay7A=;
        b=hy0rtXgD9Iu9jzv7U2SqmmaDx8ziH1tzD8ZnHysHPjiKjdsY+8DS9GVPMb29wEcHP6
         9E4IeAUDP4tMOKg+6ci/vFhnWyNDb4kCC+x23xu+ttWrA3BMx9Thdt5ICQg+k6hNB2tk
         vcnth8O6Ma8pxfuwbXpmtFmiYc1DupLXtSmf/RPLKjF1iygH4YGIHkc0RP7zKCldHHMB
         feCMsYiiu7EHIFHs0D1zj5gogLgWux+MGFQ7dF/8a8+uNcRj4WWAksmML9D44hX2UQGd
         7fSGLOvPDYv0VZ4T6mb+7ey2IQdpY7Z1z0rtlRjE8n2MJOxAzxtgON4/UbSagwVh8WAN
         uguA==
X-Gm-Message-State: AOJu0YxtaBky5vrKvWJT0LKkESWHWZDb2gTGr9JfoDc/PXTx1whdrc+Y
        52jBQDoSuBd5eBbHHbwMrnM=
X-Google-Smtp-Source: AGHT+IGCEOgS/Z/w8MtXGH9JZoCDRF1+VgOi1yWA8by7GrwOA4CgcAXcZIVASyx6qNwvmJOX94G0TA==
X-Received: by 2002:ac2:5f52:0:b0:503:5d8:da33 with SMTP id 18-20020ac25f52000000b0050305d8da33mr5035699lfz.20.1695658569742;
        Mon, 25 Sep 2023 09:16:09 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d7-20020aa7ce07000000b0050488d1d376sm5739920edv.0.2023.09.25.09.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 09:16:09 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 6653727C0054;
        Mon, 25 Sep 2023 12:16:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Sep 2023 12:16:07 -0400
X-ME-Sender: <xms:R7IRZQVhfKf4creTvnddbYA_WR-pFrZ9seKGqxKslKdqvqvnMRuKVw>
    <xme:R7IRZUnpsR31SFAt08O8oQGqHom8LZuDRuOcfgIQs1UwF9tJysDAYs7tzjpu5nm4b
    YLPO5oGwsmR1lBw5A>
X-ME-Received: <xmr:R7IRZUZCBNF9bqQxG2LlX0CEZDsjsDIP48_wqxq98P270DC-b-sYdH4Mtw4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeortddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepffelkeefudethfekhfehkefhledvjefggedvjeejffduleektdffieev
    jeettedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:R7IRZfWHxuNn3a-DGIuF_8vkKidbnXs390gKVSqSE7kyt_CIfCKXEQ>
    <xmx:R7IRZanFzWEWbQf09YO095d2ogc9ULmxDJp21aNslC8lPLN4x2ibKA>
    <xmx:R7IRZUeb5cq82GjBacIw2PdCudSnIt3OyIODWmHmZfgW2HGvAkMFEg>
    <xmx:R7IRZTcUxfGWpEKDXK12cwgwFP9j9UOfqiN0yXKhT1GfJTaHHHUxfQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 12:16:06 -0400 (EDT)
Date:   Mon, 25 Sep 2023 09:16:05 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of
 `WithRef`
Message-ID: <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-3-wedsonaf@gmail.com>
 <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
 <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
 <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
 <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14513589-cc31-8985-8ff6-a97d2882f593@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
> On 25.09.23 16:49, Boqun Feng wrote:
> > On Mon, Sep 25, 2023 at 09:14:50AM +0000, Benno Lossin wrote:
> >> On 25.09.23 08:29, Alice Ryhl wrote:
> >>> On Sat, Sep 23, 2023 at 4:50 PM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> >>>>
> >>>> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>>
> >>>> With GATs, we don't need a separate type to represent a borrowed object
> >>>> with a refcount, we can just use Rust's regular shared borrowing. In
> >>>> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> >>>>
> >>>> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> >>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >>>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> >>>> ---
> >>>>    rust/kernel/sync.rs     |   2 +-
> >>>>    rust/kernel/sync/arc.rs | 134 ++++++++++++----------------------------
> >>>>    2 files changed, 39 insertions(+), 97 deletions(-)
> >>>
> >>> I'm concerned about this change, because an `&WithRef<T>` only has
> >>> immutable permissions for the allocation. No pointer derived from it
> >>> may be used to modify the value in the Arc, however, the drop
> >>> implementation of Arc will do exactly that.
> >>
> >> That is indeed a problem. We could put the value in an `UnsafeCell`, but
> >> that would lose us niche optimizations and probably also other optimizations.
> >>
> > 
> > Not sure I understand the problem here, why do we allow modifying the
> > value in the Arc if you only have a shared ownership? Also I fail to see
> > why `ArcBorrow` doesn't have the problem. Maybe I'm missing something
> > subtle here? Could you provide an example?
> 
> Sure, here is the problem:
> 

Thanks, Benno.

> ```rust
> struct MutatingDrop {
>      value: i32,
> }
> 
> impl Drop for MutatingDrop {
>      fn drop(&mut self) {
>          self.value = 0;
>      }
> }
> 
> let arc = Arc::new(MutatingDrop { value: 42 });
> let wr = arc.as_with_ref(); // this creates a shared `&` reference to the MutatingDrop
> let arc2: Arc<MutatingDrop> = wr.into(); // increments the reference count to 2

More precisely, here we did a

	&WithRef<_> -> NonNull<WithRef<_>>

conversion, and later on, we may use the `NonNull<WithRef<_>>` in
`drop` to get a `Box<WithRef<_>>`.

> drop(arc); // this decrements the reference count to 1
> drop(arc2); // this decrements the reference count to 0, so it will drop it
> ```
> When dropping `arc2` it will run the destructor for `MutatingDrop`,
> which mutates `value`. This is a problem, because the mutable reference
> supplied was derived from a `&`, that is not allowed in Rust.
> 

Is this an UB? I kinda wonder what's the real damage we can get, because
in this case, we just use a reference to carry a value of a pointer,
i.e.

	ptr -> reference -> ptr

I cannot think of any real damage compiler can make, but I'm happy to be
surprised ;-)

Regards,
Boqun

> -- 
> Cheers,
> Benno
> 
> 
