Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223217608F6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjGYFBa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjGYFB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:01:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF49C10F9;
        Mon, 24 Jul 2023 22:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3448961530;
        Tue, 25 Jul 2023 05:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E770C433CD;
        Tue, 25 Jul 2023 05:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690261286;
        bh=+FyEzIHHHu86QHrIoXwjeeWi+fV/oC+M1YZ91MsjQXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BnI66cA59lweu/0a+Q3u7Ol/c21g7OcL6K6YkWORXYvQrvrj4qh94ARo/HvjORaMe
         qTvOs1yXe/Pdpia5RAMtcbWVHN+tOdW39vwGAp775rngcIf+JpNfIN0/VpOUHyon2O
         CMzMrsFzfNc7Tpmsab8Sy2MM5ufE3IOjmHSUBUcCO/Bq97fwVFpkqFpYx+DDEuVZ1P
         2ac4U8pBgan/zJ/OGRzjsI3dlcgGMSPPhR++d4+CAb/GAqMxFcwZG3numGUbjCaQUq
         +sUwSJqOpwNCnmIrYRgRoaRfAdc+cEAKSnm0EMb6kknpf08EpNdbEsGW/QKOZzSX7h
         kkuLgyreoWyuw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-56597d949b1so3147964eaf.1;
        Mon, 24 Jul 2023 22:01:26 -0700 (PDT)
X-Gm-Message-State: ABy/qLbj+Xl0xHHFuX9A6LVIALec8H7W5N/t+NOFMhW0hT7mv8nakfLI
        hrbGgdLQodnt+TeIhL/sbZYXXmOk20s2cIXb9vY=
X-Google-Smtp-Source: APBJJlHNMewixjluZirFDxPtZ/xyBhT/i9rV3VOmKVpLXySF76A/9PjhZyiOUBiUZa72yxWxXdde6eDqTDRyg9svjDM=
X-Received: by 2002:a4a:91d0:0:b0:566:fa3f:82af with SMTP id
 e16-20020a4a91d0000000b00566fa3f82afmr9199256ooh.5.1690261285620; Mon, 24 Jul
 2023 22:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230723142128.194339-1-ojeda@kernel.org>
In-Reply-To: <20230723142128.194339-1-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 25 Jul 2023 14:00:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR_CaZ8fJ+fOm9-X83MOtwDa9aavZ5JM6DFOAA00GgULw@mail.gmail.com>
Message-ID: <CAK7LNAR_CaZ8fJ+fOm9-X83MOtwDa9aavZ5JM6DFOAA00GgULw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rust: avoid creating temporary files
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
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
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TRACKER_ID,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 11:21=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> `rustc` outputs by default the temporary files (i.e. the ones saved
> by `-Csave-temps`, such as `*.rcgu*` files) in the current working
> directory when `-o` and `--out-dir` are not given (even if
> `--emit=3Dx=3Dpath` is given, i.e. it does not use those for temporaries)=
.
>
> Since out-of-tree modules are compiled from the `linux` tree,
> `rustc` then tries to create them there, which may not be accessible.
>
> Thus pass `--out-dir` explicitly, even if it is just for the temporary
> files.
>
> Similarly, do so for Rust host programs too.
>
> Reported-by: Raphael Nestler <raphael.nestler@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1015
> Reported-by: Andrea Righi <andrea.righi@canonical.com>
> Tested-by: Raphael Nestler <raphael.nestler@gmail.com> # non-hostprogs
> Tested-by: Andrea Righi <andrea.righi@canonical.com> # non-hostprogs
> Fixes: 295d8398c67e ("kbuild: specify output names separately for each em=
ission type from rustc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> v2:
>   - Add fix for host programs too (Masahiro).


This is now available in the mainline.

df01b7cfcef08bf3fdcac2909d0e1910781d6bfd





--=20
Best Regards
Masahiro Yamada
