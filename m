Return-Path: <linux-kernel+bounces-33153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B147836553
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53EA328359C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A433D3AE;
	Mon, 22 Jan 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV86V6/s"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07A3D0AB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705933539; cv=none; b=QCvbXTmtnLzhOJb+VrHlnMrF27OFp3WuRlEp7Y6xJqnJVJSjQO+ow0YUZDCPSfsjmvYJ9+4pozP4wlUVIJGxoZpEIaMx79r+mYz6DB6ux+SKfnSoiaPotZC9zgUIr8WzrVhzBET4dulvVJAV1/WHW740HtZq9OfiwKCU3vpr05U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705933539; c=relaxed/simple;
	bh=Rh5IVlp0YssIc4eNTuzg4mhQZO06svg3HovTv2W7ILM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjVy0zoG0sGrP8bsmUH00Zzj7olTRuWPSTcL4wVB3RgpiUgx3WjYiS/0q8SJyMzqSoeRgACD4ZQIx974dvVRaZxjJ0V35pv5NXSXrC/Gx/IlTLwuVySn23695aRJ6OtSFu4Ly/WQUaqrE9g8o5mG+OPLKBaixBMt3DiYRZboo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SV86V6/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705933536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1kM0OznqVTZzB3UnT1IpCXRocmMQjkR6vJeB4/d2+AU=;
	b=SV86V6/s0RUelitLiD1dhbsWUaF0Ut+x+Nl+lxOzp8ukfvfkZxjjrZkgZcSDUV0zwcGsqC
	uAzOz9p8t27nt9rwTwatEFYoAs0MwS9V4UkZ/ueqOcmg1bepl8hslKmfsfHtyy5LsCDNye
	Of/QKds691qh/5xsqpC1gfowveJ8a34=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-a187XN_BOLKbZjXdHTW1Ag-1; Mon, 22 Jan 2024 09:25:32 -0500
X-MC-Unique: a187XN_BOLKbZjXdHTW1Ag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D3FC868A22;
	Mon, 22 Jan 2024 14:25:32 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.2])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E0C333C2E;
	Mon, 22 Jan 2024 14:25:31 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id 387EE401CEC01; Mon, 22 Jan 2024 11:22:10 -0300 (-03)
Date: Mon, 22 Jan 2024 11:22:10 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Joe Mario <jmario@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mark power efficient workqueue as unbounded if nohz_full
 enabled
Message-ID: <Za56EiAI9D5S8NuT@tpad>
References: <ZaqbP0QmVPAQTbYA@tpad>
 <ZasMfA-v1YykDA1i@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZasMfA-v1YykDA1i@slm.duckdns.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On Fri, Jan 19, 2024 at 01:57:48PM -1000, Tejun Heo wrote:
> On Fri, Jan 19, 2024 at 12:54:39PM -0300, Marcelo Tosatti wrote:
> > 
> > A customer using nohz_full has experienced the following interruption:
> > 
> > oslat-1004510 [018] timer_cancel:         timer=0xffff90a7ca663cf8
> > oslat-1004510 [018] timer_expire_entry:   timer=0xffff90a7ca663cf8 function=delayed_work_timer_fn now=4709188240 baseclk=4709188240
> > oslat-1004510 [018] workqueue_queue_work: work struct=0xffff90a7ca663cd8 function=fb_flashcursor workqueue=events_power_efficient req_cpu=8192 cpu=18
> > oslat-1004510 [018] workqueue_activate_work: work struct 0xffff90a7ca663cd8
> > oslat-1004510 [018] sched_wakeup:         kworker/18:1:326 [120] CPU:018
> > oslat-1004510 [018] timer_expire_exit:    timer=0xffff90a7ca663cf8
> > oslat-1004510 [018] irq_work_entry:       vector=246
> > oslat-1004510 [018] irq_work_exit:        vector=246
> > oslat-1004510 [018] tick_stop:            success=0 dependency=SCHED
> > oslat-1004510 [018] hrtimer_start:        hrtimer=0xffff90a70009cb00 function=tick_sched_timer/0x0 ...
> > oslat-1004510 [018] softirq_exit:         vec=1 [action=TIMER]
> > oslat-1004510 [018] softirq_entry:        vec=7 [action=SCHED]
> > oslat-1004510 [018] softirq_exit:         vec=7 [action=SCHED]
> > oslat-1004510 [018] tick_stop:            success=0 dependency=SCHED
> > oslat-1004510 [018] sched_switch:         oslat:1004510 [120] R ==> kworker/18:1:326 [120]
> > kworker/18:1-326 [018] workqueue_execute_start: work struct 0xffff90a7ca663cd8: function fb_flashcursor
> > kworker/18:1-326 [018] workqueue_queue_work: work struct=0xffff9078f119eed0 function=drm_fb_helper_damage_work workqueue=events req_cpu=8192 cpu=18
> > kworker/18:1-326 [018] workqueue_activate_work: work struct 0xffff9078f119eed0
> > kworker/18:1-326 [018] timer_start:          timer=0xffff90a7ca663cf8 function=delayed_work_timer_fn ...
> > 
> > Set wq_power_efficient to true, in case nohz_full is enabled. 
> > This makes the power efficient workqueue be unbounded, which allows
> > workqueue items there to be moved to HK CPUs.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Applied to wq/for-6.9.
> 
> A side note: with the recent affinity improvements to unbound workqueues, I
> wonder whether we'd be able to drop wq_power_efficient and just use
> system_unbound_wq instead without noticeable perf difference.
> 
> Thanks.
> 
> -- 
> tejun

Tejun,

About the performance difference (of running locally VS running
remotely), can you list a few performance sensitive work queues 
(where per-CPU execution makes a significant difference).

Because i suppose it would be safe (from a performance regression
perspective) to move all delayed works to housekeeping CPUs.

And also, being more extreme, why not an option to mark all workqueues
as unbounded (or perhaps userspace control of bounding, even for 
workqueues marked as "per-CPU").

Thanks.




