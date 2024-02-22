Return-Path: <linux-kernel+bounces-77332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31DA08603E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55A851C250B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1B71730;
	Thu, 22 Feb 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4d+tJLJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62F6AF8B;
	Thu, 22 Feb 2024 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708634765; cv=none; b=hFRk4LWBaUhSQStJ1776JyhF54OgIVlKorX33DRKIKqw3QaCHxmI+OoiGMXJnFgXlgn1aH2FUDmLLfdAQF2sfpRbCBqXS4YoZWJKpI4TnHXCBiST/k+ert21dJWSX5rkU/GGN/W5RGAnlxmgt83Oj43KZ7eHasBxDZpe3rfqgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708634765; c=relaxed/simple;
	bh=5HxuEoK3YkrACdtWuNiKltFl3vPUbSE33TPRYygQcuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2m89ySRgZ1zIqvA3KdKV9VynimPVrWCZyM5Lbv4zVEKunWbG8muXN6d2eaawa77Q1XLvUOWZdp7mhu9blFIXGY4o5VZ7kEbKMM5rkf6FvYm2pmogyPtM0D/vQThSQruyj23ghNJze4NXuTioteJoGOTU5AkWuTUiD94pwhwgUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4d+tJLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E36EC433F1;
	Thu, 22 Feb 2024 20:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708634764;
	bh=5HxuEoK3YkrACdtWuNiKltFl3vPUbSE33TPRYygQcuI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=S4d+tJLJaY1a/gKVk4dRG215qcKo8JvQq8+jWscR74XlXY+Avpc8OZwPBL4H4PoZH
	 zKhCxYf27GZFV6MN2P0+fMd0aDO1iOj6h+l4EapJtKco4TCkULKEoWQRz3kIZa7vvB
	 QG2QrI3G6ru3XtEfqQ6vdSksQQrQPuP6B51muEnLpqelwbjuXau6Hjdt/U4A+RMJYT
	 tLRvWoPMimVUxY83pLUBJSDmKr4NjGlWkwK/so/zLMVSFtj5fwo3Ly8wW67MfiAr8V
	 2RKwtS8Holtahqpe2Lg1d87jNm8/4qorKPc3vuSX1WlQDIfYVqCqKTK7tGWHyKEnTT
	 60OqniFzdQdVQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 309B3CE0738; Thu, 22 Feb 2024 12:46:04 -0800 (PST)
Date: Thu, 22 Feb 2024 12:46:04 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 2/6] rcu-tasks: Add data to eliminate
 RCU-tasks/do_exit() deadlocks
Message-ID: <142b955c-5984-4eeb-b170-9cc516f90131@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-3-boqun.feng@gmail.com>
 <Zdd8WED095H8VsbY@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zdd8WED095H8VsbY@localhost.localdomain>

On Thu, Feb 22, 2024 at 05:54:48PM +0100, Frederic Weisbecker wrote:
> Le Fri, Feb 16, 2024 at 05:27:37PM -0800, Boqun Feng a écrit :
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > Holding a mutex across synchronize_rcu_tasks() and acquiring
> > that same mutex in code called from do_exit() after its call to
> > exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> > results in deadlock.  This is by design, because tasks that are far
> > enough into do_exit() are no longer present on the tasks list, making
> > it a bit difficult for RCU Tasks to find them, let alone wait on them
> > to do a voluntary context switch.  However, such deadlocks are becoming
> > more frequent.  In addition, lockdep currently does not detect such
> > deadlocks and they can be difficult to reproduce.
> > 
> > In addition, if a task voluntarily context switches during that time
> > (for example, if it blocks acquiring a mutex), then this task is in an
> > RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> > just as well take advantage of that fact.
> > 
> > This commit therefore adds the data structures that will be needed
> > to rely on these quiescent states and to eliminate these deadlocks.
> > 
> > Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> > 
> > Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > Reported-by: Yang Jihong <yangjihong1@huawei.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Tested-by: Yang Jihong <yangjihong1@huawei.com>
> > Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thank you, I have recorded your three review tags.

							Thanx, Paul

