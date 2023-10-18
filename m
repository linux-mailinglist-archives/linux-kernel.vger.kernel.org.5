Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A697CDB62
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjJRMPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjJRMPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:15:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293A398;
        Wed, 18 Oct 2023 05:15:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81F8C433CB;
        Wed, 18 Oct 2023 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697631303;
        bh=nGmn0pzaGHE/qvj6rQ8ChjIGCJEA9PY3ZeedXPz7NJ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j7/DLTl3x6NAMgJcCPlmnBkey1Kzaq1nbWBMXDPb5ViAIcfCL5Igq+S7QY16Sn0M6
         qy16AhM3oP4Mr0u2hnf1egYhixkYNndZMlbHHzUDPUCHSOd4UZNT/4OM/uo9pxewGF
         8id2rHei6MludtwSBnqPKCBEcS/Y+EwP6zGcwPrmDbr0Ur8YN/sdUNi0B067SBO3bv
         Ewigz+m9pRESXZ4rnKwAWsh9hsMUOc792L33ijVCYk09FpRTvy+bR8iX1OoGGAM46u
         48AyTD4pDM8i87tZP+65mkcOdn+8fff3taH1YjrICxHh5RS5z7eArrRlSvxfMKPb2R
         vVaNcmSn5ZNPQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-57b74782be6so3540867eaf.2;
        Wed, 18 Oct 2023 05:15:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YyWljBekBi43MaPhDG562L7/1lVGg2cWajv2L/LIJoveA3gFUu8
        SI6awT5sUqS/bbnfq7N6ylxDNzi+QjTb/nDABEw=
X-Google-Smtp-Source: AGHT+IEgcn0nzmRAj5+GRjt9MPHPUim6smgMT/Q/eZBbTn1SPigd6Mvj02wI5JV2LC15BVxSRL9MPaG3VXpAvawj5ZQ=
X-Received: by 2002:a05:6871:8917:b0:1e9:a4c8:1da7 with SMTP id
 ti23-20020a056871891700b001e9a4c81da7mr5355995oab.20.1697631303187; Wed, 18
 Oct 2023 05:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231017103742.130927-1-masahiroy@kernel.org> <20231017103742.130927-2-masahiroy@kernel.org>
 <CANiq72krkL_50wzZeM3C6xk_C-oU1fThykCCAXY07BWbmoxptg@mail.gmail.com>
In-Reply-To: <CANiq72krkL_50wzZeM3C6xk_C-oU1fThykCCAXY07BWbmoxptg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 18 Oct 2023 21:14:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNARto+DuNH8nuQDtJqJy7hMpozyKiaOkQJ_LYE1utU8XqQ@mail.gmail.com>
Message-ID: <CAK7LNARto+DuNH8nuQDtJqJy7hMpozyKiaOkQJ_LYE1utU8XqQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] kbuild: avoid too many execution of scripts/pahole-flags.sh
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Gary Guo <gary@garyguo.net>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Song Liu <song@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org
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

On Wed, Oct 18, 2023 at 12:21=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Tue, Oct 17, 2023 at 12:38=E2=80=AFPM Masahiro Yamada <masahiroy@kerne=
l.org> wrote:
> >
> > Convert the shell script to a Makefile, which is included only when
> > CONFIG_DEBUG_INFO_BTF=3Dy.
> >
> > [1]: https://savannah.gnu.org/bugs/index.php?64746
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> The field in `MAINTAINERS` should be removed:
>
>     F: scripts/pahole-flags.sh


I will replace it with

F: scripts/Makefile.btf


Thanks.



>
> But other than that, it looks good to me! I tried it for a given
> config and it does call `pahole` with the same flags.
>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> Cheers,
> Miguel



--=20
Best Regards
Masahiro Yamada
