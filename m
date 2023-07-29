Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC037681E1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 22:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjG2Us0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2UsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 16:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802F2134;
        Sat, 29 Jul 2023 13:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3984660A37;
        Sat, 29 Jul 2023 20:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94348C433CB;
        Sat, 29 Jul 2023 20:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690663702;
        bh=cCImiBweLwK3He7S6NoHP/buQLDFJWlbAluCSmMxegc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kE6TtH69i7ArrR5GRJMpMNo8c6HzpUETP8195c7kWqTa+O7I5OrVmMKMV1reVkOOX
         FMGUMNffR1hK3aulV60o1xnsXnSe02hDUM+3cxQ5LvYZ8LIbN2pQydtcXqn1nIf92J
         DFlNrpcXSvQXO1U6+qBzKQ0/7PDvaI4LLtYlq5eWiG5kSxrMPjZFIWcFpOGY9YdN0I
         WMOX7bnzppAYhqrNZuSxHPZMjgur007dNqlAS4fMNRadjHrHjLV9BZ8XUtM3V7NDdu
         wPTKpQxT0SfkK+KSwyQPLVGhXGttHAMEotrgwZUmUjo+4/nb9pqMRwx7FiZrRCy2jw
         P17DE509D2GxA==
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5636425bf98so1635021eaf.1;
        Sat, 29 Jul 2023 13:48:22 -0700 (PDT)
X-Gm-Message-State: ABy/qLaNqE/a0YWFH5x7qw28PuGkzXy1i/QyLHc4PkNdA+ev2cWlovMp
        n4gsSZdjgmNoe63nz94JRXDxWt4zXzYlJdDHYOI=
X-Google-Smtp-Source: APBJJlH/wR8cw2PjjQFAtuXhJWNtF/7mA0Bbp2UCXBxT/p90DEgeClBiw12X7Tn4wSr7eXegJi4w/4zFoeu4Ijx+Qas=
X-Received: by 2002:a4a:6c1b:0:b0:566:fc91:857d with SMTP id
 q27-20020a4a6c1b000000b00566fc91857dmr4808971ooc.5.1690663701837; Sat, 29 Jul
 2023 13:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230728113415.21067-1-will@kernel.org> <20230728113415.21067-2-will@kernel.org>
In-Reply-To: <20230728113415.21067-2-will@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 30 Jul 2023 05:47:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNATaXbGb7w=5xHtpVdPwcpm3iMPfzooABpftah1Sdw7ooQ@mail.gmail.com>
Message-ID: <CAK7LNATaXbGb7w=5xHtpVdPwcpm3iMPfzooABpftah1Sdw7ooQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] scripts/faddr2line: Use LLVM addr2line and readelf
 if LLVM=1
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 8:34=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> GNU utilities cannot necessarily parse objects built by LLVM, which can
> result in confusing errors when using 'faddr2line':
>
> $ CROSS_COMPILE=3Daarch64-linux-gnu- ./scripts/faddr2line vmlinux do_one_=
initcall+0xf4/0x260
> aarch64-linux-gnu-addr2line: vmlinux: unknown type [0x13] section `.relr.=
dyn'
> aarch64-linux-gnu-addr2line: DWARF error: invalid or unhandled FORM value=
: 0x25
> do_one_initcall+0xf4/0x260:
> aarch64-linux-gnu-addr2line: vmlinux: unknown type [0x13] section `.relr.=
dyn'
> aarch64-linux-gnu-addr2line: DWARF error: invalid or unhandled FORM value=
: 0x25
> $x.73 at main.c:?
>
> Although this can be worked around by setting CROSS_COMPILE to "llvm=3D-"=
,
> it's cleaner to follow the same syntax as the top-level Makefile and
> accept LLVM=3D1 as an indication to use the llvm- tools.


Just a note.
The top Makefile accepts not only LLVM=3D1
but also LLVM=3D/usr/lib/llvm-16/bin/.
The latter is useful when you want to use
a particular version or a custom one.

Another idea might be to use a generic '${prefix}'
as this is not hooked to the Makefile,
but I do not have a strong opinion.




>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  scripts/faddr2line | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 0e73aca4f908..62a3fa6f6f59 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -58,8 +58,14 @@ die() {
>         exit 1
>  }
>
> -READELF=3D"${CROSS_COMPILE:-}readelf"
> -ADDR2LINE=3D"${CROSS_COMPILE:-}addr2line"
> +if [ "${LLVM:-}" =3D=3D "1" ]; then
> +       UTIL_PREFIX=3Dllvm-
> +else
> +       UTIL_PREFIX=3D${CROSS_COMPILE:-}
> +fi
> +
> +READELF=3D"${UTIL_PREFIX}readelf"
> +ADDR2LINE=3D"${UTIL_PREFIX}addr2line"
>  AWK=3D"awk"
>  GREP=3D"grep"
>
> --
> 2.41.0.487.g6d72f3e995-goog
>


--=20
Best Regards
Masahiro Yamada
