Return-Path: <linux-kernel+bounces-106991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A5187F664
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE61F28330B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E387C09F;
	Tue, 19 Mar 2024 04:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FteKm17Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E84E1EB4A;
	Tue, 19 Mar 2024 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822380; cv=none; b=cGkYnLa9yuviJtsTN6YOWIYDlmHWqj3blym0NuN74uyfZLaU+nxCYm4XVecXOcbmjsu2vqEtUAulESiscIPxAWmE1JcYWj4eM/d3SyNhb1kMuXRF76uZD4m2M+UwsOXlSjt6QFERP8b14xCsWYuKrm7VIiYPa5IHQnPh2t0c0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822380; c=relaxed/simple;
	bh=7YsqkSV+GX//QtAFw7d+Mxcy/m0PnlisLWiaD6Nw7hE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=l9FJAWEvMNsUk/eWwaCaQPndQtcb9OM9TGUBU8XfLsLzIE0gWQE3A387aQqcX9UAyVnPXnEZH3kE0F1+stl/ndMe6OxPRg9L/EUprEz/WBOPolNnkTTg4BhwrP7MT5s9nN/SgbZsITP9snLFskEomAGZaw4jThkvVnrY4iI2hIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FteKm17Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D08C433F1;
	Tue, 19 Mar 2024 04:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710822379;
	bh=7YsqkSV+GX//QtAFw7d+Mxcy/m0PnlisLWiaD6Nw7hE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FteKm17YcI2Wyy0h3Q5fsC9sYrYdXiGwO54OtbwFBxpYSk3RnEFZVu2wNvFrSIm+L
	 oAGKi55toxtg7KcD76hsriJ2AJfI55DKcMGLFfE3rfDNx+lFKKymd+FAqW9NzdBL1n
	 zXFxJIinK/fAV/ArbS/yGpgpHPtWEuWjy4ZuVWqnWLi5jCTGLHLZnzhAa9XEARCwhr
	 jyp8b684PI32PtdhqEgtf+K94qaHcoCuAUirR70rkJQFpzaICYZpf0fFgq+u7V9ZnW
	 6hYyklDYX/3yeCy3/3wGNjf01LqC6BK2iXef9SL2xVhZbJQK/IRzCxM3wzE3qc92Sw
	 NzGdjw6O/NiKw==
Date: Tue, 19 Mar 2024 13:26:13 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
 rostedt@goodmis.org, bpf@vger.kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, jolsa@kernel.org
Subject: Re: [PATCH v2 0/3] uprobes: two common case speed ups
Message-Id: <20240319132613.0d393d6b0d4f6197c6e2ed03@kernel.org>
In-Reply-To: <20240319132057.78e60d15e4fd07dbef3b14a9@kernel.org>
References: <20240318181728.2795838-1-andrii@kernel.org>
	<20240319132057.78e60d15e4fd07dbef3b14a9@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 13:20:57 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> 
> On Mon, 18 Mar 2024 11:17:25 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> > This patch set implements two speed ups for uprobe/uretprobe runtime execution
> > path for some common scenarios: BPF-only uprobes (patches #1 and #2) and
> > system-wide (non-PID-specific) uprobes (patch #3). Please see individual
> > patches for details.
> 
> This series looks good to me. Let me pick it on probes/for-next.

Ah, and 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.

> 
> Thanks!
> 
> > 
> > v1->v2:
> >   - rebased onto trace/core branch of tracing tree, hopefully I guessed right;
> >   - simplified user_cpu_buffer usage further (Oleg Nesterov);
> >   - simplified patch #3, just moved speculative check outside of lock (Oleg);
> >   - added Reviewed-by from Jiri Olsa.
> > 
> > Andrii Nakryiko (3):
> >   uprobes: encapsulate preparation of uprobe args buffer
> >   uprobes: prepare uprobe args buffer lazily
> >   uprobes: add speculative lockless system-wide uprobe filter check
> > 
> >  kernel/trace/trace_uprobe.c | 103 +++++++++++++++++++++---------------
> >  1 file changed, 59 insertions(+), 44 deletions(-)
> > 
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

