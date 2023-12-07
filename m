Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C60808473
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 10:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378487AbjLGJKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGJKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:10:15 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F6B10DF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 01:09:45 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28657040cdcso637260a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 01:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701940185; x=1702544985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c4C3n0LRxWIX1WwXTdUDTm3hHPBj3ay99ram+tbJ5c=;
        b=R+MpIeHsJHivnaHL432W9ENPykPVOhtTnA0XNkp4U6jtWmSSG6NT6HlDA9h+igazof
         dVgosixcAb518PZlhr6gii+lu36hYymcZbzggLkwArOmI8WVYD4zutQxANL0vzVJeZjo
         WdU6eFKQzkXiWnQ/szG5krgjo4Etiy69Kek0uAuIQhyPF3PZCxNAVLFTKDoGdC4QTWux
         a2luye57uxXmBdNAfqjF4kgjo2evgIa6MK4pcLQ/YR6r3IRkMpq3VTBjRX6H4DBgb6ox
         tubfHCzzsrZ1k8uz9EFAbgRgoqNOmYLSqeosC38v2FJYIzjeVMwKEl+VknfDaEmAha2J
         mI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701940185; x=1702544985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c4C3n0LRxWIX1WwXTdUDTm3hHPBj3ay99ram+tbJ5c=;
        b=EK4rm4ge105k9/TvpE0ZU5dEr3ni2vxxxbTijD2TrFcClYdvNSkvrruc+r4z2puXXR
         5JJXt8IwAP4sMj8KtgdGzCYVseeDiRVMwTZKHBN9CmpWOXlHhP6aCE8yoFimEXme0jrq
         ayEx3jlSxSxI90c8Ivomi19PyFrH2naXlTgIvS8Mgo4wH4UuxL7STfM/a23GWJ/BseT6
         mWwGdjQjBuOOmUvHExykTG+A/DoP549V/S2mvO6jzI6A34l/p7GSs8CiNi0fEWdb/Pq1
         iVXA7wxtOosfy1YNipYsgVV1t/FDAdVEtsbnCi4ntXhyRYt6zUe19Z1PV+94OhDLj2tK
         hgVw==
X-Gm-Message-State: AOJu0Yxesy8ENutvCFFBSCtH7oZ5y0xdC9A1O98lt0jNjOfc63ekEAow
        12OpmMSS04rn569Fxlhl4S+Z6HZxTBilcapBUh9UTQ==
X-Google-Smtp-Source: AGHT+IFK+U+J/GEdq+NYipG+hOrQ/lKIqZ6/I+wyo90SHNVrwK9YL7khjtC+G9Lw2tXREXPfZ0XbM9s5dby1KfOqA4U=
X-Received: by 2002:a17:90b:3509:b0:286:9231:c5c1 with SMTP id
 ls9-20020a17090b350900b002869231c5c1mr1903943pjb.7.1701940185105; Thu, 07 Dec
 2023 01:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20231026143122.279437-1-cleger@rivosinc.com>
In-Reply-To: <20231026143122.279437-1-cleger@rivosinc.com>
From:   Xu Lu <luxu.kernel@bytedance.com>
Date:   Thu, 7 Dec 2023 17:09:33 +0800
Message-ID: <CAPYmKFsFLQnhXRPXpcoNfO-kEyjYLXD2Hm-F-O=Yxe1WJoSL9w@mail.gmail.com>
Subject: Re: [External] [RFC PATCH 0/3] riscv: add support for SBI Supervisor
 Software Events
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Himanshu Chauhan <hchauhan@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pardon. It seems that the code in opensbi[1] is not complete for PMU NMI no=
w.
For example, the pmu ovf irq is still delegated to supervisor mode and
thus can not really play a role as NMI. And neither the kernel nor
opensbi will inject a pmu event.

To complete the work, we think maybe 'enable_cb' and 'disable_cb'
functions can be supplied for sbi_sse_cb_ops.
When sbi_sse_enable is called to enable pmu event, the enable_cb will
be called to revoke the delegation of pmu ovf irq and enable this irq
in CSR_MIE.
When pmu ovf irq occurs, kernel traps into opensbi and opensbi injects
the event via sbi_sse_inject_event and eret back to kernel.

Please point it out if we have any misunderstanding.

By the way, how is SSE going now? We will appreciate it very much if
we can participate in some development work in kernel or opensbi and
be of any help.

Regards!

Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/sse [1]

On Thu, Oct 26, 2023 at 10:31=E2=80=AFPM Cl=C3=A9ment L=C3=A9ger <cleger@ri=
vosinc.com> wrote:
>
> The SBI Supervisor Software Events (SSE) extensions provides a mechanism
> to inject software events from an SBI implementation to supervisor
> software such that it preempts all other supervisor level traps and
> interrupts [1].
>
> Various events are defined and can be send asynchronously to supervisor
> software (RAS, PMU, DEBUG, Asynchronous page fault) from SBI as well
> as platform specific events. Events can be either local (per-hart) or
> global. Events can be nested on top of each other based on priority and
> can interrupt the kernel at any time.
>
> First patch adds the SSE definitions. Second one adds support for SSE
> itself. Implementation is split between arch specific code and generic
> part (similarly to what is done for ARM SDEI). Finally, the last patch
> add support fro SSE event in the SBI PMU driver. If the SSE event is
> available from the SBI then, it will be used instead of the normal
> interrupt.
>
> Amongst the specific points that needs to be handle is the interruption
> at any point of the kernel execution and more specifically during
> exception handling. Due to the fact that the exception entry
> implementation uses the SCRATCH CSR as both the current task struct and
> as the temporary register to switch the stack and save register, it is
> difficult to reliably get the current task struct if we get interrupted
> at this specific moment. A fixup-like mechanism allows to mark the
> location of the current task struct depending on the entry level
> (user/kernel) and the location. This is then used in the SSE assembly to
> determine where is located the current task_struct.
>
> Contrary to pseudo NMI [2], SSE does not modifies the way interrupts are
> handled and does not adds any overhead to existing code. Moreover, it
> provides "true" NMI-like interrupts which can interrupt the kernel at
> any time (even in exception handling). This is particularly crucial for
> RAS errors which needs to be handled as fast as possible to avoid any
> fault propagation. Additionally, SSE event handling is faster that the
> standard IRQ handling path with almost half executed instruction (700 vs
> 1590). Some complementary tests/perf measurements will be done.
>
> For testing purpose, one can use the provided SBI implementation at [3].
> This series also needs patch [4] to fix a bug in the PMU driver.
>
> Link: https://lists.riscv.org/g/tech-prs/message/515 [1]
> Link: https://lore.kernel.org/lkml/20231023082911.23242-10-luxu.kernel@by=
tedance.com/T/ [2]
> Link: https://github.com/rivosinc/opensbi/tree/dev/cleger/sse [3]
> Link: https://lore.kernel.org/linux-arm-kernel/20231026084010.11888-1-ale=
xghiti@rivosinc.com/ [4]
>
> ---
>
> Cl=C3=A9ment L=C3=A9ger (3):
>   riscv: add SBI SSE extension definitions
>   riscv: add support for SBI Supervisor Software Events extension
>   perf: RISC-V: add support for SSE event
>
>  arch/riscv/include/asm/asm-prototypes.h |   5 +
>  arch/riscv/include/asm/sbi.h            |  40 ++
>  arch/riscv/include/asm/sse.h            |  94 +++++
>  arch/riscv/kernel/Makefile              |   1 +
>  arch/riscv/kernel/asm-offsets.c         |  17 +
>  arch/riscv/kernel/entry.S               | 156 ++++++++
>  arch/riscv/kernel/sbi.c                 |   4 +
>  arch/riscv/kernel/sse.c                 |  97 +++++
>  arch/riscv/kernel/stacktrace.c          |  13 +
>  arch/riscv/kernel/vmlinux.lds.S         |   6 +
>  drivers/firmware/Kconfig                |  10 +
>  drivers/firmware/Makefile               |   1 +
>  drivers/firmware/riscv_sse.c            | 496 ++++++++++++++++++++++++
>  drivers/perf/riscv_pmu_sbi.c            |  51 ++-
>  include/linux/riscv_sse.h               |  56 +++
>  15 files changed, 1038 insertions(+), 9 deletions(-)
>  create mode 100644 arch/riscv/include/asm/sse.h
>  create mode 100644 arch/riscv/kernel/sse.c
>  create mode 100644 drivers/firmware/riscv_sse.c
>  create mode 100644 include/linux/riscv_sse.h
>
> --
> 2.42.0
>
