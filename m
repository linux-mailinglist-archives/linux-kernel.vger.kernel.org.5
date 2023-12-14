Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054688131D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1572939AbjLNNlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573280AbjLNNKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:10:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAA3129
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B4C433CD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 13:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702559440;
        bh=DlgxjSeiJJTnnWWZhlter7Y+dJ5cGY4p6x7pxDXTL9M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m1CROop2SygAcnUtsy9DFbpmHtKOQfx0QxjSvdGybM9re4GHKNRfTclRAN0iNTFzZ
         dgk+8stGhHKqJFfbmCJa+OAQfa+x3zW/0Pl2K1gaOXU5dLU8buH3v7RRWRi07z2a2e
         gyvryA73q0Xiw1B6BuVF4ZZpIeIYLMmrfnaa+3kTXQLe3TBzmubXKG87HxWkuXm/jK
         XrF8TVyEiXN2iZpjNu9K5EzZ0ScpovS5J48nkgAjV03jJrmn0LCVhWREsT6RJ3Q8El
         px+H1nnmqLndd5nm4S2n5jGgkD02wYQ0cURypfntC5YLj4+xLVXZlv5GEozrzLtbA/
         AqxuMx136/xkg==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5527ee1b5c3so719532a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 05:10:40 -0800 (PST)
X-Gm-Message-State: AOJu0YyrvQ82geBalniAhd5PnGIpy2k+KSIaMzifJ6x2ZspIfB4h6Kl9
        9FJ5/smqu7T7Qdt6xGyHZhAVhEvntmTaIP9Wl0c=
X-Google-Smtp-Source: AGHT+IGFbAvlhXbVw1gK9Mwrn19U55ODtV8P21GAhqMjLGc6Qa1dUnAwbrLySOGsKnTDjnMogaKDQCiNVTUhphgDqic=
X-Received: by 2002:a17:906:14c:b0:a22:ebf1:1c9f with SMTP id
 12-20020a170906014c00b00a22ebf11c9fmr3714768ejh.72.1702559439263; Thu, 14 Dec
 2023 05:10:39 -0800 (PST)
MIME-Version: 1.0
References: <20231214130206.21219-1-xry111@xry111.site>
In-Reply-To: <20231214130206.21219-1-xry111@xry111.site>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 14 Dec 2023 21:10:27 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5m65qL05W9VZw7Qff-qg8TUc_wY8zs-pSeBuWSAFnSaQ@mail.gmail.com>
Message-ID: <CAAhV-H5m65qL05W9VZw7Qff-qg8TUc_wY8zs-pSeBuWSAFnSaQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Micro-optimize sc_save_fcc and sc_restore_fcc
 for LA464
To:     Xi Ruoyao <xry111@xry111.site>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Emmm, I want to keep the code simpler. :)

Huacai

On Thu, Dec 14, 2023 at 9:02=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On LA464 movcf2gr is 7 times slower than movcf2fr + movfr2gr, and
> movgr2cf is 15 times (!) slower than movgr2fr + movfr2cf.
>
> On LA664 movcf2fr + movfr2gr has a similar performance with movcf2gr,
> and movgr2fr + movfr2cf has a similar performance with movgr2cf.
>
> To use FP registers in sc_save_fcc and sc_restore_fcc we need to save
> FP/LSX/LASX registers before sc_save_fcc, and restore FP/LSX/LASX
> registers after sc_restore_fcc.
>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/loongarch/kernel/fpu.S | 94 +++++++++++++++++++++----------------
>  1 file changed, 54 insertions(+), 40 deletions(-)
>
> diff --git a/arch/loongarch/kernel/fpu.S b/arch/loongarch/kernel/fpu.S
> index d53ab10f4644..ecb127f9a673 100644
> --- a/arch/loongarch/kernel/fpu.S
> +++ b/arch/loongarch/kernel/fpu.S
> @@ -96,43 +96,57 @@
>         .endm
>
>         .macro sc_save_fcc base, tmp0, tmp1
> -       movcf2gr        \tmp0, $fcc0
> -       move            \tmp1, \tmp0
> -       movcf2gr        \tmp0, $fcc1
> -       bstrins.d       \tmp1, \tmp0, 15, 8
> -       movcf2gr        \tmp0, $fcc2
> -       bstrins.d       \tmp1, \tmp0, 23, 16
> -       movcf2gr        \tmp0, $fcc3
> -       bstrins.d       \tmp1, \tmp0, 31, 24
> -       movcf2gr        \tmp0, $fcc4
> -       bstrins.d       \tmp1, \tmp0, 39, 32
> -       movcf2gr        \tmp0, $fcc5
> -       bstrins.d       \tmp1, \tmp0, 47, 40
> -       movcf2gr        \tmp0, $fcc6
> -       bstrins.d       \tmp1, \tmp0, 55, 48
> -       movcf2gr        \tmp0, $fcc7
> -       bstrins.d       \tmp1, \tmp0, 63, 56
> -       EX      st.d    \tmp1, \base, 0
> +       movcf2fr        ft0, $fcc0
> +       movcf2fr        ft1, $fcc1
> +       movfr2gr.s      \tmp0, ft0
> +       movfr2gr.s      \tmp1, ft1
> +       EX  st.b        \tmp0, \base, 0
> +       EX  st.b        \tmp0, \base, 8
> +       movcf2fr        ft0, $fcc2
> +       movcf2fr        ft1, $fcc3
> +       movfr2gr.s      \tmp0, ft0
> +       movfr2gr.s      \tmp1, ft1
> +       EX  st.b        \tmp0, \base, 16
> +       EX  st.b        \tmp0, \base, 24
> +       movcf2fr        ft0, $fcc3
> +       movcf2fr        ft1, $fcc4
> +       movfr2gr.s      \tmp0, ft0
> +       movfr2gr.s      \tmp1, ft1
> +       EX  st.b        \tmp0, \base, 32
> +       EX  st.b        \tmp0, \base, 40
> +       movcf2fr        ft0, $fcc5
> +       movcf2fr        ft1, $fcc6
> +       movfr2gr.s      \tmp0, ft0
> +       movfr2gr.s      \tmp1, ft1
> +       EX  st.b        \tmp0, \base, 48
> +       EX  st.b        \tmp0, \base, 56
>         .endm
>
>         .macro sc_restore_fcc base, tmp0, tmp1
> -       EX      ld.d    \tmp0, \base, 0
> -       bstrpick.d      \tmp1, \tmp0, 7, 0
> -       movgr2cf        $fcc0, \tmp1
> -       bstrpick.d      \tmp1, \tmp0, 15, 8
> -       movgr2cf        $fcc1, \tmp1
> -       bstrpick.d      \tmp1, \tmp0, 23, 16
> -       movgr2cf        $fcc2, \tmp1
> -       bstrpick.d      \tmp1, \tmp0, 31, 24
> -       movgr2cf        $fcc3, \tmp1
> -       bstrpick.d      \tmp1, \tmp0, 39, 32
> -       movgr2cf        $fcc4, \tmp1
> -       bstrpick.d      \tmp1, \tmp0, 47, 40
> -       movgr2cf        $fcc5, \tmp1
> -       bstrpick.d      \tmp1, \tmp0, 55, 48
> -       movgr2cf        $fcc6, \tmp1
> -       bstrpick.d      \tmp1, \tmp0, 63, 56
> -       movgr2cf        $fcc7, \tmp1
> +       EX      ld.b    \tmp0, \base, 0
> +       EX      ld.b    \tmp1, \base, 8
> +       movgr2fr.w      ft0, \tmp0
> +       movgr2fr.w      ft1, \tmp1
> +       movfr2cf        $fcc0, ft0
> +       movfr2cf        $fcc1, ft1
> +       EX      ld.b    \tmp0, \base, 16
> +       EX      ld.b    \tmp1, \base, 24
> +       movgr2fr.w      ft0, \tmp0
> +       movgr2fr.w      ft1, \tmp1
> +       movfr2cf        $fcc2, ft0
> +       movfr2cf        $fcc3, ft1
> +       EX      ld.b    \tmp0, \base, 32
> +       EX      ld.b    \tmp1, \base, 40
> +       movgr2fr.w      ft0, \tmp0
> +       movgr2fr.w      ft1, \tmp1
> +       movfr2cf        $fcc4, ft0
> +       movfr2cf        $fcc5, ft1
> +       EX      ld.b    \tmp0, \base, 48
> +       EX      ld.b    \tmp1, \base, 56
> +       movgr2fr.w      ft0, \tmp0
> +       movgr2fr.w      ft1, \tmp1
> +       movfr2cf        $fcc6, ft0
> +       movfr2cf        $fcc7, ft1
>         .endm
>
>         .macro sc_save_fcsr base, tmp0
> @@ -449,9 +463,9 @@ SYM_FUNC_END(_init_fpu)
>   * a2: fcsr
>   */
>  SYM_FUNC_START(_save_fp_context)
> -       sc_save_fcc     a1 t1 t2
>         sc_save_fcsr    a2 t1
>         sc_save_fp      a0
> +       sc_save_fcc     a1 t1 t2
>         li.w            a0, 0                           # success
>         jr              ra
>  SYM_FUNC_END(_save_fp_context)
> @@ -462,8 +476,8 @@ SYM_FUNC_END(_save_fp_context)
>   * a2: fcsr
>   */
>  SYM_FUNC_START(_restore_fp_context)
> -       sc_restore_fp   a0
>         sc_restore_fcc  a1 t1 t2
> +       sc_restore_fp   a0
>         sc_restore_fcsr a2 t1
>         li.w            a0, 0                           # success
>         jr              ra
> @@ -475,9 +489,9 @@ SYM_FUNC_END(_restore_fp_context)
>   * a2: fcsr
>   */
>  SYM_FUNC_START(_save_lsx_context)
> -       sc_save_fcc a1, t0, t1
>         sc_save_fcsr a2, t0
>         sc_save_lsx a0
> +       sc_save_fcc a1, t0, t1
>         li.w    a0, 0                                   # success
>         jr      ra
>  SYM_FUNC_END(_save_lsx_context)
> @@ -488,8 +502,8 @@ SYM_FUNC_END(_save_lsx_context)
>   * a2: fcsr
>   */
>  SYM_FUNC_START(_restore_lsx_context)
> -       sc_restore_lsx a0
>         sc_restore_fcc a1, t1, t2
> +       sc_restore_lsx a0
>         sc_restore_fcsr a2, t1
>         li.w    a0, 0                                   # success
>         jr      ra
> @@ -501,9 +515,9 @@ SYM_FUNC_END(_restore_lsx_context)
>   * a2: fcsr
>   */
>  SYM_FUNC_START(_save_lasx_context)
> -       sc_save_fcc a1, t0, t1
>         sc_save_fcsr a2, t0
>         sc_save_lasx a0
> +       sc_save_fcc a1, t0, t1
>         li.w    a0, 0                                   # success
>         jr      ra
>  SYM_FUNC_END(_save_lasx_context)
> @@ -514,8 +528,8 @@ SYM_FUNC_END(_save_lasx_context)
>   * a2: fcsr
>   */
>  SYM_FUNC_START(_restore_lasx_context)
> -       sc_restore_lasx a0
>         sc_restore_fcc a1, t1, t2
> +       sc_restore_lasx a0
>         sc_restore_fcsr a2, t1
>         li.w    a0, 0                                   # success
>         jr      ra
> --
> 2.43.0
>
