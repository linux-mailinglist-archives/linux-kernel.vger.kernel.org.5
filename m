Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30FF7B590C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238605AbjJBRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjJBRBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:01:14 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28ED7B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:01:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4054496bde3so150684435e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696266069; x=1696870869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFxH3mz3Qf6YBaOU+lSTvjLYPdlcIgrB/P0nDs/0tp8=;
        b=GZ98C3j2p+DUFlhPOPvxSwdXRxDOniArrC3e0JClvlS6KmkmeXx5mnUuv9IoLylHBG
         pSNKGGW5Wr1j8H8vUx430JAmyTSTSzS1SYwgm3uX2AsmDdxZZ3GVGORG7+ScdLFvaqCC
         Cjszx6dNJxbzBxKkn+MeM5mYb1AvjXm/G2O3BErFTSHmNdwli6DWffUBaVcnLgdrGSqO
         iD98vfe/L5I3WmO2rceR3ybQvfTW/tjUe7zIeb44NPdeVaNyM+i2L5TZtvqmfoE/J8ck
         dqeQ97ZgwunXAC7uFBlTJB0pWei1pvq5G7P0cuBzP2hQpAnlWa3REjcV6aQ7atBQaqxm
         hYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266069; x=1696870869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFxH3mz3Qf6YBaOU+lSTvjLYPdlcIgrB/P0nDs/0tp8=;
        b=Hs1KkA1ZcUq2pC/nY/5yryJfl8pPwaplcTPOdv6cbgmIgtnA2rKTberv40IP2lhI/O
         oYWbuDdc3g1/6pAwexLxxWjZ/rfMMRIVPZGFyoI1m0bR1KFziRPGE2JJaVQE1nTcS+A+
         YYUye3JpmqNa61BnEKm7/mCN8QrR3PhWEtQhx/PGQgq/xyIyjC38nxtNOdmigWdvPv61
         jx/Mt9yRCxputLomWbLJ3kRfl1J3dgVNPlMWczFd53bVE0UB+J9TH4T+akPzlMaVIMky
         BABGUB0k1ye9RWlAZGcambnp0lyTCcFyMFIljAd53Yfu9J5O48deZxUnD4ReqrEvrvKn
         fwZQ==
X-Gm-Message-State: AOJu0YybVwmWUTNUq7VYRKEp3W2BRfCPgOl/wpx/NK3XBTTKnu9bhP8v
        BcdVyRT3mCbQZCVwdDUyBK3H+cH6qW2/KtKcS4+oRQ==
X-Google-Smtp-Source: AGHT+IFNJFIeTDc/EWjwXL+Rndl0ZmZ/LK/bGiU56VjGu4++37Q/ONEFt8LguViaPpw2utCTqsi/xlm1VfelxNTDuHk=
X-Received: by 2002:a7b:c394:0:b0:403:31a:77b9 with SMTP id
 s20-20020a7bc394000000b00403031a77b9mr10499157wmj.37.1696266069361; Mon, 02
 Oct 2023 10:01:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231002165750.1661-1-will@kernel.org> <20231002165750.1661-3-will@kernel.org>
In-Reply-To: <20231002165750.1661-3-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Oct 2023 10:00:58 -0700
Message-ID: <CAKwvOdmLey43Ng5p7bD2arUY6T=B+y=K-Lo-Qbya540ZUJXU4Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] scripts/faddr2line: Use LLVM addr2line and readelf
 if LLVM=1
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 9:58=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
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
> accept LLVM=3D as an indication to use the llvm- tools, optionally
> specifying their location or specific version number.
>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/faddr2line | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index a35a420d0f26..6b8206802157 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -58,8 +58,21 @@ die() {
>         exit 1
>  }
>
> -READELF=3D"${CROSS_COMPILE:-}readelf"
> -ADDR2LINE=3D"${CROSS_COMPILE:-}addr2line"
> +UTIL_SUFFIX=3D""
> +if [[ "${LLVM:-}" =3D=3D "" ]]; then
> +       UTIL_PREFIX=3D${CROSS_COMPILE:-}
> +else
> +       UTIL_PREFIX=3Dllvm-
> +
> +       if [[ "${LLVM}" =3D=3D *"/" ]]; then
> +               UTIL_PREFIX=3D${LLVM}${UTIL_PREFIX}
> +       elif [[ "${LLVM}" =3D=3D "-"* ]]; then
> +               UTIL_SUFFIX=3D${LLVM}
> +       fi
> +fi
> +
> +READELF=3D"${UTIL_PREFIX}readelf${UTIL_SUFFIX}"
> +ADDR2LINE=3D"${UTIL_PREFIX}addr2line${UTIL_SUFFIX}"
>  AWK=3D"awk"
>  GREP=3D"grep"
>
> --
> 2.42.0.582.g8ccd20d70d-goog
>


--=20
Thanks,
~Nick Desaulniers
