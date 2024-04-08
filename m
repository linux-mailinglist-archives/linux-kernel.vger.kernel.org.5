Return-Path: <linux-kernel+bounces-135293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C989B89BE84
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8477F282407
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A75B6A335;
	Mon,  8 Apr 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="exSAgWiH"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AD06A328
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577530; cv=none; b=G6SQIW1d/xlOjVFsbF0I47ULPYN9invWXc9VG+waX1/DGsiIiXM3u5w0BKn3807OTaydcsD71ToDIn13a/M3WdYRAfefFgsIddctzh9JgW70B0A4nBI5QkqfXEa99mnFbTsDn2uJYoMHFF+wwxwKCSKqBVwLFsNDBaEiiNvLHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577530; c=relaxed/simple;
	bh=vfP6aSYaUOR89SNo33iDBJOiy2nShSuA0qK1RBew/Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1CdwMZWWa9/sNaO540q99IOhhR0K2JlunJzl+wDSZZWNfQOK+rR3/TZBRuLxvBMkWumeNB4kBD5NbFp2pSKmsA8d6ol+yUeIaqTX68Fc0/BtbUPpsh9cQVcmjNI4i7/tYgsQzLEoOU74qeN7R3HRkOPSRzb9wD/ukvgUHz2o0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=exSAgWiH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ijMJyTNW0bbtVuJy5mr07gclVu+CJ/ZwMsLdwX+81G0=; b=exSAgWiHittm2rotyeM+vUq0Hn
	eu1msBW8szONUp3LXdSQzFGdEX/DQQulqcgI7+AQKBt8ZQtcCG8CTqvfeEDlAVk2gvaEIpUoCH60y
	GVM0TgW6rhty5ZGUta2vSFB9/KGVQrLx1gFNiBqSxuyPXvgV+PSoFI5inoRHDdbeXjmhsIRaSpTxb
	NTag0D1BuwVt/YpGhTKAYKyjVcqW4F2AX4CfOTn4+ovN+njdm8z8fCYo0G8cKhEr2VUHKiYrHTXo/
	FzfpPFQrtwN1sNOFe2A+jeY1q5DYKGh0zKI9rmfa1NPcyKBbnIZPLW0tnNxpIrvpJZuwWxnF4Q8Bz
	H49qOVWQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtndy-0000000HN5j-0MdQ;
	Mon, 08 Apr 2024 11:58:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id BE29630046F; Mon,  8 Apr 2024 13:58:33 +0200 (CEST)
Date: Mon, 8 Apr 2024 13:58:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Abel Wu <wuyun.abel@bytedance.com>
Cc: Chen Yu <yu.c.chen@intel.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <20240408115833.GF21904@noisy.programming.kicks-ass.net>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>

On Thu, Feb 29, 2024 at 05:00:18PM +0800, Abel Wu wrote:

> > According to the log, vruntime is 18435852013561943404, the
> > cfs_rq->min_vruntime is 763383370431, the load is 629 + 2048 = 2677,
> > thus:
> > s64 delta = (s64)(18435852013561943404 - 763383370431) = -10892823530978643
> >      delta * 2677 = 7733399554989275921
> > that is to say, the multiply result overflow the s64, which turns the
> > negative value into a positive value, thus eligible check fails.
> 
> Indeed.

From the data presented it looks like min_vruntime is wrong and needs
update. If you can readily reproduce this, dump the vruntime of all
tasks on the runqueue and see if min_vruntime is indeed correct.

> > So where is this insane huge vruntime 18435852013561943404 coming from?
> > My guess is that, it is because the initial value of cfs_rq->min_vruntime
> > is set to (unsigned long)(-(1LL << 20)). If the task(watchdog in this case)
> > seldom scheduled in, its vruntime might not move forward too much and
> > remain its original value by previous place_entity().
> 
> So why not just initialize to 0? The (unsigned long)(-(1LL << 20))
> thing is dangerous as it can easily blow up lots of calculations in
> lag, key, avg_vruntime and so on.

The reason is to ensure the wrap-around logic works -- which it must,
because with the weighting thing, the vruntime can wrap quite quickly,
something like one day IIRC (20 bit for precision etc.)

Better to have the wrap around happen quickly after boot and have
everybody suffer, rather than have it be special and hard to reproduce.

