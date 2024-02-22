Return-Path: <linux-kernel+bounces-76902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A448885FE62
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D870282F06
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074EF153BE4;
	Thu, 22 Feb 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2hZtdag"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A519153BCE;
	Thu, 22 Feb 2024 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620385; cv=none; b=GWN5b4y8TtqkFYUwTM0v8X/ew5kfKe2XkLpstsGDJwHjx7tMLjvRJbEBKW04pn5BHC0db+lRf5Ru3r5PppiYO5Ac+fQljKaoG34T6U/mQvhkF1eXlmo2/w6dHvnE3V2dyfTRahQOl+lZ3CquBz4qolWPavCO75XFKmhmqXrK1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620385; c=relaxed/simple;
	bh=SI8rgYcy5xVxInz1JaUkz/QQn9h0SltRhO+47i1XgD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtU3uxztiW1w8Qr6Xq0fdIdSzb388NACmqk4wvbPzS9S+szoFdJVue0YXPS6Jsb9KVD4jvnsGqAieRBlEHPS9qFyt9uXFKGMBksNvCloHUhBalOmb9wHTkYty/kg/8Qc/umeap3RJpSASPi0i9DXBGdwF7DFiH4M90NJsJe1X28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2hZtdag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DB9C433F1;
	Thu, 22 Feb 2024 16:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708620384;
	bh=SI8rgYcy5xVxInz1JaUkz/QQn9h0SltRhO+47i1XgD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V2hZtdagF4x/ThTGHsvbfuxY821HtZKKrSpuhXcjcr+v0IMIA+2ndb+kn7Wer2lm/
	 JQIs3+EKD0ptoaXKJgg0/riqZhSbiNUfVr+GnCCuCa5ShgmCrkOTZko0rrGcoFdBV9
	 QfqMeLDnZPIACmP2smETS1U7Sh2Rx5uYuoGG5KtT7bTd9lF41XxL1zNdLQts1Ys1Gr
	 SQS7Q0u1PIXOY5no77ne28og5+P6D+dZ0l6vM4ohMXxv8xRi4mWWNEt7PB5OAkItUL
	 hmvqytwlvirNbRDBdp9FazG7p+616hZQh85y78bTVeVdobQNbLQFZL50WHpcv5IBHQ
	 VaTEWJDc2mWMQ==
Date: Thu, 22 Feb 2024 17:46:22 +0100
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
Subject: Re: [PATCH v2 5/6] rcu-tasks: Eliminate deadlocks involving
 do_exit() and RCU tasks
Message-ID: <Zdd6Xm15-WfF5cus@localhost.localdomain>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-6-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217012745.3446231-6-boqun.feng@gmail.com>

Le Fri, Feb 16, 2024 at 05:27:40PM -0800, Boqun Feng a écrit :
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> Holding a mutex across synchronize_rcu_tasks() and acquiring
> that same mutex in code called from do_exit() after its call to
> exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> results in deadlock.  This is by design, because tasks that are far
> enough into do_exit() are no longer present on the tasks list, making
> it a bit difficult for RCU Tasks to find them, let alone wait on them
> to do a voluntary context switch.  However, such deadlocks are becoming
> more frequent.  In addition, lockdep currently does not detect such
> deadlocks and they can be difficult to reproduce.
> 
> In addition, if a task voluntarily context switches during that time
> (for example, if it blocks acquiring a mutex), then this task is in an
> RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> just as well take advantage of that fact.
> 
> This commit therefore eliminates these deadlock by replacing the
> SRCU-based wait for do_exit() completion with per-CPU lists of tasks
> currently exiting.  A given task will be on one of these per-CPU lists for
> the same period of time that this task would previously have been in the
> previous SRCU read-side critical section.  These lists enable RCU Tasks
> to find the tasks that have already been removed from the tasks list,
> but that must nevertheless be waited upon.
> 
> The RCU Tasks grace period gathers any of these do_exit() tasks that it
> must wait on, and adds them to the list of holdouts.  Per-CPU locking
> and get_task_struct() are used to synchronize addition to and removal
> from these lists.
> 
> Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> 
> Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Reported-by: Yang Jihong <yangjihong1@huawei.com>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Tested-by: Yang Jihong <yangjihong1@huawei.com>
> Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

