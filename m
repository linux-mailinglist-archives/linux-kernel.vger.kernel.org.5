Return-Path: <linux-kernel+bounces-107986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2E988047B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CFEEB23ECE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BB938DD4;
	Tue, 19 Mar 2024 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE/QSKOE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12D2C6AE;
	Tue, 19 Mar 2024 18:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871952; cv=none; b=cmpSXHz9qTY6RVGNmYXcnUiAiNrHTmlgQuCG2cMPCEO80tKaiZq20/8AzgdZd4pwI40l6ciKEyLFuZpQ09Zw5cCRrS4SNViN4ITIt2I7CDwysHx0GOwDV7zQrw4pvocEcIJhDx63iUQPT1qJIL4yjhqy21HC5DHbvZqknqhPGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871952; c=relaxed/simple;
	bh=SftRlw25717KfraW/oJEXJbHD1EPneudXtNW4HSfDh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrTutZ2N5Gahv5f8vVXVzT10dVoKAOnIa0U+CLkO5dWUHmB4n7wZFPbN55UfziPUQk5mYdb1sqaAFtgvpImVAJby5s9/XSUiQNit3/Xdd6RDtQsyH9xC368+wrt2lXVjwClAeD9xPLE0UBQGiwmRq3r7njsVmilcsuv7i21c2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE/QSKOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49514C433C7;
	Tue, 19 Mar 2024 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710871952;
	bh=SftRlw25717KfraW/oJEXJbHD1EPneudXtNW4HSfDh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hE/QSKOELxDbrTwwKGHc86OuDRyhnMRz7p1Z0RNdTbSRZWM/rP0MmXmtqJlMrupoA
	 Zz+eHvgHcC2Y8fIrYOanYS50LHQ/eaToRhT/u39AzQc9TcbQ0o16B1XvaJzqYAN3gX
	 3OSdHpEIF4ngB1793CqW/QJX5L0Wu1LKVMsPg9TY61FlrVvYDCuuEYhnIEh/Tjl8Yg
	 wlNsuarphgAZA5jbuJHntgptuVKVchJuEDkl+W0QIzoToQBnYnLpZ87L3Qc9UWn8Ol
	 VsgWz10dOlKPlT/vxjVAKez1pAgAzk2cygGSpwfB5TjLWTHpZTL/saUNZjAraIIh7a
	 0OpOHW1q87NJQ==
Date: Tue, 19 Mar 2024 15:12:28 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 09/23] perf annotate-data: Maintain variable type info
Message-ID: <ZfnVjPlo_L5l51Bq@x1>
References: <20240319055115.4063940-1-namhyung@kernel.org>
 <20240319055115.4063940-10-namhyung@kernel.org>
 <ZfmcN4YuvQpVgJQN@x1>
 <CAM9d7cjatKSH7hw_sC3MCmY1fYT+bDBgSpFWJg=RM2oqgL5X0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cjatKSH7hw_sC3MCmY1fYT+bDBgSpFWJg=RM2oqgL5X0A@mail.gmail.com>

On Tue, Mar 19, 2024 at 10:44:31AM -0700, Namhyung Kim wrote:
> On Tue, Mar 19, 2024 at 7:07 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > +void exit_type_state(struct type_state *state)
> > > +{
> > > +     struct type_state_stack *stack, *tmp;
> > > +
> > > +     list_for_each_entry_safe(stack, tmp, &state->stack_vars, list) {
> > > +             list_del(&stack->list);

> > list_del_init()?
 
> Maybe.. but I'm not sure how much value it'd have as we free it right after.

Usually the value is in catching use after free more quickly, i.e.
someone may have a pointer to a freed list and then it would be able to
traverse the list of freed elements.

- Arnaldo

