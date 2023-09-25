Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235A47AD028
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjIYG3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjIYG3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:29:32 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB32EA2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:29:25 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-4528cba7892so2503949137.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695623365; x=1696228165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDgdET5rtDgfpk7MPhmyy8y/ZmiNwOCWphKHbytaUxo=;
        b=YTSOu2ATNujHMfgzMWSmDmbfnRBQ1sRkuiTD3sxjJAAjfzRpD/DAOAYS5ueWPkCnic
         QV2aXh0PyLcy+SM2pBthdMR/T12RJipGvq2B216WCDgaMaZuUXKrmhR4x8hQlv+89m9K
         lo5jSeTcytCejTJRCm3Jo/SQLn4XvoZA5r0Zv46A0KvCW1HB3WydOIv+3gse8H2V1FAh
         k/bcy9Q4hYQTimrg481oG2MgHVKwWzhjhpB/WoujMCBShXilKOZzAadhMHpJTQSqPyX4
         56THR7KPK4uTV6+hqgyDPcTchC8sAYhysnvR/2bhGMSWspi3ZmsMvyLBAC7UzUddc94Z
         hzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695623365; x=1696228165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDgdET5rtDgfpk7MPhmyy8y/ZmiNwOCWphKHbytaUxo=;
        b=WSW9uSA4Bjv52y6noMl9DfqcfbuSQ3xSayZ+9/qcUxNrOApSQrI74JRh4NFxhNq+QG
         DnKaIg9zrhwFN+gZmePtMhYNSLijq/kUtjpV6pyzOqMc3TdXXS2YDA2abh0sCsSez6Pp
         EiBSB4zPZAoRFkpZYbpUTuqNONVRwjfELXZy0s2TBTTu917RsMgd/Pmm7VzrI0JozY64
         E+JwvZ0Vsmho6tVT6FzFQ3e+93ucvwint6mEL0X4cKcjYAeiTp/lXPn5zvynQPFsNa5D
         D+oT3XVzHHOd0uv8im6GQHNAiHgfGj5hZN8c2XU5osUOE5HQFXZcma2ShwNxznKBFBl0
         36kA==
X-Gm-Message-State: AOJu0YznQ3G79q9zGaZ15V/Nmfb1/9SUY+QYo8wPCW1c5Nkn2hK5+9Pe
        EECaWXr+sWtopHBPr/xWWAIkNKQVU8PwT051uR+l7w==
X-Google-Smtp-Source: AGHT+IFwCb/CRM2abdfreZNQ2ERq36W4n80P8e2ba47ixMybiMq0GkOtwkvq3YyYsc2amiQiY5Y5n46o6ES39JOP/8A=
X-Received: by 2002:a05:6102:92:b0:452:68ee:654 with SMTP id
 t18-20020a056102009200b0045268ee0654mr3575157vsp.2.1695623364698; Sun, 24 Sep
 2023 23:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230923144938.219517-1-wedsonaf@gmail.com> <20230923144938.219517-3-wedsonaf@gmail.com>
In-Reply-To: <20230923144938.219517-3-wedsonaf@gmail.com>
From:   Alice Ryhl <aliceryhl@google.com>
Date:   Mon, 25 Sep 2023 08:29:13 +0200
Message-ID: <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2023 at 4:50=E2=80=AFPM Wedson Almeida Filho <wedsonaf@gmai=
l.com> wrote:
>
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> With GATs, we don't need a separate type to represent a borrowed object
> with a refcount, we can just use Rust's regular shared borrowing. In
> this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.
>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>  rust/kernel/sync.rs     |   2 +-
>  rust/kernel/sync/arc.rs | 134 ++++++++++++----------------------------
>  2 files changed, 39 insertions(+), 97 deletions(-)

I'm concerned about this change, because an `&WithRef<T>` only has
immutable permissions for the allocation. No pointer derived from it
may be used to modify the value in the Arc, however, the drop
implementation of Arc will do exactly that. It also means that we
can't convert an Arc with refcount 1 into a UniqueArc.

Alice
