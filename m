Return-Path: <linux-kernel+bounces-151159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CE8AAA07
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3094928249F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603F52F83;
	Fri, 19 Apr 2024 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KmVmXHmN"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E1E3EA8C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713515099; cv=none; b=g9ztNbIARQsZPenwcXSz/fMKcSuDhwfl+yYct2uQ8eNQgxDvRFMbzGcBJvGvSfHAfjydKWC0iCEfD6RPBJwBCMZJZIO3r1t1oEkyfPQ23pK/OWeaQRwD44ojXg2JxJ6I+aUBiGMkJFEUeqd3tNnDkqRkkkHaw3Nfp6d2lkv9KI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713515099; c=relaxed/simple;
	bh=uGJ6gQhF4xtaVh8DkoSSMEyowEiQyVEblcOoCU+SWmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pULV/8pRXOX0dxVSKCkeO6uhRBvh3qtI3fO7JL+zJmZzYwkkSexetEbOWM/gcUBPgOPw0n9dRMU+pEeA5ik7mF/KZ+CY6S5FtilXS4gyneB2Cf38zri3nW8RIic2iADb41NtQQvJ2md2kBGMDM9p+BP4q1Xc0XrhkzMi6QaT5Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KmVmXHmN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hWwmKuXcipLwwNOWyBLW6snZ40xHGiVaXCKs4svZ0Ng=; b=KmVmXHmNDe9L0zzayfyNQaGwFa
	uKdI8HtxzIx+osADnb0urrkc0NzUnlS8O1c4WL/uRCr2vulhP1BpsvTDrC5dZaaCsYEMJm97rj8AL
	ZY5R+lKfPOXhgnx537Y7lBXBxzXiyx2noLnS9Xmtu1Oz0pgs+aQ6FFT5S6fo4urklTWvtZTCrXBus
	ygNqV9Pc7irh4+8PT3I8Apl/uEnWRNzagUlNU6SNSjkHvROo2CzL89lUAMsDE5VbnTpdQBzg+WYvf
	1Thdyt9t63z1ux9RDZgFm65JwqBNBsH4dKt7wJ/IE8gg4MW+Jhfil0ELp0NLqwON1BK80AexUfiIE
	7+R+Qo9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxjY0-00000007G8h-2Egm;
	Fri, 19 Apr 2024 08:24:40 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 33D093005AA; Fri, 19 Apr 2024 10:24:40 +0200 (CEST)
Date: Fri, 19 Apr 2024 10:24:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>,
	Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <20240419082440.GB6345@noisy.programming.kicks-ass.net>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
 <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
 <ZiEaKOQwiNEglYtS@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiEaKOQwiNEglYtS@chenyu5-mobl2>

On Thu, Apr 18, 2024 at 09:03:36PM +0800, Chen Yu wrote:

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 31bca05c3612..9f203012e8f5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -696,15 +696,23 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
>   *
>   * XXX could add max_slice to the augmented data to track this.
>   */
> +
> +static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
> +{
> +	s64 limit;
> +
> +	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> +	return clamp(lag, -limit, limit);
> +}

Right, helper makes sense.

> @@ -3721,6 +3729,7 @@ static void reweight_eevdf(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  	if (avruntime != se->vruntime) {
>  		vlag = (s64)(avruntime - se->vruntime);
>  		vlag = div_s64(vlag * old_weight, weight);
> +		vlag = limit_entity_lag(se, vlag);
>  		se->vruntime = avruntime - vlag;

So the !on_rq case has clamping in update_entity_lag() which is before
scaling. And that makes more sense to me, because putting a limit on
vlag before the multiplication *should* ensure the multiplication itself
doesn't overflow.

But now you allow it to compute garbage and then clip the garbage.

>  	}
>  
> @@ -3768,6 +3777,9 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
>  
>  	update_load_set(&se->load, weight);
>  
> +	if (!se->on_rq)
> +		se->vlag = limit_entity_lag(se, se->vlag);
> +

Except you now add clamping after scaling too, but in a really weird
place. Should this not go right after the div_s64() that scales?

Unlike the reweight_eevdf() case, there might be an argument for doing
it after scaling in this case. Namely, you can have multiple reweights
stacking their scale ops.


Also, could you put a few words in on how often these clips are hit? I
suspect it's fairly rare (but crucial when it does).

