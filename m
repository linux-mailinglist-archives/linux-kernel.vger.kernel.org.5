Return-Path: <linux-kernel+bounces-119787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEA588CCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C89DE30417C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491DF13CFB0;
	Tue, 26 Mar 2024 19:19:53 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7D13CFAF;
	Tue, 26 Mar 2024 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480792; cv=none; b=QuE33mqU56UEGWxK9QTl2aRG/nZvmlpSn/Gg3NLyeFrZYFTUjaCiF4+0TlWOSNPSuDLuYrXcZsRSMBF/gK3p7815DZ8+eDb33KtahQ931Yz19GHOiXf4HpY0u7iADFTTkvtzqz9cI3fTGvtTixnmX75PMDCIh62n/hUwxceFsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480792; c=relaxed/simple;
	bh=j3QpieVYsqFQsOlMJUmIP/hY4ORtE8TOJtyH7zfzvTI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I38VlHcuAlrAaDQerWnW4PgqW7ZHOkH4MqbjeFzBAPjd4R5GL7b4jH7ELaNFt5FeJHkWd6xQaVxzGdnpPuwmt80jjw8QxMAAIklCtmigSLz238XlWCC3xHebJmlNyPWsP1ttqjprwSXwlK6Reld4DopUF08v59ciyxu7GU6UBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F463C43390;
	Tue, 26 Mar 2024 19:19:50 +0000 (UTC)
Date: Tue, 26 Mar 2024 15:22:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nikita Kiryushin <kiryushin@ancud.ru>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Neeraj Upadhyay <quic_neeraju@quicinc.com>, Joel
 Fernandes <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>,
 Boqun Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] rcu-tasks: Update show_rcu_tasks_trace_gp_kthread
 buffer size
Message-ID: <20240326152230.3e692d83@gandalf.local.home>
In-Reply-To: <20240326174839.487582-1-kiryushin@ancud.ru>
References: <20240326174839.487582-1-kiryushin@ancud.ru>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Mar 2024 20:48:39 +0300
Nikita Kiryushin <kiryushin@ancud.ru> wrote:

> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> index 147b5945d67a..13ac514489c0 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1992,7 +1992,7 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
>  #if !defined(CONFIG_TINY_RCU)
>  void show_rcu_tasks_trace_gp_kthread(void)
>  {
> -	char buf[64];
> +	char buf[87];

Why 87? as it's not even word size, and this is on the stack.

>  
>  	sprintf(buf, "N%lu h:%lu/%lu/%lu",

Better yet, why not just use snprintf()?

	snprintf(buf, 64, "N%lu h:%lu/%lu/%lu",

-- Steve

>  		data_race(n_trc_holdouts),
> -- 

