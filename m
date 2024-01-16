Return-Path: <linux-kernel+bounces-27738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046BD82F513
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64B36B2312D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850751D542;
	Tue, 16 Jan 2024 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sn8YAIa6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C071D52B;
	Tue, 16 Jan 2024 19:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705432315; cv=none; b=nTfpQ5s28ekYCewWLJuDk9szosc+CI5HNOObgefT7R1kcsCRHh2qdQanuqt2RdzAhAHuNAeVXHMloQTQMsRf8djrQXXZnqjmqHeHjTX1++ESnqPipZPm0kbxsLPMEhCkOdmbV5TtkrctjDrNnGBFWjaAb+vqzy2Xy4CzxCvnHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705432315; c=relaxed/simple;
	bh=/drwUU+HTY6+EJK87T3aiN8RP3aLTLuVGm3MejMcAPg=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OjmGeLJlA67zOKR1E8XkgpqSFhnFIJRyqETL8+tmOO2cXydOvF9kII6/1mQ+iqP9mpCivZd0fK8AgOBnPw+9NaJDl0jPxTSPbe2nmMxjgqE8pF6NOo1IzQWejRggfMIgXFvskXHkRTMFp33jSKlSKC4gVxmZEZzBnS9xJZGHIYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sn8YAIa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27551C43394;
	Tue, 16 Jan 2024 19:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705432315;
	bh=/drwUU+HTY6+EJK87T3aiN8RP3aLTLuVGm3MejMcAPg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sn8YAIa678XlyJbtescQ/qnipQawlML7iFqkzXT194nKY2NY39N7FxFZWIpBXG50Q
	 8M3871qhepDbrX5ujAoGX+BjJsPv4o7ALy+/h6tcwYQj0h36NBxWbRVcQAaJfjEQB9
	 kPC/bOinNp0bFgf0JgYt/ZBdc+0eAnyCkvxhHFTmTXkxftJkEkLwMgLqi2yS8WUJrT
	 VyuhAJkv+yajZCLwX5l3ZAFjk8S91LQ/ZgdCrMZjafO4GEuoWa9oHeAWRgYFOO/CyL
	 JxAF9t5IJEXCphjOoieVaN6PuCVGBx2lWOSkmwH5k9qSkDFB8L1KKDtuyxi8Ae62gz
	 0BZUqwdle8PnA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 33EB1CE04A3; Tue, 16 Jan 2024 11:11:53 -0800 (PST)
Date: Tue, 16 Jan 2024 11:11:53 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/7] rcu: Fix expedited GP deadlock
Message-ID: <fc2ff6b8-868b-4ac9-9e9a-4b4655cbfc32@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240112154621.261852-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112154621.261852-1-frederic@kernel.org>

On Fri, Jan 12, 2024 at 04:46:14PM +0100, Frederic Weisbecker wrote:
> TREE04 can trigger a writer stall if run with memory pressure. This
> is due to a circular dependency between waiting for expedited grace
> period and polling on expedited grace period when workqueues go back
> to mayday serialization.
> 
> Here is a proposal fix.
> 
> Changes since v2 (no functional changes, just renames and reorganization):
> 
> _ Move nocb cleanups to their own series
> _ Rename can_queue parameter to use_worker [2/7]
> _ Better explain the rename of the mutex [3/7]
> _ New commit with just code move to ease review [4/7]
> _ Comment declaration of the new rnp->exp_worker field [5/7]
> 
> Thanks.

Hearing no objections, queued for testing and further review,
thank you!

							Thanx, Paul

> Frederic Weisbecker (7):
>   rcu/exp: Fix RCU expedited parallel grace period kworker allocation
>     failure recovery
>   rcu/exp: Handle RCU expedited grace period kworker allocation failure
>   rcu: s/boost_kthread_mutex/kthread_mutex
>   rcu/exp: Move expedited kthread worker creation functions above
>     rcutree_prepare_cpu()
>   rcu/exp: Make parallel exp gp kworker per rcu node
>   rcu/exp: Handle parallel exp gp kworkers affinity
>   rcu/exp: Remove rcu_par_gp_wq
> 
>  kernel/rcu/rcu.h         |   5 --
>  kernel/rcu/tree.c        | 175 +++++++++++++++++++++++++++------------
>  kernel/rcu/tree.h        |  11 ++-
>  kernel/rcu/tree_exp.h    |  78 +++--------------
>  kernel/rcu/tree_plugin.h |  52 ++----------
>  5 files changed, 142 insertions(+), 179 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

