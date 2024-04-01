Return-Path: <linux-kernel+bounces-126971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46241894528
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77C9D1C2165D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CD251C2B;
	Mon,  1 Apr 2024 19:03:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9AA4CE13;
	Mon,  1 Apr 2024 19:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711998206; cv=none; b=kYgkBMj0uvgMCdHUZhWdZx0r7RbtUladC91g8/+aQd4468nS0wTHAz779/35T7HLRLdacyeicg83cBBUfpf5XK8SJypBE3E5DkdRwP49AVtOVfMZXtaVeg7kr80OW790HqTNl71y5gjeLTHu8Y1+tZzTUG9Wjc5ZQNei4WAbg/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711998206; c=relaxed/simple;
	bh=cExGv+FJE8UD0ApN8USdfLbi+102ExdtwV5jd7Wtldo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=azmBbYhAhe9xc6Lbr2OjtIGfyHFR29V3geg8DbEaf07cX6phhQLFqitVNTXRXkiYQbrlaqEgyEs4p8WpEVzuUC/aCupLMurEPjhp/vqxXVP4zaUldlPqkkqrmwTX6+Z2iyH41WnAQ2a8iktSG0KKcPqWXB5Q/Je+pA46MzNKYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D252AC433C7;
	Mon,  1 Apr 2024 19:03:24 +0000 (UTC)
Date: Mon, 1 Apr 2024 15:05:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] rcu: Fix buffer overlow in print_cpu_stall_info()
Message-ID: <20240401150540.6dab14fc@gandalf.local.home>
In-Reply-To: <20240401185454.361291-1-kiryushin@ancud.ru>
References: <5a629a8e-5a70-4c7d-ab6a-f4a09e8c574c@paulmck-laptop>
	<20240401185454.361291-1-kiryushin@ancud.ru>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Apr 2024 21:54:54 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -504,7 +504,8 @@ static void print_cpu_stall_info(int cpu)
>  			rcu_dynticks_in_eqs(rcu_dynticks_snap(cpu));
>  	rcuc_starved = rcu_is_rcuc_kthread_starving(rdp, &j);
>  	if (rcuc_starved)
> -		sprintf(buf, " rcuc=%ld jiffies(starved)", j);
> +		/* %ld is intentional, for easier bug detection */

The above still has assumptions of what is going on for the reviewer.
I would suggest something a bit more obvious like:

		/* Print signed value, as negative means it is likely a bug */


> +		snprintf(buf, sizeof(buf), " rcuc=%ld jiffies(starved)", j);
>  	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%04x/%ld/%#lx softirq=%u/%u fqs=%ld%s%s\n",

-- Steve

