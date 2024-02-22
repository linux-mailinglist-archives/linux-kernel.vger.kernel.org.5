Return-Path: <linux-kernel+bounces-76910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA4385FE80
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37157281D35
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3101474B6;
	Thu, 22 Feb 2024 16:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgleK6KZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB9A15530D;
	Thu, 22 Feb 2024 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620892; cv=none; b=cuj+UuTFPqg0ARWGm158Cut60wWlX2bOfOIs80QVE+zpyUa7a4QTfYqK3l2FVH3zF5eDZWe+svqtBk6O29iwMLGO1yvoLzf3NXpiC79c5p9Vr3utTHW6Ef0ApNxQKU5tneCScpCfAs1+wZT7zRRJz8r9IKRvcb6N0Zx6cXUx6xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620892; c=relaxed/simple;
	bh=9cY5jx/umKBQXhkjaty2wtDlATbIFuzu8zNWrAbZnEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nh2VNtPTVpw+lJ/5+fEV3fI3qO6Kq+zM2TKTjJ4lT/8dqOrIBoy9Yic9WQUdKAoh42gZcx0wrfLVEbhad9XYbKPPjPMOxKHYFDQouw3sq3OID2pjyILeXRf6KTj0AVWpPAt1sZ3d4DlBtwrb8XNF17qwWfnr+nfjtkUQ7Kf69YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgleK6KZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9044FC433C7;
	Thu, 22 Feb 2024 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708620890;
	bh=9cY5jx/umKBQXhkjaty2wtDlATbIFuzu8zNWrAbZnEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgleK6KZc8npigGMXlaBEMD75geC7x7eBAmIhAFjdvdugRQKuCluvoxnQmNwi8t1z
	 Dv42AsE4ry3sP4/fRFhVi9H5WgVqs/scDlfcPHw81idn/6czlaqBpGOy20tZRudo4A
	 bOBqnVAiEAtvsi6R0auWZ0/fyQo2uSkg/3QOnJXOMfFv7zaYNb41rlhFGLRwa8sTRV
	 qtFzXCCC5MhBkAIdbLO44qS4qrxe0a5LP7WqeFHaJKur/tFehJX4rYZ8mg7Muga01Q
	 YwZldrqQ4gXpNy0dqkt3YMn+a/zHe+imZ8PWlRX9pvCj+Q44SaiaeZPgKGjATaxJ7c
	 QpgfwpujrIP6w==
Date: Thu, 22 Feb 2024 17:54:48 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <Zdd8WED095H8VsbY@localhost.localdomain>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-3-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240217012745.3446231-3-boqun.feng@gmail.com>

Le Fri, Feb 16, 2024 at 05:27:37PM -0800, Boqun Feng a écrit :
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
> This commit therefore adds the data structures that will be needed
> to rely on these quiescent states and to eliminate these deadlocks.
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

