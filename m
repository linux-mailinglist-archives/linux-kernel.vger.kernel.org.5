Return-Path: <linux-kernel+bounces-5511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FFB818B84
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9914EB24194
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69631D521;
	Tue, 19 Dec 2023 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kj0CwLgR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F48D1D13C;
	Tue, 19 Dec 2023 15:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D07EC433C8;
	Tue, 19 Dec 2023 15:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703000843;
	bh=+Jv09aqqB55o8pN1kBnu6kkjl+pN06As0VbU1JQsbLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kj0CwLgRMiWjB+XF6njqtLdfEWyA8oeacX2dl50oJsjHTWd/UMZWnt/OJLqzrsfHc
	 +Ogk7/8vL4hipt5pNY8JmuuRH50X7F1FivoSnE3Mtma5ec7O2HgV544ADt5pPW1qTN
	 DgyWVI2RG5Uijl3Ozr0cPv2eyyqsxAoUV5NAZmPVUkjsZKQEShrL2rMZ9f5q3XN0mr
	 Anzqa1m4lrM0UkdBYhAtnCyvDACQQfdMhUBZY+Q0UeID5MMfzk1hdeObj2+kpuNuhs
	 CgOslLkaQOz4bT9ZzAtUOFjYq0X+qMcmttUq2rC1qQBaBlfxhwF3i1sjFQTjR9Dl73
	 w8uXOGlM22J5g==
Date: Tue, 19 Dec 2023 16:47:20 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] rcu: Defer RCU kthreads wakeup when CPU is dying
Message-ID: <ZYG7COHYyLNwxbNi@lothringen>
References: <20231218231916.11719-1-frederic@kernel.org>
 <20231218231916.11719-3-frederic@kernel.org>
 <b6da15c7-4729-4c7c-a88a-cc6773f9a371@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6da15c7-4729-4c7c-a88a-cc6773f9a371@paulmck-laptop>

On Tue, Dec 19, 2023 at 07:29:23AM -0800, Paul E. McKenney wrote:
> > +static void swake_up_one_online(struct swait_queue_head *wqh)
> > +{
> > +	int cpu = get_cpu();
> 
> This works because get_cpu() is currently preempt_disable().  If there are plans to
> make get_cpu() be some sort of read lock, we might deadlock when synchronize_rcu()
> is invoked from a CPU-hotplug notifier, correct?
> 
> Might this be worth a comment somewhere at some point?

Sure, I can add that.

Thanks.

