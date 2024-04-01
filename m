Return-Path: <linux-kernel+bounces-127015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E488945D5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77925B21307
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 20:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771E53815;
	Mon,  1 Apr 2024 20:00:59 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E713D9E;
	Mon,  1 Apr 2024 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712001658; cv=none; b=V+q5mATktvSGNj9izHL8YJJbMIdAqq1oHN0z8MQHfC1/JJAbHtrvEP8yqF28KI6Vtk3JHUOc/L1zNfHLu2MF003nV0EN5HXsnxMFLnEd9G2Ku703KCprVxtSOFUQk1NNKNPtfOf277rAi456Cn8p1MoICGpukou8+8vi6Dmgtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712001658; c=relaxed/simple;
	bh=VOBnvpteYLOm2apkTlbfYOwoE5UU50XDzaYsVhOdiwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uwZzNqils3Czf8XEe3xWYyEha0YmsZfvFPEB/5fz3oX9Cil1d9jf2zgyfT0MKP5bTSL1Qh9b6m+jdWBFIM6UfIYcgH3BfC1eS/9h3VpCVidhaltZiNBfeENa72HSCr5XkRtlAmUi6pjZbBcn5B0S5zVQlIIutd6Mh+Vz0uoOG/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062C2C433F1;
	Mon,  1 Apr 2024 20:00:56 +0000 (UTC)
Date: Mon, 1 Apr 2024 16:03:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v3] rcu: Fix buffer overlow in print_cpu_stall_info()
Message-ID: <20240401160312.7b03e568@gandalf.local.home>
In-Reply-To: <20240401194315.362090-1-kiryushin@ancud.ru>
References: <20240401150540.6dab14fc@gandalf.local.home>
	<20240401194315.362090-1-kiryushin@ancud.ru>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 22:43:15 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> rcuc info output in print_cpu_stall_info() contains
> posiible buffer overflow in the case of huge jiffies
> difference. The situation seems improbable, but, buffer
> overflow, still.
> 
> Also, unsigned jiffies difference printed as (signed)
> %ld. This is intentional for debugging purposes, but
> it is not obvious from the code.
> 
> Change sprintf to snprintf and add clarifying comment
> about intention of %ld format.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 245a62982502 ("rcu: Dump rcuc kthread status for CPUs not reporting quiescent state")
> Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
> ---
> v3: Change intention comment wording as
> Steven Rostedt <rostedt@goodmis.org> suggested
> v2: Remove signed to unsigned print format change as
> Paul E. McKenney <paulmck@kernel.org> suggested, add format
> intention clarification comment
>  kernel/rcu/tree_stall.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 5d666428546b..320440b8384e 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -504,7 +504,8 @@ static void print_cpu_stall_info(int cpu)
>  			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
>  	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
>  	if (rcuc_starved)
> -		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
> +		/* Print signed value, as negative means it is likely a bug */
> +		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
>  	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",
>  	       cpu,
>  	       "O."[!!cpu_online(cpu)],


Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

