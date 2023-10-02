Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 769ED7B5901
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238603AbjJBRCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238523AbjJBRCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:02:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB65B3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 10:02:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3232be274a0so2018686f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 10:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696266147; x=1696870947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fBgZzG8H8L+RMO629wwCt+NqtJpm6mxiNYmYMNrioQ=;
        b=wRcHmiNtZkoDucBVwQH7YeY2ld2BHTYYbcx0DukRKcgCeWkZ+G3d4daBtvISZUVOfl
         FI7SK0p/lL7ipw8MtWYoWO7rJ/GFmvY5PyC2/sDLvT3sLmjNbEbi5cmzLrF3un/bo8Bp
         3th1WTBVCI4fVYvAbBuhkjqDWdTJmVyQTXVuEHvJ8SETWgPG6JKxVpfP7O9hXsbWii4d
         aasBE/o3ssBS0G4YiPgcVGo1xl6aB1IiRkDIR/mmwTv9oOCqhI+cVxSc6rpa5Gfva5ky
         JBEpwtpW72i0OVLzGdaF1WoL6uKIJxfyQAZb6tn142L0kCMgKxeIaHncczcVq3rZFnR2
         gktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696266147; x=1696870947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fBgZzG8H8L+RMO629wwCt+NqtJpm6mxiNYmYMNrioQ=;
        b=k3NwBaWsvOPHHrWLopTQnGTfrIjEI979evQ17YElQLKSstfvGG8AbV9uSCe921Pqc9
         WKiUO24ZTFQn/hy0r9XQutLleVnwe5/wrHxGzoDcV11c+qizWpmWcb8z186jVMDk9jYq
         hc1nHc96lTI0SnGYLvwdYFAWs5AaXjKo0XVnEddfF3HZCdmuwOtUI5iO2E3Cj2amQ8Qp
         eqf/RRsNJb+/NNMthC90yf9s0jeQPVlyNjhWksRA3Jo+SR1E4WbDxWdySx+/z94c2Gfl
         X37zOumWJ/kTGrfnj9jrbOoESRbTDD52p8dN1rA13RsUtRH/pqhU825Qu+I+TSVbx575
         53QA==
X-Gm-Message-State: AOJu0YwGRTExYDZboZ9KSkk3PU0uaNi+Rq3zJP6NteUsGwm3SBsi0QhB
        hM0B2ewVB0T1Qcs+4pJ9PQpkVATAny+1CfDtFN6Nnw==
X-Google-Smtp-Source: AGHT+IHAgIMir4wwCM6XdRGvOWBdNLdGzUBf9zrpeeFrzoDCpgeqJzSybRFIgRtYZEdM3xBYZynrqbZu/R1kiLzJi7Y=
X-Received: by 2002:a05:6000:1050:b0:323:1e69:7b4 with SMTP id
 c16-20020a056000105000b003231e6907b4mr132794wrx.31.1696266147248; Mon, 02 Oct
 2023 10:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231002165750.1661-1-will@kernel.org> <20231002165750.1661-4-will@kernel.org>
In-Reply-To: <20231002165750.1661-4-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Oct 2023 10:02:16 -0700
Message-ID: <CAKwvOdmZrU90+jA4ugbqiT=VxvsEdTqwmvo7hk-HEocd8xJbmQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] scripts/faddr2line: Skip over mapping symbols in
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

On Mon, Oct 2, 2023 at 9:58=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
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

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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


--=20
Thanks,
~Nick Desaulniers
