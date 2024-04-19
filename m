Return-Path: <linux-kernel+bounces-151186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9EB8AAAC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB18FB245BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E86CDA1;
	Fri, 19 Apr 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b1QQNlCa"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8DB5F569
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713516337; cv=none; b=DerPTxsZ/LxzTK5jT54x5G4noSYnYGtiuKvpGHiiRKWy5mJrSnfj6h0gE1wmGmRNxuWgNGBYN9E0/E/0KEcPMVCVDBiSZPnJTptWqSSiSds7Pm/6vz7kR1F2xlO+GbVbIkcRfPPRaDhel5aaiI3Epqh7QiGcUiiKDF8LKLCXAs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713516337; c=relaxed/simple;
	bh=7NRyWGLv6fd6dWt/xSwbQXNYXH9MGzPqCrbkCVLXrsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK9pNwSH8dJVEDWzEAHjnnJsk5alwTCqVAm6K6pjWuslWXL1Ttjj95+k6sfMCJhcqr9JUdEEuQahJoHaHT8xRfKH1Pm7i8UUpH48RqrmmHDdQTLCFuIO1VDVIKjx9Cay3gWjmGAuB4q8QeqlnZw/HVNo9Bum0H3BD9SOoSxtMTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b1QQNlCa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Zqq0XVANIFr9fM7fZBaohgGXdk+8/jRaK64JrpLT4Ek=; b=b1QQNlCaoEfgp/9SntTJspdP3l
	mLwlMHbNxyKhGRVG51oGXzP/Kc2xbWfoeZr+u34ESB1rfRT+NJwLjtcwlhGH8HUD1JAFIY7tjJyBo
	zKwVIJh465DURWpjvzzfZQBw1VMH0ZcJtQ/8+F1l+gt7fJNaLyr1D/viY6SqrX6R4MMxbd5riAatQ
	kkwMWc2z/sgX+6RMZ/HHIATcPcbWXSMdqSlgfwN4Sy4HJwZu44g977Ujxkyag3BSnXfyng7R0Vm5j
	9fp9wfqVCudM6uIOeSZWvs19zZwCluuLaVlrDSMrLnCugOeE62W4HCiYSvrKfaGim6TUt2Rkonll7
	VSbA57ow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxjs0-00000007I48-2M6P;
	Fri, 19 Apr 2024 08:45:20 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3B5CD3002E1; Fri, 19 Apr 2024 10:45:20 +0200 (CEST)
Date: Fri, 19 Apr 2024 10:45:20 +0200
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
Message-ID: <20240419084520.GE12673@noisy.programming.kicks-ass.net>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
 <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
 <ZiEaKOQwiNEglYtS@chenyu5-mobl2>
 <20240419082440.GB6345@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240419082440.GB6345@noisy.programming.kicks-ass.net>

On Fri, Apr 19, 2024 at 10:24:40AM +0200, Peter Zijlstra wrote:
> On Thu, Apr 18, 2024 at 09:03:36PM +0800, Chen Yu wrote:
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 31bca05c3612..9f203012e8f5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -696,15 +696,23 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
> >   *
> >   * XXX could add max_slice to the augmented data to track this.
> >   */
> > +
> > +static s64 limit_entity_lag(struct sched_entity *se, s64 lag)
> > +{
> > +	s64 limit;
> > +
> > +	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
> > +	return clamp(lag, -limit, limit);
> > +}
> 
> Right, helper makes sense.

A possible other helper might be the below. But that depends if we want
to clip after scaling too. No super strong preference.

Please post your patch with a proper changelog and we'll get it sorted.


--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -696,15 +696,19 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static s64 entity_lag(u64 avruntime, struct sched_entity *se)
 {
-	s64 lag, limit;
-
-	SCHED_WARN_ON(!se->on_rq);
-	lag = avg_vruntime(cfs_rq) - se->vruntime;
+	s64 vlag, limit;
 
+	vlag = avruntime - se->vruntime;
 	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
-	se->vlag = clamp(lag, -limit, limit);
+	return clamp(vlag, -limit, limit);
+}
+
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	SCHED_WARN_ON(!se->on_rq);
+	se->vlag = entity_lag(avg_vruntime(cfs_rq), se);
 }
 
 /*
@@ -3760,7 +3764,7 @@ static void reweight_eevdf(struct sched_
 	 *	   = V  - vl'
 	 */
 	if (avruntime != se->vruntime) {
-		vlag = (s64)(avruntime - se->vruntime);
+		vlag = entity_lag(avruntime, se);
 		vlag = div_s64(vlag * old_weight, weight);
 		se->vruntime = avruntime - vlag;
 	}

