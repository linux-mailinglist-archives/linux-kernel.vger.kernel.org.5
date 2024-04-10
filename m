Return-Path: <linux-kernel+bounces-138870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D571789FB76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0490C1C229E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C9C16E889;
	Wed, 10 Apr 2024 15:25:48 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95416E878;
	Wed, 10 Apr 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762748; cv=none; b=uPwaDEWyFi1isjHGv10w0NB1c3pkI78rDXLmG74/9d3XRmof1E5LQlvpCCwcUlRU7Z7Vj6cMo66l6pm1jNeYDs1QGagOCS0GxDxeBKKs3c7ycJRYeKrt1LAWXAIPARWxweu5eTQejArS3/eDIMKc3Q2gum4VqAUHhrOVFsuaBrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762748; c=relaxed/simple;
	bh=Pk0thEfc+DKwTeAkAv2HFqvGA8+fNmNFZy9Fw5oWnfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u1SCwxMHNd6eWvwF+sklaMbhiPGIQbhF0oNp2of8oR1SEKuBxJ++fHSe1xkFiISXmaKezFKXphuonpUKFdCg4kUxIOKw1dStzBr0tt1FD6oy3YJ44FIFYOoLGxQYoerTkE7ikwnuFGhx7Bz1BwaQvPKpXr4tAXJrH0QmG6V56Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F05C433F1;
	Wed, 10 Apr 2024 15:25:47 +0000 (UTC)
Date: Wed, 10 Apr 2024 11:28:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Zheng Yejian <zhengyejian1@huawei.com>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] ftrace: Fix use-after-free issue in ftrace_location()
Message-ID: <20240410112823.1d084c8f@gandalf.local.home>
In-Reply-To: <20240401125543.1282845-1-zhengyejian1@huawei.com>
References: <20240401125543.1282845-1-zhengyejian1@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Apr 2024 20:55:43 +0800
Zheng Yejian <zhengyejian1@huawei.com> wrote:

> KASAN reports a bug:
> 
>   BUG: KASAN: use-after-free in ftrace_location+0x90/0x120
>   Read of size 8 at addr ffff888141d40010 by task insmod/424
>   CPU: 8 PID: 424 Comm: insmod Tainted: G        W          6.9.0-rc2+ #213
>   [...]
>   Call Trace:
>    <TASK>
>    dump_stack_lvl+0x68/0xa0
>    print_report+0xcf/0x610
>    kasan_report+0xb5/0xe0
>    ftrace_location+0x90/0x120
>    register_kprobe+0x14b/0xa40
>    kprobe_init+0x2d/0xff0 [kprobe_example]
>    do_one_initcall+0x8f/0x2d0
>    do_init_module+0x13a/0x3c0
>    load_module+0x3082/0x33d0
>    init_module_from_file+0xd2/0x130
>    __x64_sys_finit_module+0x306/0x440
>    do_syscall_64+0x68/0x140
>    entry_SYSCALL_64_after_hwframe+0x71/0x79
> 
> The root cause is that when lookup_rec() is lookuping ftrace record of
> an address in some module, and at the same time in ftrace_release_mod(),
> the memory that saving ftrace records has been freed as that module is
> being deleted.
> 
>   register_kprobes() {
>     check_kprobe_address_safe() {
>       arch_check_ftrace_location() {
>         ftrace_location() {
>           lookup_rec()  // access memory that has been freed by
>                         // ftrace_release_mod() !!!
> 
> It seems that the ftrace_lock is required when lookuping records in
> ftrace_location(), so is ftrace_location_range().
> 
> Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
> Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
> ---
>  kernel/trace/ftrace.c | 28 ++++++++++++++++++----------
>  1 file changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index da1710499698..838d175709c1 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1581,7 +1581,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>  }
>  
>  /**
> - * ftrace_location_range - return the first address of a traced location
> + * ftrace_location_range_locked - return the first address of a traced location
>   *	if it touches the given ip range
>   * @start: start of range to search.
>   * @end: end of range to search (inclusive). @end points to the last byte
> @@ -1592,7 +1592,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>   * that is either a NOP or call to the function tracer. It checks the ftrace
>   * internal tables to determine if the address belongs or not.
>   */
> -unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> +static unsigned long ftrace_location_range_locked(unsigned long start, unsigned long end)
>  {
>  	struct dyn_ftrace *rec;
>  
> @@ -1603,6 +1603,17 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>  	return 0;
>  }
>  
> +unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> +{
> +	unsigned long loc;
> +
> +	mutex_lock(&ftrace_lock);
> +	loc = ftrace_location_range_locked(start, end);
> +	mutex_unlock(&ftrace_lock);

I'm not so sure we can take a mutex in all places that call this function.

What about using RCU?

	rcu_read_lock();
	loc = ftrace_location_range_rcu(start, end);
	rcu_read_unlock();

Then in ftrace_release_mod() we can have:

 out_unlock:
	mutex_unlock();

	/* Need to synchronize with ftrace_location() */
	if (tmp_pages)
		synchronize_rcu();

-- Steve


> +
> +	return loc;
> +}
> +
>  /**
>   * ftrace_location - return the ftrace location
>   * @ip: the instruction pointer to check
> @@ -1614,25 +1625,22 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>   */
>  unsigned long ftrace_location(unsigned long ip)
>  {
> -	struct dyn_ftrace *rec;
> +	unsigned long loc;
>  	unsigned long offset;
>  	unsigned long size;
>  
> -	rec = lookup_rec(ip, ip);
> -	if (!rec) {
> +	loc = ftrace_location_range(ip, ip);
> +	if (!loc) {
>  		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
>  			goto out;
>  
>  		/* map sym+0 to __fentry__ */
>  		if (!offset)
> -			rec = lookup_rec(ip, ip + size - 1);
> +			loc = ftrace_location_range(ip, ip + size - 1);
>  	}
>  
> -	if (rec)
> -		return rec->ip;
> -
>  out:
> -	return 0;
> +	return loc;
>  }
>  
>  /**


