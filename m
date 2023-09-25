Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC7E7ADD6F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 18:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjIYQvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 12:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbjIYQvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:51:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A59F;
        Mon, 25 Sep 2023 09:50:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BEEC433C7;
        Mon, 25 Sep 2023 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695660658;
        bh=BpKjGJDg3rOpzfcXTucA8GSwnu0Z6eKivzwSXV+BT6w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KVte+oKFDGNOMESiUdM0cBhpjHlGl+U0OtqqtF9/s2w6/+Xstf26AEuEgTF3sYeol
         6Eo4bBuVURoLvTn2qU2ebhTeGIQ1VeKwcONqD+WKazRg0tQAPT0I893xJp1HL5cQvs
         e4NcIQjucRUOb9H1LyG/eTWONuAmDPldcSEqRb4hniwobafsJn33XUXjWyxkPcKpXY
         1JNjHeeGYHTy0ORhD/ykNy/vcHkHInOBBoxdDYccDAnd6+K0Cv3J39A0P57wa1bkYu
         cMICcWIPXRfzi7v98cr5Uiqv2mBrzjXc+Lsc1lL9p1es05jUXRv0s1FnoPfPhJzKaw
         ZhoqD6laX1JBA==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6c4b7e90e99so3399544a34.0;
        Mon, 25 Sep 2023 09:50:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YzO3jF9OQK9HHrlACR5hikmM1cGHVQD7rGv/cP2OtraogefhGHy
        8sYUAr3N8SQoudupct8taNMsXIpl1YK9f27MYvg=
X-Google-Smtp-Source: AGHT+IGAK1848QgAncxQqsakKUapLjRgv7Jb1Fe358g7b9fLCNObr2RnAZcJYLnInYiG+nzjNwk9G0e4/tQ9yTZRUwU=
X-Received: by 2002:a05:6870:5b8b:b0:1d5:4fb0:105 with SMTP id
 em11-20020a0568705b8b00b001d54fb00105mr8930862oab.20.1695660657483; Mon, 25
 Sep 2023 09:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230914131225.13415-1-will@kernel.org> <20230914131225.13415-4-will@kernel.org>
In-Reply-To: <20230914131225.13415-4-will@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Sep 2023 01:50:20 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQimVFOofEN5dNtPMWZ1m0Jh_3KawNU04kpmnSaUn3MKQ@mail.gmail.com>
Message-ID: <CAK7LNAQimVFOofEN5dNtPMWZ1m0Jh_3KawNU04kpmnSaUn3MKQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] scripts/faddr2line: Skip over mapping symbols in
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

On Thu, Sep 14, 2023 at 10:12=E2=80=AFPM Will Deacon <will@kernel.org> wrot=
e:
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
> +                               continue
> +                       fi
> +


Too many parentheses.


The latest include/linux/module_symbol.h looks like this.

static inline int is_mapping_symbol(const char *str)
{
        if (str[0] =3D=3D '.' && str[1] =3D=3D 'L')
                return true;
        if (str[0] =3D=3D 'L' && str[1] =3D=3D '0')
                return true;
        return str[0] =3D=3D '$';
}






Does this work?

if [[ ${cur_sym_name} =3D~ ^(\.L|L0|\$) ]]; then
        continue
fi








>                         if [[ $cur_sym_addr =3D $sym_addr ]] &&
>                            [[ $cur_sym_elf_size =3D $sym_elf_size ]] &&
>                            [[ $cur_sym_name =3D $sym_name ]]; then
> --
> 2.42.0.283.g2d96d420d3-goog
>


--=20
Best Regards
Masahiro Yamada
