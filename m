Return-Path: <linux-kernel+bounces-158387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBFD8B1F1A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 310571F22A93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427CD86636;
	Thu, 25 Apr 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UapVWm1f"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0060781AC6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714040733; cv=none; b=OH6q2zsqQfQNxzYIMQr/2ch1ZuYFaMHCxMNwJZU6IhYA5fV1sgrAFzRciIAbpQbYDxCWkminstiSj6jryiv5T+gR7r59GBB9ieRFTOxWBT3pwr3Qgw3sm8LeEjd71+vgTlVPawVwh+ZoM5AdSnVnF4uvl9Ejsrzp5QhqpWkgA90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714040733; c=relaxed/simple;
	bh=nQ6BAMEjWN+AZKKlyNuNYNVscajVEm4QpeRWXj6TSmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oA01dHy+OHXSHsNNEtSKfRwCM2SoRvXSepP13AJytBrmpsgEKmU/YF+O0rdumRi4x1iAS75AUT8NX/1mmSsK14/ab7oMxqAR9gYWYWU6qLMpvfsI/MqOV305i9M7GhvIE3BGj3zWN2EswRGznv4rrkoj7NQ3G6sOJNWvBL2yV+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UapVWm1f; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IINbEFON+HPYGGTEXA55gchXBYnchVeuFDrlPk0d1qA=; b=UapVWm1fsTF2w8v1NdTh/Nwmo3
	FHYR43hKf1TpVf+sWpyiijbviWiWN99ssDosbTZP1WJACA7iLkdigrTAA76CpligOA18/xaSB6iU/
	3mHF6RJPnvrD092vsE4Frmj4pyyv9+nt4OFhdwijezOHJxcxGBHqDbMX4bET6Nb3PgoBlxbfkmgWZ
	hMdW7KmXJNup7XjZbPOf7QJtjRevgw+zjYwZPI+3XQ2jM8N0LINlgPIlekmO7fVEJclm78kzwXAoP
	jw+q3Ia06Cpc0+oqhRKWtZzzs0GC5jvjeH7rF1dVmTLnvQi4CwecCKAPlqkbpRImoS+R/pvqg9QEu
	T9EVozJg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzwI1-0000000EpVl-1Vga;
	Thu, 25 Apr 2024 10:25:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 07CA4300439; Thu, 25 Apr 2024 12:25:17 +0200 (CEST)
Date: Thu, 25 Apr 2024 12:25:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Yan-Jie Wang <yanjiewtw@gmail.com>
Cc: Chen Yu <yu.c.chen@intel.com>, mingo@redhat.com, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	yu.chen.surf@gmail.com
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240425102516.GD21980@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <ZhEUjX1Nw0y2eJ1o@chenyu5-mobl2>
 <20240408090639.GD21904@noisy.programming.kicks-ass.net>
 <c3611c0a-007f-4e09-b92d-3752438e653e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3611c0a-007f-4e09-b92d-3752438e653e@gmail.com>

On Thu, Apr 11, 2024 at 09:32:23AM +0800, Yan-Jie Wang wrote:
> I have an alternative approach to delayed-dequeue inspired by the original
> CFS implementation.
> 
> The idea is to keep the task's vruntime when it goes to sleep.
> When the task is woken up, see if the lag is positive at the woken time, if
> it is the case, clamp it to 0 by setting vruntime to avg_vruntime().

Problem is that avg_vruntime() can go backwards, eg by dequeueing a
negative lag task. This gets really hard to argue about real quick.

Keeping the task competing (delaying the dequeue) is by far the simplest
solution -- conceptually.

The code just became a total mess because of cgroups :/

