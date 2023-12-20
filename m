Return-Path: <linux-kernel+bounces-7289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F9881A4EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C4B28A3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D912A482CA;
	Wed, 20 Dec 2023 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pbx40+sV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490A47A7B;
	Wed, 20 Dec 2023 16:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CC8C433C7;
	Wed, 20 Dec 2023 16:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703089399;
	bh=IYxNhfoPQDOhU8TVSYJ0LQ/+qknb5nTRTy9LLBYZ0Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pbx40+sVvAprd4ZsHKt5lVIzubGuCmQZjBNcWlwFYNuDkUltnT23y4VAtisropWA5
	 mKDUrMnK0f/AS6Ju8v7okrOu8uX0WWJmvvnn7PDQ+myx5x02lTzoK9N73eF730Szdy
	 tDkMg8mswc64Ts5qQ6YlN7GvFfJPvPrdTj86b0Pq1g6XoTJEggpiVrjVGMO48peTrt
	 gMmBI0SZcCsLPRsx9Ndv1LRcpBsHAm24jtBhaB9dVG6Iw/4Vbf0HSamaRIhkmKTOlp
	 SzFWzJPR3GW+BuWcoFRnd6l/ONtBr4GiQj0TXvV0FE7PkcU8JGO3XPUf59wi8ucolN
	 /xhjEwmFYLC1w==
Date: Thu, 21 Dec 2023 01:23:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>, Kent Overstreet
 <kent.overstreet@gmail.com>
Subject: Re: [PATCH v5 06/15] ring-buffer: Clear pages on error in
 ring_buffer_subbuf_order_set() failure
Message-Id: <20231221012314.1d041383caf29e31c49dfc4e@kernel.org>
In-Reply-To: <20231219185629.179352802@goodmis.org>
References: <20231219185414.474197117@goodmis.org>
	<20231219185629.179352802@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Dec 2023 13:54:20 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> On failure to allocate ring buffer pages, the pointer to the CPU buffer
> pages is freed, but the pages that were allocated previously were not.
> Make sure they are freed too.
> 
> Fixes: TBD ("tracing: Set new size of the ring buffer sub page")

Do you merge this fix to the original one in the same series later?
I think it is better to merge it for git bisect.

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index c2afcf98ea91..3c11e8e811ed 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5927,6 +5927,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  	for_each_buffer_cpu(buffer, cpu) {
>  		if (!cpu_buffers[cpu])
>  			continue;
> +		rb_free_cpu_buffer(cpu_buffers[cpu]);
>  		kfree(cpu_buffers[cpu]);
>  	}
>  	kfree(cpu_buffers);
> -- 
> 2.42.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

