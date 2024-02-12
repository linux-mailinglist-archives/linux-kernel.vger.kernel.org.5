Return-Path: <linux-kernel+bounces-62230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54262851D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:52:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86FF01C224F4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4FD41233;
	Mon, 12 Feb 2024 18:52:40 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A721441206;
	Mon, 12 Feb 2024 18:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763959; cv=none; b=dAd9LRLYcUr724rNp6HGSdZpwaLJu5Uvez7W99UGe/V3YIMHXueC+JPyiHBI0rdnYaB9CAwYqZdyxVuyXp116gOTMW1KgJFdsMJ6HKuNxyqa7z1dep0JxMjcKRW+PEwmuIc0ijHN0KEyQTFBT0IgBXbWcQ6Hr7Ygy9VhjDkV+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763959; c=relaxed/simple;
	bh=Q5A4rNQ8gxAzUuOWSk/FOunFd5wB+QiktWiYf+9QpVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kX1IdsfHZmmDJi/+egaI0GFO7P3MCHaO8pToQq5JUXByDuvuhWds7WzrkPAF6NcUTOFgfb5LNG7K7Azz9aTa4s3J4VwAHejeDwu1LMC0L/6ZSbuRxLFae03cE3EYqi+ICLptPy8stosJon6jZ1B5WuM4wypa5O8OV3ILaGAmSA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5838AC433C7;
	Mon, 12 Feb 2024 18:52:38 +0000 (UTC)
Date: Mon, 12 Feb 2024 13:53:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use ring_buffer_record_is_set_on() in
 tracer_tracing_is_on()
Message-ID: <20240212135320.26f90f28@gandalf.local.home>
In-Reply-To: <8c986cb3-61b3-4f65-81c9-ffcfa994390f@linux.ibm.com>
References: <20240205065340.2848065-1-svens@linux.ibm.com>
	<20240205075504.1b55f29c@rorschach.local.home>
	<yt9djznj3vbl.fsf@linux.ibm.com>
	<20240205092353.523cc1ef@rorschach.local.home>
	<yt9d34u63xxz.fsf@linux.ibm.com>
	<yt9dsf262d2n.fsf@linux.ibm.com>
	<20240206060113.39c0f5bc@rorschach.local.home>
	<yt9deddovn3w.fsf@linux.ibm.com>
	<20240207060923.182ecb55@rorschach.local.home>
	<9a062196-ccbe-440e-a2f9-23eb8c5eb837@linux.ibm.com>
	<20240207072812.4a29235f@rorschach.local.home>
	<yt9dzfwch00u.fsf@linux.ibm.com>
	<20240207104703.071ee985@rorschach.local.home>
	<8c986cb3-61b3-4f65-81c9-ffcfa994390f@linux.ibm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 Feb 2024 11:25:50 +0100
Mete Durlu <meted@linux.ibm.com> wrote:

> I have been only able to reliably reproduce this issue when the system
> is under load from stressors. But I am not sure if it can be considered
> as *really stressed*.
> 
> system : 8 cpus (4 physical cores)
> load   : stress-ng --fanotify 1 (or --context 2)
> result : ~5/10 test fails
> 
> of course as load increases test starts to fail more often, but a
> single stressor doesn't seem like much to me for a 4 core machine.
> 
> after adding synchronize_rcu() + patch from Sven, I am no longer seeing
> failures with the setup above. So it seems like synchronize_rcu() did
> the trick(or at least it helps a lot) for the case described on the
> previous mail. I couldn't trigger the failure yet, not even with
> increased load(but now the test case takes > 5mins to finish :) ).

Right, it will definitely force the race window to go away.

Can you still trigger this issue with just Sven's patch and not this change?

-- Steve

> 
> Here is the diff:
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> @@ -9328,10 +9328,12 @@ rb_simple_write(struct file *filp, const char 
> __user *ubuf,
>                          val = 0; /* do nothing */
>                  } else if (val) {
>                          tracer_tracing_on(tr);
> +                       synchronize_rcu();
>                          if (tr->current_trace->start)
>                                  tr->current_trace->start(tr);
>                  } else {
>                          tracer_tracing_off(tr);
> +                       synchronize_rcu();
>                          if (tr->current_trace->stop)
>                                  tr->current_trace->stop(tr);
> 
> Not 100% sure if these were the correct places to add them.

