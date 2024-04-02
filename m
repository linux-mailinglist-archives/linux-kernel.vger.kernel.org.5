Return-Path: <linux-kernel+bounces-128025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CEB889551A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4330A1F2357B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488981721;
	Tue,  2 Apr 2024 13:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D08TMqDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5958360279
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063932; cv=none; b=rC19hskMI/t4CtW8yXQpQ8eNS2rXPqLYMWcEo13DCkbQ93Ut/QPJk2Kk1rgt0+Wo9fWzNTuf8rAh6NXVuiK5c9ayl7xKT1qBF3zpyX7wKu0lTaLm53Hz15wbv6N41cI0tyMv84rggUtVyQEszlY5IzcQweE4zWk4N4YO3+ma744=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063932; c=relaxed/simple;
	bh=jY5//6Du2pTQZWVH0jCz+G3qgjlZ0vRTRA6F/N21xAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gP/d1Jp7Yu62SSW31gSy7xYOq+InCjvro8sz680lHtP8fwDfbt4uTQZH8I9BdXRmVMaxuJpJsB58S1/efCK+vpiyg5SH9r/PVOvBJr+6NG/uvpv2qaYgWYL92SSOkNyBksUEyOno/xcJBNfdMiY8NgBj2cbBFcTPRqYTzsHc0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D08TMqDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD3AC433C7;
	Tue,  2 Apr 2024 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712063931;
	bh=jY5//6Du2pTQZWVH0jCz+G3qgjlZ0vRTRA6F/N21xAM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D08TMqDUO1xmdZLn0nLYMEK8EgL9/rQL8jEl4BTnp/+gVup8uwgXxf/ETYwvAgI+Q
	 etNe0s3f89IhcfIKmeMWRzp6/2abfxbPl/FaJleloRAKL7T+JglpnfBKU73niCkGTD
	 Ihbs9OYCfoeuiQw/Ax+4u5v2ZEZbwS2u9uQSrtwaBBNo+s7vEKV+feON4LMc1q+bc/
	 A0daqzNqniOz4/W9n9XRIwPbOKoY+3/BgUyJmIg8oqqMZ9oKLrbEK+jhE+KgoVg/k5
	 9EWrkV1EltuC/tWXdH5gJd+E5kLa5VGUbk+AtART1SdurDWUQFt7hTvN/YLEZJYN0Y
	 raHLfffNDDuoA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
Cc: puranjay12@gmail.com
Subject: Re: [PATCH 0/2] riscv: ftrace: make stack walk more robust.
In-Reply-To: <20240328184020.34278-1-puranjay12@gmail.com>
References: <20240328184020.34278-1-puranjay12@gmail.com>
Date: Tue, 02 Apr 2024 15:18:48 +0200
Message-ID: <8734s3sy13.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

> The current stack walker in riscv implemented in walk_stackframe() provid=
es
> the PC to a callback function when it unwinds the stacks. This doesn't
> allow implementing stack walkers that need access to more information like
> the frame pointer, etc.
>
> This series makes walk_stackframe() provide a unwinde_state structure to
> callback functions. This structure has all the information that
> walk_stackframe() can provide.
>
> Currently, there are four users of walk_stackframe(): return_address(),
> perf_callchain_kernel(), dump_backtrace(), and __get_wchan(). All of these
> have been converted to use arch_stack_walk() rather than calling
> walk_stackframe() directly.
>
> We need this to implement arch_bpf_stack_walk() that provides a callback
> that needs the FP, SP, and PC. This will be needed for implementing BFP
> exceptions for RISCV.

Hmm, I wonder if it's easier to have these two patches as part of the
BPF exception series, instead of having the dependencies be cross-tree?

> There are no functional changes in this series.
>
> I have tested this by crashing the kernel and looking at the stack trace
> with and without CONFIG_FRAME_POINTER

I have two really minor style nits, but regardless if they're fixed or
not:

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

