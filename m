Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720C27C93BE
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233020AbjJNJ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjJNJ0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:26:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E606C2;
        Sat, 14 Oct 2023 02:26:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0946C433D9;
        Sat, 14 Oct 2023 09:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697275605;
        bh=aGl4g3Sh3c+rQVAipdArG0sIEhyzdN1YpzpNOg38+TI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RaWJ/fOo5o9ngjwhlR5S1QxO8pKwquGkpkBM6XON34hCB9ktWAhmItUaTCPG8EXPv
         Q0rN9mTSYY5a22niHACtv8SKegbOBoDoy7ux0LbcOwvMhGDsU8avWdT0Piye8E3wCR
         OMvDD9CglE649f8pRbJlRWA6XZlz/T6PTXmo0D6w2a5IUWzOqgkzWIW5vMVMvF4h++
         zrK9Joklh91odonXxDzQybPy2znw0P+/NjNs/2nYQhN8Pab9pT79S86VGIYcHhAOH+
         T0hcJpbTAisMpbG+aDEiReqd3yLtGEv88A4WcelCwp6IAj0P5wIAkrDd+8PBHZrrQD
         bV8c2MdvRQIlQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1e562706d29so1648814fac.2;
        Sat, 14 Oct 2023 02:26:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQfUZBdUdX6eysUg7j8j1tu4bCDp5bkPfwOkYBwE4HbKuCkdFC
        RNSbORV1dlGVZEhjZABUtNRYznNx1B/j3LfRrog=
X-Google-Smtp-Source: AGHT+IEwEQUUC1JNZqjlzEvZLXYqnFViuoo3sDCGG2QuSlxycV452MkTdFFBAni9pTPEblM/p69MXbyOyylRdCUdRis=
X-Received: by 2002:a05:6870:d905:b0:1e9:f4e4:2882 with SMTP id
 gq5-20020a056870d90500b001e9f4e42882mr3597436oab.38.1697275604992; Sat, 14
 Oct 2023 02:26:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231005214057.759089-1-mmaurer@google.com> <CAK7LNATBBk-a0EJcxpWGJ9n+9BHQUw3a4s41LTtC-R8fYrVMpw@mail.gmail.com>
 <CANiq72=Dsaa77n-OKDZCcv6TWgxZf7R00n=X137WbsUzwgU4RA@mail.gmail.com>
In-Reply-To: <CANiq72=Dsaa77n-OKDZCcv6TWgxZf7R00n=X137WbsUzwgU4RA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 14 Oct 2023 18:26:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNATmscONw-Sy7tkgEY=z9i7Rgt0G0Mq9+FV8nN_vP+Q4mg@mail.gmail.com>
Message-ID: <CAK7LNATmscONw-Sy7tkgEY=z9i7Rgt0G0Mq9+FV8nN_vP+Q4mg@mail.gmail.com>
Subject: Re: [PATCH v4] rust: Respect HOSTCC when linking for host
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 7:00=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Sat, Oct 7, 2023 at 5:38=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
> >
> > Acked-by: Masahiro Yamada <masahiroy@kernel.org>
> >
> > if Miguel picked this up.
> >
> > Please let me know if I should pick this up.
>
> Thanks a lot for taking a look Masahiro -- either way is fine for me.
> If you want to take it, please feel free to add my `Acked-by`.
>
> Cheers,
> Miguel

I do not see this yet in linux-next.

So, I applied to linux-kbuild with Miguel's Ack now.



--=20
Best Regards
Masahiro Yamada
