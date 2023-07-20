Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA0A75B6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjGTSfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjGTSfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD96C196;
        Thu, 20 Jul 2023 11:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B04361B5C;
        Thu, 20 Jul 2023 18:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC4EC433C7;
        Thu, 20 Jul 2023 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878106;
        bh=81m5ZIcvfNL0FEFJ3Nuqam7BZthequgHa1BosBTrhVw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eR20BcHuZY0XWxQd8OtfDbxHXKUyGrqY6D71W9u8tdWPnfELSbHVV1tBRaP9lmxDg
         tiMLZnjMzSW4HatYlHq00xWkjjIi73SBzYbDiDfowPta/b1gLCTzwbAJ3u+wrD+ZlG
         Riuzp/GE5I3Bejkjezf/ewhZgeugbFtAT97csbHzTUTEFuHdRzCdutM5oUYK2IdTPH
         4tDocR27uLB7HJjf7h1N1XMsTDpmH9d/DosiRegxbZdcndZnVQfMX32uAu6jSMInkt
         lzuf3gvPWO8EnAdnWODZdOy9UK9ERf23QSDC8KbK54VPBqtojTS9xeMFOAJRK3wNd7
         WC8KATBqWYxog==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3a425ef874dso809230b6e.0;
        Thu, 20 Jul 2023 11:35:06 -0700 (PDT)
X-Gm-Message-State: ABy/qLZgN20ek2KKvxx8qisxsOTh8m9oQrsFN2x+Kia567AcssBjyh0F
        6EtSU9H7S04rbU+plIOi1vJ7YXP3MxRT+Xvh06A=
X-Google-Smtp-Source: APBJJlHKVWn9kDYcjOUOHIW70le7sgGdHBkr9p1Ep42APR+8uWupNFlwMZpme2w+wFD7onPJrRcdfhAUjJJ/+Q0LkTw=
X-Received: by 2002:a05:6808:19a9:b0:3a3:baf8:5b8a with SMTP id
 bj41-20020a05680819a900b003a3baf85b8amr450324oib.13.1689878106023; Thu, 20
 Jul 2023 11:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230718055235.1050223-1-ojeda@kernel.org> <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
 <CANiq72kZjOGvRKoRxtgG=2DhJnMJK9TCQtTmeef_B=nLcLQD6g@mail.gmail.com>
In-Reply-To: <CANiq72kZjOGvRKoRxtgG=2DhJnMJK9TCQtTmeef_B=nLcLQD6g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 03:34:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASqumGb0xvSa8n4Heasz9BKxgk4mvzNXsfFhZE1G+Bxbg@mail.gmail.com>
Message-ID: <CAK7LNASqumGb0xvSa8n4Heasz9BKxgk4mvzNXsfFhZE1G+Bxbg@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 2:30=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jul 20, 2023 at 7:18=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > Applied to linux-kbuild/fixes. Thanks.
> >
> > I believe this is a fix, so I will include it
> > in my next pull request.
>
> Thanks Masahiro! Yeah, it can be considered a fix. By the way, in case yo=
u want:
>
>     Fixes: 2f7ab1267dc9 ("Kbuild: add Rust support")


Maybe, the following was a breakage.


commit 295d8398c67e314d99bb070f38883f83fe94a97a
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat Jan 7 18:18:15 2023 +0900

    kbuild: specify output names separately for each emission type from rus=
tc




Before that, rust_common_cmd had --out-dir.


BTW, do we also need to fix scripts/Makefile.host
in case the external module Makefile creates host programs?







> I guess it can be also considered a feature (e.g. "supporting more
> setups"), but having the temporaries created where they were was
> unintentional.





--=20
Best Regards
Masahiro Yamada
