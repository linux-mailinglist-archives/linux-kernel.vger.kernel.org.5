Return-Path: <linux-kernel+bounces-64570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A4485405D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A9D11F2A637
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194E5633E8;
	Tue, 13 Feb 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JC+PfN5V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEC763131;
	Tue, 13 Feb 2024 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707868337; cv=none; b=SZO0ePRcJmCJ8YUnPEAIWw0+D85R5eHfg/XPY5g6DrKy1mb9cX6J3/rfVVZGMbMo+QyjbKgQ5Ky0b6kpOl/Twoe+qreJ9h69f8yNihPE5RTvl7RUykL6CUoo0nKDJGFm2wEtKplNHsSvW/Qnkz4OYs0PxyM7XVdsGr6ivYqUCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707868337; c=relaxed/simple;
	bh=vRGeSV4Qpp3V6GpBdwLNOS519apuGrX2Dq5pxk/34f8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jB9juPgz+nXdIRpqAAWBRG4VwwN02eW4mg7XL77in0SpCZx+qaVNlq5wLZtqit+vC6dVcYAY5sV4i7f5mn8EhT4pVvgNYeRL7IvMTizj7g5Lj+5mNdP63XA7mpT5VVqUHibctza/XfI4WpzHGJMSnffGPIf7WvhL0XyX41x6yCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JC+PfN5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E73FC433F1;
	Tue, 13 Feb 2024 23:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707868336;
	bh=vRGeSV4Qpp3V6GpBdwLNOS519apuGrX2Dq5pxk/34f8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JC+PfN5VpoDtVaJaUZaBrAtsENePlNUitDPQ88/VKs9+HOeNOxDbksrEq7zS6kiTM
	 4u6o1ZEyMHT+5vCw8ZiICWO3m3tMdry7J/+LrrDXe3pNCG3HUfHE+BOyvn2WEKdrsA
	 QMttB47zWYLHJ81v1OSRTN2PlGTCHAmnT6lAMYb2MYmsOHZaahcY9XxD6OP+b0Gi5n
	 NpBe92sCi4qxolESIjLXYk1g7RC3yOGx2AHOWxsHdvUpLeI9hzGuUOCmat8EiB+GVC
	 Ue5rie0XhMouwz0qYJb/Mc53ZUfIfO7webEvQL1jCidyn0vEl49v2CjnQF5CUyC+f3
	 Y+Qckpe1OdlqQ==
Date: Wed, 14 Feb 2024 08:52:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Tim Chen <tim.c.chen@linux.intel.com>,
 Vincent Donnefort <vdonnefort@google.com>, Sven Schnelle
 <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH v2] tracing: Have saved_cmdlines arrays all in one
 allocation
Message-Id: <20240214085212.a30c64de67e58d76edf4b2d8@kernel.org>
In-Reply-To: <20240213115232.5fd9e611@gandalf.local.home>
References: <20240213115232.5fd9e611@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Feb 2024 11:52:32 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The saved_cmdlines have three arrays for mapping PIDs to COMMs:
> 
>  - map_pid_to_cmdline[]
>  - map_cmdline_to_pid[]
>  - saved_cmdlines
> 
> The map_pid_to_cmdline[] is PID_MAX_DEFAULT in size and holds the index
> into the other arrays. The map_cmdline_to_pid[] is a mapping back to the
> full pid as it can be larger than PID_MAX_DEFAULT. And the
> saved_cmdlines[] just holds the COMMs associated to the pids.
> 
> Currently the map_pid_to_cmdline[] and saved_cmdlines[] are allocated
> together (in reality the saved_cmdlines is just in the memory of the
> rounding of the allocation of the structure as it is always allocated in
> powers of two). The map_cmdline_to_pid[] array is allocated separately.
> 
> Since the rounding to a power of two is rather large (it allows for 8000
> elements in saved_cmdlines), also include the map_cmdline_to_pid[] array.
> (This drops it to 6000 by default, which is still plenty for most use
> cases). This saves even more memory as the map_cmdline_to_pid[] array
> doesn't need to be allocated.
> 
> Link: https://lore.kernel.org/linux-trace-kernel/20240212174011.068211d9@gandalf.local.home/
> 

OK, this looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240212180941.379c419b@gandalf.local.home/
> 
> -- Added SAVED_CMDLINE_MAP_ELEMENT_SIZE helper macro.
> 
>  kernel/trace/trace_sched_switch.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index e4fbcc3bede5..5f3e9bc87079 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -175,6 +175,10 @@ struct saved_cmdlines_buffer {
>  };
>  static struct saved_cmdlines_buffer *savedcmd;
>  
> +/* Holds the size of a cmdline and pid element */
> +#define SAVED_CMDLINE_MAP_ELEMENT_SIZE(s)			\
> +	(TASK_COMM_LEN + sizeof((s)->map_cmdline_to_pid[0]))
> +
>  static inline char *get_saved_cmdlines(int idx)
>  {
>  	return &savedcmd->saved_cmdlines[idx * TASK_COMM_LEN];
> @@ -201,7 +205,7 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
>  	int order;
>  
>  	/* Figure out how much is needed to hold the given number of cmdlines */
> -	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
> +	orig_size = sizeof(*s) + val * SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
>  	order = get_order(orig_size);
>  	size = 1 << (order + PAGE_SHIFT);
>  	page = alloc_pages(GFP_KERNEL, order);
> @@ -212,16 +216,11 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
>  	memset(s, 0, sizeof(*s));
>  
>  	/* Round up to actual allocation */
> -	val = (size - sizeof(*s)) / TASK_COMM_LEN;
> +	val = (size - sizeof(*s)) / SAVED_CMDLINE_MAP_ELEMENT_SIZE(s);
>  	s->cmdline_num = val;
>  
> -	s->map_cmdline_to_pid = kmalloc_array(val,
> -					      sizeof(*s->map_cmdline_to_pid),
> -					      GFP_KERNEL);
> -	if (!s->map_cmdline_to_pid) {
> -		free_saved_cmdlines_buffer(s);
> -		return NULL;
> -	}
> +	/* Place map_cmdline_to_pid array right after saved_cmdlines */
> +	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
>  
>  	s->cmdline_idx = 0;
>  	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
> -- 
> 2.43.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

