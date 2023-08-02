Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941A576D5AC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjHBRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbjHBRkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:40:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D372D65;
        Wed,  2 Aug 2023 10:39:49 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d0a8ae5f8a6so78235276.0;
        Wed, 02 Aug 2023 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690997988; x=1691602788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxP//0HpOMlKg6ktr694XCDTCBcPEyH/NZFFfkxgwPk=;
        b=HTi55FN5M2RPOu7bifbsWU1/2zQ4QtfERt/4y3deSTiDPrJ5FT+rEQMk0sPYPNrZvs
         1pUJJ2ZwbH+zicLXJ9xvYdrCf3AM0MI7vQ6mqnJE0z7YVRUT9ccqCbES+W/hhg2ab7ap
         wUcfZusbOop1N1CyL4S7an4mq7gDNxTEpZxhFUG9MV17/ReH2o18y3Lm97ZskkZTOshH
         fljuVDibqZX/XUhqNd+hVWGrSkdW0RWYD7XVqt5/BV41K+uEndcBlb4CIty3++WhfRXa
         tgKHog4qPN/tAy482stauUw8m77vcjM9GB8BD4gQIGOKOGfaK44Jh3hGnUD1P2szs3J1
         gqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997988; x=1691602788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxP//0HpOMlKg6ktr694XCDTCBcPEyH/NZFFfkxgwPk=;
        b=UarRrlTdyJkjEv16XLzt1hMA9/SYFUCqg+6fSdDhY1fj0ul4e4PrF2vrOJHTJCWHDU
         hP8OOCCN+eowJ6ncvHqWKVVIYaKx/V2JpHu5mFL34ZikLll1Km9upgPqMFm6RCYu4i80
         6R6RMOna71Q8i4Bl1EJrqn6HxMMAD1tSI66A9HtQQ+BdOw0iDkKWcBd0LZ/iwJbHFsh2
         so2WEMDAlFDBEdhZlfQbqkThHESe6IbPve/ZlvGqrjYi2XJ2NcP+3DfRcDsSe9As4piR
         SyX079O7PZz8L1/uK8JEUbIvyNh7+C/pZFCn4B/F+toSFHre7IDgrKo9N+JSjBb+131A
         RE6w==
X-Gm-Message-State: ABy/qLbuCV+hTAbDijwiBSULNImcbiwQqa2wsvdiTb6gC136hpFuwmfU
        fkaHDU58QMxJ6wDn2DbY265Hf6PB4SuDEG4/eOQ=
X-Google-Smtp-Source: APBJJlGXdX/trGZcV6zPG7z0PQ2EmAwNi23ZNhngp7RP6lx2r4Und01wwQQnjB6LzY4ojk7rO6ereEUvu//sqnhxiPk=
X-Received: by 2002:a25:ab09:0:b0:d06:f3e8:e6d2 with SMTP id
 u9-20020a25ab09000000b00d06f3e8e6d2mr15691045ybi.40.1690997988410; Wed, 02
 Aug 2023 10:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230626074242.3945398-1-changxian.cqs@antgroup.com> <20230626074242.3945398-2-changxian.cqs@antgroup.com>
In-Reply-To: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 2 Aug 2023 19:39:37 +0200
Message-ID: <CANiq72muJwPHuJF++BYptO4_WVA=mU68nn=GWgqYo7pMdxC=pA@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 9:48=E2=80=AFAM Qingsong Chen
<changxian.cqs@antgroup.com> wrote:
>
> If the trait has same function name, the `vtable` macro
> will redefine its `gen_const_name`, e.g.:
> ```rust
>     #[vtable]
>     pub trait Foo {
>         #[cfg(CONFIG_X)]
>         fn bar();
>
>         #[cfg(not(CONFIG_X))]
>         fn bar(x: usize);
>     }
> ```
> Use `HashSet` to avoid this.
>
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>

Applied to `rust-fixes`, thanks! I have reworded it with content from
the cover letter to make it more clear. Please double-check if it is
OK.

By the way, for single-patches, you don't need the cover letter,
especially if both have the same information like here (in fact, in
this case the cover letter was more clear, so it should have been part
of the commit message ideally).

Cheers,
Miguel
