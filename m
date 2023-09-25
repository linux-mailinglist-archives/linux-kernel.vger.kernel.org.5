Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DCD7ADA5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjIYOt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjIYOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:49:54 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFD719F;
        Mon, 25 Sep 2023 07:49:46 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3214d4ecd39so5529986f8f.1;
        Mon, 25 Sep 2023 07:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695653385; x=1696258185; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4he1UcNWD/nxAw2ufykX42VkaU3M4ltsQwdB7gsOnrY=;
        b=SuzONUOC/Ky4LcBsGTnGYumIDYryZb+QfmmuzIa5gV0IUlMRsYLR3LDHAprfSOYLZ+
         FUF2ztnwYxrkg+hAPea120yKHJlGbmRXENQ4pLytmtesB37oY9ILuFPBFYtV3C9WI0lK
         wRoIfbBciIrRMh/GS80O7TltoyyyDd6qjXeJdOh2nHwV73pcK2Gkox3U3BD87ECol2hz
         lIzOXIjxV3NJeDbV1VlACc5YoVWgqR6O1eniTHQ3MDd+ua43cekeWr8gUYJZBvh5+qTG
         sK2p+TxsRPnJhxeDgvMQf2gdnRkZ0+XbxcEokLyy1gly1A8w8D3p66eO9H/6pGeFyfGN
         WVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695653385; x=1696258185;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4he1UcNWD/nxAw2ufykX42VkaU3M4ltsQwdB7gsOnrY=;
        b=BBzpg4mYXzo4h3lJMaORgjvgE68SRKzoSiF9cFTtdDCtMUzBUIotvXDxWgD9t+Webx
         odSkBjLsv2OKvAAtLcxFdBNkzruQbqZ2gMwyJsuo5psrPuxlv5XarLoMW1uvLGgttUYj
         TDuxxGW5JqZtbS2tmSW/qKuslR0PKNeNHGWX6gUAvI7Udff+7R8+2Zi4GVgaQ8Ac842A
         rPzTYxLXKB3CbABUN8eR82ZVjLtaS4Urdb916g77eV8lrlIfoaAVofiBC3UcsdmTQi6k
         U0lhmnTXXrBCQnZgZrv4FVOSjrS8M6nwfTnwhv0ZMg9Nsz7e9e25KDMei2Rha7PSzEdc
         V6ow==
X-Gm-Message-State: AOJu0YxQu7Ta6wg33ZazpKklm17mX9F56ZYiGcaHI5cu1d+4L3yiURsZ
        NViT/NZfJoo0/fMwQb2sdmG/7L0bBrU=
X-Google-Smtp-Source: AGHT+IF/zPqz+1SYvudIHyVhJ3r83Iwx17ga6vinQRcGcNx1/t8o27cl+WK/lm/CX4MVsCAlJ7vOAg==
X-Received: by 2002:adf:fa0f:0:b0:321:7050:6fb6 with SMTP id m15-20020adffa0f000000b0032170506fb6mr6904770wrr.67.1695653384919;
        Mon, 25 Sep 2023 07:49:44 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id p6-20020a170906228600b009adc743340fsm6401465eja.197.2023.09.25.07.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 07:49:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 56F1E27C005B;
        Mon, 25 Sep 2023 10:49:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 Sep 2023 10:49:42 -0400
X-ME-Sender: <xms:BZ4RZSdVSxKfkLGmouxmaHwX7PrPbHIzUKYOJwZCTyFcbHcN-XHE1g>
    <xme:BZ4RZcNnfhImHJEYxPIdQ0B7soehZqLsRE7FPYIgB3s8hl0xDpd_yn2lrDcn1IH2j
    8FJzeCB1__A9WnTVQ>
X-ME-Received: <xmr:BZ4RZTi4LyrF1T_jU2Be8dyUUWoAkK0ddLK72-rTJUxJdhA3qYcJq3XxoUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudelgedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfhgfehgeekkeeigfdukefh
    gfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:BZ4RZf8rV34W18JflOmzaNSQOkPflPugkov6w9I7TL_t73niJDVPeg>
    <xmx:BZ4RZeuZ_AkmkJ6r_h_3fFioEDalqM1-OHBpQ8nSFTnylSvzH0xtoA>
    <xmx:BZ4RZWFHYWLFlzQ7nR44gWvJARYnSF4uHdycnRb7wPZZs5jrX3KUkw>
    <xmx:Bp4RZfl8OfG0M9u_hNtXX99hl1r0b30qwVLMKQBasJ9-u5VkYVdz8A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Sep 2023 10:49:41 -0400 (EDT)
Date:   Mon, 25 Sep 2023 07:49:06 -0700
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
Message-ID: <ZRGd4lsNP30L2yB3@Boquns-Mac-mini.home>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
 <20230923144938.219517-3-wedsonaf@gmail.com>
 <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
 <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <969eab7f-ad40-0dfb-18b9-6002fc54e12b@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 09:14:50AM +0000, Benno Lossin wrote:
> On 25.09.23 08:29, Alice Ryhl wrote:
> > On Sat, Sep 23, 2023 at 4:50 PM Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> >>
> >> From: Wedson Almeida Filho <walmeida@microsoft.com>
> >>
> >> With GATs, we don't need a separate type to represent a borrowed object
> >> with a refcount, we can just use Rust's regular shared borrowing. In
> >> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
> >>
> >> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> >> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> >> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> >> ---
> >>   rust/kernel/sync.rs     |   2 +-
> >>   rust/kernel/sync/arc.rs | 134 ++++++++++++----------------------------
> >>   2 files changed, 39 insertions(+), 97 deletions(-)
> > 
> > I'm concerned about this change, because an `&WithRef<T>` only has
> > immutable permissions for the allocation. No pointer derived from it
> > may be used to modify the value in the Arc, however, the drop
> > implementation of Arc will do exactly that. 
> 
> That is indeed a problem. We could put the value in an `UnsafeCell`, but
> that would lose us niche optimizations and probably also other optimizations.
> 

Not sure I understand the problem here, why do we allow modifying the
value in the Arc if you only have a shared ownership? Also I fail to see
why `ArcBorrow` doesn't have the problem. Maybe I'm missing something
subtle here? Could you provide an example?

Regards,
Boqun

> > It also means that we
> > can't convert an Arc with refcount 1 into a UniqueArc.
> 
> I think you still can, since to do that you would consume the `Arc<T>` by
> value, thus guaranteeing that no references (and thus no `&WithRef<T>`) exist.
> So I think this would still be fine.
> 
> -- 
> Cheers,
> Benno
> 
> 
