Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA778C500
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjH2NSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbjH2NST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866B2184;
        Tue, 29 Aug 2023 06:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 246D9636C7;
        Tue, 29 Aug 2023 13:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E0EC433C7;
        Tue, 29 Aug 2023 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693315095;
        bh=jh66Sdt/TwjtCznyiblMwdkrIJLYKmp6mKZvnmhdovY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NribA2HGMkZneLf9U7/uitry3HzkvhacsTq11HT1wum835IAUo2agwyqKNJCBjx6J
         N37zrBFJZa1Xu3rbLSFAKYXL9zgM7DzzKEv2OWDy6LxB3WbUkhnn6D1VWjipIz2uKH
         aExGbl9HN+Z69MENEAkCytMBV/3MBL7MvmkVWLuT7kCl/CmIatoOgUYkh5O3mewye+
         f/KF7JJUE3aYL73P5uTU8X6T4S57a3wRdkrF4Y50Del1jxrK4wRefa6OhAxbREy0gV
         4Mjf3oxZ+zz7tiR2dhMlH7tVbOa7klbkZqQJUXD0+M3qKAjgO5xmZM2iYRFK9bSCo/
         SITHHIMgdb3NA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5733710eecaso2593138eaf.1;
        Tue, 29 Aug 2023 06:18:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YxfIMwFJ8vzywdsc0Azv5jqQDpaBuvT16hd11R4GzoPsMb+j8XK
        aaR89+PofWqxLKgqZyLF9tArrE6PbS6iLLnHFg0=
X-Google-Smtp-Source: AGHT+IGrjdYeWbzwPkSj7uxQXMLlkMd5pKaoLDSbw/kSc27B5Aqi/G2w7zTKdbqYYh9m/slezXtMglvq+C6n0WEcJ2g=
X-Received: by 2002:a4a:6b0a:0:b0:573:7828:ce53 with SMTP id
 g10-20020a4a6b0a000000b005737828ce53mr6105017ooc.4.1693315094817; Tue, 29 Aug
 2023 06:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230822065256.163660-1-denik@chromium.org> <20230825072744.1322656-1-denik@chromium.org>
In-Reply-To: <20230825072744.1322656-1-denik@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Aug 2023 22:17:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKMC-G4AJbHafPF0ef74_YPtzXipcmnZY=1AWgayVoCA@mail.gmail.com>
Message-ID: <CAK7LNAQKMC-G4AJbHafPF0ef74_YPtzXipcmnZY=1AWgayVoCA@mail.gmail.com>
Subject: Re: [PATCH v3] modpost: Skip .llvm.call-graph-profile section check
To:     Denis Nikitin <denik@chromium.org>
Cc:     linux-kbuild@vger.kernel.org, Fangrui Song <maskray@google.com>,
        Douglas Anderson <dianders@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Mon, Aug 28, 2023 at 5:15=E2=80=AFAM Denis Nikitin <denik@chromium.org> =
wrote:
>
> .llvm.call-graph-profile section is added by clang when the kernel is
> built with profiles (e.g. -fprofile-sample-use=3D or -fprofile-use=3D).
> Note that .llvm.call-graph-profile intentionally uses REL relocations
> to decrease the object size, for more details see
> https://reviews.llvm.org/D104080.
>
> The section contains edge information derived from text sections,
> so .llvm.call-graph-profile itself doesn't need more analysis as
> the text sections have been analyzed.
>
> This change fixes the kernel build with clang and a sample profile
> which currently fails with:
>
> "FATAL: modpost: Please add code to calculate addend for this architectur=
e"
>
> Signed-off-by: Denis Nikitin <denik@chromium.org>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Fangrui Song <maskray@google.com>
> ---


Applied to linux-kbuild.
Thanks.


>  scripts/mod/modpost.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index b29b29707f10..64bd13f7199c 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -761,6 +761,7 @@ static const char *const section_white_list[] =3D
>         ".fmt_slot*",                   /* EZchip */
>         ".gnu.lto*",
>         ".discard.*",
> +       ".llvm.call-graph-profile",     /* call graph */
>         NULL
>  };
>
> --
> 2.42.0.rc1.204.g551eb34607-goog
>


--=20
Best Regards
Masahiro Yamada
