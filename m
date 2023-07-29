Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651D6767CAE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 08:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjG2G7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 02:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2G7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 02:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD18649EB;
        Fri, 28 Jul 2023 23:59:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CA1660766;
        Sat, 29 Jul 2023 06:59:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829E0C433C7;
        Sat, 29 Jul 2023 06:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690613954;
        bh=pH61JHyCnyY9RStw/F9+va8ZXuOwbbiiebLPqill1n0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=az+FzhTyIRfsDg6cCIJSp5wA/lSM6MNsVviNmMELnJGq4g+euILuU+o86NPIcamuy
         GOR2GFFlvzrKdj5Mv/aDJMCJ3eAz2oNEnDcYyNiM37j/SoSSSAy0nRZTBCJ4EGUQWu
         H0CURCOOE3VGyn2RYQip0d3Aip0Tik53a7SAB/nbxS8EiicwGFs1ctbOAM28pqCYTJ
         xVPpRzJ4Nr7kA/+4Blu+nF8k6W+2WZkHfK19fdlgn7liQ5oeCAQa45YOhagx9Ou1dW
         +BYz/RC3nbbW/wJRrNTS47epuws2A+b6rxYeNWUa5SYiSlEaqPLUctkPI9lWD5ilYg
         81tvVHsrIURiQ==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56368c40e8eso1962291eaf.0;
        Fri, 28 Jul 2023 23:59:14 -0700 (PDT)
X-Gm-Message-State: ABy/qLYiShmAZU+PBo/wBeprX3I6jX7aDRQrbdrI8ZVoyiPbtxwYZq+f
        0PcjYau5qXWbMNl87P7eLX8Ef5oMWRRopygk1SU=
X-Google-Smtp-Source: APBJJlGvd3PMN7Ht1B42qUs98OQA9vQ7tJHewBRhzNp/XTPhiOuUuzFjYheFXXnNgKJ47UruW+IkvVmpvqrXwb4qvRs=
X-Received: by 2002:a4a:3457:0:b0:566:f9ff:57f with SMTP id
 n23-20020a4a3457000000b00566f9ff057fmr4447885oof.8.1690613953808; Fri, 28 Jul
 2023 23:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230725105827.1119167-1-james.clark@arm.com>
In-Reply-To: <20230725105827.1119167-1-james.clark@arm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 29 Jul 2023 15:58:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNAST1bq=oLT9spUJ3tH+f1RKjG0N_hXh+K7juaS1XgpCRQ@mail.gmail.com>
Message-ID: <CAK7LNAST1bq=oLT9spUJ3tH+f1RKjG0N_hXh+K7juaS1XgpCRQ@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/kallsyms: Fix build failure by setting errno
 before calling getline()
To:     James Clark <james.clark@arm.com>
Cc:     linux-kbuild@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicolas Schier <n.schier@avm.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 7:58=E2=80=AFPM James Clark <james.clark@arm.com> w=
rote:
>
> getline() returns -1 at EOF as well as on error. It also doesn't set
> errno to 0 on success, so initialize it to 0 before using errno to check
> for an error condition. See the paragraph here [1]:
>
>   For some system calls and library functions (e.g., getpriority(2)),
>   -1 is a valid return on success. In such cases, a successful return
>   can be distinguished from an error return by setting errno to zero
>   before the call, and then, if the call returns a status that indicates
>   that an error may have occurred, checking to see if errno has a
>   nonzero value.
>
> Bear has a bug [2] that launches processes with errno set and causes the
> following build failure:
>
>  $ bear -- make LLVM=3D1
>  ...
>   LD      .tmp_vmlinux.kallsyms1
>   NM      .tmp_vmlinux.kallsyms1.syms
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>  read_symbol: Invalid argument
>
> [1]: https://linux.die.net/man/3/errno
> [2]: https://github.com/rizsotto/Bear/issues/469
>
> Fixes: 1c975da56a6f ("scripts/kallsyms: remove KSYM_NAME_LEN_BUFFER")
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: James Clark <james.clark@arm.com>

Applied to linux-kbuild/fixes.
Thanks.


> ---
>  scripts/kallsyms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 16c87938b316..653b92f6d4c8 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -129,6 +129,7 @@ static struct sym_entry *read_symbol(FILE *in, char *=
*buf, size_t *buf_len)
>         ssize_t readlen;
>         struct sym_entry *sym;
>
> +       errno =3D 0;
>         readlen =3D getline(buf, buf_len, in);
>         if (readlen < 0) {
>                 if (errno) {
> --
> 2.34.1
>


--=20
Best Regards
Masahiro Yamada
