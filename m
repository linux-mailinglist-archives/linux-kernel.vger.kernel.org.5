Return-Path: <linux-kernel+bounces-142775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D1C8A2FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD171C23EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB4685931;
	Fri, 12 Apr 2024 13:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8b90VHG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465B1E542;
	Fri, 12 Apr 2024 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930121; cv=none; b=AtYYeC2yvzbziGeR/NT+HNar4ufSvEgwWtxtVfOWkHU4ZwpYgRVMqjvdHdwhso5BFOaDRUnowgsCIL+qbiD385pr6CtVBoUEEiMdjOxExUzHM9oL+yVqb94JVY+tgR96I6K02fW9wRxbmA6nEcpyWGV+uifRw6OVyo75xUAzRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930121; c=relaxed/simple;
	bh=6TmX4w4nn9aEsWZzU+YqQ0aoR97tm4JTGPuVtWmpvk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPY5myU2p0h5RuCRGGhL9av7MK/H7Ebr/bdDHNAArV4udk+MM+hXQxHiXGJYuCA+itVY0QdLSBuC37NWJf1OLjQyhiDor1uzai9jzEAEmaCVe1WaIIcsZDtfPNFnLnT1V4NqrQJe7zbttDDwnTWbFJsPp0fWh800nCgLwf1wpZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8b90VHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4964EC113CC;
	Fri, 12 Apr 2024 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712930120;
	bh=6TmX4w4nn9aEsWZzU+YqQ0aoR97tm4JTGPuVtWmpvk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8b90VHG3dFi6r7H4peNaQ7XyuyXMW7KTbXYe1ETTnZez/mDTaliiN7Zy2Lf/9vGG
	 PI5zvovIwRO41dnkMHiJI8UCuvN7FBtIhTgaBTNoTgrLIp9hbJYgOowoOqel3MSN/1
	 D/XOGuTwT7ZVJVjOg55lfvt90KjlWNIxwS+UZAZMOgSoTKXSt11M03H12qL7bkkH+L
	 cT27lKJydShJqHAR7i6W09q4n8LFB7kbt8D+1M2p4CiXjXQj2zR3l4Lnf7lv1gWY3s
	 umsKiPX9Q7meJZW2tlO8jstSeQk/vINPne/Iv2b/spbWDA+hO2p6F6abjHkYhHFRGf
	 Oig6PwAnFDe4A==
Date: Fri, 12 Apr 2024 14:55:13 +0100
From: Will Deacon <will@kernel.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Misono Tomohiro <misono.tomohiro@fujitsu.com>,
	Chen-Yu Tsai <wens@csie.org>, Stephen Boyd <swboyd@chromium.org>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: smp: smp_send_stop() and crash_smp_send_stop()
 should try non-NMI first
Message-ID: <20240412135513.GA28004@willie-the-truck>
References: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207170251.1.Id4817adef610302554b8aa42b090d57270dc119c@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Doug,

I'm doing some inbox Spring cleaning!

On Thu, Dec 07, 2023 at 05:02:56PM -0800, Douglas Anderson wrote:
> When testing hard lockup handling on my sc7180-trogdor-lazor device
> with pseudo-NMI enabled, with serial console enabled and with kgdb
> disabled, I found that the stack crawls printed to the serial console
> ended up as a jumbled mess. After rebooting, the pstore-based console
> looked fine though. Also, enabling kgdb to trap the panic made the
> console look fine and avoided the mess.
>
> After a bit of tracking down, I came to the conclusion that this was
> what was happening:
> 1. The panic path was stopping all other CPUs with
>    panic_other_cpus_shutdown().
> 2. At least one of those other CPUs was in the middle of printing to
>    the serial console and holding the console port's lock, which is
>    grabbed with "irqsave". ...but since we were stopping with an NMI
>    we didn't care about the "irqsave" and interrupted anyway.
> 3. Since we stopped the CPU while it was holding the lock it would
>    never release it.
> 4. All future calls to output to the console would end up failing to
>    get the lock in qcom_geni_serial_console_write(). This isn't
>    _totally_ unexpected at panic time but it's a code path that's not
>    well tested, hard to get right, and apparently doesn't work
>    terribly well on the Qualcomm geni serial driver.
> 
> It would probably be a reasonable idea to try to make the Qualcomm
> geni serial driver work better, but also it's nice not to get into
> this situation in the first place.
> 
> Taking a page from what x86 appears to do in native_stop_other_cpus(),
> let's do this:
> 1. First, we'll try to stop other CPUs with a normal IPI and wait a
>    second. This gives them a chance to leave critical sections.
> 2. If CPUs fail to stop then we'll retry with an NMI, but give a much
>    lower timeout since there's no good reason for a CPU not to react
>    quickly to a NMI.
> 
> This works well and avoids the corrupted console and (presumably)
> could help avoid other similar issues.
> 
> In order to do this, we need to do a little re-organization of our
> IPIs since we don't have any more free IDs. We'll do what was
> suggested in previous conversations and combine "stop" and "crash
> stop". That frees up an IPI so now we can have a "stop" and "stop
> NMI".
> 
> In order to do this we also need a slight change in the way we keep
> track of which CPUs still need to be stopped. We need to know
> specifically which CPUs haven't stopped yet when we fall back to NMI
> but in the "crash stop" case the "cpu_online_mask" isn't updated as
> CPUs go down. This is why that code path had an atomic of the number
> of CPUs left. We'll solve this by making the cpumask into a
> global. This has a potential memory implication--with NR_CPUs = 4096
> this is 4096/8 = 512 bytes of globals. On the upside in that same case
> we take 512 bytes off the stack which could potentially have made the
> stop code less reliable. It can be noted that the NMI backtrace code
> (lib/nmi_backtrace.c) uses the same approach and that use also
> confirms that updating the mask is safe from NMI.

Updating the global masks without any synchronisation feels broken though:

> @@ -1085,77 +1080,75 @@ void smp_send_stop(void)
>  {
>  	unsigned long timeout;
>  
> -	if (num_other_online_cpus()) {
> -		cpumask_t mask;
> +	/*
> +	 * If this cpu is the only one alive at this point in time, online or
> +	 * not, there are no stop messages to be sent around, so just back out.
> +	 */
> +	if (num_other_online_cpus() == 0)
> +		goto skip_ipi;
>  
> -		cpumask_copy(&mask, cpu_online_mask);
> -		cpumask_clear_cpu(smp_processor_id(), &mask);
> +	cpumask_copy(to_cpumask(stop_mask), cpu_online_mask);
> +	cpumask_clear_cpu(smp_processor_id(), to_cpumask(stop_mask));

I don't see what prevents multiple CPUs getting in here concurrently and
tripping over the masks. x86 seems to avoid that with an atomic
'stopping_cpu' variable in native_stop_other_cpus(). Do we need something
similar?

Apart from that, I'm fine with the gist of the patch.

Will

