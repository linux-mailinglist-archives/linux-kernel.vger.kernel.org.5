Return-Path: <linux-kernel+bounces-11742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA32681EB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 01:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282641C220CB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 00:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A711C3E;
	Wed, 27 Dec 2023 00:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkyjzRTG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9AAA35;
	Wed, 27 Dec 2023 00:59:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BCC433C8;
	Wed, 27 Dec 2023 00:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703638759;
	bh=ygOF1FE2qsIEsSYrjFBXdoWsOq4WuzTN5J8O+K11Qu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CkyjzRTGfGttnJ9UIlGWZhotoLx4Nmw2tC7mw6HAmvFXD5NEC3SAf+88dHVplXVfQ
	 ggqSq+TP+Pc8wEREx86470ByGHh242ehTQq3a7JKaOBsu0X0xtLYbyzker662m55ZQ
	 HM5IlzJThylwdyCGSJnLvEcxCx89cOTw3YkVRJVXt4gCd6xg1fn7MPgkgv9q2Wh9T/
	 Pv2HLyi1UoWBUpBZmxd5AQijMhEto1JRQ4B1cvdi+Mbv0wO9EIC8C0Zqmz6gUQleL2
	 RLbGJzwvnVrHIVP7dmrWQ/8X+sYpL3WApdUrijcmF1tSwKm9O3RWmP4Pw8RVtLPmtA
	 n3YctZGs+nGHg==
Date: Wed, 27 Dec 2023 09:59:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org, Linux
 Trace Kernel <linux-trace-kernel@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] ring-buffer/Documentation: Add documentation on
 buffer_percent file
Message-Id: <20231227095914.4ee69b53b69254ad8c5f7171@kernel.org>
In-Reply-To: <20231226123525.71a6d0fb@gandalf.local.home>
References: <20231226123525.71a6d0fb@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Dec 2023 12:35:25 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> When the buffer_percent file was added to the kernel, the documentation
> should have been updated to document what that file does.
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Fixes: 03329f9939781 ("tracing: Add tracefs file buffer_percentage")
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  Documentation/trace/ftrace.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 933e7efb9f1b..16eabb00fa55 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -180,6 +180,21 @@ of ftrace. Here is a list of some of the key files:
>  	Only active when the file contains a number greater than 0.
>  	(in microseconds)
>  
> +  buffer_percent:
> +
> +	This is the water-mark for how much the ring buffer needs to be filled
> +	before a waiter is woken up. That is, if an application call a
> +	blocking read syscall on one of the per_cpu trace_pipe_raw files, it
> +	will block until the given amount of data specified by buffer_percent
> +	is in the ring buffer before it wakes the reader up. This also
> +	controls how splice system calls are blocked on this file.
> +
> +	0   - means to wake up as soon as there is any data in the ring buffer.
> +	50  - means to wake up when roughly half of the ring buffer sub-buffers
> +	      are full.
> +	100 - means to block until the ring buffer is totally full and is
> +	      about to start overwriting the older data.
> +
>    buffer_size_kb:
>  
>  	This sets or displays the number of kilobytes each CPU
> -- 
> 2.42.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

