Return-Path: <linux-kernel+bounces-130500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 221F78978FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BB2284844
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C8A15530A;
	Wed,  3 Apr 2024 19:26:54 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E8154C09;
	Wed,  3 Apr 2024 19:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712172414; cv=none; b=lqVgWm1C7TxXpOI5yxc/kwBDmbpSY/hg71dGJ+enRUyZ2sMWJygrRlT7Z9clD0FAiKmHhBFIl5oFWqXBR2F98Lm6piPRfZQnaua5q8NFfxJp5YJhgpgEt6sXG914/B+aGaY/0pC4Kj81GnbFUTe0DBwHx64LN5nwSNs5Ol4Nlls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712172414; c=relaxed/simple;
	bh=G4rssQJ+iew4mkpVzB+QC7sReSlu3vcswXRDXIWQw6A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch95Usf55jS6CQzsCcqnuicNjDtraegKJTiYZ9XeFqp4eRtbgJnnhCHrdI1/fvX7ourWFGmBCf24Iwv2pui3+EPjfUJThOpzCswKlV1xm6n0XGpvrXqJFVIMr/ABO0JvffzBBON4DkU6nKLYhZiyFwFGy42/zib35t+XBTIznMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036BDC433F1;
	Wed,  3 Apr 2024 19:26:52 +0000 (UTC)
Date: Wed, 3 Apr 2024 15:29:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Jakub Kicinski
 <kuba@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Chris Mason
 <clm@fb.com>
Subject: Re: [PATCH RFC ftrace] Asynchronous grace period for
 register_ftrace_direct()
Message-ID: <20240403152912.7f03c6db@gandalf.local.home>
In-Reply-To: <7ed089be-c0c6-43b5-849a-05599cb32cfd@paulmck-laptop>
References: <7ed089be-c0c6-43b5-849a-05599cb32cfd@paulmck-laptop>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Apr 2024 11:53:14 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> @@ -5366,6 +5366,13 @@ static void remove_direct_functions_hash(struct ftrace_hash *hash, unsigned long
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
> @@ -5464,10 +5471,8 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
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

I'm getting ready to go on PTO, but a quick glance doesn't look like this
would cause any harm.

-- Steve

