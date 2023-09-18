Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010F27A4D8B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjIRPxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIRPxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:53:05 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26A419B7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:51:13 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76ef935abaeso308459185a.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695051996; x=1695656796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSP+16G1Bwl8A9IxgIP/Sa5BiOxstbUYl8oEInDZp+w=;
        b=txqFLE+MS1O0Bp7OnBjkA3p+ajO0hNQdaN+PLm2WUvcPzKQvXyQC6oMnVYaaZpcABt
         NXC3G+Dz0RhnO7X5bBeuZVSr0WpSxLu84maUJN39GHh07inBahBrRmF9233eb87K19Xf
         nR3m49yrcdkHHmLcHKzlUozy75I/X+oK5spNKnxoBMCUaXYgiAicPp39BFMX3nfoNJdW
         mYlO3aR11caVCuf7bn8w/VwWm5phZkzMcRlEaT/bfWmoHUMtg4CGcJdWENTYZC9LaLfc
         J/zGsqPp6H3wKS86PSAei6YuqFtjh21AxR0Z0mUXvvDxLvaeknLekTPNTK1dRQrrVZcH
         e3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051996; x=1695656796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSP+16G1Bwl8A9IxgIP/Sa5BiOxstbUYl8oEInDZp+w=;
        b=kULmuVDSGYRJKxW33EMzUzrV7v5Y7v3QYWeh5lDoJAGiXFOnGCKJACsm9ox3wyWOfF
         6v1YEpQiiFXLB91xorWEtQZYJSlgapDdTwykdaZ3ckQrCGVITkHsomFMLLzuNIjvtNXs
         ztjxS0O+1uxXlxzlTsquk4hWycMuoIRx0/sGUVXGOr8/YF5jpE0o5aP4bbcdiQhMpQGG
         wLupa34IxbfOModXfhiEYXxPbpDLMSfNkKLXn2piQ8+c7U2EFMFW2vbV+pYvIdhyyRaC
         5kJJyLikQTRXLyLEnyrWqtL4j+MueAB9qhHpa3gSP4du1cpvSEZnvOczJ9rD2PpmCE0d
         zEXA==
X-Gm-Message-State: AOJu0Yw9ESnCIykI3fEaP8lXFBcp1ta+f5q1SVnoIJMWWm3tklvMEWcq
        S3p6PfcI4nQ85qmPSZXkV/Dvr/KxpNCOYPztGNDMGO04/vrJV8yUVLRjDg==
X-Google-Smtp-Source: AGHT+IGSUULgLx9FvIM2G5gEeM7ybNMOW2H+dM1B3pvbSlmQSrVHa/ewZDJJ/XayWLE5Hm+MVwugsUEgSOjdjnGSzrQ=
X-Received: by 2002:a0c:e38f:0:b0:64f:539b:f52a with SMTP id
 a15-20020a0ce38f000000b0064f539bf52amr9516982qvl.20.1695051996407; Mon, 18
 Sep 2023 08:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230914131225.13415-1-will@kernel.org> <20230914131225.13415-4-will@kernel.org>
In-Reply-To: <20230914131225.13415-4-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Sep 2023 08:46:22 -0700
Message-ID: <CAKwvOd=gDX4ebkyHyqr276nrZVuRaoJG9Ptofpq8WjejD3s5AA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] scripts/faddr2line: Skip over mapping symbols in
 output from readelf
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 6:12=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
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
> index 6b8206802157..20d9b3d37843 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -179,6 +179,11 @@ __faddr2line() {
>                         local cur_sym_elf_size=3D${fields[2]}
>                         local cur_sym_name=3D${fields[7]:-}
>
> +                       # is_mapping_symbol(cur_sym_name)
> +                       if [[ ${cur_sym_name} =3D~ ^((\.L)|(L0)|(\$[adtx]=
(\.|$))) ]]; then

Thanks for the patch!

I'm curious about the `|$` in the final part of the regex.  IIUC that
will match something like
$a
Do we have any such symbols without `.<n>` suffixes?

With aarch64 defconfig + cfi:
$ llvm-readelf -s vmlinux | grep '\$' | rev | cut -d ' ' -f 1 | rev | sort =
-u
I only see $d.<n> and $x.<n> where the initial value of <n> is zero
(as opposed to no `.<n>` suffix).
Can we tighten up that last part of the regex to be `\$[adtx]\.[0-9]+$` ?
Or perhaps you've observed mapping symbols use another convention than
what clang is doing?

https://sourceware.org/binutils/docs/as/AArch64-Mapping-Symbols.html
also only mentions $d and $x. Ah,
https://developer.arm.com/documentation/dui0803/a/Accessing-and-managing-sy=
mbols-with-armlink/About-mapping-symbols
mentions $a for A32 and $t for T32.
Consider adding a link to the ARM documentation on mapping symbols in
the commit message?

(Curiously, `llvm-nm` does not print these symbols, but `llvm-readelf -s` d=
oes).

> +                               continue
> +                       fi
> +
>                         if [[ $cur_sym_addr =3D $sym_addr ]] &&
>                            [[ $cur_sym_elf_size =3D $sym_elf_size ]] &&
>                            [[ $cur_sym_name =3D $sym_name ]]; then
> --
> 2.42.0.283.g2d96d420d3-goog
>


--=20
Thanks,
~Nick Desaulniers
