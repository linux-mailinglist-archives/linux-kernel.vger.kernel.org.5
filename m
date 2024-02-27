Return-Path: <linux-kernel+bounces-83580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 389FD869BF6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F865B21C4C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7083F13B2A8;
	Tue, 27 Feb 2024 16:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rwfC0dGK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B667B1474A5;
	Tue, 27 Feb 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709050511; cv=none; b=k9WuRUMomnvEAnOGUnCv50Avi5CIEW293Xi6O/q8e9nGhSSfueQ2LdlWURsj9B7M03Mx2Z1YLtu6v7zx9YKIjA1Xg5mNTYcUnC7Jp1P5QS9rvqOriFlHX7SFLuaMQF54q8yeg/hmiC9XGYM2C1pn/jB5jpdtAXeCSpnPD28Lls0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709050511; c=relaxed/simple;
	bh=9phnZqI/p+RrHBITJ6u9yXLy+AnyeKje1wey9GQybqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxE1RkZgczATe6UReyYnxk/IdQ5GRidIxvCzJpvBLhsmHhuLUuuX6OobKjLwnaDdvHvIARA2fOwq79FcsYEfA7QXWec3i77GlpJzM2vEMlh9K11gx8lBV/jZsyBB+eoT/7klB33O6kyRWtnUWh3vQmDjr3z39UuoR5XvNpC/FY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rwfC0dGK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5093C433F1;
	Tue, 27 Feb 2024 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709050510;
	bh=9phnZqI/p+RrHBITJ6u9yXLy+AnyeKje1wey9GQybqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rwfC0dGKMFZa+ko3AnfglI5z2LBIy9CQ2e9I4scLMDqMC8E7WupN46PHjyhdIEVkX
	 5YxVqaC70rV730ag9NhpEADK0MHGkebHuvAfNcWXTaBYlxCA3DIcnMdgkUnYqP7QvT
	 MFCapdc9wdaQBmvspv/60pVTJzc7mnXGn3HlWoqejHgQhKrOkV0wAGL+RYxIh5xcCb
	 +hLjaU3w1hLO+HtJhzTdVNIr0SI4lRga+pdC8ohDnIYJ7B3L1ndCRgBW96iKN/bQhL
	 gNSobVPllEtd+oYEkzIlbdi2Aek3WU0MeMnzDYHSymULveRjfWY2WVl/2biQlJBx5Y
	 6FqbzDtqk1dZA==
Date: Tue, 27 Feb 2024 17:15:07 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zd4KizFuP4aGuNLE@localhost.localdomain>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220183115.74124-3-urezki@gmail.com>

Le Tue, Feb 20, 2024 at 07:31:13PM +0100, Uladzislau Rezki (Sony) a écrit :
> +static struct llist_node *rcu_sr_get_wait_head(void)
> +{
> +	struct sr_wait_node *sr_wn;
> +	int i;
> +
> +	for (i = 0; i < SR_NORMAL_GP_WAIT_HEAD_MAX; i++) {
> +		sr_wn = &(rcu_state.srs_wait_nodes)[i];
> +
> +		if (!atomic_cmpxchg_acquire(&sr_wn->inuse, 0, 1))
> +			return &sr_wn->node;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void rcu_sr_put_wait_head(struct llist_node *node)
> +{
> +	struct sr_wait_node *sr_wn = container_of(node, struct sr_wait_node, node);
> +	atomic_set_release(&sr_wn->inuse, 0);

Can we comment this release/acquire pair?

IIUC, the point is that we must make sure that the wait_head->next fetch
happens before it gets reused and rewritten to something else.

Thanks.

