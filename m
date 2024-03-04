Return-Path: <linux-kernel+bounces-91242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 147D3870BA8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85974282304
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775839473;
	Mon,  4 Mar 2024 20:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kQpLPbaj"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A48F61
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709584486; cv=none; b=E3u3QyuTEWc4xUCRCKQpiN10Sf3/eoVsL/HdbdADUDB78e3DfhtepTyj1VgHxhveYtum2M87gf4QEXB0ZtOPWYQT6BUPlb63kQBuR/fMlO3DMfobCiN3aZ2Gdqi2N5GX4djPB2pYvy8kbbKWg/sikTauy5R41IgawMTwZLT4dEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709584486; c=relaxed/simple;
	bh=agTGJ7mvTxHNHU2+yxW39F0Pesw+dn+kEI+hcsUMMM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tk/vbV0LuL19B+yP+eNv9s/nvLNHNw0uQdcUbctjckLUUVHaoYEVMbA7sB3kUtIlbYnjll+vlKOoCx1p3toaKd1SkWa+45ZV3Kh8e7uDJoRYEV7VQnj+gZjmAurTSO8/LJJF+F6Io9tY/y99JHWxxWw/5+akLmQmhAqqXWx0MAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kQpLPbaj; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d35d69f525so787157e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 12:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709584484; x=1710189284; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Yidc7dQqIK4DELs1FgeItRWziYxfLhE7eHCKyDkTI=;
        b=kQpLPbajNhBhgnuEcGlA+xTNIepCxdk2p0kLlB0W1mcXpMLjg04bOBaVS5RA45SE5g
         HfOqr9t6x3EuPz4CqTAtdNsZotyuiw/raZikx3K6tpJgDa1kvfZwlUp6Y7ICGRRVKggk
         gAPFo1re1+teonIkp+Vj2UShpmm7/t8GUM2S9Yk8gq3YxgxXkUMhMLXfdhgE5BZJCwyw
         j+5mg96ZLaGtqU+hnAFZWXVMEbXxgCCIa0QjEbXoJXdn4zsvGbHdXu8P7TjGCjPxZRB4
         2xiBtlkggy1bBdWzR1uhZJuillWfwcQ3K1rmd/mdLVEUHEWFFxVrWsJevFh3odIQHQSo
         qssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709584484; x=1710189284;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0Yidc7dQqIK4DELs1FgeItRWziYxfLhE7eHCKyDkTI=;
        b=McHxZ76kLDfbUxTGEKn+cxDNtNFTHggtLgcv+NmPZ4HSGsrXLPXw7nhnzbx73a8TKI
         EHHpM+jvHtEG4jj5FqtbVoxouCua91rw1qP292Y88DiCOnFeIUOAig+ZotrWuiJftJnJ
         kup0tW1PATqhiaBSnx7dJju3daD7PnJZvDc1m/GVEJxBWrqtLA2QUIm5OWxbTz03+0Kc
         HhFbBaRB4UeM05WJmH/A3ZqfpWeyaQV2CGeq/+jqsK2Q6AT1vgQGb1Xfxb3fGECfhH78
         Z0SliSXO3jUcK29XZU3QT4poR2vp7bgEchu8ScXqxbZjtVx4HB6nF8S7+L4T1i8U4o77
         m1hw==
X-Forwarded-Encrypted: i=1; AJvYcCUFF6ZTOp9LitL+njwNcVFtGNuXL4tIWuxiHpx+j7igqlKFZaw9bEb+4X5calFeXwwjBBCwdi7dZ6QQygJRVCH/vsGtRDkVl/zMAQib
X-Gm-Message-State: AOJu0YzGr9ARYJ+OUaqK8AIECCHfv1290WKhoi4r8yEb4RCH4kpF9nfP
	kK7+b1qzgm89WEe2w+J97eEBOq1TWMWNTp1eBSQOyslykgToxi5sdyD3p4iAEf+13JVQ5cgQ22d
	UTFXYyImxreXPWqwvpPTL19gat2RYflFvy8TYHzMQhM8fiiL6Gl3A
X-Google-Smtp-Source: AGHT+IEijcQgtibxEwRnA6QNXpea6ijSEjSQ5ApXUicgRhVOR54sTsLFrR74KsQA1jxfPcT7XWfnAHFo60oN5NOisb8=
X-Received: by 2002:a05:6122:4812:b0:4d3:3236:e91 with SMTP id
 ef18-20020a056122481200b004d332360e91mr5181048vkb.11.1709584483711; Mon, 04
 Mar 2024 12:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f477329e-4ecf-4c6c-82b1-1e9b84443902@roeck-us.net>
In-Reply-To: <f477329e-4ecf-4c6c-82b1-1e9b84443902@roeck-us.net>
From: Marco Elver <elver@google.com>
Date: Mon, 4 Mar 2024 21:34:05 +0100
Message-ID: <CANpmjNMZD7-HY9FNGKnWTzHJ+Kibf2++rHj=j+3UTFKZ+Hr+EQ@mail.gmail.com>
Subject: Re: hw_breakpoint unit test failures with various architectures/platforms
 in qemu
To: Guenter Roeck <linux@roeck-us.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Dmitry Vyukov <dvyukov@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 19:12, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Hi,
>
> I see a number of failures and tracebacks when running the hw_breakpoint
> unit tests on various architectures in qemu. Some examples are below.
>
> Is this a potential problem with the unit tests, with the hardware,
> or with the qemu emulation of that hardware ?

The test is testing the accounting logic (allocating/deallocating HW
breakpoints), not actually using the breakpoints. That requires that
the architecture reports the correct number of HW breakpoints
available. It looks like it's not doing that.

> In other words, is it worthwhile to look into this further, or would
> it make more sense to just disable those tests if they fail on a
> given hardware/platform ?

It's an arch bug:
https://lore.kernel.org/lkml/Ytl9L0Zn1PVuL1cB@FVFF77S0Q05N.cambridge.arm.com/

Back then we decided to leave the test as-is, given it's reporting an
actual issue. However, since then nothing has changed and the test
continues to exist as a reminder the arch code needs fixing. I suspect
none of us have the time to get to that soon, so we can either leave
things as is, or skip the test on all the broken architectures.

No idea what's going on with loongarch.

Thanks,
-- Marco

> Thanks,
> Guenter
>
> ---
> arm:smdkc210:
>
> [    9.515572]     ok 2 test_many_cpus
> [    9.519425] ########### searching unregister_test_bp
> [    9.519989] ------------[ cut here ]------------
> [    9.520995] ########### searching test_one_task_on_all_cpus
> [    9.521318] WARNING: CPU: 1 PID: 63 at kernel/events/hw_breakpoint_test.c:49 test_one_task_on_all_cpus+0x90/0x1c4
> [    9.521921] Modules linked in:
> [    9.522532] CPU: 1 PID: 63 Comm: kunit_try_catch Tainted: G                 N 6.8.0-rc7-00028-g624465c9abd6 #1
> [    9.523102] Hardware name: Samsung Exynos (Flattened Device Tree)
> [    9.523610]  unwind_backtrace from show_stack+0x10/0x14
> [    9.523936]  show_stack from dump_stack_lvl+0x68/0x90
> [    9.524191]  dump_stack_lvl from __warn+0xbc/0x21c
> [    9.524429]  __warn from warn_slowpath_fmt+0x1a8/0x1b0
> [    9.524674]  warn_slowpath_fmt from test_one_task_on_all_cpus+0x90/0x1c4
> [    9.524971]  test_one_task_on_all_cpus from kunit_try_run_case+0x58/0x18c
> [    9.525273]  kunit_try_run_case from kunit_generic_run_threadfn_adapter+0x14/0x20
> [    9.525593]  kunit_generic_run_threadfn_adapter from kthread+0x118/0x124
> [    9.525889]  kthread from ret_from_fork+0x14/0x28
> [    9.526200] Exception stack(0xf0ad5fb0 to 0xf0ad5ff8)
> [    9.526663] 5fa0:                                     00000000 00000000 00000000 00000000
> [    9.527112] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    9.527449] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    9.527876] irq event stamp: 113
> [    9.528088] hardirqs last  enabled at (121): [<c01adfb4>] console_unlock+0x114/0x130
> [    9.529049] hardirqs last disabled at (140): [<c01adfa0>] console_unlock+0x100/0x130
> [    9.529501] softirqs last  enabled at (138): [<c010168c>] __do_softirq+0x340/0x520
> [    9.529892] softirqs last disabled at (129): [<c012f23c>] irq_exit+0x190/0x1c0
> [    9.530227] ---[ end trace 0000000000000000 ]---
> [    9.531752]     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [    9.531752]     Expected IS_ERR(bp) to be false, but is true
> [    9.537757]     not ok 3 test_one_task_on_all_cpus
>
> ---
> arm:raspi2b (and others):
>
> [   14.718608]     # Subtest: hw_breakpoint
> [   14.719351]     # module: hw_breakpoint_test
> [   14.722275]     1..9
> [   14.737927]     # test_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   14.737927]     Expected IS_ERR(bp) to be false, but is true
> [   14.745960]     not ok 1 test_one_cpu
> [   14.750052]     # test_many_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   14.750052]     Expected IS_ERR(bp) to be false, but is true
> [   14.791453]     not ok 2 test_many_cpus
> [   14.805964]     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   14.805964]     Expected IS_ERR(bp) to be false, but is true
> [   14.822662]     not ok 3 test_one_task_on_all_cpus
> [   14.836897]     # test_two_tasks_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   14.836897]     Expected IS_ERR(bp) to be false, but is true
> [   14.869770]     not ok 4 test_two_tasks_on_all_cpus
> [   14.913412]     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   14.913412]     Expected IS_ERR(bp) to be false, but is true
> [   14.929852]     not ok 5 test_one_task_on_one_cpu
> [   14.939676]     # test_one_task_mixed: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   14.939676]     Expected IS_ERR(bp) to be false, but is true
> [   14.953670]     not ok 6 test_one_task_mixed
> [   14.964403]     # test_two_tasks_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   14.964403]     Expected IS_ERR(bp) to be false, but is true
> [   14.997262]     not ok 7 test_two_tasks_on_one_cpu
> [   15.012825]     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   15.012825]     Expected IS_ERR(bp) to be false, but is true
> [   15.045472]     not ok 8 test_two_tasks_on_one_all_cpus
> [   15.070033]     # test_task_on_all_and_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [   15.070033]     Expected IS_ERR(bp) to be false, but is true
> [   15.077092]     not ok 9 test_task_on_all_and_one_cpu
>
> ---
> arm64:virt:
>
> [    7.753199]     ok 2 test_many_cpus
> [    7.766356]     # test_one_task_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [    7.766356]     Expected IS_ERR(bp) to be false, but is true
> [    7.775897]     not ok 3 test_one_task_on_all_cpus
> [    7.786604]     # test_two_tasks_on_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [    7.786604]     Expected IS_ERR(bp) to be false, but is true
> [    7.793878]     not ok 4 test_two_tasks_on_all_cpus
> [    7.799954]     # test_one_task_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [    7.799954]     Expected IS_ERR(bp) to be false, but is true
> [    7.811446]     not ok 5 test_one_task_on_one_cpu
> [    7.823706]     # test_one_task_mixed: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [    7.823706]     Expected IS_ERR(bp) to be false, but is true
> [    7.838892]     not ok 6 test_one_task_mixed
> [    7.843594]     # test_two_tasks_on_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [    7.843594]     Expected IS_ERR(bp) to be false, but is true
> [    7.862087]     not ok 7 test_two_tasks_on_one_cpu
> [    7.869706]     # test_two_tasks_on_one_all_cpus: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [    7.869706]     Expected IS_ERR(bp) to be false, but is true
> [    7.874499]     not ok 8 test_two_tasks_on_one_all_cpus
> [    7.878321]     # test_task_on_all_and_one_cpu: ASSERTION FAILED at kernel/events/hw_breakpoint_test.c:70
> [    7.878321]     Expected IS_ERR(bp) to be false, but is true
> [    7.894138]     not ok 9 test_task_on_all_and_one_cpu
> [    7.894501] # hw_breakpoint: pass:2 fail:7 skip:0 total:9
> [    7.894911] # Totals: pass:2 fail:7 skip:0 total:9
>
> ---
> loongarch:
>
> [    7.327439]     ok 2 test_many_cpus
> [    7.330144] ------------[ cut here ]------------
> [    7.330849] WARNING: CPU: 1 PID: 87 at kernel/events/hw_breakpoint_test.c:49 test_one_task_on_all_cpus+0x204/0x210

