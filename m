Return-Path: <linux-kernel+bounces-56908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C29F84D132
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3A928AB01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7834183CC0;
	Wed,  7 Feb 2024 18:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmkKjbbS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8D5405E6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707330621; cv=none; b=uy0eQSCzdGTdL0Nn5OOIp98U1lb7JPZHYtL2VuFO/CaEWQf/If4QYfNurPrarGFdZIsXX5PmdcyBAx3tMe0mcsfFzDex70isGT1RPXd9Nv1FfGN+akKBP2OWFLBXr2XqHUuMeHGyHvf3bP2Ye3fDHcQ6UZmYTzrqvrxbtBKFIco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707330621; c=relaxed/simple;
	bh=31Feqw1Sdjw8fNuzWjApovGsnb7lwGLdBv6L9jjAxYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3dwccE/iBhHgnKgkSPMTcSgSPJtqzMK0H2T5hBm1TbRv+jDJz+NZJEI8y2QleZCdlChaFcwm0NuivS1xmthkYrizjZezqUXoWnl4k9QeE/RkuNbhT7rKYfNsx1iv/Je2QBE5Md1ypopouqwzLYP+ti25P1+wwATLSJY1LluBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmkKjbbS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AA5C433C7;
	Wed,  7 Feb 2024 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707330621;
	bh=31Feqw1Sdjw8fNuzWjApovGsnb7lwGLdBv6L9jjAxYA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=rmkKjbbS1E7BTLYe7urgASQYOkfbPtLvEHma1S2wP5JPa6HO2uZtQS+UqGrROWR+L
	 Hh5VKrpRRiw7qyc5tjOommNJ1/JqmqM1A/NxPon+875RyasmexdjO8IvKzF9g7qNGC
	 18tj06m9wFGVAqKTRLzWHT1SRA7hrsdvlYZgIqhtwMsliY0sc6L8S2MIIOO1+82t57
	 AvmclAA3Hi4X1FoLaoZIcFGeSSZkm38kVrgaftCAk1sTbQ4WBLWlNf3DxJbxz6hSZS
	 EZkb7jPR/Tvn4T9LYpNhunE6e9BC7Y9qRC0TIHt+M05lGhDyU07p+a1eWjOJ5zIfja
	 MRoEwwCgBe8cQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 706F5CE0DDB; Wed,  7 Feb 2024 10:30:17 -0800 (PST)
Date: Wed, 7 Feb 2024 10:30:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, leit@meta.com,
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/nmi: Fix "in NMI handler" check
Message-ID: <c128c9b0-6bfa-4d62-9bc9-1215ee12ce2b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240207165237.1048837-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207165237.1048837-1-leitao@debian.org>

On Wed, Feb 07, 2024 at 08:52:35AM -0800, Breno Leitao wrote:
> Commit 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are
> ignored") creates a super nice framework to diagnose NMIs.
> 
> Every time nmi_exc() is called, it increments a per_cpu counter
> (nsp->idt_nmi_seq). At its exit, it also increments the same counter.
> Looking at this counter, you can see how many times that function was
> called (dividing by 2), and, if the function is still being executed, by
> checking the idt_nmi_seq's last bit.
> 
> On the check side (nmi_backtrace_stall_check()), that variable is
> queried to check if the NMI is still being executed, but, there is a
> mistake in the bitwise operation. That code wants to check if the last
> bit of the idt_nmi_seq is set or not, but, does the opposite, and check
> for all the other bits, which will always be true after the first
> exc_nmi() executed successfully.
> 
> This appends the misleading string to the dump "(CPU currently in NMI
> handler function)"
> 
> Fix it by checking the last bit, and if it is set, append the string.
> 
> Fixes: 344da544f177 ("x86/nmi: Print reasons why backtrace NMIs are ignored")
> Signed-off-by: Breno Leitao <leitao@debian.org>

If someone else is taking this:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

(I am queueing it for testing in any case.)

> ---
>  arch/x86/kernel/nmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
> index 17e955ab69fe..6e738ad474dc 100644
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -639,7 +639,7 @@ void nmi_backtrace_stall_check(const struct cpumask *btp)
>  			msgp = nmi_check_stall_msg[idx];
>  			if (nsp->idt_ignored_snap != READ_ONCE(nsp->idt_ignored) && (idx & 0x1))
>  				modp = ", but OK because ignore_nmis was set";
> -			if (nmi_seq & ~0x1)
> +			if (nmi_seq & 0x1)
>  				msghp = " (CPU currently in NMI handler function)";
>  			else if (nsp->idt_nmi_seq_snap + 1 == nmi_seq)
>  				msghp = " (CPU exited one NMI handler function)";
> -- 
> 2.39.3
> 

