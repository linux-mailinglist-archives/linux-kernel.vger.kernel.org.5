Return-Path: <linux-kernel+bounces-141239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 874878A1BC7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39B29B33B83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212F456B6B;
	Thu, 11 Apr 2024 15:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9QD44qB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A3FEAF0;
	Thu, 11 Apr 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850923; cv=none; b=cRqP5H8qgtziNswlWfbvBKgIT1PZSTcp+GlxvxAZVuz3jCs0xvSJhxKw7m+UjJuWCnLVEx0x37r73e4KaBox4kr3c+EbqRud96g8FlV3V0F2aojlaUm4JIqWVmTDCVKEDlyfoH/8LqwWFM6jdbEELd+hUVkvea4dOlvdcLfCKjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850923; c=relaxed/simple;
	bh=L2C12Yb7j79+1CkcxokhELggPidIxkIpVX1xQ0kbD1Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eAScw+NA1WtwTJItDVP7k2bzTxqVdIDzMYKI+7iU7z7rUnbyYmTYf/4Iy0hGs6Vttxam41IhZp7zGa4Yyquhe78YNNxqk0x1Ph72yUhgNSmwYubzDniFReE1wVhhH6YVf7NtJg8MCpcqU+/0ntOpTM+2csSFC2qcStQq5WM1KpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9QD44qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03836C072AA;
	Thu, 11 Apr 2024 15:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712850923;
	bh=L2C12Yb7j79+1CkcxokhELggPidIxkIpVX1xQ0kbD1Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J9QD44qBcgT9w01Hs7cVMBmPBhtujTAVF/DC+E/Vv1XvIw37sKKLAZgrlB3WTFnyH
	 tH44qaxr6RBbnigkG4aD4Kp/basbn1MHedzLA80bOOxflb92MdD434cWR9T1+rHMOh
	 dWckZvKRt4wjh+n1P5e6ZREJyXUsFC7s5TaVRYiK230VwoEOhR+qqj3BvRXLszEreb
	 aVX8UHzhHE2ATVf52K+qFALDjyiNDCaC3NqcoU2onAONin0P82PEjj74Akqe/X/r/t
	 NkR2oJJEuvF/T4UgA7XUvpHmgT6RhMg/zSrYtuU9oblRajSXFm3uaZ76TOtx5nFk8T
	 oKjlHRyylL2Jw==
Date: Fri, 12 Apr 2024 00:55:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: Copying TLS/user register data per perf-sample?
Message-Id: <20240412005519.e7b664950ac776993da348bd@kernel.org>
In-Reply-To: <20240410153542.GA460-beaub@linux.microsoft.com>
References: <20240404192641.GA2628-beaub@linux.microsoft.com>
	<20240410220628.609188857f8c93e33e48d12a@kernel.org>
	<20240410153542.GA460-beaub@linux.microsoft.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 08:35:42 -0700
Beau Belgrave <beaub@linux.microsoft.com> wrote:

> On Wed, Apr 10, 2024 at 10:06:28PM +0900, Masami Hiramatsu wrote:
> > On Thu, 4 Apr 2024 12:26:41 -0700
> > Beau Belgrave <beaub@linux.microsoft.com> wrote:
> > 
> > > Hello,
> > > 
> > > I'm looking into the possibility of capturing user data that is pointed
> > > to by a user register (IE: fs/gs for TLS on x86/64) for each sample via
> > > perf_events.
> > > 
> > > I was hoping to find a way to do this similar to PERF_SAMPLE_STACK_USER.
> > > I think it could even use roughly the same ABI in the perf ring buffer.
> > > Or it may be possible by some kprobe linked to the perf sample function.
> > > 
> > > This would allow a profiler to collect TLS (or other values) on x64. In
> > > the Open Telemetry profiling SIG [1], we are trying to find a fast way
> > > to grab a tracing association quickly on a per-thread basis. The team
> > > at Elastic has a bespoke way to do this [2], however, I'd like to see a
> > > more general way to achieve this. The folks I've been talking with seem
> > > open to the idea of just having a TLS value for this we could capture
> > > upon each sample. We could then just state, Open Telemetry SDKs should
> > > have a TLS value for span correlation. However, we need a way to sample
> > > the TLS value(s) when a sampling event is generated.
> > > 
> > > Is this already possible via some other means? It'd be great to be able
> > > to do this directly at the perf_event sample via the ABI or a probe.
> > > 
> > 
> > Have you tried to use uprobes? It should be able to access user-space
> > registers including fs/gs.
> > 
> 
> We need to get fs/gs during a sample interrupt from perf. If the sample
> interrupt lands during kernel code (IE: syscall) we would also like to
> get these TLS values when in process context.

OK, those are not directly accessible from pt_regs.

> 
> I have some patches into the kernel to make this possible via
> perf_events that works well, however, I don't want to reinvent the wheel
> if there is some way to get these via perf samples already.

I would like to see it. I think it is possible to introduce a helper
to get a base address of user TLS for probe events, and start supporting
from x86.

> 
> In OTel, we are trying to attribute samples to transactions that are
> occurring. So the TLS fetch has to be aligned exactly with the sample.
> You can do this via eBPF when it's available, however, we have
> environments where eBPF is not available.
> 
> It's sounding like to do this properly without eBPF a new feature would
> be required. If so, I do have some patches I can share in a bit as an
> RFC.

It is better to be shared in RFC stage, so that we can discuss it from
the direction level.

Thank you,

> 
> Thanks,
> -Beau
> 
> > Thank you,
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

