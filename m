Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545DF77074C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjHDRp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHDRp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E200449FF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77768620DA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD669C433CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691171124;
        bh=SKdiKrmN6Sz1OpEH5WWRpir+7XEJOPyBzfO1EenofaM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kfPIraGFvEpUrGS+gImT2Qno7RQ0JMZ1iGUq1l7fjX9puYZKEPdW5IIM07uO3vOQE
         ChaAujL92NyvxKUCLNFl0SGA5/UwP3pPWNj22C7TBX+U4BFA9EePygHpXblwAOCAHB
         aNjyvdTTKzEY0TpVpW16SsxyPIuKD13oeJ/LkKHf1eFF1j6CgkV6PM/+WAocr8/7A6
         9zhbexwxW3FjcJ7Lfo0o7V+MjEoWzaGaDB3utQKHYjOj2VFdi52ap7y4a18pggY7/s
         CcxAZRb60yQPIxmbDu+kIF5pKOfRCpWatzbV+m4EsZTDmLJyQ0fBiq7ggrRR6DyyGM
         Wf6CfGEAQ84aA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5222c5d71b8so3023663a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 10:45:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YzF1BZtP8iuRS/HS8bqxIIW/n99JAyi12mCAuWPJ77xkQEWombR
        I0R2MJhy/rb3ifEwfPV/VYsCzCQ9vYtBVUXPBwk=
X-Google-Smtp-Source: AGHT+IH+SIdKRya90YSfxgWiDDPb9HOv3hMCFwPS0M+dlzO2VBsw5mk01hdh3i47Uyuzz4oeEBG88U4ZxuEPJrNlePk=
X-Received: by 2002:aa7:d690:0:b0:522:4f6d:c443 with SMTP id
 d16-20020aa7d690000000b005224f6dc443mr2343632edr.23.1691171123123; Fri, 04
 Aug 2023 10:45:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230804084900.1135660-2-leobras@redhat.com> <20230804084900.1135660-6-leobras@redhat.com>
In-Reply-To: <20230804084900.1135660-6-leobras@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 4 Aug 2023 13:45:11 -0400
X-Gmail-Original-Message-ID: <CAJF2gTTOT3_3K_cWNY9n_DgRoPhYEhBLno=bh57r9D--OavREQ@mail.gmail.com>
Message-ID: <CAJF2gTTOT3_3K_cWNY9n_DgRoPhYEhBLno=bh57r9D--OavREQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 4/5] riscv/cmpxchg: Implement cmpxchg for variables
 of size 1 and 2
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
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

On Fri, Aug 4, 2023 at 4:49=E2=80=AFAM Leonardo Bras <leobras@redhat.com> w=
rote:
>
> cmpxchg for variables of size 1-byte and 2-bytes is not yet available for
> riscv, even though its present in other architectures such as arm64 and
> x86. This could lead to not being able to implement some locking mechanis=
ms
> or requiring some rework to make it work properly.
>
> Implement 1-byte and 2-bytes cmpxchg in order to achieve parity with othe=
r
> architectures.
>
> Signed-off-by: Leonardo Bras <leobras@redhat.com>
> ---
>  arch/riscv/include/asm/cmpxchg.h | 35 ++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cm=
pxchg.h
> index 5a07646fae65..dfb433ac544f 100644
> --- a/arch/riscv/include/asm/cmpxchg.h
> +++ b/arch/riscv/include/asm/cmpxchg.h
> @@ -72,6 +72,36 @@
>   * indicated by comparing RETURN with OLD.
>   */
>
> +#define __arch_cmpxchg_mask(sc_sfx, prepend, append, r, p, o, n)       \
> +({                                                                     \
> +       /* Depends on 2-byte variables being 2-byte aligned */          \
> +       ulong __s =3D ((ulong)(p) & 0x3) * BITS_PER_BYTE;                =
 \
> +       ulong __mask =3D GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)  =
 \
> +                       << __s;                                         \
> +       ulong __newx =3D (ulong)(n) << __s;                              =
 \
> +       ulong __oldx =3D (ulong)(o) << __s;                              =
 \
> +       ulong __retx;                                                   \
> +       register unsigned int __rc;                                     \
> +                                                                       \
> +       __asm__ __volatile__ (                                          \
> +               prepend                                                 \
> +               "0:     lr.w %0, %2\n"                                  \
> +               "       and  %0, %0, %z5\n"                             \
> +               "       bne  %0, %z3, 1f\n"                             \
bug:
-               "       and  %0, %0, %z5\n"                             \
-               "       bne  %0, %z3, 1f\n"                             \
+               "       and  %1, %0, %z5\n"                             \
+               "       bne  %1, %z3, 1f\n"                             \
Your code breaks the %0.



> +               "       and  %1, %0, %z6\n"                             \
> +               "       or   %1, %1, %z4\n"                             \
> +               "       sc.w" sc_sfx " %1, %1, %2\n"                    \
> +               "       bnez %1, 0b\n"                                  \
> +               append                                                  \
> +               "1:\n"                                                  \
> +               : "=3D&r" (__retx), "=3D&r" (__rc), "+A" (*(p))          =
   \
> +               : "rJ" ((long)__oldx), "rJ" (__newx),                   \
> +                 "rJ" (__mask), "rJ" (~__mask)                         \
> +               : "memory");                                            \
> +                                                                       \
> +       r =3D (__typeof__(*(p)))(__retx >> __s);                         =
 \
> +})
> +
>
>  #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n) =
       \
>  ({                                                                     \
> @@ -98,6 +128,11 @@
>         __typeof__(*(ptr)) __ret;                                       \
>                                                                         \
>         switch (sizeof(*__ptr)) {                                       \
> +       case 1:                                                         \
> +       case 2:                                                         \
> +               __arch_cmpxchg_mask(sc_sfx, prepend, append,            \
> +                                       __ret, __ptr, __old, __new);    \
> +               break;                                                  \
>         case 4:                                                         \
>                 __arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,      \
>                                 __ret, __ptr, (long), __old, __new);    \
> --
> 2.41.0
>


--=20
Best Regards
 Guo Ren
