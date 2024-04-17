Return-Path: <linux-kernel+bounces-149021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F3C08A8A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911001C22AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D03D172BD3;
	Wed, 17 Apr 2024 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R7DYTJNd"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FD81487DF;
	Wed, 17 Apr 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713376545; cv=none; b=jd2JyAEP1zKf8RDZ9wMDnTto7yxCkNFKlq7loP0QcTGoiBmA9ncjFzz6HhKChx0nOyro2jczY2M/CcD2MdLb8EzOINhY2+bNTgTsdmP8tBP5afPvY2TH3Th+BPplVuKXkxZvkFqGrOvAMRmRUYAnn62YjCWgpepQP9SuS9oyqP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713376545; c=relaxed/simple;
	bh=iM1cRx/dRlcToMFYIxS0SCJWI9W90EJVDhqZRt7Jh1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Net0NebJYH0uhtpMnygkaHiObP4/G143n1bwbuvwowgZgmpNcgwGxOgcb+qrL4onKshgh+J18zcnFubEXQAIdkiZN/PKruxLMjoh8FbIVcq6XhM3vPAudIyyhKhUFZLtzQklF8HRyvPoGufBnE6Rj760UlwwDQvIyhaRh1Yt5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R7DYTJNd; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=InWcaRy3h3nbfDQgATItK7nUOOUbF1ycPOVv55Cp7bw=; b=R7DYTJNd8n8/ayp8J3r+y+0izk
	BnBCLmMrEZ8RPWxyf2cv3HpzKGFEBSyu4aIfr4pF9eTeVeO0Oj40XEWmyaXpA0uGTvaf5Fy11+Gjl
	Hh5+GHXybPSmn1VuiPOa8w5SQEc872Q7YkEShx2CdOa4D71qe5WE6qhinyf3OnyIHfhNJMvelo6gs
	BIsGCR7u0X64TVweOu0Pr5T6HWYp1SwdYZ4v+B0vsfwJ8k+sRMOxitce4vuq+ncmkcuBG4iNenbEV
	/5FPlAnOTqxZSxfw9CEkTfVBWbkCNgH55nzZOjFNPsPzhBr5/WnkZMQlH2N3r14Qd4Q/wWl3fdFCw
	RYv4roNA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rx9VT-0000000Bd3H-1UcW;
	Wed, 17 Apr 2024 17:55:39 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 079023002E1; Wed, 17 Apr 2024 19:55:39 +0200 (CEST)
Date: Wed, 17 Apr 2024 19:55:38 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Mike Snitzer <msnitzer@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] completion: move blk_wait_io to
 kernel/sched/completion.c
Message-ID: <20240417175538.GP40213@noisy.programming.kicks-ass.net>
References: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b118f3-bc8d-b18b-c4b9-e57d74a73f@redhat.com>

On Wed, Apr 17, 2024 at 07:49:17PM +0200, Mikulas Patocka wrote:
> Index: linux-2.6/kernel/sched/completion.c
> ===================================================================
> --- linux-2.6.orig/kernel/sched/completion.c	2024-04-17 19:41:14.000000000 +0200
> +++ linux-2.6/kernel/sched/completion.c	2024-04-17 19:41:14.000000000 +0200
> @@ -290,6 +290,26 @@ wait_for_completion_killable_timeout(str
>  EXPORT_SYMBOL(wait_for_completion_killable_timeout);
>  
>  /**
> + * wait_for_completion_long_io - waits for completion of a task
> + * @x:  holds the state of this particular completion
> + *
> + * This is like wait_for_completion_io, but it doesn't warn if the wait takes
> + * too long.
> + */
> +void wait_for_completion_long_io(struct completion *x)
> +{
> +	/* Prevent hang_check timer from firing at us during very long I/O */
> +	unsigned long timeout = sysctl_hung_task_timeout_secs * HZ / 2;
> +
> +	if (timeout)
> +		while (!wait_for_completion_io_timeout(x, timeout))
> +			;
> +	else
> +		wait_for_completion_io(x);
> +}
> +EXPORT_SYMBOL(wait_for_completion_long_io);

Urgh, why is it a sane thing to circumvent the hang check timer? 

