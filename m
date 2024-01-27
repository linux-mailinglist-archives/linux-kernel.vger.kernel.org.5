Return-Path: <linux-kernel+bounces-41085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7376E83EB94
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 08:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969691C2169D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 07:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7371C1D698;
	Sat, 27 Jan 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUWMxGFM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69791D524;
	Sat, 27 Jan 2024 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706339239; cv=none; b=PZT+TPdPVFhJHXz6VVTZessR2xb6V6DakyOee9uq7xiqT7/YSIpmDhsK1pXDL2UrZYaNihdA/qTZKWj2N01wf20rR7/XlHMWK9KpHTIJSKhfn+1tqht4x8qD45PL9EtOYGMezN36SfhhqCW2ZH/f7wTa8mpGaBfs4WtXiOQoHcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706339239; c=relaxed/simple;
	bh=cowBM1wENyFzXVov+SQtnhDqzYj/i8BhLeInL+6Gn8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwFp72+Y8jrrWmJ7aOoNffrmc4e/EDlO0zoleab/3f7wRT44hG4XvXXSiSvJd4b1LB2fCPOgeiQeDlRPWp6QIfjFyO6lyXs0sYq0IUkOpMKsFtpbwoM5rj25d2bclukQ/x6pzLYYeQti++j/fUFas02O9lemR/UkGad681K/8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUWMxGFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C78CC433F1;
	Sat, 27 Jan 2024 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706339239;
	bh=cowBM1wENyFzXVov+SQtnhDqzYj/i8BhLeInL+6Gn8s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=OUWMxGFM+DD4G4kelhTUbMh1SlPs/EhWz5qNrMt+vsyM4FckdL5p7j1XACWih0FWl
	 ZYbI0uNwRakxDwW4hR3Vh3L/ZETHfiO++EOGM6pFPlxU/DO4tjvkllwSrQdcKfsP0z
	 orsy4Hc7Qpwpy2uwY2ZtNAqpqCmgZhFzWf1u5zNF9rwI9Y/j1FN8wuTTR5vngIHz9J
	 wdiIfXBkgrIupwb2dXTzLoXPaFFrjnqYI51guo1fjpVWgtuoTR8KBgHuxRm/JNQMZ/
	 q4OtiPD+wFGQoOKgnVYIqB0KXuLtO8wzZzRxjABZ5n0L85iolqKFMIGYxN9FTxO63r
	 LtIF9PfNjyz6A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C627DCE190D; Fri, 26 Jan 2024 23:07:18 -0800 (PST)
Date: Fri, 26 Jan 2024 23:07:18 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 0/4] Reduce synchronize_rcu() latency(v4)
Message-ID: <620b475d-eef8-4396-9d3a-d3dcf1d70f9a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240104162510.72773-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104162510.72773-1-urezki@gmail.com>

On Thu, Jan 04, 2024 at 05:25:06PM +0100, Uladzislau Rezki (Sony) wrote:
> This is a v4 that tends to improve synchronize_rcu() call. To be more
> specific it is about reducing a waiting time(especially worst cases)
> of caller that blocks until a grace period is elapsed. 
> 
> In general, this series separates synchronize_rcu() callers from other
> callbacks. We keep a dedicated an independent queue, thus the processing
> of it starts as soon as grace period is over, so there is no need to wait
> until other callbacks are processed one by one. Please note, a number of
> callbacks can be 10K, 20K, 60K and so on. That is why this series maintain
> a separate track for this call that blocks a context.

And before I forget (again), a possible follow-on to this work is to
reduce cond_synchronize_rcu() and cond_synchronize_rcu_full() latency.
Right now, these wait for a full additional grace period (and maybe
more) when the required grace period has not elapsed.  In contrast,
this work might enable waiting only for the needed portion of a grace
period to elapse.

							Thanx, Paul

> v3 -> v4:
>  - Squash patches;
>  - Add more description;
>  - Fix comments based on v3 feedback.
> 
> v3: https://lore.kernel.org/lkml/cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop/T/
> v2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
> v1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/
> 
> Neeraj Upadhyay (1):
>   rcu: Improve handling of synchronize_rcu() users
> 
> Uladzislau Rezki (Sony) (3):
>   rcu: Reduce synchronize_rcu() latency
>   rcu: Add a trace event for synchronize_rcu_normal()
>   rcu: Support direct wake-up of synchronize_rcu() users
> 
>  .../admin-guide/kernel-parameters.txt         |  14 +
>  include/trace/events/rcu.h                    |  27 ++
>  kernel/rcu/Kconfig.debug                      |  12 +
>  kernel/rcu/tree.c                             | 361 +++++++++++++++++-
>  kernel/rcu/tree.h                             |  19 +
>  kernel/rcu/tree_exp.h                         |   2 +-
>  6 files changed, 433 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.2
> 

