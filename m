Return-Path: <linux-kernel+bounces-156580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 586D78B051D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1595628622A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D179158A1A;
	Wed, 24 Apr 2024 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XctjqQA5"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B57157468
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 08:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948953; cv=none; b=uGavHGdv7nVPk7BALws+sNbt1oi0bwVAAuYHFN+SiT5Jh7uOZg+LsSQb77mTTwelxTV3oMWerjAWZy2Se5iJls//fRe16rW8KvEYB8xDZQ58LuqydF6cl2Npn3XbMR90LaD8O/O+9vWTsjXgsX+UiMdo2VDcLREGzy6I0oPxxtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948953; c=relaxed/simple;
	bh=o9ieXt4YsstwVp8erJoixPiBUSmpe1lBbhh/3wG2GZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICzEB7B61A1rxNaUeHOwQDYPJCoIGEwqPPLfNV+U9XmGAPGXcKd2ATfk1CBInjsZpvZFztyGlnjlBmW3DrNmmiH0Hfr7q7y4Nh55nSebNyZdRQTSPwy6P+AAR/6p6hnL1LCJ0G9fgOA5HQAHR1wsXV/F38HOCoVYX8Ipna/+W2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XctjqQA5; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0WNxoRpoZX+6fP6MFZJq0xwYM7fV0oJP00z3XTiuTEQ=; b=XctjqQA5AFhGRfsmnSwBTs9Pas
	VRARhW6xFa6yVsV0UZp6CHcfjO/FN30bHmvZndoXxlp/+GCy7y2JYwRnZz566wITPW2yGkWpLto9E
	ts8IySeHaNmXgsIbKj1hGDbODjnw5KaOaPGphviYW+2laDYS4znQIjl1yT3i36szMyXPp52+oxFhP
	pmQsYmFLgLSU6SU9Z1t5QmyHy9dBk51QOlL2AmJzy5gMRtDNS/f19eEATu5GrvC4B7x6SsE9ZWS47
	Fv52gYEUJzfqqCpsvQJYiw+Sa+hCi38cFPpjPTbSnpYweqEUypiQvlsI2+lI8O+V5Uex/Pe5l0bVx
	F8uGGPbg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzYPd-0000000EKz7-2MGF;
	Wed, 24 Apr 2024 08:55:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 37D9230043E; Wed, 24 Apr 2024 10:55:33 +0200 (CEST)
Date: Wed, 24 Apr 2024 10:55:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: hupu@oppo.com
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, wuyun.abel@bytedance.com
Subject: Re: [PATCH] sched/fair.c: Fix the calculation method of 'lag' to
 ensure  that the vlag of the task after placement is the same as before.
Message-ID: <20240424085533.GS40213@noisy.programming.kicks-ass.net>
References: <20240423114416.64308-1-hupu@oppo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423114416.64308-1-hupu@oppo.com>

On Tue, Apr 23, 2024 at 07:44:16PM +0800, hupu@oppo.com wrote:
> From: hupu <hupu@oppo.com>
> 
> I think the 'lag' calculation here is inaccurate.
> 
> Assume that delta needs to be subtracted from v_i to ensure that the
> vlag of task i after placement is the same as before.

Why ?!? v_i is the unkown, it makes no sense to complicate things by
adding extra unknowns.

> At this time, the
> vlag of task i after placement should be:
> vl'_i = V' - (v_i - delta)

But but but, you can't have V' without knowing v_i.

> From the above formula, we know that vl'_i should be:
> vl'_i = (vl_i * W)/(W + w_i)
> 
> That is to say:
> V' - (v_i - delta) = (vl_i * W)/(W + w_i)
> 
> For a newly added entity, generally set v_i to V', and the above formula
> can be converted into:
> V' - (V' - delta) = (vl_i * W)/(W + w_i)
> 
> Therefore the value of delta should be as follows, where delta is the
> 'lag' in the code.
> delta = (vl_i * W)/(W + w_i)
> 
> Signed-off-by: hupu <hupu@oppo.com>
> ---
>  kernel/sched/fair.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 03be0d1330a6..c5f74f753be8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5239,9 +5239,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  		if (curr && curr->on_rq)
>  			load += scale_load_down(curr->load.weight);
>  
> -		lag *= load + scale_load_down(se->load.weight);
> +		lag *= load;
> +
> +		load += scale_load_down(se->load.weight);
>  		if (WARN_ON_ONCE(!load))
>  			load = 1;
> +
>  		lag = div_s64(lag, load);

You're making it:

	v_i = V - (W * vl_i) / (W + w_i)

In direct contradiction to the giant comment right above this that
explains why the code is as it is.

>  	}
>  
> -- 
> 2.17.1
> 

