Return-Path: <linux-kernel+bounces-26607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8652582E416
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FA881C2237D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8381B7F0;
	Mon, 15 Jan 2024 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KL2djf5Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596D1B7E2;
	Mon, 15 Jan 2024 23:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF123C433F1;
	Mon, 15 Jan 2024 23:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705362517;
	bh=KZwAUGNVj6Y4Y4rlr5muEF1gOqr5vNBnbpgz4CwGlUs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KL2djf5ZjDfkD4lMU3ZknlW1ZJ9+UEk1POs6fKFyc1besOOH8tjrnvqLbsoGdlXaj
	 nNr8s7mWjq+cPb+0ZHfBseJm4X6EX421qo30LXmy3QOH40anud7T7kNUrwZ019INqE
	 1mc0blZqYtMYmuepI60pIpgc7b6NGezrtOWfnLp6i65HoM384JkXmD8rUAV3LYMfgp
	 Q3KGl9H4aImXEemkm1SXyQU86JjioObCPvTUdW5cw0QaenOnCgoY9RPClScCk2SNyC
	 2CXU2Q3mPPtSZZhoikn/qkQ637kygBt3A+f8BAnDDmCmVINlN43XMD765fKNqXy9fb
	 jTxaVKCtTtUPQ==
Date: Tue, 16 Jan 2024 08:48:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 kernel-team@android.com
Subject: Re: [PATCH v11 2/5] ring-buffer: Introducing ring-buffer mapping
 functions
Message-Id: <20240116084833.f5537b00bae88afb0249492f@kernel.org>
In-Reply-To: <20240115112359.65dcecbf@rorschach.local.home>
References: <20240111161712.1480333-1-vdonnefort@google.com>
	<20240111161712.1480333-3-vdonnefort@google.com>
	<20240115134303.1a673e37b8e7d35a33d8df52@kernel.org>
	<ZaVRO76JxaHjPwCi@google.com>
	<20240115110938.613380ca@rorschach.local.home>
	<20240115112359.65dcecbf@rorschach.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jan 2024 11:23:59 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 15 Jan 2024 11:09:38 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > No. The ring buffer logic should not care if the user of it is swapping
> > the entire ring buffer or not. It only cares if parts of the ring
> > buffer is being swapped or not. That's not the level of scope it should
> > care about. If we do not want a swap to happen in update_max_tr()
> > that's not ring_buffer.c's problem. The code to prevent that from
> > happening should be 100% in trace.c.
> 
> What needs to be done, and feel free to add this as a separate patch,
> is to have checks where snapshot is used.
> 
>   (All errors return -EBUSY)
> 
> Before allowing mapping, check to see if:
> 
>  1) the current tracer has "use_max_tr" set.
>  2) any event has a "snapshot" trigger set
>  3) Any function has a "snapshot" command set
> 
> Fail if any of the above is true.
> 
> Also in reverse, if the buffer is mapped, then fail:
> 
>  1) a tracer being set that has "use_max_tr" set.
>  2) a "snapshot" command being set on a function
>  3) a "snapshot" trigger being set on an event.
> 
> For the last two, we may be able to get away with just a below as well.
> Adding the tr->flags bit. We could also add a tr->snapshot count to
> keep track of everything that is using a snapshot, and if that count is
> non-zero, mapping fails.

BTW, if we allow mapping per-cpu ring buffer, we may need "tr->mapped"
counter in addition to per-cpu mapped bit. Then we can just check
tr->snapshot at mapping, and tr->mapped at preparing snapshot.

Thank you,

> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 2a7c6fd934e9..f534f74ae80f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1175,6 +1175,12 @@ static void tracing_snapshot_instance_cond(struct trace_array *tr,
>  		return;
>  	}
>  
> +	if (tr->flags & TRACE_ARRAY_FL_MAPPED) {
> +		trace_array_puts(tr, "*** BUFFER IS MEMORY MAPPED ***\n");
> +		trace_array_puts(tr, "*** Can not use snapshot (sorry) ***\n");
> +		return;
> +	}
> +
>  	local_irq_save(flags);
>  	update_max_tr(tr, current, smp_processor_id(), cond_data);
>  	local_irq_restore(flags);
> 
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

