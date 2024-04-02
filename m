Return-Path: <linux-kernel+bounces-128026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCC289551D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924A0284134
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF6C81721;
	Tue,  2 Apr 2024 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFfbQ9oF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55DA60279
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063972; cv=none; b=XYnEO6ebLeQcVylsLXcqiUpIud3kAjz+2KhgT+2G8JjpNVbRL/bFSdZHQRXGj2CcQMhKNxz5ETSytFvQeYxfrzLTUN1m1h3xpE76afJx32N6fO3hWKcUyFZgJagk4RvvGuvTRtli+baI9DojeQc+BGaryJul9KweMPcVFl3zBJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063972; c=relaxed/simple;
	bh=HSrh7OQUagdQP/I1BKUPujeKyaLpFjrOfOThuODgUt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kFOyXUCCxzJl/QO637KCji9sHwtIb5a3EZRYcgwCsT+yR1jqCRXHKSzGooAjSigGQaxusfZxieY1JEO6pQ/nd/xArlUkWTG57lAxqQl6DJLz4HG5FfoOXXmnt1o5p/18KalvSKbj0t1zlp1n5ix9e91F0C4vgTBLil57ECNEvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFfbQ9oF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31957C433F1;
	Tue,  2 Apr 2024 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712063972;
	bh=HSrh7OQUagdQP/I1BKUPujeKyaLpFjrOfOThuODgUt0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AFfbQ9oFDJPX0tUP4l0IYbN/pB3/ZQyA9/Ib2vBIOzYv+lyIaystfw2fmT/5lIcMa
	 82FLn5nxcU+9kuLo6izOS+nQ6ulZAhqtHJInG/djbnImRMRv2MDLv7yBLKEX98K5rh
	 xe5guAotmTmQ86zsxcFHNRSRwdk/+kZP0UISHQVFAaLn9svLiCvzsVn/H+e4OD7rbW
	 NtUE17cp2T/yAhp2nG6eLnc2x/fgTE5CVmhL1w9TiCnu6mPgxfzSTWsqcbR0Ne3KqC
	 FKLGNV0xLPABH7JE4dOBrtPCGoXXZiDOvLv0uiTq9eoL4Q6Mi0x3v4taag9fVCZTnF
	 Ehjiqydw92pdA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
Cc: puranjay12@gmail.com
Subject: Re: [PATCH 1/2] riscv: stacktrace: use arch_stack_walk() in place
 of walk_stackframe
In-Reply-To: <20240328184020.34278-2-puranjay12@gmail.com>
References: <20240328184020.34278-1-puranjay12@gmail.com>
 <20240328184020.34278-2-puranjay12@gmail.com>
Date: Tue, 02 Apr 2024 15:19:29 +0200
Message-ID: <87zfubrjfi.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> Currently, dump_backtrace(), __get_wchan(), and perf_callchain_kernel()
> directly call walk_stackframe(). Make then call arch_stack_walk() which
> is a wrapper around walk_stackframe() and make walk_stackframe() static.
>
> This allows making changes to walk_stackframe() without disturbing the
> users of arch_stack_walk() which is the exposed function.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/riscv/include/asm/stacktrace.h |  2 --
>  arch/riscv/kernel/perf_callchain.c  |  2 +-
>  arch/riscv/kernel/stacktrace.c      | 26 ++++++++++++++------------
>  3 files changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm=
/stacktrace.h
> index b1495a7e06ce6..32213e37c379f 100644
> --- a/arch/riscv/include/asm/stacktrace.h
> +++ b/arch/riscv/include/asm/stacktrace.h
> @@ -11,8 +11,6 @@ struct stackframe {
>  	unsigned long ra;
>  };
>=20=20
> -extern void notrace walk_stackframe(struct task_struct *task, struct pt_=
regs *regs,
> -				    bool (*fn)(void *, unsigned long), void *arg);
>  extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tas=
k,
>  			   const char *loglvl);
>=20=20
> diff --git a/arch/riscv/kernel/perf_callchain.c b/arch/riscv/kernel/perf_=
callchain.c
> index 3348a61de7d99..c023e0b1eb814 100644
> --- a/arch/riscv/kernel/perf_callchain.c
> +++ b/arch/riscv/kernel/perf_callchain.c
> @@ -74,5 +74,5 @@ static bool fill_callchain(void *entry, unsigned long p=
c)
>  void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
>  			   struct pt_regs *regs)
>  {
> -	walk_stackframe(NULL, regs, fill_callchain, entry);
> +	arch_stack_walk(fill_callchain, entry, NULL, regs);
>  }
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 64a9c093aef93..e28f7b2e4b6a6 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -18,8 +18,9 @@
>=20=20
>  extern asmlinkage void ret_from_exception(void);
>=20=20
> -void notrace walk_stackframe(struct task_struct *task, struct pt_regs *r=
egs,
> -			     bool (*fn)(void *, unsigned long), void *arg)
> +static __always_inline void
> +walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> +		bool (*fn)(void *, unsigned long), void *arg)

Really a nit, but please try to keep the return value/linkage/function
name on one line if possible.

>  {
>  	unsigned long fp, sp, pc;
>  	int level =3D 0;
> @@ -76,8 +77,9 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>=20=20
>  #else /* !CONFIG_FRAME_POINTER */
>=20=20
> -void notrace walk_stackframe(struct task_struct *task,
> -	struct pt_regs *regs, bool (*fn)(void *, unsigned long), void *arg)
> +static __always_inline void
> +walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> +		bool (*fn)(void *, unsigned long), void *arg)

..and here.


Bj=C3=B6rn

