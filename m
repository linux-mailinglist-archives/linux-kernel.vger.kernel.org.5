Return-Path: <linux-kernel+bounces-78244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE788610A4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B94C1C2217E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6587C090;
	Fri, 23 Feb 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQrH7EoJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24343664D7;
	Fri, 23 Feb 2024 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708688388; cv=none; b=XwPzNV+Fjv4M9xt8W70e5T/Xh9TR6Y8EcpGG4Z9PlUTdBe2sYeZDOjHzNDEJL6k1p5aQS2KKtLFdlYGCfM8wld71jCs2HuYTROY8TC5SgzwAHtooamYv2osA13JNqfRmVPDrB5N7W5Pbs5a/6vP+xbq6+7bNvSJhyS5l8R+5+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708688388; c=relaxed/simple;
	bh=HYUQjAE4WdJ6K+bIyLr2HE5+D/keOdzS3+RV5vP2ak4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1lYD++F4sfxFooEGInNXSxrBbpMatdACJUcAs9GRgdPeZKfh+Nht02IZsRru7U379zHOUBRAPxoJk+GFFTIaXp01L33ssRoefhJnMrkMyWM6gfQah2W6uHLbpYv+rD5ncyr6T7nAkhUU8urH/Qx6ZgcpHUrGLTGCRRcrbP3P3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQrH7EoJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C90C433C7;
	Fri, 23 Feb 2024 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708688387;
	bh=HYUQjAE4WdJ6K+bIyLr2HE5+D/keOdzS3+RV5vP2ak4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sQrH7EoJhU78lDusZtSycgOB5TobF+XgA/Kc798Udpd52zFQ9BSZfvV7jUh+7WoW1
	 vP9IGJiQWhgtajmsAKoYSEdiD4plLU7Km3hX4SkLFQOpavqVCArhgigdIbLbcRntli
	 cdk+FTPZJqBLRv/t7KILVN73mhAUXjwIaKHUIhz2TqAUHyEqygu1d0twfsw7LIp/ha
	 FEPFnpjignENeU8KLOkayxjgd74Vm/4qux1ZWQsuZR6IK6G4hdn7uGxSdRTihx+IqI
	 bxBedPb5NXr5vIFYDTM/PVmdqqLrDuDEXfM5sRuAQHE5PVLXkFW2sCKqo3NkXkm87S
	 HOHhnMJSQPR8g==
Date: Fri, 23 Feb 2024 12:39:44 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org, Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Chen Zhongjin <chenzhongjin@huawei.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Oleg Nesterov <oleg@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peng Zhang <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH v2 3/6] rcu-tasks: Initialize data to eliminate
 RCU-tasks/do_exit() deadlocks
Message-ID: <ZdiEAPczZT+GVuxa@lothringen>
References: <20240217012745.3446231-1-boqun.feng@gmail.com>
 <20240217012745.3446231-4-boqun.feng@gmail.com>
 <Zdd0b3HI4uNAoc2P@localhost.localdomain>
 <1e265c80-2008-4419-8a21-d05c39e1e53e@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1e265c80-2008-4419-8a21-d05c39e1e53e@paulmck-laptop>

On Thu, Feb 22, 2024 at 12:41:55PM -0800, Paul E. McKenney wrote:
> On Thu, Feb 22, 2024 at 05:21:03PM +0100, Frederic Weisbecker wrote:
> > Le Fri, Feb 16, 2024 at 05:27:38PM -0800, Boqun Feng a écrit :
> > > From: "Paul E. McKenney" <paulmck@kernel.org>
> > > 
> > > Holding a mutex across synchronize_rcu_tasks() and acquiring
> > > that same mutex in code called from do_exit() after its call to
> > > exit_tasks_rcu_start() but before its call to exit_tasks_rcu_stop()
> > > results in deadlock.  This is by design, because tasks that are far
> > > enough into do_exit() are no longer present on the tasks list, making
> > > it a bit difficult for RCU Tasks to find them, let alone wait on them
> > > to do a voluntary context switch.  However, such deadlocks are becoming
> > > more frequent.  In addition, lockdep currently does not detect such
> > > deadlocks and they can be difficult to reproduce.
> > > 
> > > In addition, if a task voluntarily context switches during that time
> > > (for example, if it blocks acquiring a mutex), then this task is in an
> > > RCU Tasks quiescent state.  And with some adjustments, RCU Tasks could
> > > just as well take advantage of that fact.
> > > 
> > > This commit therefore initializes the data structures that will be needed
> > > to rely on these quiescent states and to eliminate these deadlocks.
> > > 
> > > Link: https://lore.kernel.org/all/20240118021842.290665-1-chenzhongjin@huawei.com/
> > > 
> > > Reported-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > > Reported-by: Yang Jihong <yangjihong1@huawei.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Tested-by: Yang Jihong <yangjihong1@huawei.com>
> > > Tested-by: Chen Zhongjin <chenzhongjin@huawei.com>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Looks good, thanks!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

