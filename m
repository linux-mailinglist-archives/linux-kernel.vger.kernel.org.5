Return-Path: <linux-kernel+bounces-83670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE83869D0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78999283737
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F50825757;
	Tue, 27 Feb 2024 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAGGJVUS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC95A38DD5;
	Tue, 27 Feb 2024 17:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709053418; cv=none; b=qE8Q2blgg+XoPzOEuo06ODVyb8XLwO0exSISr9r3pbkwSQHDbmhiwFTLXbGNQ+1JpKwKAikC35GShg2ITCN41+I/l6L+YmU6EQiUEW3byepie2I28w+HkCM6TyStXICgukrjFD8fwpMdgivbNwRQwXpOq29HmGLpd8OmviAhM5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709053418; c=relaxed/simple;
	bh=1/bBE1XLy4K5uJe2V1Vu4Qkqw5RQ+NsxPuHoElXjpTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jyy+I8EvEBsQ6PPLE/BRSzR/smbepnpIjsULQm8crViBVPfexX/+f8k3qbYCbBzpBthZxmwY8Zqwi9DF4P4XRT7EPwwhClbtmGdr8rELOaJWyL/9kcuRXlBzh6DrWCWBCATUpjAJbKdWXieVdsozRYFw9zJFeP0Lp4IrUup6Fso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAGGJVUS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE590C433C7;
	Tue, 27 Feb 2024 17:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709053418;
	bh=1/bBE1XLy4K5uJe2V1Vu4Qkqw5RQ+NsxPuHoElXjpTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JAGGJVUSrTwX/KkHBqEDAPZV/3Ri4Z+yjiosNvfEJVX0TreKnaHbhm0SlpB2RtTbC
	 Dx2gRfMjxjm6SCfHL9uYwGJlY8wy7i+dDVJBQhSIHkz857yk77mekpqQgN97tyJK0P
	 eLs/Mts1gRkp/heNwLnrws9gZBEKSTyyPN2u9+VB+Pyv1vAMY3Nmxdsz9vrW2FVcIr
	 A+2VrExRZLv2rauRkncLJDv0/Ehen93zP/2j8UYypauI1e/YRs5xaIJkaL6HhaSSFC
	 bXI66Eug83/L9pxPnaP0ahp+dDRHLATUbv6zY2A9NuDjM5OeWsA8BIJDyfNXjonhbp
	 TFoZZhJyPBzPQ==
Date: Tue, 27 Feb 2024 18:03:35 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <Zd4V52g0ARybAUQE@localhost.localdomain>
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
> +/*
> + * Helper function for rcu_gp_cleanup().
> + */
> +static void rcu_sr_normal_gp_cleanup(void)
> +{
> +	struct llist_node *wait_tail;
> +
> +	wait_tail = rcu_state.srs_wait_tail;
> +	if (wait_tail == NULL)
> +		return;
> +
> +	rcu_state.srs_wait_tail = NULL;
> +	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
> +
> +	// concurrent sr_normal_gp_cleanup work might observe this update.
> +	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> +	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> +
> +	if (wait_tail)
> +		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);

You can queue unconditionally here, wait_tail is non-NULL at this point.

Thanks.

