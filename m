Return-Path: <linux-kernel+bounces-91902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7624C871821
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32BA928271C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F5B80025;
	Tue,  5 Mar 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOPPu2Rv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA337F7FF;
	Tue,  5 Mar 2024 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709626871; cv=none; b=OcfJncda3fRnp+6YNpKj4yMnwZNN3a+K7+1r5YBA83guGtH/cB4z9B3nPVbE8GiZ3OGBLQadVbono2/5MsEex5gZVj2G+2tCUyHYRA0mTbznMl9hc5T9rAec8rK6Yem+PvNvaVpTCxZ+mBJ72qu6J0BH2Z/SQPbNItGrd9DHuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709626871; c=relaxed/simple;
	bh=WFgIUqss9TAdO9AjaUlgXXkzHAVPaeaf3euW2nSz/wM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qbbkvcExg2WpiJY+AHXlW9JoeRd4MojeWkJPMiKXAxrRlfjRRfFgr41CMJxJqx4Xi6/aN8cv2oX44kd+F7O/tPnMoplspKKH1NRnWdfEWYKZOYDTaupKUUHqjGM0QRzEX3o9oLl0XvaSImxfrofSJGetYWGH3oz0OqAt5l+tcbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOPPu2Rv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4607CC433F1;
	Tue,  5 Mar 2024 08:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709626870;
	bh=WFgIUqss9TAdO9AjaUlgXXkzHAVPaeaf3euW2nSz/wM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HOPPu2Rv+RdmcOkgyYlgmMrXFdBSqx6Lvib1K4Tvnhn3J67hqN2RcG18v/LlVUFFh
	 jpaJpRl+uuBbX9T2FNShyS6KtAkgkO8S7CyG4SY+uWlvHPbo2HFl6mGAW0LTKHqZ0F
	 SWQ4zlsNDWXzN33UMPiKoKQdEJVlFhU2GYr2UmYwOAklK+kq1aaf+/7o6ER9xBqsLx
	 fedo6DW/bucOVcaw5pOch3Pwrw7BRAQlPK//XqKgfh87mc0kD/3xjS2ezlOWPYjcrq
	 bUca/5InbS+0ycCLRscWpkgSe1MY74qpIj8J6wVZmbTMRFn1LEJuttlgXICziEBbd2
	 RXDwoQ2B7A0ww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>, Anup Patel
 <apatel@ventanamicro.com>
Cc: Conor Dooley <conor@kernel.org>, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Anup Patel <anup@brainfault.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Andrea
 Parri <andrea@rivosinc.com>, Samuel Holland <samuel.holland@sifive.com>,
 Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Andrea Parri
 <parri.andrea@gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: Fix text patching when IPI are used
In-Reply-To: <20240305-sarcasm-ending-0f7946490aea@wendy>
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
 <20240229121056.203419-3-alexghiti@rivosinc.com>
 <20240304-makeshift-bakeshop-26c9611de1a3@spud>
 <87msrdzqxi.fsf@all.your.base.are.belong.to.us>
 <CAK9=C2Xjgr9_H-sHkmAAc95dAm2jd+_dxLUxSM3RM3NrQJFKGQ@mail.gmail.com>
 <20240305-sarcasm-ending-0f7946490aea@wendy>
Date: Tue, 05 Mar 2024 09:21:07 +0100
Message-ID: <87frx5ozrg.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Conor Dooley <conor.dooley@microchip.com> writes:

> On Tue, Mar 05, 2024 at 08:33:30AM +0530, Anup Patel wrote:
>> On Tue, Mar 5, 2024 at 1:54=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kern=
el.org> wrote:
>> >
>> > Conor Dooley <conor@kernel.org> writes:
>> >
>> > > On Thu, Feb 29, 2024 at 01:10:56PM +0100, Alexandre Ghiti wrote:
>> > >> For now, we use stop_machine() to patch the text and when we use IP=
Is for
>> > >> remote icache flushes (which is emitted in patch_text_nosync()), th=
e system
>> > >> hangs.
>> > >>
>> > >> So instead, make sure every CPU executes the stop_machine() patching
>> > >> function and emit a local icache flush there.
>> > >>
>> > >> Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> > >> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> > >> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> > >> Reviewed-by: Andrea Parri <parri.andrea@gmail.com>
>> > >
>> > > What commit does this fix?
>> >
>> > Hmm. The bug is exposed when the AIA IPI are introduced, and used
>> > (instead of the firmware-based).
>> >
>> > I'm not sure this is something we'd like backported, but rather a
>> > prerequisite to AIA.
>> >
>> > @Anup @Alex WDYT?
>> >
>>=20
>> The current text patching never considered IPIs being injected
>> directly in S-mode from hart to another so we are seeing this
>> issue now with AIA IPIs.
>>=20
>> We certainly don't need to backport this fix since it's more
>> of a preparatory fix for AIA IPIs.
>
> Whether or not this is backportable, if it fixes a bug, it should get
> a Fixes: tag for the commit that it fixes. Fixes: isn't "the backport"
> tag, cc: stable is.

I guess the question is if this *is* a fix, or rather a change required
for AIA (not a fix).

