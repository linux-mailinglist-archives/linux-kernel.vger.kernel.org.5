Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E2A7D1BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjJUION (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJUIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:14:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CC1D52
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:14:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A3FC433C7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697876046;
        bh=Os6dmC0vnRGZEYhqZd2x3vRHxfFy1e1UzoFQq9eXATg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oMcug7XdNQH3y3Q/0L1Y9MMONxVwtE7yASf1r11f2b5dcAYxSgllWFYOvbeZmptJm
         v3LFIHTOpuxabWUan6Poj4D6yeNy9Dqwqo8l3pmuDc07FSNaWBpTGIzfWvLBh3zPdW
         icTjp4iqmNhzDNM6GSDTsTvnnYjiZdhS8Aus/imeAaG4VfkLLnQXcSdle7y/XG+sWx
         jB8W7v7GO/HSAQp3yidkesEODtSG6ywYdCPhAeIMHFm9NarODsbTCR4DXpAZ1mLO8H
         0FoSXxbiXYckQlUa3LR9/np48jNJjJ6IzwJ44YC20ABoeJWkRXaaDDxL9b5liLC4bg
         DlDblMXyEKSrw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so2186731a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:14:06 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw+Fixs4FIr6w/MfGxnmxrwhalcizOdzeH4ZuzKzX1Cv/cNh9qj
        HVCHm/0oBn7xFyMk/YgeOJHhx8iviKP9J+GYyi8=
X-Google-Smtp-Source: AGHT+IGwBeHBKTlH1S/NFVnBmf690MmJZ9s1KcP3VSer6ybfMBM74Wl15mBbO+OHKIhuzp9VR1yeayP301cdSvBh65o=
X-Received: by 2002:a05:6402:2550:b0:53e:6a4e:1f91 with SMTP id
 l16-20020a056402255000b0053e6a4e1f91mr3364120edb.7.1697876044632; Sat, 21 Oct
 2023 01:14:04 -0700 (PDT)
MIME-Version: 1.0
References: <1697768821-22931-1-git-send-email-yangtiezhu@loongson.cn>
 <CAAhV-H4wqO0=+EOhyH+t=0bpiX2DayddVArB=x_yzVvmX9OW1g@mail.gmail.com>
 <a967ebeb-f19d-4e36-3547-80e838ad2fa0@loongson.cn> <23a3ebe302f77db630edc52b23afb812f31f103e.camel@xry111.site>
 <caa9c73c-4779-a88e-4577-4d7b0ed2b76a@loongson.cn>
In-Reply-To: <caa9c73c-4779-a88e-4577-4d7b0ed2b76a@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 21 Oct 2023 16:13:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5_PN7yWiBo7A4PA_c3UvWDZ+WwQaWQ2F6cJSGUydrKaQ@mail.gmail.com>
Message-ID: <CAAhV-H5_PN7yWiBo7A4PA_c3UvWDZ+WwQaWQ2F6cJSGUydrKaQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Add objtool and orc support for LoongArch
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Xi Ruoyao <xry111@xry111.site>,
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

Hi, Tiezhu,

On Fri, Oct 20, 2023 at 6:55=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
>
>
> On 10/20/2023 06:45 PM, Xi Ruoyao wrote:
> > On Fri, 2023-10-20 at 18:28 +0800, Tiezhu Yang wrote:
> >> On 10/20/2023 04:51 PM, Huacai Chen wrote:
> >>> Cross compiling on X86 for LoongArch fails:
> >>>
> >>>    CALL    scripts/checksyscalls.sh
> >>>    DESCEND objtool
> >>> make[5]: *** No rule to make target
> >>> '/usr/lib/gcc/x86_64-redhat-linux/8/include/stdbool.h', needed by
> >>> '/home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/exec-cmd=
.o'.
> >>> Stop.
> >>> make[4]: *** [Makefile:80:
> >>> /home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/libsubcmd=
-in.o]
> >>> Error 2
> >>> make[3]: *** [Makefile:82:
> >>> /home/chenhuacai/linux-official.git/tools/objtool/libsubcmd/libsubcmd=
.a]
> >>> Error 2
> >>> make[2]: *** [Makefile:73: objtool] Error 2
> >>> make[1]: *** [/home/chenhuacai/linux-official.git/Makefile:1355:
> >>> tools/objtool] Error 2
> >>> make: *** [Makefile:234: __sub-make] Error 2
> >>
> >> It seems that there is no stdbool.h in your cross compile environment.
> >>
> >> It works well with the following steps, you can try it.
> >
> > /* snip */
> >
> >> find /opt -name stdbool.h
> >> /opt/cross-tools/lib/gcc/loongarch64-unknown-linux-gnu/14.0.0/include/=
stdbool.h
> >> /opt/cross-tools/loongarch64-unknown-linux-gnu/include/c++/14.0.0/tr1/=
stdbool.h
> >
> > The problem is HOSTCC cannot find stdbool.h, not (target) CC.  So these
> > two files are not relevant.
> >
>
> Oh, thank you for pointing out the real reason of this issue.
>
> By the way, my test system is Fedora 38 x86_64, it works well.
I can also cross compile now.

And I have fixed some issues I comments in this series, then I have pushed =
here:
https://github.com/chenhuacai/linux/commits/master

To save time, you can do additional modifications (e.g. Peter's
suggestions) on top of my version.

And there are still some problems that need some more effort.
1, Build warnings:
  AS      arch/loongarch/kernel/fpu.o
arch/loongarch/kernel/fpu.o: warning: objtool: _restore_fp+0xb0:
unreachable instruction
arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lsx+0xf4:
unreachable instruction
arch/loongarch/kernel/fpu.o: warning: objtool: _restore_lasx+0xf4:
unreachable instruction
  CC      arch/loongarch/kernel/kfpu.o
  AS      arch/loongarch/kernel/lbt.o
arch/loongarch/kernel/lbt.o: warning: objtool:
_restore_ftop_context+0x18: unreachable instruction

2, Partial call stack:
[10589.180597] [<9000000002e435e0>] show_stack+0x34/0x14c
[10589.188124] [<9000000003f0bd7c>] dump_stack_lvl+0x5c/0x88
[10589.193487] [<9000000003f0bdb8>] dump_stack+0x10/0x20
[10589.198505] [<9000000002e43704>] show_regs+0xc/0x1c
[10589.203350] [<9000000003edb174>] nmi_cpu_backtrace+0x154/0x15c
[10589.209146] [<9000000002e43acc>] handle_backtrace+0xc/0x40
[10589.214597] [<9000000002f165d8>] __flush_smp_call_function_queue+0xe4/0x=
2bc
[10589.221518] [<9000000002f17538>]
generic_smp_call_function_single_interrupt+0xc/0x1c
[10589.229217] [<9000000002e4e6a0>] loongson_ipi_interrupt+0x7c/0xc0
[10589.235274] [<9000000002ecf1c4>] __handle_irq_event_percpu+0x50/0x130
[10589.241675] [<9000000002ecf2b8>] handle_irq_event_percpu+0x14/0x70
[10589.247818] [<9000000002ed5aa4>] handle_percpu_irq+0x50/0x78
[10589.253443] [<9000000002ece3c0>] generic_handle_domain_irq+0x24/0x40
[10589.259758] [<900000000369be68>] handle_cpu_irq+0x68/0xa4
[10589.265122] [<9000000003f0c128>] handle_loongarch_irq+0x2c/0x4c
[10589.271004] [<9000000003f0c1cc>] do_vint+0x84/0xbc

3, Runtime warnings:
[   51.891244] [<9000000002b935e0>] show_stack+0x34/0x14c
[   51.898777] [<9000000003c5bd7c>] dump_stack_lvl+0x5c/0x88
[   51.904144] [<9000000003c5bdb8>] dump_stack+0x10/0x20
[   51.909161] [<9000000003c2b158>] nmi_cpu_backtrace+0x138/0x15c
[   51.914960] [<9000000003c2b324>] nmi_trigger_cpumask_backtrace+0x1a8/0x1=
e4
[   51.921794] [<9000000002b944ec>] arch_trigger_cpumask_backtrace+0x10/0x2=
0
[   51.928541] [<9000000003508bd0>] sysrq_handle_showallcpus+0x14/0x24
[   51.934772] [<90000000035095b8>] __handle_sysrq+0x184/0x1e0
[   51.940310] [<9000000003509cf8>] write_sysrq_trigger+0x94/0x9c
[   51.946107] [<9000000002e98a6c>] proc_reg_write+0xb4/0xf0
[   51.951472] [<9000000002e07c4c>] vfs_write+0x108/0x3d8
[   51.956580] [<9000000002e080d0>] ksys_write+0x74/0x124
[   51.961686] [<9000000002e0818c>] sys_write+0xc/0x1c
[   51.966533] [<9000000003c5d0b8>] do_syscall+0x78/0x98
[   51.971552] [<9000000002b91198>] handle_syscall+0xb8/0x158
[   51.977002] WARNING: unknown SP base reg 0 at handle_syscall+0xb8/0x158

Huacai

>
> Thanks,
> Tiezhu
>
>
