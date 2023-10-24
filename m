Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131C67D43D4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 02:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjJXARy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 20:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJXARw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 20:17:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72DCD6E;
        Mon, 23 Oct 2023 17:17:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1E0C433C7;
        Tue, 24 Oct 2023 00:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698106670;
        bh=3q2j031K9WR3kHW/1FF7tj1iuRrzBeX5gnG1AT3nR1Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rpODxa8UECTDfdDLBH0YAEOpbwm+/Peb8lnyLaiZvd3DVnS/59wGWZBxB5ELOsQD9
         JHmrPXxQgRqd61scOyaTnP70FnRo1z1sZumm4TF9pKpNk9teazVI+eJ4YPHFt2vZdS
         d9ObW3lAzZmnwD6Lat1AznDB9VxLd3/E7oVAPj+X2As9JP0naxyxaCiR8bhU67EaZ0
         GQDxV5gWqUfdkR49U6vrRomDmEap2TKVG6IG7mNhG2EHs1TBpw1kx9D/Urtw4dsbG1
         h4DGceIPYrBNbMLcjfg9Ny1udZOcgqFRGZKJq/wS9NUkDZg0jlS01Ay3jB+0sUoDmh
         6O6QpZhuoXaFw==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-5832ea25c7eso1498193eaf.3;
        Mon, 23 Oct 2023 17:17:50 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxq3He2kctaS3f5PMHJKRYoLJLyhaf7yclYWKJild14IRfcMseM
        /olWjfdR/kZeYpog9TXsjPzMi/CaRItQH49m890=
X-Google-Smtp-Source: AGHT+IGgx+goDYUrN1p4jOx1XaLm71LBGdqMfgjX0cebhoBhJ3O1Fh6oWaEViaqPJey9ObCB46wjaySdsyltD1CqpXo=
X-Received: by 2002:a05:6870:568a:b0:1d0:f5bd:6e9 with SMTP id
 p10-20020a056870568a00b001d0f5bd06e9mr10166484oao.22.1698106669621; Mon, 23
 Oct 2023 17:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231002165750.1661-1-will@kernel.org> <20231002165750.1661-4-will@kernel.org>
In-Reply-To: <20231002165750.1661-4-will@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 24 Oct 2023 09:17:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-8NA9dG-G6gU3XZnTgo41-5c2v74LsCo18HkGJ-7CbQ@mail.gmail.com>
Message-ID: <CAK7LNAR-8NA9dG-G6gU3XZnTgo41-5c2v74LsCo18HkGJ-7CbQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] scripts/faddr2line: Skip over mapping symbols in
 output from readelf
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 3, 2023 at 1:58=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> Mapping symbols emitted in the readelf output can confuse the
> 'faddr2line' symbol size calculation, resulting in the erroneous
> rejection of valid offsets. This is especially prevalent when building
> an arm64 kernel with CONFIG_CFI_CLANG=3Dy, where most functions are
> prefixed with a 32-bit data value in a '$d.n' section. For example:
>
> 447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_initcal=
l
>    104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
>    106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
>    111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
>    112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
>     36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_proce=
ss
>
> Adding a warning to do_one_initcall() results in:
>
>   | WARNING: CPU: 0 PID: 1 at init/main.c:1236 do_one_initcall+0xf4/0x260
>
> Which 'faddr2line' refuses to accept:
>
> $ ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
> skipping do_one_initcall address at 0xffff800080014c74 due to size mismat=
ch (0x260 !=3D 0x224)
> no match for do_one_initcall+0xf4/0x260
>
> Filter out these entries from readelf using a shell reimplementation of
> is_mapping_symbol(), so that the size of a symbol is calculated as a
> delta to the next symbol present in ksymtab.
>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  scripts/faddr2line | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 6b8206802157..587415a52b6f 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -179,6 +179,11 @@ __faddr2line() {
>                         local cur_sym_elf_size=3D${fields[2]}
>                         local cur_sym_name=3D${fields[7]:-}
>
> +                       # is_mapping_symbol(cur_sym_name)
> +                       if [[ ${cur_sym_name} =3D~ ^(\.L|L0|\$) ]]; then
> +                               continue
> +                       fi
> +
>                         if [[ $cur_sym_addr =3D $sym_addr ]] &&
>                            [[ $cur_sym_elf_size =3D $sym_elf_size ]] &&
>                            [[ $cur_sym_name =3D $sym_name ]]; then
> --
> 2.42.0.582.g8ccd20d70d-goog
>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


--=20
Best Regards
Masahiro Yamada
