Return-Path: <linux-kernel+bounces-128028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8C895522
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07B01C21E6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B78289C;
	Tue,  2 Apr 2024 13:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZFQ3Dsk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4653260DE9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064005; cv=none; b=scxwwuRyhvGqB1te/dqKLOIzz2txiADg43/VjZW2+eWxkburzR5ubO3Q4zSIgIjdJ0oAalgeu8jUCU+c6FX0EElqPZeL5UuTp7Lu4ZOGWigtgRgHrabM27bju5MSSl6B1d2FZRieljdJK/QtnfTfvULloXxR13G3UI81MlPxu6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064005; c=relaxed/simple;
	bh=uKsjU8/PIj0LW7ebecEKaDRjpVVEPAPWOJqhLvwjBdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=COx+TQalKCY5W5Ty7cmXQMQ+HA0r4tKx6uikn+t2mLSquNGA/C3ifrq61q9zvq0Ifo5EwekVLvZrtmvbnabZ/fBPtdJPZAMmwRx0YGOCn4+bTACA7MTVFo1iPpN0326XuHJQnexz6UmfBf6spI49noiZmAqgZdFU6/vNBjkFXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZFQ3Dsk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57347C433F1;
	Tue,  2 Apr 2024 13:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712064004;
	bh=uKsjU8/PIj0LW7ebecEKaDRjpVVEPAPWOJqhLvwjBdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dZFQ3DskOEKCJJ0pjg1btHzSeMqU5YkkvRkMb7PmvR6XoRk5BdnGWP1ZPPnBsNgfM
	 Av1CEuprICBAeX0wAlhkCPjXl8uRUhu1CZDEIG4674budbSyQlFgEnmDjMAFAMP14P
	 nqqxnetxZv0/0OAny6ddaerzAQQYnEl2pKa8OGzFuCPDf4Oe4FTphJVpSGL17g6oWV
	 Nq7BU1lN+wk/l/6x4ApmMsojReAskjExzqutQ25+eUyZR3mlHf4Z967feBBcCSEHmJ
	 5dYTA121fm+zgKKJ48sHACOTTYAg8Y5Pr/SwKmJJPZltypnS/iqDCc4xlhq63+JB7r
	 +N2z1Y/YT041A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
Cc: puranjay12@gmail.com
Subject: Re: [PATCH 2/2] riscv: stacktrace: make walk_stackframe() more robust
In-Reply-To: <20240328184020.34278-3-puranjay12@gmail.com>
References: <20240328184020.34278-1-puranjay12@gmail.com>
 <20240328184020.34278-3-puranjay12@gmail.com>
Date: Tue, 02 Apr 2024 15:20:01 +0200
Message-ID: <87v84zrjem.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> Currently walk_stackframe() provides only a cookie and the PC to the
> consume_entry function. This doesn't allow the implementation of
> advanced stack walkers that need access to SP and FP as well.
>
> Change walk_stackframe to provide a struct unwind_state to the
> consume_entry function. This unwind_state has all information that is
> available to walk_stackframe. The information provided to the callback
> will not always be live/useful, the callback would be aware of the
> different configurations the information in unwind_state can be.
>
> For example: if CONFIG_FRAME_POINTER is not available, unwind_state->fp
> will always be zero.
>
> This commit doesn't make any functional changes.
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 55 ++++++++++++++++++++++++++++++----
>  1 file changed, 49 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index e28f7b2e4b6a6..92c41c87b267b 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -14,15 +14,26 @@
>=20=20
>  #include <asm/stacktrace.h>
>=20=20
> +struct unwind_state {
> +	unsigned long fp;
> +	unsigned long sp;
> +	unsigned long pc;
> +	struct pt_regs *regs;
> +	struct task_struct *task;
> +};
> +
> +typedef bool (*unwind_consume_fn)(void *cookie, const struct unwind_stat=
e *state);
> +
>  #ifdef CONFIG_FRAME_POINTER
>=20=20
>  extern asmlinkage void ret_from_exception(void);
>=20=20
>  static __always_inline void
>  walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> -		bool (*fn)(void *, unsigned long), void *arg)
> +		unwind_consume_fn fn, void *arg)
>  {
>  	unsigned long fp, sp, pc;
> +	struct unwind_state state;
>  	int level =3D 0;
>=20=20
>  	if (regs) {
> @@ -40,12 +51,17 @@ walk_stackframe(struct task_struct *task, struct pt_r=
egs *regs,
>  		sp =3D task->thread.sp;
>  		pc =3D task->thread.ra;
>  	}
> +	state.task =3D task;
> +	state.regs =3D regs;
>=20=20
>  	for (;;) {
>  		unsigned long low, high;
>  		struct stackframe *frame;
>=20=20
> -		if (unlikely(!__kernel_text_address(pc) || (level++ >=3D 0 && !fn(arg,=
 pc))))
> +		state.sp =3D sp;
> +		state.fp =3D fp;
> +		state.pc =3D pc;
> +		if (unlikely(!__kernel_text_address(pc) || (level++ >=3D 0 && !fn(arg,=
 &state))))
>  			break;
>=20=20
>  		/* Validate frame pointer */
> @@ -64,7 +80,10 @@ walk_stackframe(struct task_struct *task, struct pt_re=
gs *regs,
>  			pc =3D ftrace_graph_ret_addr(current, NULL, frame->ra,
>  						   &frame->ra);
>  			if (pc =3D=3D (unsigned long)ret_from_exception) {
> -				if (unlikely(!__kernel_text_address(pc) || !fn(arg, pc)))
> +				state.sp =3D sp;
> +				state.fp =3D fp;
> +				state.pc =3D pc;
> +				if (unlikely(!__kernel_text_address(pc) || !fn(arg, &state)))
>  					break;
>=20=20
>  				pc =3D ((struct pt_regs *)sp)->epc;
> @@ -79,9 +98,10 @@ walk_stackframe(struct task_struct *task, struct pt_re=
gs *regs,
>=20=20
>  static __always_inline void
>  walk_stackframe(struct task_struct *task, struct pt_regs *regs,
> -		bool (*fn)(void *, unsigned long), void *arg)
> +		unwind_consume_fn fn, void *arg)
>  {
>  	unsigned long sp, pc;
> +	struct unwind_state state;
>  	unsigned long *ksp;
>=20=20
>  	if (regs) {
> @@ -99,9 +119,14 @@ walk_stackframe(struct task_struct *task, struct pt_r=
egs *regs,
>  	if (unlikely(sp & 0x7))
>  		return;
>=20=20
> +	state.task =3D task;
> +	state.regs =3D regs;
> +	state.sp =3D sp;
> +	state.fp =3D 0;
>  	ksp =3D (unsigned long *)sp;
>  	while (!kstack_end(ksp)) {
> -		if (__kernel_text_address(pc) && unlikely(!fn(arg, pc)))
> +		state.pc =3D pc;
> +		if (__kernel_text_address(pc) && unlikely(!fn(arg, &state)))
>  			break;
>  		pc =3D READ_ONCE_NOCHECK(*ksp++) - 0x4;
>  	}
> @@ -109,10 +134,28 @@ walk_stackframe(struct task_struct *task, struct pt=
_regs *regs,
>=20=20
>  #endif /* CONFIG_FRAME_POINTER */
>=20=20
> +struct unwind_consume_entry_data {
> +	stack_trace_consume_fn consume_entry;
> +	void *cookie;
> +};
> +
> +static __always_inline bool
> +arch_unwind_consume_entry(void *cookie, const struct unwind_state *state)

Same comment as patch 1.


Bj=C3=B6rn

