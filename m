Return-Path: <linux-kernel+bounces-97217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6D187671E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683DA28182D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE58C1DFC5;
	Fri,  8 Mar 2024 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7xotcQe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007254C90;
	Fri,  8 Mar 2024 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910908; cv=none; b=lZ5TmueOgsruyic4k25dwrljd+yBzLJEZGDfL/BGjc60SDvp7WBUAKpUlJEktUam1iHhPXfwXNVmYR/XuSiXXiE4qpBjyF/XMrh7L7HSw5YBJ+8zAkK0VSpl7WhoBEpZYIkzbf+D6Pw3cZMmhh6IeDd1bfoYvc/05NlIvoNpy2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910908; c=relaxed/simple;
	bh=kiBG6NDg0mdz/VQTJh0JeyINO/3FNBUFPbEEfObBu1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jorP+mDE7ag5AlVwwpMTHOUl43kpS6siCfg/8NzRgwdKtA8b+UTer4Ug+QrxTZaC3JJwT72JtxSRiUmfzm8KNOdmsJw6LdQqxLov9qh6/PkWxUs3xcyeDzUYjvYbL+WLAmGHrHW0e21hILGTJLmnNjFoRnkLIQVRdCxr1jaXW2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7xotcQe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14120C433F1;
	Fri,  8 Mar 2024 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709910907;
	bh=kiBG6NDg0mdz/VQTJh0JeyINO/3FNBUFPbEEfObBu1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D7xotcQe3A04Jva6aO95z5uwgSua5Kh8NIKGlm9gMf8NZn7Lh2SXPv8O+9Q/ctBbX
	 SE5/1uOnYkir0I8D3mMkxOy4240pGsl4Vlpg8NiFLkRgtw7thX5S2gyWytXw4zfllB
	 96Hd6aUc6P+yJGcvxlNfd3p1oKPIrfq/N+TVVGiDU3ute21NHvlP6DOvfQu7NrvxfH
	 +AYKncrCxuNeZnIdyIIQXlobvX4Mg+h5ugyQ/xg5ighezsIqijXzLB3SwuEtHfIuqh
	 in9lVWw+zzvQCPXPtcOaJVn2T+sOBMbEF4YxGPZTTZjzcmGpNvFME/2OF2jXNvKn3h
	 05Nh1GxfmGPOA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Sami Tolvanen <samitolvanen@google.com>,
 Guo Ren <guoren@kernel.org>, Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Deepak Gupta <debug@rivosinc.com>, Sia Jee Heng
 <jeeheng.sia@starfivetech.com>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Song
 Shuai <suagrfillet@gmail.com>, =?utf-8?Q?Cl=C3=A9ment_L=C3=A9ger?=
 <cleger@rivosinc.com>, Al
 Viro <viro@zeniv.linux.org.uk>, Jisheng Zhang <jszhang@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
In-Reply-To: <CANk7y0jpKb8XUycKxHbsrJGEWcTvVDYFjM+A2VUe0JeZ2Y-Zbw@mail.gmail.com>
References: <20240306165904.108141-1-puranjay12@gmail.com>
 <87ttlhdeqb.fsf@all.your.base.are.belong.to.us>
 <CANk7y0gbQdYw0V+CEv-z8wFGXnki8KSn4c8+i0iZ1UFNCg7wJQ@mail.gmail.com>
 <87jzmdowp4.fsf@all.your.base.are.belong.to.us>
 <CANk7y0jpKb8XUycKxHbsrJGEWcTvVDYFjM+A2VUe0JeZ2Y-Zbw@mail.gmail.com>
Date: Fri, 08 Mar 2024 16:15:04 +0100
Message-ID: <87edckkb5z.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Puranjay Mohan <puranjay12@gmail.com> writes:

>> Now, I think a better approach for RISC-V would be implementing what x86
>> has (arch_ftrace_update_trampoline()), rather than CALL_OPS for RISC-V.
>>
>> Thoughts?
>
> I am going to spin some patches for implementing
> arch_ftrace_update_trampoline() for
> RISC-V, then we can compare the two approaches and see which is
> better. But I agree
> that arch_ftrace_update_trampoline() is a better approach given that
> we can jump anywhere
> with auipc/jalr.

Yup, and the text size wont blow up.


Cheers,
Bj=C3=B6rn

