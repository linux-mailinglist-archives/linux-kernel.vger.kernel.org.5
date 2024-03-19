Return-Path: <linux-kernel+bounces-106987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5528A87F655
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3DE91F21D25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35CC57C092;
	Tue, 19 Mar 2024 04:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDtTeaUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235D7BB1C;
	Tue, 19 Mar 2024 04:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710822063; cv=none; b=C2TbSoT7oi5cIYsrqvCyveNE04pGd8fBsjiyp7+ULZs2M3GdxxaLyTydC5CmEXvSxm51SotUoOfk4yCkpdI5P5mZ0unoSW69IIdl6puvPMSxHmyneRnTtnaTIDCvcJwdbkTtANGVMrT24GP95McpRtRAXZnzkvLgIXQdq7wTZxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710822063; c=relaxed/simple;
	bh=EFq7mIqWfl+BjiP6nOSsSBppaKo1QaSeIi0ksZ/ZTFE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SK9zw2jGPfJvLiKujWDwP9H+rIJ1SrVfaE2/Y/3jYi2mvd19PeHCxwYM2zXv0UKy2ex50aBqJjiDtZsWn7Svv5X04Uxs4qtT2XL4g8sGkSS3QpMhrOymYllBB7rPUpMwZnxoIeAZtofvWJzTt1TSJgZqi8+qVHtAzkDTKinn0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDtTeaUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D003C433F1;
	Tue, 19 Mar 2024 04:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710822063;
	bh=EFq7mIqWfl+BjiP6nOSsSBppaKo1QaSeIi0ksZ/ZTFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FDtTeaUvL7WF1Pnnna4HQWDXaRFsPsVf9iuGsGGEuguwiRz0uisp/Fkyvdzv33vuY
	 8uDgcqdqb/JtpZJVVvjBHqR/99YAoIf5yxmXq1ezwUUpJI8OgXzyvS+fUjpuhydNsS
	 uBnhz24tyjg6d6kdiq3N9W+Goj7brXfzL/EoaUdrK9YO5/7HgiCV9+iXOYAOTpR0Q6
	 ddEbl+5QwuPSaH5wvCD+Zz/uO+ib/7XmkT3zG3xKKY0aD7jqbvb1XSY110ktRc9VYi
	 LM1JLJjLZidac3ZaGXCnoYy+o9YYxbPl3R5zT5x8z/OJAYRUks+ijxTZnsjDBR2syA
	 MPkYG1Bw3YpIw==
Date: Tue, 19 Mar 2024 13:20:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 bpf@vger.kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, oleg@redhat.com, jolsa@kernel.org
Subject: Re: [PATCH v2 0/3] uprobes: two common case speed ups
Message-Id: <20240319132057.78e60d15e4fd07dbef3b14a9@kernel.org>
In-Reply-To: <20240318181728.2795838-1-andrii@kernel.org>
References: <20240318181728.2795838-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 18 Mar 2024 11:17:25 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> This patch set implements two speed ups for uprobe/uretprobe runtime execution
> path for some common scenarios: BPF-only uprobes (patches #1 and #2) and
> system-wide (non-PID-specific) uprobes (patch #3). Please see individual
> patches for details.

This series looks good to me. Let me pick it on probes/for-next.

Thanks!

> 
> v1->v2:
>   - rebased onto trace/core branch of tracing tree, hopefully I guessed right;
>   - simplified user_cpu_buffer usage further (Oleg Nesterov);
>   - simplified patch #3, just moved speculative check outside of lock (Oleg);
>   - added Reviewed-by from Jiri Olsa.
> 
> Andrii Nakryiko (3):
>   uprobes: encapsulate preparation of uprobe args buffer
>   uprobes: prepare uprobe args buffer lazily
>   uprobes: add speculative lockless system-wide uprobe filter check
> 
>  kernel/trace/trace_uprobe.c | 103 +++++++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 44 deletions(-)
> 
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

