Return-Path: <linux-kernel+bounces-4562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 988E9817F57
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD2441C22E25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB154402;
	Tue, 19 Dec 2023 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqEconij"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D701FAE;
	Tue, 19 Dec 2023 01:40:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8948BC433C7;
	Tue, 19 Dec 2023 01:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702950042;
	bh=dUKH6D+WzIOMLrgnYnmJD46YvRtTLGyBcs3F5gy8Mq0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nqEconijl9NAh7LJLyv62d/EeGs4eXqV7spb1vnkNwT3hu7MPrvR7AYsXv/PN9mxm
	 OBKFxk1DwQZIlmggh17z+SIH04TYkmjMqh95gMY8uaj3zPeT+TfYk/7wFdRMfEjwby
	 JjjXHv8X8Xkn4+qSYwuFGHbOfj7piL6pSfLEyh7ysTNohR/8oYxO+a022dM7wdaGRz
	 njk1QCgF9cXH605zcwzNe1C7XeHYRutjWes1XCEHvDvJNhZvU0/scBRiqV0VGU1Jki
	 Jp9L4hCCne67b8Vq/pngY2TNhG6LGS7P4j7DLv2MrXp99qbpUsnUT9I5gTlhYkO42e
	 nkQJhf7PxTTkw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 16D35CE0BDF; Mon, 18 Dec 2023 17:40:42 -0800 (PST)
Date: Mon, 18 Dec 2023 17:40:42 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/3] timers & RCU: Fix TREE03 stalls
Message-ID: <b1611b83-f3f5-445c-8be1-286c33703624@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20231218231916.11719-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218231916.11719-1-frederic@kernel.org>

On Tue, Dec 19, 2023 at 12:19:13AM +0100, Frederic Weisbecker wrote:
> 5c0930ccaad5 ("hrtimers: Push pending hrtimers away from outgoing CPU earlier")
> has introduced an issue with RCU. This is a proposal to solve the
> situation after realizing that fixing that on the timers side wouldn't
> be pretty to say the least.
> 
> Oh and the last patch is absolutely irrelevant to the issue...

I pulled all three in and started testing.

That last one will need some careful review, but you knew that already.  ;-)

							Thanx, Paul

> Frederic Weisbecker (3):
>   hrtimer: Report offline hrtimer enqueue
>   rcu: Defer RCU kthreads wakeup when CPU is dying
>   rcu/exp: Remove full barrier upon main thread wakeup
> 
>  include/linux/hrtimer.h |  3 ++-
>  kernel/rcu/tree.c       | 34 +++++++++++++++++++++++++++++++++-
>  kernel/rcu/tree_exp.h   |  8 +++-----
>  kernel/time/hrtimer.c   |  3 +++
>  4 files changed, 41 insertions(+), 7 deletions(-)
> 
> -- 
> 2.42.1
> 

