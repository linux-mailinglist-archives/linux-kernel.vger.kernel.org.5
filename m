Return-Path: <linux-kernel+bounces-119427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 109FC88C8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99911F816AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D71913C9A6;
	Tue, 26 Mar 2024 16:10:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DE13C903
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469426; cv=none; b=LBawNcizSfq6reRZAi99rDBTy4QUanh66EYNyXgqnL1SwMjyv95gprebL1SfXf5Hi4zuAs++gxnS7ev3EzxlOghnjBaLLvNJN2MFmT0bVKaKUdvGPRbB5JrBfII14WvCM//ygPxMe1tnhTAB4l7/h1+4zasEt6eW548+jcM+2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469426; c=relaxed/simple;
	bh=O9/O8/3Ppgo9S1fbSrcjMJAgmepc3kwRil8a/eoK62M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3mLjPltBg0LNs9ReEG3MU5chmRORayB5aUEYR3498hpYe0FuPnUUhGqXTXvsJ9IMaOhJhjLfRTgEUzI8Av2LFYuLv+cIVJ/cJdNn1R/hc/xoVz2VzQa/v9td8YcNYGCmN8LV+GPu/w4qV33i6QmMCuEmAHdNrbelFY2Y8eD4sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E92EC433F1;
	Tue, 26 Mar 2024 16:10:24 +0000 (UTC)
Date: Tue, 26 Mar 2024 12:13:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Maxim Moskalets <maximmosk4@gmail.com>
Cc: bristot@redhat.com, bsegall@google.com, dietmar.eggemann@arm.com,
 juri.lelli@redhat.com, linux-kernel@vger.kernel.org, mgorman@suse.de,
 mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
 vschneid@redhat.com, Maxim.Moskalets@kaspersky.com
Subject: Re: [PATCH RESEND] kernel: replace seq_puts by seq_putc
Message-ID: <20240326121303.7633eca8@gandalf.local.home>
In-Reply-To: <20240325192829.6710-1-Maxim.Moskalets@kaspersky.com>
References: <20240325192829.6710-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 22:28:29 +0300
Maxim Moskalets <maximmosk4@gmail.com> wrote:

> Using seq_putc for single characters is faster and more appropriate
> than seq_puts, since only one character is passed and there is no need
> to use a more powerful and less fast function.
> 
> Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
> ---
>  kernel/bpf/arraymap.c            |  6 +++---
>  kernel/bpf/bpf_struct_ops.c      |  2 +-
>  kernel/bpf/hashtab.c             |  4 ++--
>  kernel/bpf/local_storage.c       |  4 ++--
>  kernel/cgroup/cgroup.c           |  2 +-
>  kernel/cgroup/debug.c            |  6 +++---
>  kernel/latencytop.c              |  2 +-
>  kernel/locking/lockdep_proc.c    | 24 ++++++++++++------------
>  kernel/module/procfs.c           |  4 ++--
>  kernel/module/tracking.c         |  2 +-
>  kernel/sched/cpuacct.c           |  4 ++--
>  kernel/sched/debug.c             | 14 +++++++-------
>  kernel/time/test_udelay.c        |  2 +-
>  kernel/trace/trace_events_hist.c | 26 +++++++++++++-------------
>  kernel/trace/trace_events_user.c |  8 ++++----
>  kernel/trace/trace_hwlat.c       |  4 ++--
>  16 files changed, 57 insertions(+), 57 deletions(-)
> 

It's probably better to break this up per sub-system and send them out as
separate patches. At least that way the maintainers of the subsystems can
take the patch. Otherwise, nobody is going to take ownership of this.

-- Steve


> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c

