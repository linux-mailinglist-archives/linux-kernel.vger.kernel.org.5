Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB575E21C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGWNgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 09:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGWNgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 09:36:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46710DD;
        Sun, 23 Jul 2023 06:36:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A9F960CFA;
        Sun, 23 Jul 2023 13:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FE4C433CB;
        Sun, 23 Jul 2023 13:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690119362;
        bh=O1IIMN7Y1zRc3XOUmu8VPg3ACsmolQilL9wEXTaUfq0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bEohhuLUK1dSi12/IxXfSkxMEfJgOh0hOz+UucGXozkJpf7axqzuCpVb8Y+hXgCNX
         SaPf2jkC52Lm1mk0xAnT9v0MwB1AWeT1fEIov9y7rQUG4fEkIlmHDNVR5dhSzy5CU8
         sXpyAm/oSnTJAtfE5yzVxKS0Jca0FEXYP2mYBl+HfuyM9gjsltwEXfbjtEIRJ2PiO4
         BE8vBu94NSSU4v8qXxvtB/S72Bh16bAakamyFA35uOLtrZTy3Xp0Ai7vsgXS3ij2aj
         mx1S+a71fzn2Xa3D33cPycajyhSwu12mbW9UMKHoA4YbLhEUncOv1kBtnGCidfWSwA
         sQ/j/u+2oigow==
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3a36b52b4a4so2217932b6e.1;
        Sun, 23 Jul 2023 06:36:02 -0700 (PDT)
X-Gm-Message-State: ABy/qLa0Y28e2mPMLHDyhmuWsYU8E0eEMyQvZmtmah9Udi2cc6+EK6Hw
        ucuLhpQ8w1O6DVVsywJ14Emb9FZZk6+0WHNK6Jc=
X-Google-Smtp-Source: APBJJlEtZ7vv6IbOH84SATHMJCAMxnz2YpuXNOI1/BwoW86mbx9Nm47dGyoVL7wZ1gh1ODC5aHD1JS0QWO0h/EoEPu8=
X-Received: by 2002:a05:6808:302c:b0:39c:7f78:ba6d with SMTP id
 ay44-20020a056808302c00b0039c7f78ba6dmr6412590oib.19.1690119361932; Sun, 23
 Jul 2023 06:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230718055235.1050223-1-ojeda@kernel.org> <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
 <CANiq72kZjOGvRKoRxtgG=2DhJnMJK9TCQtTmeef_B=nLcLQD6g@mail.gmail.com>
 <CAK7LNASqumGb0xvSa8n4Heasz9BKxgk4mvzNXsfFhZE1G+Bxbg@mail.gmail.com>
 <CANiq72kD2wxXy2ri8sBhVJ4y-JJiq+kYt_MRZwuwB9uGkX-_jQ@mail.gmail.com> <CAK7LNARm1LevTQVw1j5pQjp_gP=6-4CiwXLRDXbVH3bnC0OCxg@mail.gmail.com>
In-Reply-To: <CAK7LNARm1LevTQVw1j5pQjp_gP=6-4CiwXLRDXbVH3bnC0OCxg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 23 Jul 2023 22:35:25 +0900
X-Gmail-Original-Message-ID: <CAK7LNARZaeJ4SzRFo-GUA4Q7DGHwrDshxEMuEDO_N+SPHvof3A@mail.gmail.com>
Message-ID: <CAK7LNARZaeJ4SzRFo-GUA4Q7DGHwrDshxEMuEDO_N+SPHvof3A@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: avoid creating temporary files
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Raphael Nestler <raphael.nestler@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 2:05=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Sun, Jul 23, 2023 at 12:52=E2=80=AFAM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Thu, Jul 20, 2023 at 8:35=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > Maybe, the following was a breakage.
> > >
> > > commit 295d8398c67e314d99bb070f38883f83fe94a97a
> > > Author: Masahiro Yamada <masahiroy@kernel.org>
> > > Date:   Sat Jan 7 18:18:15 2023 +0900
> > >
> > >     kbuild: specify output names separately for each emission type fr=
om rustc
> > >
> > > Before that, rust_common_cmd had --out-dir.
> >
> > That's right, good catch!
> >
> > > BTW, do we also need to fix scripts/Makefile.host
> > > in case the external module Makefile creates host programs?
> >
> > Indeed, we need it too. [1] would fix it (tested it with a trivial
> > out-of-tree Rust hostprog).
> >
> > Do you want me to send it separately? i.e. to avoid losing the
> > `Tested-by`s etc. that we already got for this one, which is the
> > important one since that actually has users.
> >
> > The hostprogs fix is not really critical for stable, since it is
> > unlikely there are users at all (we just got the first in-tree real
> > user in the Rust+KUnit integration coming into 6.6), but I guess it
> > does not hurt for the same reason.
>
>
> Can you send v2 with the following squashed?
>
>
> I think it makes sense to fix both if we add
> Fixes: 295d8398c67e ("kbuild: specify output names separately for each
> emission type from rustc")


I dropped v1 for now,
expecting to get v2 soon.


--=20
Best Regards
Masahiro Yamada
