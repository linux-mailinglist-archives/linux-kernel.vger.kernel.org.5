Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62A676B9D7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjHAQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjHAQmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:42:25 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8912107
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 09:42:23 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-63cf8754d95so26750226d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690908142; x=1691512942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7AXRcxN4X2nbD5LSU083hpEJi9dyUxKKAP9wUCW8Yqo=;
        b=IFLycd+YUlQ7e7S9s6lp9S6XDT8KWx7Edj009JPHpiAomCCtUiVeD4c9cmYqdeWanD
         s2IOab9PnwUwD4L6PdlvT4VMjnAIKuIuU5LGs+9FWS4V8u/qIl8HYzoTPIP2AErE79u/
         FSDBM1tIUQg5EDNMR5YZwZmEzD1Ph/7u7+nL6KwReM8VYooWM+Hkp4Dh7sZO4qKGyiYZ
         xsrNOnxyeV2yEJufXa626hq0XSlopUXzW6PLkDvLltPybskIoDb3N4fkeYnzIWRgZITW
         NlxuF3ekD5VvqnNTGBPeF3Zo5gPb7ouJQcYvRCdNV/lt+W859Vk/ffOZxucwPZx6ztmo
         p7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690908142; x=1691512942;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AXRcxN4X2nbD5LSU083hpEJi9dyUxKKAP9wUCW8Yqo=;
        b=kZ7fzfN6akDGkmEvD91fWU5S0dStcjtYHsJza1/pSIxPp7BcHGiyYJp5qT56R0YriG
         f9s2kjjwYL87ba1bmBtnZpMyZoQCBstQltH90FtWEfUOwA0l6SCN/VZx3SGYPLmlP+2F
         LkH49MN0dWjiylBaSxVs5yFn06dhmNoiS8xyxE0z932xe97YWcrwS4JZiidoSGJMtQFw
         +nWRsq6nAVCNw8kL1W1nBk7vL3EQVgNDyj7BzEGVZ8+jDVYaAEJNBQiEvOxbdsVOBMvN
         owtvpdq+GIuSkKf8Os265AM9N3GjxuegftkCPwgrotNfxi1+MHQLIhVlUHILZJ/kEGwH
         h7+w==
X-Gm-Message-State: ABy/qLYfgduLJJmvM5iE7RFKLY1PzZzrVVebVlDZYYf89h+Psp5JH0XN
        Wt2E8PY0TucgC3oyeZvlx0x0rUI05R4Uo8MLlHQKZQ==
X-Google-Smtp-Source: APBJJlFimWkkB+UHcacql4MfY2gMzddAHFvsKdoaX4FE0t3+ibG/83drylyfPYFBK598WQtUQzj3WppduOZn349kPCg=
X-Received: by 2002:ad4:4382:0:b0:63c:f325:5aac with SMTP id
 s2-20020ad44382000000b0063cf3255aacmr9358248qvr.19.1690908141896; Tue, 01 Aug
 2023 09:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230728113415.21067-1-will@kernel.org> <20230728113415.21067-4-will@kernel.org>
In-Reply-To: <20230728113415.21067-4-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Aug 2023 09:42:11 -0700
Message-ID: <CAKwvOdnPWL7ts0PC_NxqxZZRgaT=WLZGQQ-3cVii-jG5GCNjfw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] scripts/faddr2line: Constrain readelf output to
 symbols from System.map
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 4:34=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> Some symbols emitted in the readelf output but filtered from System.map
> can confuse the 'faddr2line' symbol size calculation, resulting in the
> erroneous rejection of valid offsets. This is especially prevalent when
> building an arm64 kernel with CONFIG_CFI_CLANG=3Dy, where most functions
> are prefixed with a 32-bit data value in a '$d.n' section. For example:
>
> 447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_initcal=
l
>    104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
>    106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
>    111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
>    112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
>     36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_proce=
ss

Sami,
Should we change the llvm-ir linkage type for these symbols from
`internal` to `private`?
https://llvm.org/docs/LangRef.html#linkage-types

Then they would not appear in the symbol table.

At first, I thought other modules might need to directly reference
this data, but with the local binding, I don't think they can.

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
> Filter out entries from readelf using the 'sysmap-ignored-syms.sed'
> script used to construct System.map, so that the size of a symbol is
> calculated as a delta to the next symbol present in ksymtab.
>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  scripts/faddr2line | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 62a3fa6f6f59..da734af90036 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -64,6 +64,7 @@ else
>         UTIL_PREFIX=3D${CROSS_COMPILE:-}
>  fi
>
> +IGNORED_SYMS=3D$(dirname $0)/sysmap-ignored-syms.sed
>  READELF=3D"${UTIL_PREFIX}readelf"
>  ADDR2LINE=3D"${UTIL_PREFIX}addr2line"
>  AWK=3D"awk"
> @@ -185,7 +186,7 @@ __faddr2line() {
>                                 found=3D2
>                                 break
>                         fi
> -               done < <(${READELF} --symbols --wide $objfile | sed 's/\[=
.*\]//' | ${AWK} -v sec=3D$sym_sec '$7 =3D=3D sec' | sort --key=3D2)
> +               done < <(${READELF} --symbols --wide $objfile | sed -f ${=
IGNORED_SYMS} -e 's/\[.*\]//' | ${AWK} -v sec=3D$sym_sec '$7 =3D=3D sec' | =
sort --key=3D2)
>
>                 if [[ $found =3D 0 ]]; then
>                         warn "can't find symbol: sym_name: $sym_name sym_=
sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
> --
> 2.41.0.487.g6d72f3e995-goog
>


--=20
Thanks,
~Nick Desaulniers
