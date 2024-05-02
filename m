Return-Path: <linux-kernel+bounces-165909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEB58B9341
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F1951C20ED8
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159517543;
	Thu,  2 May 2024 02:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5xfT4v7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303010A24;
	Thu,  2 May 2024 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714615506; cv=none; b=QB0Mo0hJNv9WGZCjo6VHN4n1hJmzHOFDeYcImJ/RO0M+yfFCAed4V7iUQMbMYjueNgAzVKCkmfyQf9lIasf09wnzlc8BjIeGmZIik4IUv9+mkFeNdqQHYQFeFYZg+uoZx7fiPIu/9YpjMxuVT1OGOvIscCag5lTABqZPp5c+G/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714615506; c=relaxed/simple;
	bh=PfI7kwT0zdz9ddo+WKYrEGr2s1BpAOvYE9Db/2BXM60=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BMgsf9orRaq71S8eNfAMtipTo0VSUeg5chKmIzoAf+x4bMOlLuP6A5gs20iWXwe0azppdo0IflML3Vdny25qktUOd7B7Dyf10I+mEmQXC9qAa8egYtqWBQDZ59Kxz6drdWIYiPpjtQIC7esCe8KGtb+pDgZjgb9boq67Ctaaqcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5xfT4v7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4C6C4AF14;
	Thu,  2 May 2024 02:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714615506;
	bh=PfI7kwT0zdz9ddo+WKYrEGr2s1BpAOvYE9Db/2BXM60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G5xfT4v7LqRRqiTOLWcsTxXm/rI5JeTH1azHm3XHh1cQhN7MZz2smok/LPx6TKqwH
	 9KydlEdxvptacaS2917q9oylBkZi71fRvSs9hRxfYmNlnY4gP/RYqyawm3vQ+2VY9Z
	 0md0MnqpW24+VQBgSKoRS5uKHX5IwySrt5F9xE0NlCJWEEdiQj/Nmr/jHdEYP3p/or
	 MyNZzL0pencfL+o79u2s915hUldlCLFcipYlNEZigJ+T4QE6hBK9/IYQlTqS5Jrq28
	 lqXxIzysA3sGWFOClkMuO1R/pp0VrqOmjjrYqDvVjEO7FnQKfXiKBJC0GgHdzX3VmT
	 PqX4mEbXxhcQQ==
Date: Thu, 2 May 2024 11:05:01 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: paulmck@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 kuba@kernel.org, ast@kernel.org, clm@fb.com, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH resend ftrace] Asynchronous grace period for
 register_ftrace_direct()
Message-Id: <20240502110501.772941f7fdbc1650a9a3bea4@kernel.org>
In-Reply-To: <ac05be77-2972-475b-9b57-56bef15aa00a@paulmck-laptop>
References: <ac05be77-2972-475b-9b57-56bef15aa00a@paulmck-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 16:12:37 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Note that the immediate pressure for this patch should be relieved by the
> NAPI patch series [1], but this sort of problem could easily arise again.
> 
> When running heavy test workloads with KASAN enabled, RCU Tasks grace
> periods can extend for many tens of seconds, significantly slowing
> trace registration.  Therefore, make the registration-side RCU Tasks
> grace period be asynchronous via call_rcu_tasks().
> 

Good catch! AFAICS, there is no reason to wait for synchronization
when adding a new direct trampoline.
This looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> [1] https://lore.kernel.org/all/cover.1710877680.git.yan@cloudflare.com/
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Reported-by: Alexei Starovoitov <ast@kernel.org>
> Reported-by: Chris Mason <clm@fb.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: <linux-trace-kernel@vger.kernel.org>
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 6c96b30f3d63b..32ea92934268c 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5365,6 +5365,13 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
>  	}
>  }
>  
> +static void register_ftrace_direct_cb(struct rcu_head *rhp)
> +{
> +	struct ftrace_hash *fhp = container_of(rhp, struct ftrace_hash, rcu);
> +
> +	free_ftrace_hash(fhp);
> +}
> +
>  /**
>   * register_ftrace_direct - Call a custom trampoline directly
>   * for multiple functions registered in @ops
> @@ -5463,10 +5470,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>   out_unlock:
>  	mutex_unlock(&direct_mutex);
>  
> -	if (free_hash && free_hash != EMPTY_HASH) {
> -		synchronize_rcu_tasks();
> -		free_ftrace_hash(free_hash);
> -	}
> +	if (free_hash && free_hash != EMPTY_HASH)
> +		call_rcu_tasks(&free_hash->rcu, register_ftrace_direct_cb);
>  
>  	if (new_hash)
>  		free_ftrace_hash(new_hash);


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

