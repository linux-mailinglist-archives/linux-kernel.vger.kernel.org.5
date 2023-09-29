Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEE07B3ABF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 21:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjI2Tix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 15:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2Tiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 15:38:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E129B9C;
        Fri, 29 Sep 2023 12:38:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75760C433CA;
        Fri, 29 Sep 2023 19:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696016329;
        bh=k9t+qS0jO6IW57fA+w7PDdAJNLwGMZjX4+UlxZcE1iI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=thzcpJk1zqQ7StwfdqGkOrUZdKdNWXnDlm0ebRH+9LRTxIoiBuqjCWqbjk8ZV+wA8
         mv4GuyYTBpm8rGusGvVa+mj8vH1AIqatGZslz7at8J0jVhPzIohEONlPUiNBVuU6LP
         ynAqxWSp5LjnhyMORtfRlTuVylzwaJAIZX42wS4+f7K5y24ReKbw/CXgVQUBokimAw
         sWQqccPxy6QU8/lnF98hHlZ4D2Uf4uB73IOEGvTkGVtfSY389rTKuOPwBuDuWWbZDc
         zrf0NqwJaW7Zm6AT2bznhp2C09uOMx591Du9TabMSMjWu/wY9WOceHPZ3r7UOAyAuL
         RdEWGX1z+VP+w==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-50336768615so23937464e87.0;
        Fri, 29 Sep 2023 12:38:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzv/xjHZCPyL7JUgyZWynXA+fYJNiX/SzDpt44Qng7LhaMwxYOf
        InWNX94jF4+nmOY/WisZW5IZBg95Rr38RxC/S20=
X-Google-Smtp-Source: AGHT+IHVJH5ISVMuU4CdMsvawojJazZ5/9bLi0QZfkSAMKOI+xAU3qaK4DtKDGK6xr8IgiNwi7+S8Dkv/YFTP0ooc1c=
X-Received: by 2002:a05:6512:3e0d:b0:503:9ea:3a67 with SMTP id
 i13-20020a0565123e0d00b0050309ea3a67mr5290722lfv.26.1696016327575; Fri, 29
 Sep 2023 12:38:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230927055954.3755-1-quic_aiquny@quicinc.com>
 <CAMj1kXEh=yQ12v1Ht6=-vgXVe8VCQTPdUD8AowkKcpyDXh_0mg@mail.gmail.com>
 <af59ec04-aa68-5a22-0f3f-f4872cefeb46@quicinc.com> <CAMj1kXEUTOpATv_jbimGktSXBBweyfVNPpqWWJaJNp0U-zvg+w@mail.gmail.com>
 <29bf8f4c-44b8-ab22-aa66-3e3040012ee5@quicinc.com> <22c91d69-328b-8221-f0fa-d6e1663ce074@quicinc.com>
In-Reply-To: <22c91d69-328b-8221-f0fa-d6e1663ce074@quicinc.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 29 Sep 2023 19:38:36 +0000
X-Gmail-Original-Message-ID: <CAMj1kXHKgrJR_pdDV23U_9q5Gft5Sydcus=tmXXM6anKvb7H5w@mail.gmail.com>
Message-ID: <CAMj1kXHKgrJR_pdDV23U_9q5Gft5Sydcus=tmXXM6anKvb7H5w@mail.gmail.com>
Subject: Re: [PATCH] ARM: kprobes: Explicitly assign register for local variables
To:     "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
Cc:     linux@armlinux.org.uk, mhiramat@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@quicinc.com, quic_lijuang@quicinc.com,
        linux-arm-msm@vger.kernel.org
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

On Thu, 28 Sept 2023 at 00:46, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wr=
ote:
>
> On 9/28/2023 8:40 AM, Aiqun(Maria) Yu wrote:
> > On 9/27/2023 6:11 PM, Ard Biesheuvel wrote:
> >> On Wed, 27 Sept 2023 at 09:44, Aiqun(Maria) Yu
> >> <quic_aiquny@quicinc.com> wrote:
> >>>
> >>> On 9/27/2023 5:26 PM, Ard Biesheuvel wrote:
> >>>> Hello Maria,
> >>>>
> >>>> On Wed, 27 Sept 2023 at 06:00, Maria Yu <quic_aiquny@quicinc.com>
> >>>> wrote:
> >>>>>
> >>>>> Registers r7 is removed in clobber list, so compiler may choose r7 =
for
> >>>>> local variables usage, while r7 will be actually updated by the
> >>>>> inline asm
> >>>>> code.
> >>>>
> >>>> The inline asm does not update R7, it preserves and restores it.
> >>> That is the asm is updating r7 purposely and compiler still choose r7
> >>> for the asm local varialbe and use it inside the asm code.
> >>> So the change is to fix the issue when "r7 is removed from the clobbe=
r
> >>> list of current asm code while actually r7 shouldn't be choosed for t=
he
> >>> current asm local variables".
> >>> The issue is only reproducible when ftrace is not enabled, and r7 is
> >>> removed from the current clobber list.
> >>>
> >>> Let me have the assemble code that will make you understand better.
> >>>
> >>> --the original code:
> >>> "mov    r11, r7                 \n\t"
> >>> ...
> >>> "ldmia  %[regs], {r0-r7}        \n\t"
> >>> "blx    %[fn]                   \n\t"
> >>> ...
> >>> "mov    r7, r11                 \n\t"
> >>>
> >>> --After compile to choose register for [fn] and [regs].
> >>> mov     r11, r7
> >>> ldr=E2=80=83=E2=80=83r7, [r1, #16] //r7 used for store asi->insn_fn
> >>> ...
> >>> ldmia.w=E2=80=83=E2=80=83ip, {r0, r1, r2, r3, r4, r5, r6, r7}
> >>> blx r7
> >>> ...
> >>> mov r7,r11
> >>>
> >>> The current change is to avoid by fix the registers for local variabl=
e
> >>> usage and not choose r7 for [fn].
> >>>
> >>
> >> OK, I understand now, thanks.
> >>
> >> Would it help if we just always enabled frame pointers for this source
> >> file?
> The compiler(clang 17 here I am using) will still complain for "inline
> asm clobber list contains reserved registers" when ftrace enabled.
>
> More over, the local variable have fixed registers was align with
> current solution as well. we referenced other asm inlined function
> inside kprobe folder, like __kprobes functions inside actions-common.c
> files, it is also have similar solution to fixed register usage for
> local variables which will be used inside similar inline asm code.

I tested the approach below, and it seems to work fine both with
ftrace enabled and disabled. R7 is no longer selected by the compiler
as an inline asm argument, but is still in charge of the register
allocation.

With your approach, the compiler is still free to use R7, and we have
had issues in the past where the compiler does not honour the register
asm ("rX") assignment strictly.

Could you please explain how you produced the "inline asm clobber list
contains reserved registers" with this change?




--- a/arch/arm/probes/kprobes/Makefile
+++ b/arch/arm/probes/kprobes/Makefile
@@ -8,6 +8,7 @@ test-kprobes-objs               :=3D test-core.o

 ifdef CONFIG_THUMB2_KERNEL
 obj-$(CONFIG_KPROBES)          +=3D actions-thumb.o checkers-thumb.o
+CFLAGS_actions-thumb.o         +=3D -fno-omit-frame-pointer
 test-kprobes-objs              +=3D test-thumb.o
 else
 obj-$(CONFIG_KPROBES)          +=3D actions-arm.o checkers-arm.o
