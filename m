Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2AA478DBD5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbjH3Shy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbjH3Pkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:40:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63E6122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E4F46068C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA86C433C8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693410045;
        bh=OfkHF940V8bVlz017j5dgKgrTL7TlTWtYOhd5+ZFIhc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MkefpL604gjUcgnnQWdj27r6PUEqsrYz3mbmOtnNPXuP8tlbA4sG0N8eFitSS7Liq
         7gUmYBc+jRf/p14vIdo/n2vJbVr4vissQTeyluIQ6M24sQUosknBh0DzU1CfPDFrI9
         YtIkMW8RkNk3la2P8C8Lw5G7IOoVPdJl1bHXjskIGBrdKJhCKFO/H/aIvWGAbJ+cmN
         eSmHegLbPbQg8MwoCm3cQLmNBqMkjBPgc8JB0slf5hzcUMvOK0zC6yykoyroHQWt4o
         g/xz0s56tkCwswqEwc25nAE6UdzB5usfGw9mMTQ0PYM1IWkoGK9HrprFmwLysorwm6
         YJt2cYgsW+e4w==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2bd0a5a5abbso56683231fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:40:45 -0700 (PDT)
X-Gm-Message-State: AOJu0YwdfYNCoCUsclZpg9yzEDo2AEerW3Zy2rwnh6Zz+zuRbjY4e4pk
        zgM0yv0dDwRXQKQmyqnmgNOiokTpFnoqEg8kKrM=
X-Google-Smtp-Source: AGHT+IG5tHWG0k3aeYAtCZszmkxmntyxtcBLV8yCAF6paqzfA7s9enEriqovO6smlLObrCvsjA+Tyu317sDGb42XptI=
X-Received: by 2002:a2e:90d6:0:b0:2bc:b9c7:7ba3 with SMTP id
 o22-20020a2e90d6000000b002bcb9c77ba3mr2429625ljg.12.1693410043510; Wed, 30
 Aug 2023 08:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230830010435.2969785-1-liweihao@loongson.cn>
In-Reply-To: <20230830010435.2969785-1-liweihao@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 30 Aug 2023 23:40:32 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4T+od3DWKWRRb1QhFgMrPcXLeR90EOdjO15cjFrt4w8g@mail.gmail.com>
Message-ID: <CAAhV-H4T+od3DWKWRRb1QhFgMrPcXLeR90EOdjO15cjFrt4w8g@mail.gmail.com>
Subject: Re: [PATCH 1/1] LoongArch: adjust copy/clear_user exception handler behavior
To:     liweihao <liweihao@loongson.cn>
Cc:     kernel@xen0n.name, wangrui@loongson.cn, masahiroy@kernel.org,
        yijun@loongson.cn, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

Hi, Weihao,

The title should be "LoongArch: Adjust {copy, clear}_user exception
handler behavior" and 1/1 is unnecessary. Commit logs also need
similar adjustments.

On Wed, Aug 30, 2023 at 9:04=E2=80=AFAM liweihao <liweihao@loongson.cn> wro=
te:
>
> The copy/clear_user function should returns number of bytes that could
> not be copied/cleared. So, try to copy/clear byte by byte when ld.d/w/h
> and st.d/w/h trapped into an exception.
>
> Signed-off-by: liweihao <liweihao@loongson.cn>
Your email format should be "Weihao Li  <liweihao@loongson.cn>"

Huacai
> ---
>  arch/loongarch/lib/clear_user.S |  87 ++++++++---------
>  arch/loongarch/lib/copy_user.S  | 161 ++++++++++++++++----------------
>  2 files changed, 127 insertions(+), 121 deletions(-)
>
> diff --git a/arch/loongarch/lib/clear_user.S b/arch/loongarch/lib/clear_u=
ser.S
> index 0790eadce166..9b6eef569f89 100644
> --- a/arch/loongarch/lib/clear_user.S
> +++ b/arch/loongarch/lib/clear_user.S
> @@ -11,19 +11,6 @@
>  #include <asm/cpu.h>
>  #include <asm/regdef.h>
>
> -.irp to, 0, 1, 2, 3, 4, 5, 6, 7
> -.L_fixup_handle_\to\():
> -       sub.d   a0, a2, a0
> -       addi.d  a0, a0, (\to) * (-8)
> -       jr      ra
> -.endr
> -
> -.irp to, 0, 2, 4
> -.L_fixup_handle_s\to\():
> -       addi.d  a0, a1, -\to
> -       jr      ra
> -.endr
> -
>  SYM_FUNC_START(__clear_user)
>         /*
>          * Some CPUs support hardware unaligned access
> @@ -51,7 +38,7 @@ SYM_FUNC_START(__clear_user_generic)
>  2:     move    a0, a1
>         jr      ra
>
> -       _asm_extable 1b, .L_fixup_handle_s0
> +       _asm_extable 1b, 2b
>  SYM_FUNC_END(__clear_user_generic)
>
>  /*
> @@ -173,33 +160,47 @@ SYM_FUNC_START(__clear_user_fast)
>         jr      ra
>
>         /* fixup and ex_table */
> -       _asm_extable 0b, .L_fixup_handle_0
> -       _asm_extable 1b, .L_fixup_handle_0
> -       _asm_extable 2b, .L_fixup_handle_1
> -       _asm_extable 3b, .L_fixup_handle_2
> -       _asm_extable 4b, .L_fixup_handle_3
> -       _asm_extable 5b, .L_fixup_handle_4
> -       _asm_extable 6b, .L_fixup_handle_5
> -       _asm_extable 7b, .L_fixup_handle_6
> -       _asm_extable 8b, .L_fixup_handle_7
> -       _asm_extable 9b, .L_fixup_handle_0
> -       _asm_extable 10b, .L_fixup_handle_1
> -       _asm_extable 11b, .L_fixup_handle_2
> -       _asm_extable 12b, .L_fixup_handle_3
> -       _asm_extable 13b, .L_fixup_handle_0
> -       _asm_extable 14b, .L_fixup_handle_1
> -       _asm_extable 15b, .L_fixup_handle_0
> -       _asm_extable 16b, .L_fixup_handle_0
> -       _asm_extable 17b, .L_fixup_handle_s0
> -       _asm_extable 18b, .L_fixup_handle_s0
> -       _asm_extable 19b, .L_fixup_handle_s0
> -       _asm_extable 20b, .L_fixup_handle_s2
> -       _asm_extable 21b, .L_fixup_handle_s0
> -       _asm_extable 22b, .L_fixup_handle_s0
> -       _asm_extable 23b, .L_fixup_handle_s4
> -       _asm_extable 24b, .L_fixup_handle_s0
> -       _asm_extable 25b, .L_fixup_handle_s4
> -       _asm_extable 26b, .L_fixup_handle_s0
> -       _asm_extable 27b, .L_fixup_handle_s4
> -       _asm_extable 28b, .L_fixup_handle_s0
> +.Llarge_fixup:
> +       sub.d   a1, a2, a0
> +
> +.Lsmall_fixup:
> +29:    st.b    zero, a0, 0
> +       addi.d  a0, a0, 1
> +       addi.d  a1, a1, -1
> +       bgt     a1, zero, 1b
> +
> +.Lexit:
> +       move    a0, a1
> +       jr      ra
> +
> +       _asm_extable 0b, .Lsmall_fixup
> +       _asm_extable 1b, .Llarge_fixup
> +       _asm_extable 2b, .Llarge_fixup
> +       _asm_extable 3b, .Llarge_fixup
> +       _asm_extable 4b, .Llarge_fixup
> +       _asm_extable 5b, .Llarge_fixup
> +       _asm_extable 6b, .Llarge_fixup
> +       _asm_extable 7b, .Llarge_fixup
> +       _asm_extable 8b, .Llarge_fixup
> +       _asm_extable 9b, .Llarge_fixup
> +       _asm_extable 10b, .Llarge_fixup
> +       _asm_extable 11b, .Llarge_fixup
> +       _asm_extable 12b, .Llarge_fixup
> +       _asm_extable 13b, .Llarge_fixup
> +       _asm_extable 14b, .Llarge_fixup
> +       _asm_extable 15b, .Llarge_fixup
> +       _asm_extable 16b, .Llarge_fixup
> +       _asm_extable 17b, .Lexit
> +       _asm_extable 18b, .Lsmall_fixup
> +       _asm_extable 19b, .Lsmall_fixup
> +       _asm_extable 20b, .Lsmall_fixup
> +       _asm_extable 21b, .Lsmall_fixup
> +       _asm_extable 22b, .Lsmall_fixup
> +       _asm_extable 23b, .Lsmall_fixup
> +       _asm_extable 24b, .Lsmall_fixup
> +       _asm_extable 25b, .Lsmall_fixup
> +       _asm_extable 26b, .Lsmall_fixup
> +       _asm_extable 27b, .Lsmall_fixup
> +       _asm_extable 28b, .Lsmall_fixup
> +       _asm_extable 29b, .Lexit
>  SYM_FUNC_END(__clear_user_fast)
> diff --git a/arch/loongarch/lib/copy_user.S b/arch/loongarch/lib/copy_use=
r.S
> index bfe3d2793d00..feec3d362803 100644
> --- a/arch/loongarch/lib/copy_user.S
> +++ b/arch/loongarch/lib/copy_user.S
> @@ -11,19 +11,6 @@
>  #include <asm/cpu.h>
>  #include <asm/regdef.h>
>
> -.irp to, 0, 1, 2, 3, 4, 5, 6, 7
> -.L_fixup_handle_\to\():
> -       sub.d   a0, a2, a0
> -       addi.d  a0, a0, (\to) * (-8)
> -       jr      ra
> -.endr
> -
> -.irp to, 0, 2, 4
> -.L_fixup_handle_s\to\():
> -       addi.d  a0, a2, -\to
> -       jr      ra
> -.endr
> -
>  SYM_FUNC_START(__copy_user)
>         /*
>          * Some CPUs support hardware unaligned access
> @@ -54,8 +41,8 @@ SYM_FUNC_START(__copy_user_generic)
>  3:     move    a0, a2
>         jr      ra
>
> -       _asm_extable 1b, .L_fixup_handle_s0
> -       _asm_extable 2b, .L_fixup_handle_s0
> +       _asm_extable 1b, 3b
> +       _asm_extable 2b, 3b
>  SYM_FUNC_END(__copy_user_generic)
>
>  /*
> @@ -69,10 +56,10 @@ SYM_FUNC_START(__copy_user_fast)
>         sltui   t0, a2, 9
>         bnez    t0, .Lsmall
>
> -       add.d   a3, a1, a2
> -       add.d   a2, a0, a2
>  0:     ld.d    t0, a1, 0
>  1:     st.d    t0, a0, 0
> +       add.d   a3, a1, a2
> +       add.d   a2, a0, a2
>
>         /* align up destination address */
>         andi    t1, a0, 7
> @@ -94,7 +81,6 @@ SYM_FUNC_START(__copy_user_fast)
>  7:     ld.d    t5, a1, 40
>  8:     ld.d    t6, a1, 48
>  9:     ld.d    t7, a1, 56
> -       addi.d  a1, a1, 64
>  10:    st.d    t0, a0, 0
>  11:    st.d    t1, a0, 8
>  12:    st.d    t2, a0, 16
> @@ -103,6 +89,7 @@ SYM_FUNC_START(__copy_user_fast)
>  15:    st.d    t5, a0, 40
>  16:    st.d    t6, a0, 48
>  17:    st.d    t7, a0, 56
> +       addi.d  a1, a1, 64
>         addi.d  a0, a0, 64
>         bltu    a1, a4, .Lloop64
>
> @@ -114,11 +101,11 @@ SYM_FUNC_START(__copy_user_fast)
>  19:    ld.d    t1, a1, 8
>  20:    ld.d    t2, a1, 16
>  21:    ld.d    t3, a1, 24
> -       addi.d  a1, a1, 32
>  22:    st.d    t0, a0, 0
>  23:    st.d    t1, a0, 8
>  24:    st.d    t2, a0, 16
>  25:    st.d    t3, a0, 24
> +       addi.d  a1, a1, 32
>         addi.d  a0, a0, 32
>
>  .Llt32:
> @@ -126,9 +113,9 @@ SYM_FUNC_START(__copy_user_fast)
>         bgeu    a1, a4, .Llt16
>  26:    ld.d    t0, a1, 0
>  27:    ld.d    t1, a1, 8
> -       addi.d  a1, a1, 16
>  28:    st.d    t0, a0, 0
>  29:    st.d    t1, a0, 8
> +       addi.d  a1, a1, 16
>         addi.d  a0, a0, 16
>
>  .Llt16:
> @@ -136,6 +123,7 @@ SYM_FUNC_START(__copy_user_fast)
>         bgeu    a1, a4, .Llt8
>  30:    ld.d    t0, a1, 0
>  31:    st.d    t0, a0, 0
> +       addi.d  a1, a1, 8
>         addi.d  a0, a0, 8
>
>  .Llt8:
> @@ -214,62 +202,79 @@ SYM_FUNC_START(__copy_user_fast)
>         jr      ra
>
>         /* fixup and ex_table */
> -       _asm_extable 0b, .L_fixup_handle_0
> -       _asm_extable 1b, .L_fixup_handle_0
> -       _asm_extable 2b, .L_fixup_handle_0
> -       _asm_extable 3b, .L_fixup_handle_0
> -       _asm_extable 4b, .L_fixup_handle_0
> -       _asm_extable 5b, .L_fixup_handle_0
> -       _asm_extable 6b, .L_fixup_handle_0
> -       _asm_extable 7b, .L_fixup_handle_0
> -       _asm_extable 8b, .L_fixup_handle_0
> -       _asm_extable 9b, .L_fixup_handle_0
> -       _asm_extable 10b, .L_fixup_handle_0
> -       _asm_extable 11b, .L_fixup_handle_1
> -       _asm_extable 12b, .L_fixup_handle_2
> -       _asm_extable 13b, .L_fixup_handle_3
> -       _asm_extable 14b, .L_fixup_handle_4
> -       _asm_extable 15b, .L_fixup_handle_5
> -       _asm_extable 16b, .L_fixup_handle_6
> -       _asm_extable 17b, .L_fixup_handle_7
> -       _asm_extable 18b, .L_fixup_handle_0
> -       _asm_extable 19b, .L_fixup_handle_0
> -       _asm_extable 20b, .L_fixup_handle_0
> -       _asm_extable 21b, .L_fixup_handle_0
> -       _asm_extable 22b, .L_fixup_handle_0
> -       _asm_extable 23b, .L_fixup_handle_1
> -       _asm_extable 24b, .L_fixup_handle_2
> -       _asm_extable 25b, .L_fixup_handle_3
> -       _asm_extable 26b, .L_fixup_handle_0
> -       _asm_extable 27b, .L_fixup_handle_0
> -       _asm_extable 28b, .L_fixup_handle_0
> -       _asm_extable 29b, .L_fixup_handle_1
> -       _asm_extable 30b, .L_fixup_handle_0
> -       _asm_extable 31b, .L_fixup_handle_0
> -       _asm_extable 32b, .L_fixup_handle_0
> -       _asm_extable 33b, .L_fixup_handle_0
> -       _asm_extable 34b, .L_fixup_handle_s0
> -       _asm_extable 35b, .L_fixup_handle_s0
> -       _asm_extable 36b, .L_fixup_handle_s0
> -       _asm_extable 37b, .L_fixup_handle_s0
> -       _asm_extable 38b, .L_fixup_handle_s0
> -       _asm_extable 39b, .L_fixup_handle_s0
> -       _asm_extable 40b, .L_fixup_handle_s0
> -       _asm_extable 41b, .L_fixup_handle_s2
> -       _asm_extable 42b, .L_fixup_handle_s0
> -       _asm_extable 43b, .L_fixup_handle_s0
> -       _asm_extable 44b, .L_fixup_handle_s0
> -       _asm_extable 45b, .L_fixup_handle_s0
> -       _asm_extable 46b, .L_fixup_handle_s0
> -       _asm_extable 47b, .L_fixup_handle_s4
> -       _asm_extable 48b, .L_fixup_handle_s0
> -       _asm_extable 49b, .L_fixup_handle_s0
> -       _asm_extable 50b, .L_fixup_handle_s0
> -       _asm_extable 51b, .L_fixup_handle_s4
> -       _asm_extable 52b, .L_fixup_handle_s0
> -       _asm_extable 53b, .L_fixup_handle_s0
> -       _asm_extable 54b, .L_fixup_handle_s0
> -       _asm_extable 55b, .L_fixup_handle_s4
> -       _asm_extable 56b, .L_fixup_handle_s0
> -       _asm_extable 57b, .L_fixup_handle_s0
> +.Llarge_fixup:
> +       sub.d   a2, a2, a0
> +
> +.Lsmall_fixup:
> +58:    ld.b    t0, a1, 0
> +59:    st.b    t0, a0, 0
> +       addi.d  a0, a0, 1
> +       addi.d  a1, a1, 1
> +       addi.d  a2, a2, -1
> +       bgt     a2, zero, 58b
> +
> +.Lexit:
> +       move    a0, a2
> +       jr      ra
> +
> +       _asm_extable 0b, .Lsmall_fixup
> +       _asm_extable 1b, .Lsmall_fixup
> +       _asm_extable 2b, .Llarge_fixup
> +       _asm_extable 3b, .Llarge_fixup
> +       _asm_extable 4b, .Llarge_fixup
> +       _asm_extable 5b, .Llarge_fixup
> +       _asm_extable 6b, .Llarge_fixup
> +       _asm_extable 7b, .Llarge_fixup
> +       _asm_extable 8b, .Llarge_fixup
> +       _asm_extable 9b, .Llarge_fixup
> +       _asm_extable 10b, .Llarge_fixup
> +       _asm_extable 11b, .Llarge_fixup
> +       _asm_extable 12b, .Llarge_fixup
> +       _asm_extable 13b, .Llarge_fixup
> +       _asm_extable 14b, .Llarge_fixup
> +       _asm_extable 15b, .Llarge_fixup
> +       _asm_extable 16b, .Llarge_fixup
> +       _asm_extable 17b, .Llarge_fixup
> +       _asm_extable 18b, .Llarge_fixup
> +       _asm_extable 19b, .Llarge_fixup
> +       _asm_extable 20b, .Llarge_fixup
> +       _asm_extable 21b, .Llarge_fixup
> +       _asm_extable 22b, .Llarge_fixup
> +       _asm_extable 23b, .Llarge_fixup
> +       _asm_extable 24b, .Llarge_fixup
> +       _asm_extable 25b, .Llarge_fixup
> +       _asm_extable 26b, .Llarge_fixup
> +       _asm_extable 27b, .Llarge_fixup
> +       _asm_extable 28b, .Llarge_fixup
> +       _asm_extable 29b, .Llarge_fixup
> +       _asm_extable 30b, .Llarge_fixup
> +       _asm_extable 31b, .Llarge_fixup
> +       _asm_extable 32b, .Llarge_fixup
> +       _asm_extable 33b, .Llarge_fixup
> +       _asm_extable 34b, .Lexit
> +       _asm_extable 35b, .Lexit
> +       _asm_extable 36b, .Lsmall_fixup
> +       _asm_extable 37b, .Lsmall_fixup
> +       _asm_extable 38b, .Lsmall_fixup
> +       _asm_extable 39b, .Lsmall_fixup
> +       _asm_extable 40b, .Lsmall_fixup
> +       _asm_extable 41b, .Lsmall_fixup
> +       _asm_extable 42b, .Lsmall_fixup
> +       _asm_extable 43b, .Lsmall_fixup
> +       _asm_extable 44b, .Lsmall_fixup
> +       _asm_extable 45b, .Lsmall_fixup
> +       _asm_extable 46b, .Lsmall_fixup
> +       _asm_extable 47b, .Lsmall_fixup
> +       _asm_extable 48b, .Lsmall_fixup
> +       _asm_extable 49b, .Lsmall_fixup
> +       _asm_extable 50b, .Lsmall_fixup
> +       _asm_extable 51b, .Lsmall_fixup
> +       _asm_extable 52b, .Lsmall_fixup
> +       _asm_extable 53b, .Lsmall_fixup
> +       _asm_extable 54b, .Lsmall_fixup
> +       _asm_extable 55b, .Lsmall_fixup
> +       _asm_extable 56b, .Lsmall_fixup
> +       _asm_extable 57b, .Lsmall_fixup
> +       _asm_extable 58b, .Lexit
> +       _asm_extable 59b, .Lexit
>  SYM_FUNC_END(__copy_user_fast)
> --
> 2.39.2
>
>
