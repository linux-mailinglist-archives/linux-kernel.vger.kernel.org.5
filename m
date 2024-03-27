Return-Path: <linux-kernel+bounces-121763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675F788ED54
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AD21C2B726
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A262152E16;
	Wed, 27 Mar 2024 17:50:08 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4BE14F130;
	Wed, 27 Mar 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711561808; cv=none; b=f1IbshHSA5SwxZXBtHoud6MGZiuOvhDMjN/Z4OtpweydUmO2r+3bsBIsM4FRqjTbn2tY12tDRZl+QkIhJ+KZ0rnZ10lG95arDH+OyrOcMRdg/PYLzBo10HlWWtQoGkuiMeLyN8/ZzGRgUcjwRjwIWB00+9in9JukNJVBTChtLZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711561808; c=relaxed/simple;
	bh=L60+hwzuhgsT0n2An7LhZzoaJZ7ijJhdidT19m3OCZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXqnEvDwgO+UjzEykDVJC+KkEZyydumK1XFgaQyiYIh4Aks7BSOtpBQLfdMEaJn85qQvquDsd19gbU57C87pUaE+VWm0ITQFHJ9k7xlR58MudGr6NPcUy+xeM++SGF5bVBUetA/akyC157usLut/wHK01U8rWHpKn9r9e/gmGXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86402C433C7;
	Wed, 27 Mar 2024 17:50:06 +0000 (UTC)
Date: Wed, 27 Mar 2024 13:52:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v4] rcu-tasks: Fix show_rcu_tasks_trace_gp_kthread
 buffer overflow
Message-ID: <20240327135246.54cdb58e@gandalf.local.home>
In-Reply-To: <20240327174747.612002-1-kiryushin@ancud.ru>
References: <20240327125132.600d62a3@gandalf.local.home>
	<20240327174747.612002-1-kiryushin@ancud.ru>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 20:47:47 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> There is a possibility of buffer overflow in
> show_rcu_tasks_trace_gp_kthread() if counters, passed
> to sprintf() are huge. Counter numbers, needed for this
> are unrealistically high, but buffer overflow is still
> possible.
> 
> Use snprintf() with buffer size instead of sprintf().
> 

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: edf3775f0ad6 ("rcu-tasks: Add count for idle tasks on offline CPUs")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
> v4: Change ARRAY_SIZE to sizeof() as more idiomatic
> as Steven Rostedt <rostedt@goodmis.org> suggested
> v3: Fixed commit message
> v2: Use snprintf() as
> Steven Rostedt <rostedt@goodmis.org> suggested.
>  kernel/rcu/tasks.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 147b5945d67a..2a453de9f3d9 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1994,7 +1994,7 @@ void show_rcu_tasks_trace_gp_kthread(void)
>  {
>  	char buf[64];
>  
> -	sprintf(buf, "N%lu h:%lu/%lu/%lu",
> +	snprintf(buf, sizeof(buf), "N%lu h:%lu/%lu/%lu",
>  		data_race(n_trc_holdouts),
>  		data_race(n_heavy_reader_ofl_updates),
>  		data_race(n_heavy_reader_updates),


