Return-Path: <linux-kernel+bounces-32254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DE9835918
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24D1AB21D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 01:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6146D37E;
	Mon, 22 Jan 2024 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I83vGYs6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA6836B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705886236; cv=none; b=eRy2I8/BwOlNl0IpRlcpGyDU9k9lqzOxdxlv/8gxZUU+OZYWJPoteDAFO5IjAfH0A0cjxS9cl0rvYt3yKHg0rIrF9v2MI51T/3+H3AXcc4db0uV91C/LCuu0mfdhBuEUkXCPSnURM0V61xSuLBEJnI3OfG7Pb7d49aZs4FmHrx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705886236; c=relaxed/simple;
	bh=TZzJ3PfeoH9Vypk8Q8FWe66v67+8djpbIddsghAPqUI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jt+17mXOHYMIcaVn1bIuEw4Xamt7RzqPyeYZRmsoMT+ew8K4KOQuIrrAuz7XXvKcD8MQAO/YKG9zhdrwmMk15nb3YzQrJ2CpbmZRFTh3sQ76loluAVfEh57hl6Obhze+kgmGFX8DrdImzk3y2jB3Ijd4+WiB4DJ0t5elP8kY0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I83vGYs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCFEC433C7;
	Mon, 22 Jan 2024 01:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705886235;
	bh=TZzJ3PfeoH9Vypk8Q8FWe66v67+8djpbIddsghAPqUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I83vGYs6FpJQaFgxfq1mvXxphAoISuVn4rmuEv5ouKPba1FYHtUmdRAqMVmGl8epZ
	 W40UguU6LqIWl7lIi3nyLKvT2IslQcNEe7wDYHHrJ8IB5ORF54Y9HeFTmOzaTTkKQs
	 d1JR6CBoJtwG/MiT8OMneQj92tPPuxvuNYIikuHTFoDW7qAn0bjjwA5ATkDbAlgjnx
	 AaoRXcL2SiG4WgJHqXz6Ymi+POSCtj1IZ827tpfsC4wKMFBI/Bfltn74go+rp/sFLn
	 38iznXW5yhaAhmmdOrQsu6KPymt76xCQZAmdsr/LZo2RL/+NHZ55QROCPhxT84dlEg
	 kFxbYVZ+GU+uA==
Date: Mon, 22 Jan 2024 10:17:10 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, x86@kernel.org, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>, Jinyang
 He <hejinyang@loongson.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH -tip v2] x86/kprobes: Drop removed INT3 handling code
Message-Id: <20240122101710.4a572d31d26940c5e9d02604@kernel.org>
In-Reply-To: <a2517861-cfd4-4ddd-b6b9-faedcd229da8@kernel.org>
References: <166981518895.1131462.4693062055762912734.stgit@devnote3>
	<06cb540e-34ff-4dcd-b936-19d4d14378c9@kernel.org>
	<20240120170517.5cadbc20@rorschach.local.home>
	<20240121112852.381ebd7bf37ea6d2236db9f2@kernel.org>
	<20240121180544.8c663977651d2a18291318d5@kernel.org>
	<f8bbf989-f709-4ceb-af5c-87e1e20de914@kernel.org>
	<20240121103144.4bf735c6@rorschach.local.home>
	<a2517861-cfd4-4ddd-b6b9-faedcd229da8@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Jan 2024 17:20:26 +0100
Matthieu Baerts <matttbe@kernel.org> wrote:

> Hi Steven,
> 
> On 21/01/2024 16:31, Steven Rostedt wrote:
> > On Sun, 21 Jan 2024 16:23:35 +0100
> > Matthieu Baerts <matttbe@kernel.org> wrote:
> > 
> >> Hi Masami, Steven,
> >>
> >> On 21/01/2024 10:05, Masami Hiramatsu (Google) wrote:
> >>> On Sun, 21 Jan 2024 11:28:52 +0900
> >>> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> >>>   
> >>>> On Sat, 20 Jan 2024 17:05:17 -0500
> >>>> Steven Rostedt <rostedt@goodmis.org> wrote:
> >>>>  
> >>>>> On Sat, 20 Jan 2024 18:44:38 +0100
> >>>>> Matthieu Baerts <matttbe@kernel.org> wrote:
> >>>>>  
> >>>>>>
> >>>>>> I'm sorry to reply on a patch that is more than one year old, but in  
> >>>>>
> >>>>> No problem, I've done the same.  
> >>>>
> >>>> Yeah, thanks for reporting! I realized the problem.  
> >>
> >> Thank you both for your quick reply, very useful explanations, analysis
> >> and patch!
> >>
> >> (...)
> >>
> >>> So this another solution is already done. I think we need to add the
> >>> ghost INT3 check in the exc_int3() as follows;
> >>>
> >>> Thank you,
> >>>
> >>> From add8cf7da99cdb096a0d6765b3dc5de9a3ea3019 Mon Sep 17 00:00:00 2001
> >>> From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
> >>> Date: Sun, 21 Jan 2024 17:16:50 +0900
> >>> Subject: [PATCH] x86: Fixup from the removed INT3 if it is unhandled
> >>>
> >>> INT3 is used not only for software breakpoint, but also self modifying
> >>> code on x86 in the kernel. For example, jump_label, function tracer etc.
> >>> Those may not handle INT3 after removing it but not waiting for
> >>> synchronizing CPUs enough. Since such 'ghost' INT3 is not handled by
> >>> anyone because they think it has been removed already.
> >>> Recheck there is INT3 on the exception address and if not, ignore it.
> >>>
> >>> Note that previously kprobes does the same thing by itself, but that is
> >>> not a good location to do that because INT3 is commonly used. Do it at
> >>> the common place so that it can handle all 'ghost' INT3.  
> >>
> >> I just tested it, and I was able to run pings for 3h without any issues!
> >>
> >> While at it, and just to be on the safe side, I also re-run the tests
> >> after having added a "pr_warn()" -- I know, using printk(), especially
> >> when talking to you... but I was not sure what was safe to use at this
> >> place in the code :) -- before returning "true" in the new function you
> >> added, and we can see that the crash is avoided thanks to the new code:
> >>
> >> [   27.422518] traps: crash avoided, addr=18446744071882050317
> >> [   27.426182] traps: crash avoided, addr=18446744071882050317
> >>
> >> [  370.483208] traps: crash avoided, addr=18446744071882075656
> >> [  370.485066] traps: crash avoided, addr=18446744071882075656
> >> [  370.485084] traps: crash avoided, addr=18446744071882075656
> >>
> >> [  592.866416] traps: crash avoided, addr=18446744071882075656
> >> [  592.867937] traps: crash avoided, addr=18446744071882075656
> >>
> >> [  980.988342] traps: crash avoided, addr=18446744071882050317
> >> [  980.989866] traps: crash avoided, addr=18446744071882050317
> >>
> >> (from my VM running with 2 CPU cores)
> >>
> >>
> >> Again, thank you for the fix!
> >>
> >> (Just in case you need it:)
> >>
> >> Tested-by: Matthieu Baerts <matttbe@kernel.org>
> > 
> > The thing is, the bug is with qemu and *not* the kernel. Masami's patch
> > just paper's over the real bug, and worse, if the kernel has a bug
> > that's not doing proper synchronization, the patch will keep it from
> > being detected. So no, I do not think this is the proper solution.
> > 
> > The real problem is that qemu does not seem to be honoring the memory
> > barriers of an interrupt. The reason the code does the ipi's is to
> > force a full memory barrier across all CPUs so that they all see the
> > same memory before going forward to the next step.
> > 
> > My guess is that qemu does not treat the IPI being sent as a memory
> > barrier, and then the CPUs do not see a consistent memory view after
> > the IPIs are sent. That's a bug in qemu!
> > 
> > This should be reported to the qemu community and should be fixed
> > there. In the mean time, feel free to use Masami's patch in your local
> > repo until qemu is fixed, but it should not be added to Linux mainline.
> 
> Thank you for the explanation!
> 
> For QEmu, I'm currently not using a recent version: v6.2.0, while the
> latest one is v8.2.0. I was already suspecting that QEmu could be
> responsible for this issue -- we don't have the issue with KVM, only TCG

Ah, I missed this point. If KVM works well, I agree that this is a qemu
TCG's bug. I guess TCG implementation forgets to serialize CPU when the
IPI comes.

> -- but it looks like it is not that easy to upgrade it: for the CI, we
> use virtme, which doesn't support newer versions. We will switch to
> virtme-ng, upgrade QEmu to a version that is still supported, try to
> reproduce the issue without Masami's patch, and report that to QEmu
> community.

Thanks, and if you need a reference, "Intel SDM Vol3A, 9.1.3 Handling
Self- and Cross-Modifying Code" said that what the other CPU needs to
do is "Execute serializing instruction; (* For example, CPUID
instruction *)" for cross-modifying code. that has been done in
do_sync_core(). Thus this bug should not happen.

Thank you!

> 
> For the time being, the CI will run the tests with Masami's patch.
> 
> Cheers,
> Matt
> -- 
> Sponsored by the NGI0 Core fund.


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

