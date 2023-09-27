Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB377B01BF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjI0KXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjI0KXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:23:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB668449A;
        Wed, 27 Sep 2023 03:11:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DF4C433C8;
        Wed, 27 Sep 2023 10:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695809478;
        bh=AsqrDF9NU5xeBJ5ZD8/j8B6x2uUVmpdua9PB6GUbGBU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RJ2L3aiM74bOH7cDQ4Jb3leOE49w45romXH+DmI9x30rE3CErmU1XRY2KNXxJES7m
         Sm0uVOwqtYyCOPZIiEvmXxO4SLjmfOoCUhI1LYyrzm1Fr0xDnFS+A/hEYQ7zCC3Kj2
         BPDe/uBTiqybVVN4/OCW7TSSJdphz/spEFLcL6eb8XrcEnYPV8Qq4oLDdJfMALxuS7
         yLmJqt74fBvM7AoQkgnFkUCGWuQ53tUJK+X2QSiM4vvZqDsv0NX/v8ClNC3NMk5TAi
         nqZ3sLehBXVwIWYUZzqIh+qM0oCAudKRSuV+hbc4R93FgC3kB8weQGXHHtKWPWpP4A
         UHnvDbnXcdpxQ==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2c12fc235fbso124029621fa.0;
        Wed, 27 Sep 2023 03:11:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YyVGhzuOGyi3SWnMBPkp18zKw3Bws8RgFsgWzh//Pr8tl/C8Wtz
        hvdZ3BIH+V2y1YQqgqguzoNKT7VUlQxVGEANHb0=
X-Google-Smtp-Source: AGHT+IErHOGMjYxrQ1t/+DgPaZ4dBmBSaTLegmhhD5AyCtWVIwsd7X66QDMROebWfGTc2GB04ctfmhYYpYi8z7uDJJs=
X-Received: by 2002:a2e:700d:0:b0:2bc:fd50:573d with SMTP id
 l13-20020a2e700d000000b002bcfd50573dmr678352ljc.23.1695809476737; Wed, 27 Sep
 2023 03:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230927055954.3755-1-quic_aiquny@quicinc.com>
 <CAMj1kXEh=yQ12v1Ht6=-vgXVe8VCQTPdUD8AowkKcpyDXh_0mg@mail.gmail.com> <af59ec04-aa68-5a22-0f3f-f4872cefeb46@quicinc.com>
In-Reply-To: <af59ec04-aa68-5a22-0f3f-f4872cefeb46@quicinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 27 Sep 2023 10:11:05 +0000
X-Gmail-Original-Message-ID: <CAMj1kXEUTOpATv_jbimGktSXBBweyfVNPpqWWJaJNp0U-zvg+w@mail.gmail.com>
Message-ID: <CAMj1kXEUTOpATv_jbimGktSXBBweyfVNPpqWWJaJNp0U-zvg+w@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: Explicitly assign register for local variables
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     linux@armlinux.org.uk, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, quic_lijuang@quicinc.com,
        linux-arm-msm@vger.kernel.org
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

On Wed, 27 Sept 2023 at 09:44, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wr=
ote:
>
> On 9/27/2023 5:26 PM, Ard Biesheuvel wrote:
> > Hello Maria,
> >
> > On Wed, 27 Sept 2023 at 06:00, Maria Yu <quic_aiquny@quicinc.com> wrote=
:
> >>
> >> Registers r7 is removed in clobber list, so compiler may choose r7 for
> >> local variables usage, while r7 will be actually updated by the inline=
 asm
> >> code.
> >
> > The inline asm does not update R7, it preserves and restores it.
> That is the asm is updating r7 purposely and compiler still choose r7
> for the asm local varialbe and use it inside the asm code.
> So the change is to fix the issue when "r7 is removed from the clobber
> list of current asm code while actually r7 shouldn't be choosed for the
> current asm local variables".
> The issue is only reproducible when ftrace is not enabled, and r7 is
> removed from the current clobber list.
>
> Let me have the assemble code that will make you understand better.
>
> --the original code:
> "mov    r11, r7                 \n\t"
> ...
> "ldmia  %[regs], {r0-r7}        \n\t"
> "blx    %[fn]                   \n\t"
> ...
> "mov    r7, r11                 \n\t"
>
> --After compile to choose register for [fn] and [regs].
> mov     r11, r7
> ldr=E2=80=83=E2=80=83r7, [r1, #16] //r7 used for store asi->insn_fn
> ...
> ldmia.w=E2=80=83=E2=80=83ip, {r0, r1, r2, r3, r4, r5, r6, r7}
> blx r7
> ...
> mov r7,r11
>
> The current change is to avoid by fix the registers for local variable
> usage and not choose r7 for [fn].
>

OK, I understand now, thanks.

Would it help if we just always enabled frame pointers for this source file=
?

--- a/arch/arm/probes/kprobes/Makefile
+++ b/arch/arm/probes/kprobes/Makefile
@@ -9,6 +9,7 @@ test-kprobes-objs               :=3D test-core.o
 ifdef CONFIG_THUMB2_KERNEL
 obj-$(CONFIG_KPROBES)          +=3D actions-thumb.o checkers-thumb.o
 test-kprobes-objs              +=3D test-thumb.o
+KBUILD_CFLAGS                  +=3D -fno-omit-frame-pointer
 else
 obj-$(CONFIG_KPROBES)          +=3D actions-arm.o checkers-arm.o
 obj-$(CONFIG_OPTPROBES)                +=3D opt-arm.o
