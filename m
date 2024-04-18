Return-Path: <linux-kernel+bounces-150414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101E18A9EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4226B1C22285
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39916E872;
	Thu, 18 Apr 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXIpS5dE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548F165FD9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454846; cv=none; b=uEa7CxkqXT3Q5dk3W7qTYXKXah8g57VEeRIQk4Aa/9MYK8KlApFCRXItDfZHxwIvBPLIAW1WXr28oRPev8Bv+IpBMLyw5jAbGZzs/FQfCVIyVhQr7uInm7adUdefyX2FVTIvACK6kCBRU0Yf5sKenPhNgdTheNeCFFMc7z2PYgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454846; c=relaxed/simple;
	bh=AtyV0iVTtcQ/CYk8/4oTzQreCUZEygEjlALQ+qjF7hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAYMdi8BrdHDfEr05Prju2iXrGN7yTaAIhZX9Qr4qwgH29EoPUg8xS0CwUsGbujGERDTsstYmaKGMO6DvrPwLxHLmBiS5nXJSSyfvW598jUYOtJ0gVBm2/++K5QTLHhvXyH22ouF6U0uNM5LSUSlWgdHqIPufrNcu5oZoVfflbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXIpS5dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C0EC113CC;
	Thu, 18 Apr 2024 15:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713454846;
	bh=AtyV0iVTtcQ/CYk8/4oTzQreCUZEygEjlALQ+qjF7hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXIpS5dEMN4TnQoMStFbRplmXfetbCaS0l6jSGMblRZUes3E498ZUGd902+rIrc+r
	 mMsdbTl4ACP8A889pV0X8vs5CtO4rfith2wpSF+V+khbHwEjizVON9p8ZM4tg7ERRI
	 mg/NCi+MAJoaWHuhy98K9jOVp0Yh8UuMUYZRshimnJWKp1COOo9IMOJAPWeDBdey1k
	 c8Xr3GpTvaZMnaA491xJEML556xl6DNlTI+ubaUo3ooEAmxA3eDaR114yrXDp8cN4G
	 hcDaSwYnZhDxjyZ4t34DC3RRILRfYlg2mh78l6atZILUGxc9tQUNMm5NHwYFF6DOnK
	 7R5dqYMY1nJnQ==
Date: Thu, 18 Apr 2024 17:40:43 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: [PATCH] sched/isolation: fix boot crash when maxcpus <
 first-housekeeping-cpu
Message-ID: <ZiE--7rz1vuEudAm@localhost.localdomain>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <20240411143905.GA19288@redhat.com>
 <20240413141746.GA10008@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240413141746.GA10008@redhat.com>

Le Sat, Apr 13, 2024 at 04:17:46PM +0200, Oleg Nesterov a écrit :
> housekeeping_setup() checks cpumask_intersects(present, online) to ensure
> that the kernel will have at least one housekeeping CPU after smp_init(),
> but this doesn't work if the maxcpus= kernel parameter limits the number
> of processors available after bootup.
> 
> For example, the kernel with "maxcpus=2 nohz_full=0-2" parameters crashes
> at boot time on my virtual machine with 4 CPUs.
> 
> Change housekeeping_setup() to use cpumask_first_and() and check that the
> returned cpu number is valid and less than setup_max_cpus.
> 
> Another corner case is "nohz_full=0" on a machine with a single CPU or
> with the maxcpus=1 kernel argument. In this case non_housekeeping_mask
> is empty and IIUC tick_nohz_full_setup() makes no sense. And indeed, the
> kernel hits the WARN_ON(tick_nohz_full_running) in tick_sched_do_timer().
> 
> And how should the kernel interpret the "nohz_full=" parameter? I think
> it should be silently ignored, but currently cpulist_parse() happily
> returns the empty cpumask and this leads to the same problem.
> 
> Change housekeeping_setup() to check cpumask_empty(non_housekeeping_mask)
> and do nothing in this case.
> 
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

