Return-Path: <linux-kernel+bounces-108598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A8880CC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6938B21B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3A2DF7D;
	Wed, 20 Mar 2024 08:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpHocqaw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7732C698;
	Wed, 20 Mar 2024 08:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922329; cv=none; b=itM0y5aExt/+H269tDMwGSiy+grv6wxS9ofy541DPQMqk869wNdLPMmW38GfULHaqjW6HPF54nj3bsrNGcqSLonas/wwKPFoGlT/KePoiVjYFp5+suXBAnFz0h/cVzsdlri7kdbVh9vE4f0S6O8MP4umOEJLsZ3TBF03mHD6s9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922329; c=relaxed/simple;
	bh=awbQ0Ep7VHcHdIe0ZE07B5fkjUV7A9KmfScsQi612S8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fsqmwo5m+/p9nUjtj0UjE74BbYYJls8rb4AnPEolUS5zigzVRxfo6Gd3M6YoxNgax0o4jWK3LtNlI2nZAnaUEvxCxMmCxEFq4lnMaIomiqVIzNEjydJUgD+P/DzEUuPc2tW0Sgbs1aqhl9HXLgyax8dyWelL0K162z9n1psDODI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpHocqaw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329F2C433F1;
	Wed, 20 Mar 2024 08:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710922329;
	bh=awbQ0Ep7VHcHdIe0ZE07B5fkjUV7A9KmfScsQi612S8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mpHocqawgkxvcZXo7zXtsqCOQXdAo34GU9lsZF2Vz7dRhtR76b8DS/V9AxuZSfl3A
	 PO1/2mIsFQcfohNvROykb5bJj1GeBCH04G/l+nAox6/ybpSxfAtY2s/LOmANvKvSqf
	 ec0CxXkJ31SXAfdXUtPrwGjArtG5IskfC3SJwkfti+3iNxgXKFdXvo5JoqH1EeN+C9
	 7Nrb1g+BXs2+OUuCy/bYlDMQa/cPxWH15PqbEfUwR+IdA/nZKz9RYT3JU8OkugU6bi
	 RBbTQgDQRk+GURtX7zjNZwFMU9lgupD6U6ly+a++w8HwYrhF7aH62FnITWJG68Wdyu
	 hFOefrxjfllEA==
Date: Wed, 20 Mar 2024 17:12:03 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinghao Jia <jinghao7@illinois.edu>
Cc: Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Qiang
 Zhang <zzqq0103.hey@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Peter
 Zijlstra <peterz@infradead.org>, x86@kernel.org
Subject: Re: [PATCH v2] kprobes/x86: Use copy_from_kernel_nofault() to read
 from unsafe address
Message-Id: <20240320171203.d493d214dea91a18114994cd@kernel.org>
In-Reply-To: <12453ce8-0b78-4c1c-9aca-de4cc366e3e1@illinois.edu>
References: <20240315000753.a448251fce0291e041f76c13@kernel.org>
	<171042945004.154897.2221804961882915806.stgit@devnote2>
	<fb6919c5-8acf-4ee3-8fd2-1d483b274867@illinois.edu>
	<20240316224630.01bd6b91938720f5083e0d07@kernel.org>
	<12453ce8-0b78-4c1c-9aca-de4cc366e3e1@illinois.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Mar 2024 10:53:59 -0500
Jinghao Jia <jinghao7@illinois.edu> wrote:

> 
> 
> On 3/16/24 08:46, Masami Hiramatsu (Google) wrote:
> > On Thu, 14 Mar 2024 18:56:35 -0500
> > Jinghao Jia <jinghao7@illinois.edu> wrote:
> > 
> >> On 3/14/24 10:17, Masami Hiramatsu (Google) wrote:
> >>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >>>
> >>> Read from an unsafe address with copy_from_kernel_nofault() in
> >>> arch_adjust_kprobe_addr() because this function is used before checking
> >>> the address is in text or not. Syzcaller bot found a bug and reported
> >>> the case if user specifies inaccessible data area,
> >>> arch_adjust_kprobe_addr() will cause a kernel panic.
> >>
> >> IMHO there is a check on the address in kallsyms_lookup_size_offset to see
> >> if it is a kernel text address before arch_adjust_kprobe_addr is invoked.
> > 
> > Yeah, kallsyms does not ensure the page (especially data) exists.
> > 
> >>
> >> The call chain is:
> >>
> >> register_kprobe()
> >>   _kprobe_addr()
> >>     kallsyms_lookup_size_offset() <- check on addr is here
> >>     arch_adjust_kprobe_addr()
> >>
> >> I wonder why this check was not able to capture the problem in this bug
> >> report (I cannot reproduce it locally).
> > 
> > I could reproduce it locally, it tried to access 'Y' data.
> > (I attached my .config) And I ensured that this fixed the problem.
> > 
> > The reproduce test actually tried to access initdata area
> > 
> > ffffffff82fb5450 d __alt_reloc_selftest_addr
> > ffffffff82fb5460 d int3_exception_nb.1
> > ffffffff82fb5478 d tsc_early_khz
> > ffffffff82fb547c d io_delay_override
> > ffffffff82fb5480 d fxregs.0
> > ffffffff82fb5680 d y                    <--- access this
> > ffffffff82fb5688 d x
> > ffffffff82fb56a0 d xsave_cpuid_features
> > ffffffff82fb56c8 d l1d_flush_mitigation
> > 
> > `y` is too generic, so check `io_delay_override` which is on the
> > same page.
> > 
> > $ git grep io_delay_override
> > arch/x86/kernel/io_delay.c:static int __initdata io_delay_override;
> > 
> > As you can see, it is marked as `__initdata`, and the initdata has been
> > freed before starting /init.
> > 
> > ----
> > [    2.679161] Freeing unused kernel image (initmem) memory: 2888K
> > [    2.688731] Write protecting the kernel read-only data: 24576k
> > [    2.691802] Freeing unused kernel image (rodata/data gap) memory: 1436K
> > [    2.746994] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> > [    2.748022] x86/mm: Checking user space page tables
> > [    2.789520] x86/mm: Checked W+X mappings: passed, no W+X pages found.
> > [    2.790527] Run /init as init process
> > ----
> > 
> > So this has been caused because accessing freed initdata.
> 
> Thanks a lot for the explanation! I have confirmed the bug and tested the
> patch with CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT=y (which explicitly marks
> the init pages as not-present after boot).
> 
> Tested-by: Jinghao Jia <jinghao7@illinois.edu>
> 

Thank you for testing!

Regards,
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

