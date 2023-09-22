Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1737AB2D3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjIVNfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjIVNfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:35:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7FE194;
        Fri, 22 Sep 2023 06:35:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A237C433C9;
        Fri, 22 Sep 2023 13:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695389707;
        bh=hFU2ZNAaYrMwRcX66C2zAAyeU4y4hucIP2xCW7j7hEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ewHSFyZWOi9bugrv7zDFugE5i45UWaM64191GjsAkXcELJ60M0dOQiQkkQWKF3TnW
         QP49rW5IY9NUtuDTPxlYFVlnRFpqeizKcGgfgoxC7RMAdVwdWbW/qVOaxAaeqbTPRK
         QDJRhHHR+zxHKuMt9XwiiA0tpWNVjpNhR0pgVMiez9zxNMahYxWb+iidfHNFZ7kYT3
         R//XA6z0z7vJsdJasNM5ubYxNhI5/AMVHJC00zjkW6cVs686zL05LvdIvt7hyn3SsK
         cnkmigSK7TDYlRInQk+XtIPjMNwLc8I1yI6tUWvHmTVnvaSX5KTtou5/YEBI8YdRhO
         Wsae8uxqtMWzA==
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-57b9193b1aeso69337eaf.0;
        Fri, 22 Sep 2023 06:35:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywk2RaHRM1uONG2nHy3pjNaUGqFCo5s59Mpoxf3sVqr3i4x/MBK
        QHE7TohZQ/hG76SnUYJucnD8kJwv7TsC1unDEq0=
X-Google-Smtp-Source: AGHT+IGA81653n4C71R8kzqxqwPxnyNXGh2Y6BEyGm3/KYFy577leiM2HWClrgCJe/USG6z7z+YHshTmCpmiYC7RNeU=
X-Received: by 2002:a05:6871:54b:b0:1a6:cfcc:befd with SMTP id
 t11-20020a056871054b00b001a6cfccbefdmr1764941oal.5.1695389706789; Fri, 22 Sep
 2023 06:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
 <c2b92ff2-d077-4588-9d5c-93dfec0037ee@mailbox.org> <b85bf040-f6be-ef12-5b33-6d41991e4d97@tweek.dk>
 <CAK7LNAQVuKQ34xK8AA9M0dytb1zNpE+rUYDhi6kGDO60SYBpyw@mail.gmail.com> <d0016504-af19-eab5-8898-f51a8c8abdcd@tweek.dk>
In-Reply-To: <d0016504-af19-eab5-8898-f51a8c8abdcd@tweek.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 Sep 2023 22:34:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNARKiu54dRK9y8aRRFC_UrurE_qumXdv6TRJpzQ_AS1dwQ@mail.gmail.com>
Message-ID: <CAK7LNARKiu54dRK9y8aRRFC_UrurE_qumXdv6TRJpzQ_AS1dwQ@mail.gmail.com>
Subject: Re: [PATCH] Use CRC32 and a 1MiB dictionary for XZ compressed modules
To:     Martin Nybo Andersen <tweek@tweek.dk>
Cc:     Tor Vic <torvic9@mailbox.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Terrell <terrelln@fb.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
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

On Fri, Sep 22, 2023 at 8:04=E2=80=AFPM Martin Nybo Andersen <tweek@tweek.d=
k> wrote:
>
>
> On Fri, 22 Sep 2023, Masahiro Yamada wrote:
>
> [...]
>
> > Hello, sorry for the delay.
> >
> > I am OK with picking the patch to my tree.
>
> Hi,
>
> That sound great :)
>
> > I think we can use --check=3Dcrc32 --lzma2=3Ddict=3D1MiB
> > unconditionally.
> >
> > (But, if the in-kernel decompressor is improved
> > to understand CRC64 in the future, we can loosen
> > this restriction again.)
>
> Of course.
>
> > Just small change requests.
> >
> > Please do not use the Fixes tag to point at the Debian bug tracker.
> >
> >
> > Instead, you can do
> >
> > Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582
> >
> >   or
> >
> > Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582
> >
> >
> >
> > Also, mention that this change happened in
> >
> > kmod commit 09c9f8c5df04 ("libkmod: Use kernel decompression when avail=
able")
> >
> > in the commit description might be helpful.
> >
> >
> >
> >
> > I added Lukas to CC.
> > He is the author of the change on kmod side.
>
> Is this ok?


Yes, perfect!

Thanks.


>
> Kmod is now (since kmod commit 09c9f8c5df04 ("libkmod: Use kernel
> decompression when available")) using the kernel decompressor, when
> loading compressed modules.
>
> However, the kernel XZ decompressor is XZ Embedded, which doesn't
> handle CRC64 and dictionaries larger than 1MiB.
>
> Use CRC32 and 1MiB dictionary when XZ compressing and installing
> kernel modules.
>
> Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582
> Signed-off-by: Martin Nybo Andersen <tweek@tweek.dk>
> ---
>   scripts/Makefile.modinst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index c59cc57286ba..ffbafbd3aeea 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -144,7 +144,7 @@ endif
>   quiet_cmd_gzip =3D GZIP    $@
>         cmd_gzip =3D $(KGZIP) -n -f $<
>   quiet_cmd_xz =3D XZ      $@
> -      cmd_xz =3D $(XZ) --lzma2=3Ddict=3D2MiB -f $<
> +      cmd_xz =3D $(XZ) --check=3Dcrc32 --lzma2=3Ddict=3D1MiB -f $<
>   quiet_cmd_zstd =3D ZSTD    $@
>         cmd_zstd =3D $(ZSTD) -T0 --rm -f -q $<
> --
> 2.40.1



--=20
Best Regards
Masahiro Yamada
