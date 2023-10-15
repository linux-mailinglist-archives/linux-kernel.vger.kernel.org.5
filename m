Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601087C993F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 15:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjJON6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 09:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJON6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 09:58:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F006AC1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 06:58:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957F1C433C7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697378288;
        bh=oCUqC7c37zE4Mwmnx6EDE2MQorXiznyPZgwkCRKjc/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oXuSEB4vuPrN+OonqYHiT853E/SgupHYs/UU6b0U//8L70iWRPbUi/yxeTioesUVT
         2EfgpkTs9j03wwfEWTodYzKeY0PS2eR6rsGgx/KiImIROAQmDj2LrgRBi7h2x8FBIR
         Ris9sR87tS/F3vnqS9xKPuU19Q+0ciqDIRtDqLyVeJpOCJu9BNy6ff5DD6S/Fcoe9w
         CjUhH8wI0ug0QjPAZRNrcLpXveAfVDGaX3NaQTVArpn3SIdOWmYicBOjFXT1H478OA
         fpMmdRMNgxlJUi10U2Hdjk6BcqHh6mwsLzjteB0ckmnpMJ1LlqyKGR7NEMZOyPkP22
         Ck2vbPPc2NUWw==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso131894466b.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 06:58:08 -0700 (PDT)
X-Gm-Message-State: AOJu0YyfWSXLYV6mLibuuvoITVDwutp3GgTWMqFTNXKWIygghxLeXOmg
        s+AAPkpN/j3wdnhJUypV2ODrM8trbSLUwS/VK4o=
X-Google-Smtp-Source: AGHT+IHdc/tSoweMZ2rf86++vl9tHdZiUBGDIYABbX3KMiISDlkxUe5i8/QHzc5q2elhbBt/mYMy3TPLlVEYpVccC7c=
X-Received: by 2002:a17:907:26cb:b0:9c3:b609:7211 with SMTP id
 bp11-20020a17090726cb00b009c3b6097211mr770867ejc.1.1697378286973; Sun, 15 Oct
 2023 06:58:06 -0700 (PDT)
MIME-Version: 1.0
References: <1696856590-30298-1-git-send-email-yangtiezhu@loongson.cn>
 <1696856590-30298-9-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4pVRLPZ9OrfvV-UbPm1kRRJ0gpTqRtVbDd-eA5WzUaXg@mail.gmail.com>
 <bd40004b-10af-3c06-5ae0-750850f31446@loongson.cn> <CAAhV-H77o8nMiYrKJt9nocpsOh5e66dAeg+j4soncniLc+eY=w@mail.gmail.com>
 <bb99083b-6f50-79c0-5407-ede327346887@loongson.cn>
In-Reply-To: <bb99083b-6f50-79c0-5407-ede327346887@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 15 Oct 2023 21:57:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4gCFgGrOaHtTdDhJ=EWVhK7jtLtzOcynVD+-T2tubPNQ@mail.gmail.com>
Message-ID: <CAAhV-H4gCFgGrOaHtTdDhJ=EWVhK7jtLtzOcynVD+-T2tubPNQ@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] LoongArch: Add ORC unwinder support
To:     Jinyang He <hejinyang@loongson.cn>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
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

Hi, Jinyang,

On Sun, Oct 15, 2023 at 8:58=E2=80=AFPM Jinyang He <hejinyang@loongson.cn> =
wrote:
>
> On 2023-10-14 19:37, Huacai Chen wrote:
>
> > +CC Jinyang
> >
> > On Sat, Oct 14, 2023 at 5:21=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongso=
n.cn> wrote:
> >>
> >>
> >> On 10/11/2023 12:37 PM, Huacai Chen wrote:
> >>> Hi, Tiezhu,
> >>>
> >>> Maybe "LoongArch: Add ORC stack unwinder support" is better.
> >> OK, will modify it.
> >>
> >>> On Mon, Oct 9, 2023 at 9:03=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongs=
on.cn> wrote:
> >>>> The kernel CONFIG_UNWINDER_ORC option enables the ORC unwinder, whic=
h is
> >>>> similar in concept to a DWARF unwinder. The difference is that the f=
ormat
> >>>> of the ORC data is much simpler than DWARF, which in turn allows the=
 ORC
> >>>> unwinder to be much simpler and faster.
> >> ...
> >>
> >>>> +ifdef CONFIG_OBJTOOL
> >>>> +# https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3De=
cb802d02eeb
> >>>> +# https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3D8=
16029e06768
> >>>> +ifeq ($(shell as --help 2>&1 | grep -e '-mthin-add-sub'),)
> >>>> +  $(error Sorry, you need a newer gas version with -mthin-add-sub o=
ption)
> >>> I prefer no error out here, because without this option we can still
> >>> built a runnable kernel.
> >> I agree with you that it is better to not error out to stop compilatio=
n,
> >> but there are many objtool warnings during the compile process with ol=
d
> >> binutils, so it is necessary to give a warning so that the users know
> >> what happened and how to fix the lots of objtool warnings.
> >>
> >> That is to say, I would prefer to replace "error" with "warning".
> >>
> >>>> +endif
> >>>> +KBUILD_AFLAGS  +=3D $(call cc-option,-mthin-add-sub) $(call cc-opti=
on,-Wa$(comma)-mthin-add-sub)
> >>>> +KBUILD_CFLAGS  +=3D $(call cc-option,-mthin-add-sub) $(call cc-opti=
on,-Wa$(comma)-mthin-add-sub)
> >>>> +KBUILD_CFLAGS  +=3D -fno-optimize-sibling-calls -fno-jump-tables -f=
align-functions=3D4
> >>>> +endif
> >> ...
> >>
> >>>> +#define ORC_REG_BP                     3
> >>> Use FP instead of BP in this patch, too.
> >> OK, will do it.
> >>
> >>>> +#define ORC_REG_MAX                    4
> >> ...
> >>
> >>>> +.macro UNWIND_HINT_UNDEFINED
> >>>> +       UNWIND_HINT type=3DUNWIND_HINT_TYPE_UNDEFINED
> >>>> +.endm
> >>> We don't need to set sp_reg=3DORC_REG_UNDEFINED for UNWIND_HINT_UNDEF=
INED?
> >> Yes, no need to set sp_reg, the instructions marked with UNDEFINED
> >> are blind spots in ORC coverage, it is no related with stack trace,
> >> this is similar with x86.
> >>
> >>>> +
> >>>> +.macro UNWIND_HINT_EMPTY
> >>>> +       UNWIND_HINT sp_reg=3DORC_REG_UNDEFINED type=3DUNWIND_HINT_TY=
PE_CALL
> >>>> +.endm
> >>> We don't need to define UNWIND_HINT_END_OF_STACK?
> >> Yes, it is useless now.
> >>
> >>>> +
> >>>> +.macro UNWIND_HINT_REGS
> >>>> +       UNWIND_HINT sp_reg=3DORC_REG_SP type=3DUNWIND_HINT_TYPE_REGS
> >>>> +.endm
> >>>> +
> >>>> +.macro UNWIND_HINT_FUNC
> >>>> +       UNWIND_HINT sp_reg=3DORC_REG_SP type=3DUNWIND_HINT_TYPE_CALL
> >>>> +.endm
> >>> We don't need to set sp_offset for UNWIND_HINT_REGS and UNWIND_HINT_F=
UNC?
> >> sp_offset is 0 by default, no need to set it unless you need to change
> >> its value, see include/linux/objtool.h
> >> .macro UNWIND_HINT type:req sp_reg=3D0 sp_offset=3D0 signal=3D0
> >>
> >>>> +
> >>>> +#endif /* __ASSEMBLY__ */
> >> ...
> >>
> >>>> diff --git a/arch/loongarch/kernel/entry.S b/arch/loongarch/kernel/e=
ntry.S
> >>>> index 65518bb..e43115f 100644
> >>>> --- a/arch/loongarch/kernel/entry.S
> >>>> +++ b/arch/loongarch/kernel/entry.S
> >>>> @@ -14,11 +14,13 @@
> >>>>   #include <asm/regdef.h>
> >>>>   #include <asm/stackframe.h>
> >>>>   #include <asm/thread_info.h>
> >>>> +#include <asm/unwind_hints.h>
> >>>>
> >>>>          .text
> >>>>          .cfi_sections   .debug_frame
> >>>>          .align  5
> >>>> -SYM_FUNC_START(handle_syscall)
> >>>> +SYM_CODE_START(handle_syscall)
> >>> Why?
> >>>
> >> see include/linux/linkage.h
> >> FUNC -- C-like functions (proper stack frame etc.)
> >> CODE -- non-C code (e.g. irq handlers with different, special stack et=
c.)
> > Hi, Jinyang,
> >
> > What do you think about it? In our internal repo, most asm functions
> > changed in this patch are still marked with FUNC, not CODE.
>
> Hi, Huacai,
>
>
> As the anotations in the include/linux/linkage.h, CODE should be used for
> exception handler in case where the stack at the start of the handler
> is unbalanced with the stack at the exit. In validate_branch,
> validate_return, and validate_sibling_call it will not check the stack.
> CODE needs HINT to describe the actual stack at the beginning of the CODE=
.
>
> In objtool's check flow, then entry check FUNC is validate_functions and
> the entry of check CODE is validate_unwind_hints. They actual check funct=
ion
> is validate_branch. If ignore the stack check, they can get the same ORC
> info in most cases. In the internal repo, limited by what I knew about
> objtool
> at that time, I might have done something wrong.  e.g. NOT_SIBLING_CALL_H=
INT
> could be a way to ignore stack checks. These exception handler code logic=
 in
> upstream is cleaner than that in the internal repo. So I hope this can be
> fixed in upstream first.
>
> handle_syscall is an example of a FUNC that looks stack balanced. However=
,
> the RA register at the entry is not the real RA, and its SP is also chang=
ed
> from user stack SP to kernel stack SP. So in fact, it is not stack balanc=
ed.
> It needs to be marked as CODE, and annotate HINT at the CODE entry to
> describe the actual stack (, usually described as undefined).
>
> In short, objtool is strictly dependent on canonical codes so that it can
> get the ORC information right.
Is the code in tlbex.S the same as handle_syscall()? If so, I suggest
submitting a separate patch to rename FUNC to CODE. That will be easy
to review, and can be upstream earlier because it is independent with
objtool.

Huacai

>
> Thanks,
>
> Jinyang
>
>
> >
> >>>> +       UNWIND_HINT_UNDEFINED
> >>>>          csrrd           t0, PERCPU_BASE_KS
> >> ...
> >>
> >>>> diff --git a/arch/loongarch/kernel/head.S b/arch/loongarch/kernel/he=
ad.S
> >>>> index 53b883d..5664390 100644
> >>>> --- a/arch/loongarch/kernel/head.S
> >>>> +++ b/arch/loongarch/kernel/head.S
> >>>> @@ -43,6 +43,7 @@ SYM_DATA(kernel_offset, .long _kernel_offset);
> >>>>          .align 12
> >>>>
> >>>>   SYM_CODE_START(kernel_entry)                   # kernel entry poin=
t
> >>>> +       UNWIND_HINT_EMPTY
> >>> I'm not sure but I think this isn't needed, because
> >>> "OBJECT_FILES_NON_STANDARD_head.o               :=3Dy"
> >> Yes, you are right, will remove it.
> >>
> >>>>          /* Config direct window and set PG */
> >> ...
> >>
> >>>>   void __init setup_arch(char **cmdline_p)
> >>>>   {
> >>>> +       unwind_init();
> >>> I think this line should be after cpu_probe().
> >> I am OK to do this change, but if so, there are no stack trace before
> >> cpu_probe() for the early code.
> > As I said before, stack trace needs printk, but printk cannot work
> > before cpu_probe().
> >
> >>>>          cpu_probe();
> >>>>
> >>>>          init_environ();
> >> ...
> >>
> >>>> diff --git a/arch/loongarch/power/Makefile b/arch/loongarch/power/Ma=
kefile
> >>>> index 58151d0..bbd1d47 100644
> >>>> --- a/arch/loongarch/power/Makefile
> >>>> +++ b/arch/loongarch/power/Makefile
> >>>> @@ -1,3 +1,5 @@
> >>>> +OBJECT_FILES_NON_STANDARD_suspend_asm.o :=3D y
> >>> hibernate_asm.o has no problem?
> >> Yes, only suspend_asm.o has one warning, just ignore it.
> > What kind of warning? When I submitted the suspend patch, Jinyang told
> > me that with his changes loongarch_suspend_enter() can be a regular
> > function.
> >
> > Huacai
>
> Hi, Tiezhu,
>
> We can think the jirl with link register is a call instruction.
> loongarch_suspend_enter:
>      jirl   a0, t0, 0 /* Call BIOS's STR sleep routine */
> Its link register is a0, (not ra), we also think it is a call
> instruction. The func is also stack banlaced. So the func can be a
> regular function.
>
> Thanks,
>
> Jinyang
>
>
> >> Thanks,
> >> Tiezhu
> >>
> >>
>
>
