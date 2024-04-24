Return-Path: <linux-kernel+bounces-156653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398548B064A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 722DFB2693C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7B7158DC1;
	Wed, 24 Apr 2024 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IrxaxZu0"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D3158D79;
	Wed, 24 Apr 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713951792; cv=none; b=NvJ1ax9Zz5eYZNiEFIhxv6AZp7whoq8k7iMsf9ZuQWanY+2j4cHKOl1UqlAGofemfFh/iInmv7fyCM3o42myiJD43w11z4Q7pxPZSOhdcfKjlSo3kQLgQJfZVPd7oB0UTVHDYriFj5CYTU3pVCNyDO+bxJWUnE/V5rbYkQd06NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713951792; c=relaxed/simple;
	bh=/65etkBmGsEVLl5U3yOh0Ou1arON2z5fXAP3GvQqTuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn85j7rB4j2BzifVYZJYIdwGej0Oo/237B1xe3Vl/Wh8PAyS44krbup4awEx8WcQTO9lkRWh6xw851hitEqkejHdDOnCdNDZV7S+aJrFC0lMYMqbxGUNinygTRnk2sUijRoZZFaoW+Di9hDIgtNBotQ6QApaiKhucRY/TClrPug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IrxaxZu0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=4/+2atuMXw1YbIUIXPrW9e5nnOBu2ouFfOljApBRNMk=; b=IrxaxZu0mztblG5X2rVAHfhx5L
	HKUiLnRYlZsRor4VDhGBuxb+hHebhQ6/592Hbh9nuaauKQVN6HRRurLS8RxOir2nAKIFxUR55d5ps
	6Th5U79HakGLbeM5AiCdJMkgMsoy37ILuTAOxPrvSZ/emPKq4wHWGe+d02A/3julAdl7Ir3muO+bn
	8m1vQG0MHOemDUvOk8OQiUXrXYLSgwy/Im8ewxI8lYuu6b1eJVctstYfURgnfOoyG4dJZXTsVOqvv
	9YXi+tZkqvPhbgKIV0XCHqi3GA8XyVNHfuNmC19n3LF4ga66Ilw0H4nzI9JgmEP1lLHij708zRFo+
	v3Sd9+XA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzZ9e-00000000dnn-1Rdk;
	Wed, 24 Apr 2024 09:43:06 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 06D8E30040C; Wed, 24 Apr 2024 11:43:06 +0200 (CEST)
Date: Wed, 24 Apr 2024 11:43:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Marius Fleischer <fleischermarius@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com, harrisonmichaelgreen@gmail.com
Subject: Re: possible deadlock in __perf_event_task_sched_in
Message-ID: <20240424094305.GT40213@noisy.programming.kicks-ass.net>
References: <CAJg=8jw=5vKSE8ibuim0uFKQq=sA3sWULqM5auqKNJCq0=kqGg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJg=8jw=5vKSE8ibuim0uFKQq=sA3sWULqM5auqKNJCq0=kqGg@mail.gmail.com>

On Mon, Apr 22, 2024 at 11:44:27AM -0700, Marius Fleischer wrote:
> Hi,
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
> 
> We found this report (https://lkml.org/lkml/2021/9/12/333) that seems
> to have a similar but different stack trace. We are unable to tell,
> though, whether it is the same cause. We’d be grateful for your
> advice.

This is just the printk thing sucks again. Some WARN/printk got tripped
in a non-suitable context.


>  _printk+0xba/0xed kernel/printk/printk.c:2299
>  ex_handler_msr.cold+0xb7/0x147 arch/x86/mm/extable.c:90
>  fixup_exception+0x973/0xbb0 arch/x86/mm/extable.c:187
>  __exc_general_protection arch/x86/kernel/traps.c:601 [inline]
>  exc_general_protection+0xed/0x2f0 arch/x86/kernel/traps.c:562
>  asm_exc_general_protection+0x22/0x30 arch/x86/include/asm/idtentry.h:562
> RIP: 0010:__wrmsr arch/x86/include/asm/msr.h:103 [inline]
> RIP: 0010:native_write_msr arch/x86/include/asm/msr.h:154 [inline]
> RIP: 0010:wrmsrl arch/x86/include/asm/msr.h:271 [inline]
> RIP: 0010:__x86_pmu_enable_event
> arch/x86/events/intel/../perf_event.h:1120 [inline]
> RIP: 0010:intel_pmu_enable_event+0x2d9/0xff0 arch/x86/events/intel/core.c:2694
> Code: ea 03 49 81 cc 00 00 40 00 4d 21 f4 80 3c 02 00 0f 85 5b 0c 00
> 00 44 8b ab 70 01 00 00 4c 89 e2 44 89 e0 48 c1 ea 20 44 89 e9 <0f> 30
> 0f 1f 44 00 00 e8 1b 32 75 00 48 83 c4 20 5b 5d 41 5c 41 5d
> RSP: 0018:ffffc900115af348 EFLAGS: 00010002
> RAX: 0000000000530000 RBX: ffff888019dd6a50 RCX: 0000000000000188
> RDX: 0000000000000002 RSI: ffffffff81029464 RDI: ffff888019dd6bc0
> RBP: 0000000000000000 R08: 0000000000000001 R09: ffff888063e22ab7
> R10: 0000000000000000 R11: 0000000000000001 R12: 0000000200530000
> R13: 0000000000000188 R14: ffffffffffffffff R15: ffff888019dd6bb0
>  x86_pmu_start+0x1cc/0x270 arch/x86/events/core.c:1520
>  x86_pmu_enable+0x481/0xdf0 arch/x86/events/core.c:1337
>  perf_pmu_enable kernel/events/core.c:1243 [inline]
>  perf_pmu_enable kernel/events/core.c:1239 [inline]

Most likely your VM is wonky and perf tries to poke an MSR that either
doesn't exist or isn't emulated properly, who knows.

