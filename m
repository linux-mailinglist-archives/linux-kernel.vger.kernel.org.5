Return-Path: <linux-kernel+bounces-109272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23988170F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908791F236A1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C0F6A8B5;
	Wed, 20 Mar 2024 18:03:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D2D6A8A4;
	Wed, 20 Mar 2024 18:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957838; cv=none; b=WpU9yinbiA6UKETQfGubQ2OHfS0EdsA/NJqY0z6FbiWB2F6ux36C4uM9SrCr9gS5R7hDxNFpGnGciS1AQ+penVFMqE+9Mq1dYmmoQLA6k4E0YmfidXx2KCj/MIL210Ch9fUYvKJH67t3OlnyrZr2dHLk/bGIZPfO+a5p1oGfjHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957838; c=relaxed/simple;
	bh=afr0MOAqLqtv3YfQ4k+Meq+aEdBVU04DiUCM/8TGLhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qluEXuNpcyfKdrOsa3hmnb13RvvfmI93eX8wVlZwvo6iijYBkS8+uDY76L8JaZl2ks77Rm2RjaSsvH6xUMiyLHjGy4J+Da+LaB6ca+8PqNfy4lCZGgnPF9qWvdOFwkz0kswV5R2uvW+FBMLA+nuEjmP/AG7Zs44TT+02fJSqM8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6E01007;
	Wed, 20 Mar 2024 11:04:27 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.34.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19D053F762;
	Wed, 20 Mar 2024 11:03:49 -0700 (PDT)
Date: Wed, 20 Mar 2024 18:03:45 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: =?us-ascii?Q?Bj=22orn_T=22opel?= <bjorn@kernel.org>
Cc: Puranjay Mohan <puranjay12@gmail.com>, Andy Chiu <andy.chiu@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Guo Ren <guoren@kernel.org>,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Sia Jee Heng <jeeheng.sia@starfivetech.com>,
	Bjorn Topel <bjorn@rivosinc.com>,
	Song Shuai <suagrfillet@gmail.com>,
	Cl'ement L'eger <cleger@rivosinc.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jisheng Zhang <jszhang@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Robbin Ehn <rehn@rivosinc.com>
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <ZfslAb_W0Gk-0pmR@FVFF77S0Q05N.cambridge.arm.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
 <8734suqsth.fsf@all.your.base.are.belong.to.us>
 <mb61pplvw6grf.fsf@gmail.com>
 <87zfv0onre.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfv0onre.fsf@all.your.base.are.belong.to.us>

On Thu, Mar 14, 2024 at 04:07:33PM +0100, Bj"orn T"opel wrote:
> After reading Mark's reply, and discussing with OpenJDK folks (who does
> the most crazy text patching on all platforms), having to patch multiple
> instructions (where the address materialization is split over multiple
> instructions) is a no-go. It's just a too big can of worms. So, if we
> can only patch one insn, it's CALL_OPS.
> 
> A couple of options (in addition to Andy's), and all require a
> per-function landing address ala CALL_OPS) tweaking what Mark is doing
> on Arm (given the poor branch range).
> 
> ..and maybe we'll get RISC-V rainbows/unicorns in the future getting
> better reach (full 64b! ;-)).
> 
> A) Use auipc/jalr, only patch jalr to take us to a common
>    dispatcher/trampoline
>   
>  | <func_trace_target_data_8B> # probably on a data cache-line != func .text to avoid ping-pong
>  | ...
>  | func:
>  |   ...make sure ra isn't messed up...
>  |   aupic
>  |   nop <=> jalr # Text patch point -> common_dispatch
>  |   ACTUAL_FUNC
>  | 
>  | common_dispatch:
>  |   load <func_trace_target_data_8B> based on ra
>  |   jalr
>  |   ...
> 
> The auipc is never touched, and will be overhead. Also, we need a mv to
> store ra in a scratch register as well -- like Arm. We'll have two insn
> per-caller overhead for a disabled caller.

Is the AUIPC a significant overhead? IIUC that's similar to Arm's ADRP, and I'd
have expected that to be pretty cheap.

IIUC your JALR can choose which destination register to store the return
address in, and if so, you could leave the original ra untouched (and recover
that in the common trampoline). Have I misunderstood that?

Maybe that doesn't play nicely with something else?

> B) Use jal, which can only take us +/-1M, and requires multiple
>    dispatchers (and tracking which one to use, and properly distribute
>    them. Ick.)
> 
>  | <func_trace_target_data_8B> # probably on a data cache-line != func .text to avoid ping-pong
>  | ...
>  | func:
>  |   ...make sure ra isn't messed up...
>  |   nop <=> jal # Text patch point -> within_1M_to_func_dispatch
>  |   ACTUAL_FUNC
>  | 
>  | within_1M_to_func_dispatch:
>  |   load <func_trace_target_data_8B> based on ra
>  |   jalr
> 
> C) Use jal, which can only take us +/-1M, and use a per-function
>    trampoline requires multiple dispatchers (and tracking which one to
>    use). Blows up text size A LOT.
> 
>  | <func_trace_target_data_8B> # somewhere, but probably on a different cacheline than the .text to avoid ping-ongs
>  | ...
>  | per_func_dispatch
>  |   load <func_trace_target_data_8B> based on ra
>  |   jalr
>  | func:
>  |   ...make sure ra isn't messed up...
>  |   nop <=> jal # Text patch point -> per_func_dispatch
>  |   ACTUAL_FUNC

Beware that with option (C) you'll need to handle that in your unwinder for
RELIABLE_STACKTRACE. If you don't have a symbol for per_func_dispatch (or
func_trace_target_data_8B), PC values within per_func_dispatch would be
symbolized as the prior function/data.

> It's a bit sad that we'll always have to have a dispatcher/trampoline,
> but it's still better than stop_machine(). (And we'll need a fencei IPI
> as well, but only one. ;-))
> 
> Today, I'm leaning towards A (which is what Mark suggested, and also
> Robbin).. Any other options?

Assuming my understanding of JALR above is correct, I reckon A is the nicest
option out of A/B/C.

Mark.

