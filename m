Return-Path: <linux-kernel+bounces-133660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6377B89A70D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 00:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040651F228CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 22:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5706D175553;
	Fri,  5 Apr 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PXNx6pVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3041C6A8
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 22:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354633; cv=none; b=UCEJ2Cq8BCiO4j65r7il5uojLroLMbYpJJXIufjEimLag8URQOpPWSTYGLos/9XHwBH0wWGvWoy6HxfQi+nsvjw606UH9voRxqPaDXKAGCkokUBL9i7n+H7COb7A5MBQt/JpmFdheUQUm2BD2CL5Cushk65z9kOi1M3kEhqWOPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354633; c=relaxed/simple;
	bh=6fvBs5K7EkwFblWVj+nBmhxGER3ybYM0lpr/wQ+brfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcoCUnfc3aA6aW2zq426sNVBGldU2SDI5GQRcRDCFzG7WxNQocYrmGRZ22lyw0K1KHMPzAwV2hEv2rf7186QmQrLZD0aNGiPdR7LOuXQPNRkQR1jLEDaVg5KXyninNYaevB1gnkk9O28GPa6+k5qXkxODNpIhlO0N4dO/6WPe0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PXNx6pVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95FB6C433C7;
	Fri,  5 Apr 2024 22:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712354633;
	bh=6fvBs5K7EkwFblWVj+nBmhxGER3ybYM0lpr/wQ+brfo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PXNx6pVwR6ygQIlRc1cKuJkSSToTejNTDZNmGnSBg4zLXBaJTQh5YwTKYtR80rHXD
	 omlX+/AhgbpJtU7X1dYb8kyW+udZFaYp976wFsCLDTe6b2R14gCgSCI3l9y+0s7dgh
	 4+S5R+Y09ZbOijJAiKpUmZ5m01pcrWhw7nlaMgtLowktDqO/3i1YUzR9qACsqO7yyw
	 /l0y2TQvoKb+rQWaQ5jbLo5uZWl665k3NraqDOPEpYyl/JWkLERjtMoGPXEtwJ1+C2
	 mrUhTbPtbC83j2AeacQER2QY1Vby+VI4cX4nf84weNSzwuKX4C7KjOv4PbCtn8LLCZ
	 ea/miywIobfBQ==
Date: Sat, 6 Apr 2024 00:03:50 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Tejun Heo <tj@kernel.org>, Nick Piggin <npiggin@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on
 queue_delayed_work
Message-ID: <ZhB1RrjyTDtbwMjZ@localhost.localdomain>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
 <ZhAbDkzlKhvHee49@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAbDkzlKhvHee49@slm.duckdns.org>

Le Fri, Apr 05, 2024 at 05:38:54AM -1000, Tejun Heo a écrit :
> > > > > So it seems that we should fix housekeeping_setup() ? see the patch below.
> > > > >
> > > > > In any case the usage of cpu_present_mask doesn't look right to me.
> > > > >
> > > > > Oleg.
> > > > >
> > > > > --- a/kernel/sched/isolation.c
> > > > > +++ b/kernel/sched/isolation.c
> > > > > @@ -129,7 +154,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
> > > > >  	cpumask_andnot(housekeeping_staging,
> > > > >  		       cpu_possible_mask, non_housekeeping_mask);
> > > > >
> > > > > -	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
> > > > > +	if (!cpumask_test_cpu(smp_processor_id(), housekeeping_staging)) {
> > > > >  		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
> > > > >  		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
> > > > >  		if (!housekeeping.flags) {
> 
> Ensuring the boot CPU always be a housekeeping CPU makes sense to me but I'm
> not very familiar with the housekeeping code. Frederic, what do you think?

I vote for reverting:

  08ae95f4fd3b (nohz_full: Allow the boot CPU to be nohz_full)

And if that's not possible because there are actual users of it, then
the best we can do is to make housekeeping_any_cpu() return smp_processor_id()
if the housekeeping_mask() is empty. Or rather if the housekeeping_mask is
empty, return cpumask_of(smp_processor_id()).

Of course that's merely just a bandaid.

Thanks.

