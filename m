Return-Path: <linux-kernel+bounces-110624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18EE886163
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101861C220D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED46134439;
	Thu, 21 Mar 2024 20:00:22 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9301F13442D;
	Thu, 21 Mar 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051221; cv=none; b=q42QORF/wlBoIDnmXFS61tWX/j4eMzGra9ChkqmvAPvBaWKWwBD0elS9efmqoUPCAaN2wjJ50vA/7ehYWRqLK95AcEQr9JWwhT94HqlQx7JaTd71X++vJwI56HP/UM8GWM6mTIihh8p4ZEoz+6jfcxyOkPpuuwJ9DOofLfX4e+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051221; c=relaxed/simple;
	bh=CtdoVQnUUB1yzk4xQkmuGvVDOzJhQ5TBfb/YgqcA5hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VElpFQL2kbp6IJFTEPVw3ggQoYhVY+Hl4jfJy4MVtaXPu+rYqOZNnrtHw4zp8wXUNXCoslDjdH+BREjdnpLPngNkKJtLACcGWjXUDTudDu7jK3l2SUxQfhmef/oUySABPjjsySobgxXUJzgv7ohSnJDc9JIiIQIiwEV0D5hX4vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1219CC433C7;
	Thu, 21 Mar 2024 20:00:18 +0000 (UTC)
Date: Thu, 21 Mar 2024 16:02:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Bj\"orn T\"opel" <bjorn@kernel.org>, Puranjay Mohan
 <puranjay12@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Masami
 Hiramatsu <mhiramat@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, "Bj\"orn T\"opel" <bjorn@rivosinc.com>,
 Song Shuai <suagrfillet@gmail.com>, Cl'ement L'eger <cleger@rivosinc.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
Message-ID: <20240321160246.2e28cf9d@gandalf.local.home>
In-Reply-To: <ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
References: <20240306165904.108141-1-puranjay12@gmail.com>
	<87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
	<ZfBbxPDd0rz6FN2T@FVFF77S0Q05N>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 13:42:28 +0000
Mark Rutland <mark.rutland@arm.com> wrote:

> There are ways around that, but they're complicated and/or expensive, e.g.
> 
> * Use a sequence of multiple patches, starting with replacing the JALR with an
>   exception-generating instruction with a fixup handler, which is sort-of what
>   x86 does with UD2. This may require multiple passes with
>   synchronize_rcu_tasks() to make sure all threads have seen the latest
>   instructions, and that cannot be done under stop_machine(), so if you need
>   stop_machine() for CMODx reasons, you may need to use that several times with
>   intervening calls to synchronize_rcu_tasks().

Just for clarification. x86 doesn't use UD2 for updating the call sites. It
uses the breakpoint (0xcc) operation. This is because x86 instructions are
not a fixed size and can cross cache boundaries, making updates to text
sections dangerous as another CPU may get half the old instruction and half
the new one!

Thus, when we have:

	0f 1f 44 00 00		nop

and want to convert it to:

	e8 e7 57 07 00		call ftrace_caller

We have to first add a breakpoint:

	cc 17 44 00 00

Send an IPI to all CPUs so that they see the breakpoint (IPI is equivalent
to a memory barrier).

We have a ftrace breakpoint handler that will look at the function that the
breakpoint happened on. If it was a nop, it will just skip over the rest of
the instruction, and return from the break point handler just after the
"cc 17 44 00 00". If it's supposed to be a function, it will push the
return to after the instruction onto the stack, and return from the break
point handler to ftrace_caller. (Although things changed a little since
this update is now handled by text_poke_bp_batch()).

Then it changes the rest of the instruction:

	cc e7 57 07 00

Sends out another IPI to all CPUs and removes the break point with the new
instruction op.

	e8 e7 57 07 00

and now all the callers of this function will call the ftrace_caller.

-- Steve

