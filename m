Return-Path: <linux-kernel+bounces-78285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA3861162
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:19:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C175D1F25F77
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5367BAEA;
	Fri, 23 Feb 2024 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUk8JKLn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821357B3F8;
	Fri, 23 Feb 2024 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690785; cv=none; b=ii9caxFLO+sEjZ3h6PoVuUDmWl1fTh4kptu4bBynRfySLWI/GIYFSckna9G/Hs6FOtbEZiAjfA9+YxZrH/CAArn4RHFHI/oBFnfZTgvsmrAGbeW/JXR2gfHuQSY9zKuNJ4jHd+E2MZYIDrRVeZb3CLXhiWGwWCT0ptGcImnbzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690785; c=relaxed/simple;
	bh=4gzU2byppYsDWyO3CpAa2LCcNsiLVRq34acY1QqQOvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBRdcJvv5iKG6XYG2PyfDGrejrHUmtxi8Wdm4DJVAWfALJelL/60l/PDM8TLzoSyjc0GL9dNXaHw516+bYAtN/UlxkqHJfVVI05UPHuUJ46m7wMT4uM6v/Et/7CMvWc/2hh4wbdAfKxxKzSd8V+arlFHYWUzvIOXMXBF0GR5oiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUk8JKLn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F692C433F1;
	Fri, 23 Feb 2024 12:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690785;
	bh=4gzU2byppYsDWyO3CpAa2LCcNsiLVRq34acY1QqQOvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pUk8JKLnlasMOlnYTEAiosWhw2tzY138SY3MZmja683xK+dC80ACUvRFg8GpuwLNN
	 eyJ3AmUU672gn0IaL2TUPnjPiahg2xUq02QrqA6guj9W0rJj5dSQfoUhRrmTTINGAn
	 iRxmQ5baJWzcN/+adE/t9085cT7/pGxOfBViuQ8QtmftYIIUTIGXmjkavib20AxFqu
	 JVuXSAlr0hOL0O+2MHPv/iAa9LkWhOANXjvWiXlCDg5baQOlvfrp256qMB/RFBapvQ
	 s7VkrwTqupBmkPgl9cQsznbtz+ZmsMgLavtnyoQBcnf0ZYG5JAmBJIUlQg9q0c5yna
	 6YWQGSU1rG/pg==
Date: Fri, 23 Feb 2024 13:19:42 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 4/6] rcu-tasks: Maintain lists to eliminate
 RCU-tasks/do_exit() deadlocks
Message-ID: <ZdiNXmO3wRvmzPsr@lothringen>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-5-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217012745.3446231-5-boqun.feng@gmail.com>

On Fri, Feb 16, 2024 at 05:27:39PM -0800, Boqun Feng wrote:
> -void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
> +void exit_tasks_rcu_start(void)
>  {
> -	current->rcu_tasks_idx = __srcu_read_lock(&tasks_rcu_exit_srcu);
> +	unsigned long flags;
> +	struct rcu_tasks_percpu *rtpcp;
> +	struct task_struct *t = current;
> +
> +	WARN_ON_ONCE(!list_empty(&t->rcu_tasks_exit_list));
> +	preempt_disable();
> +	rtpcp = this_cpu_ptr(rcu_tasks.rtpcpu);
> +	t->rcu_tasks_exit_cpu = smp_processor_id();
> +	raw_spin_lock_irqsave_rcu_node(rtpcp, flags);
> +	if (!rtpcp->rtp_exit_list.next)

And then you might want to turn that into a WARN_ONCE.

Thanks.

> +		INIT_LIST_HEAD(&rtpcp->rtp_exit_list);
> +	list_add(&t->rcu_tasks_exit_list, &rtpcp->rtp_exit_list);
> +	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> +	preempt_enable();
>  }

