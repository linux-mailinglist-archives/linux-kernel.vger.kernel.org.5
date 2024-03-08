Return-Path: <linux-kernel+bounces-97616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A1B876C80
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C291C21278
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA235FB8D;
	Fri,  8 Mar 2024 21:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GPWe0YY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C1E3FB9E;
	Fri,  8 Mar 2024 21:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709934690; cv=none; b=dX/kYPOhlqOUOOkiE1ZU/vzPd+VHvhMDLnNpWcq/zN3m6Hr4raYjYnmywW/F17Hn2/WCDnWSpRAaduovxll8SyWODdo4RyOnoqnU+luBhQkTlnJQHtJV1afqrfBDjKipRK2haefZ2Y+I2S72w5JJj+uKPGq8p0MFj8KEXw/NPMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709934690; c=relaxed/simple;
	bh=DgzJgOIltqwNHqOYEOKxyuP05a5tnack1aI+I0jVx80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fS7NyFYm+hUvVyv1Q2PFJJZNNMDWo+3soSmEI2iN6tRQXcFWznNNYQ+RAeaMPokINA1xbpeGcv5LKvCqSCdRN/tbJwx7M+ZrU6st2PNjJ38WHFtjnZcewxpv8+oCKWzjiJxoR6oxkAS3LgCJQaGR7oH6k1+Kp/Rjt1Sj/TyYi7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPWe0YY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3535C433C7;
	Fri,  8 Mar 2024 21:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709934689;
	bh=DgzJgOIltqwNHqOYEOKxyuP05a5tnack1aI+I0jVx80=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=GPWe0YY/kEBNEc1ubsPcyYiz2c0B6cJyve3g/YCfzKDan0ab3yZC3ex4yzzkdwUli
	 K2FcS7+9jkygAz/5UAm1bPCLM1/X1n1vkNs4x2jUvsi1rqmO4/qdUexNBMMb7MQBm+
	 2plBuuXVcZvIiWI3y+9v9vsITButre0CPay5gI+mhZvJPnQ5HnU2ZEZqLqTGH5wush
	 g4O0VJIUCCL4+GfMRgQsYGUDupr1a3KW02fwuYAZujHHVrHU3vcB1yaAF528lHQdoY
	 hEfFVH6Y2finwnCWkgZAEf/Frxqh1Z22hXPLWcLEwUz49V7wdVLfB1P01etVZ6UO0d
	 QkpA64DbQZffA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 86F38CE0548; Fri,  8 Mar 2024 13:51:29 -0800 (PST)
Date: Fri, 8 Mar 2024 13:51:29 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v6 0/6] Reduce synchronize_rcu() latency(v6)
Message-ID: <63e54cb9-fd08-43c3-9f42-3627198634e8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240308173409.335345-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308173409.335345-1-urezki@gmail.com>

On Fri, Mar 08, 2024 at 06:34:03PM +0100, Uladzislau Rezki (Sony) wrote:
> This is v6. It is based on the Paul's "dev" branch:
> 
> HEAD: f1bfe538c7970283040a7188a291aca9f18f0c42
> 
> please note, that patches should be applied from scratch,
> i.e. the v5 has to be dropped from the "dev".
> 
> v5 -> v6:
>  - Fix a race due to realising a wait-head from the gp-kthread;
>  - Use our own private workqueue with WQ_MEM_RECLAIM to have
>    at least one execution context.
> 
> v5: https://lore.kernel.org/lkml/20240220183115.74124-1-urezki@gmail.com/
> v4: https://lore.kernel.org/lkml/ZZ2bi5iPwXLgjB-f@google.com/T/
> v3: https://lore.kernel.org/lkml/cd45b0b5-f86b-43fb-a5f3-47d340cd4f9f@paulmck-laptop/T/
> v2: https://lore.kernel.org/all/20231030131254.488186-1-urezki@gmail.com/T/
> v1: https://lore.kernel.org/lkml/20231025140915.590390-1-urezki@gmail.com/T/

Queued in place of your earlier series, thank you!

Not urgent, but which rcutorture scenario should be pressed into service
testing this?

							Thanx, Paul

> Uladzislau Rezki (Sony) (6):
>   rcu: Add data structures for synchronize_rcu()
>   rcu: Reduce synchronize_rcu() latency
>   rcu: Add a trace event for synchronize_rcu_normal()
>   rcu: Support direct wake-up of synchronize_rcu() users
>   rcu: Do not release a wait-head from a GP kthread
>   rcu: Allocate WQ with WQ_MEM_RECLAIM bit set
> 
>  .../admin-guide/kernel-parameters.txt         |  14 +
>  include/trace/events/rcu.h                    |  27 ++
>  kernel/rcu/tree.c                             | 361 +++++++++++++++++-
>  kernel/rcu/tree.h                             |  20 +
>  kernel/rcu/tree_exp.h                         |   2 +-
>  5 files changed, 422 insertions(+), 2 deletions(-)
> 
> -- 
> 2.39.2
> 

