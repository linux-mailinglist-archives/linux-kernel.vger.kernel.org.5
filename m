Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF5E7AAFD3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjIVKmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjIVKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:42:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1113AAC;
        Fri, 22 Sep 2023 03:42:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC69C433CB;
        Fri, 22 Sep 2023 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379333;
        bh=ORm7kuwlD/Fvo8ESZ1v+JAsTRK52tEMMlKCCDrA0YY8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TXhsDQUfnwx6RyV9NNuadjwzrT2EUkn+EwKJevn77xA6Wd7mRdf2ZNwVAjCLB2c8v
         9RHXdZLvEOvr84+SkxV/2USZTmYChZiOnyuPSQjPMcsxKIfgULhiMSj1CqUCcG8aHz
         iO+AK058Ic2GveDrdS12CWQIljFXvSl7FY+18Dg2LB4z7+4zhniLtLnRMv7FjfUlnd
         GZRZ+FjxXL0xnhMpUbJLdm9bZ6FJ78cK1orQhshDSp8S79bnx4ka8GEkrxtMhL4qo6
         mseuLCdeXRUeGw2Cr4WJltzc0jZ4EhrYD1Y9eYF75qlxjmarYl5Ycuy2JMnOjac1Uh
         KPdbzMdtH7ypw==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-57b2e23de65so993535eaf.1;
        Fri, 22 Sep 2023 03:42:13 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8qORikjsl5XsKogyUgzCAd38gkQoHhMWkUgaqZmpTb8C/Yz9m
        z9/lHEy9i07Qges7Jv0whCjtfKjNufyoMW3LiKg=
X-Google-Smtp-Source: AGHT+IGE4IEqCwRq4hFD60gv0+WMRiqrWPruMG4GYnR6vNmZUl9HsLYfswyLN4S34COv4gRYMRyem9VswuhCXNx5bfg=
X-Received: by 2002:a05:6870:891a:b0:1bf:1a58:c50 with SMTP id
 i26-20020a056870891a00b001bf1a580c50mr8773299oao.9.1695379333035; Fri, 22 Sep
 2023 03:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <3d34a965-ab9c-d549-0c63-c717ab5d2edc@tweek.dk>
 <c2b92ff2-d077-4588-9d5c-93dfec0037ee@mailbox.org> <b85bf040-f6be-ef12-5b33-6d41991e4d97@tweek.dk>
In-Reply-To: <b85bf040-f6be-ef12-5b33-6d41991e4d97@tweek.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 22 Sep 2023 19:41:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQVuKQ34xK8AA9M0dytb1zNpE+rUYDhi6kGDO60SYBpyw@mail.gmail.com>
Message-ID: <CAK7LNAQVuKQ34xK8AA9M0dytb1zNpE+rUYDhi6kGDO60SYBpyw@mail.gmail.com>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 5:52=E2=80=AFPM Martin Nybo Andersen <tweek@tweek.d=
k> wrote:
>
> On Fri, 22 Sep 2023, Tor Vic wrote:
>
> >>
> >> Hello?
> >
> > Hello,
>
> :)
>
> >> Anyone?
> >>
> >> Best regards,
> >> - Martin
> >>
> >> On Fri, 15 Sep 2023, Martin Nybo Andersen wrote:
> >>
> >>> Kmod is now using the kernel decompressor which doesn't handle CRC64
> >>> and dictionaries larger than 1MiB.
> >>>
> >>> Fixes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582
> >>> Signed-off-by: Martin Nybo Andersen <tweek@tweek.dk>
> >>> ---
> >>> scripts/Makefile.modinst | 2 +-
> >>> 1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> >>> index c59cc57286ba..ffbafbd3aeea 100644
> >>> --- a/scripts/Makefile.modinst
> >>> +++ b/scripts/Makefile.modinst
> >>> @@ -144,7 +144,7 @@ endif
> >>> quiet_cmd_gzip =3D GZIP    $@
> >>>       cmd_gzip =3D $(KGZIP) -n -f $<
> >>> quiet_cmd_xz =3D XZ      $@
> >>> -      cmd_xz =3D $(XZ) --lzma2=3Ddict=3D2MiB -f $<
> >>> +      cmd_xz =3D $(XZ) --check=3Dcrc32 --lzma2=3Ddict=3D1MiB -f $<
> >
> > I wonder whether it should be guarded with
> >    ifdef CONFIG_MODULE_DECOMPRESS
> >
> > But on the other hand, the difference between 1M and 2M is likely very =
small
> > in terms of compression ratio.
>
> That would work, since kmod decompress the modules in userspace if
> CONFIG_MODULE_DECOMPRESS if off.
>
> What I'm aiming for is just that the kernel should be able to decompress
> its own modules, when it advertises it.


Hello, sorry for the delay.

I am OK with picking the patch to my tree.


I think we can use --check=3Dcrc32 --lzma2=3Ddict=3D1MiB
unconditionally.

(But, if the in-kernel decompressor is improved
to understand CRC64 in the future, we can loosen
this restriction again.)



Just small change requests.

Please do not use the Fixes tag to point at the Debian bug tracker.


Instead, you can do

Link: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582

   or

Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1050582



Also, mention that this change happened in

kmod commit 09c9f8c5df04 ("libkmod: Use kernel decompression when available=
")

in the commit description might be helpful.




I added Lukas to CC.
He is the author of the change on kmod side.






> Cheers,
> Martin
>
> > Cheers,
> > Tor Vic
> >
> >>> quiet_cmd_zstd =3D ZSTD    $@
> >>>       cmd_zstd =3D $(ZSTD) -T0 --rm -f -q $<
> >>>
> >>> --
> >>> 2.40.1
> >>>
> >>>
> >>
> >
> >



--=20
Best Regards
Masahiro Yamada
