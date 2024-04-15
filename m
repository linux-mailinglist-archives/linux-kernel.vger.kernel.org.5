Return-Path: <linux-kernel+bounces-144663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4068A48ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C97B3B22ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F842374C;
	Mon, 15 Apr 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EfysjrlE"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3110F22EFB
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713165797; cv=none; b=oXm8YVxc62IVEvmth8DEumRNT9qT7J4WM0tcxrNvo3zP9AwxZ0Fv1+Ehxfdbklqgo0lNrD9dYoPlnR1nFwGWPWdUbi/oiFeaLQwkOVzVJpo71whP+jTEJG05D+9Hrk08o2t2xz4bU/jt1mfvFnngPtNga1L0L75EMalfUQrMDmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713165797; c=relaxed/simple;
	bh=827hdgoqW5AbO6bifAUuyp9xXZRxJEjy1Rg4gUC2fXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gy91vD7AdYbSl9vYPxmLUqpQLE/YPCupK5ggtWqD2g0qhZ/SE85iqT23+6jC5G9pp74RQ+NTrfebQIjHmSM+S78BtPGKMIh/cZz/25JAKvqZTMq1lfOrlh1F4VkCTEk5C0dhJdyJzB6s8DJb38oeG+eJZUiBWZNrhnB5ETKipbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EfysjrlE; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=827hdgoqW5AbO6bifAUuyp9xXZRxJEjy1Rg4gUC2fXA=; b=EfysjrlEO2n5+HbwFmW3gBDeij
	S8m+E292t6VmzGofOl2fFPjZFK6u7Kl6TxxxuixlgKqbFDaBftzg5fZ9NNnnMo2ZMu1n3TZgzdnn0
	gY0sOEG4ghZsOqjzGDHIvr/IZ2WsgKc1cECcdPMhUAQEBR/QAjM935Lg0eYzJBUuiswFn8fPcUnfB
	99g6bhD4TGHY4a6m7i6EZqlPDYOVrxBDJ6ttrZNRvmLxKl+HNIlWAvxlR3yjYAKQPX6G0zmXpyZvr
	kGclyq+lSUz8DsOwO4P2ZrACgrs4lJbhyREUqehJ9qzFVhREhuyP69S9riMKvZVsC+1/OK81heWsQ
	/276x2og==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwGg0-0000000ASh1-0FuU;
	Mon, 15 Apr 2024 07:22:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B3DE530040C; Mon, 15 Apr 2024 09:22:51 +0200 (CEST)
Date: Mon, 15 Apr 2024 09:22:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Chen Yu <yu.c.chen@intel.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Juri Lelli <juri.lelli@redhat.com>, Tim Chen <tim.c.chen@intel.com>,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Honglei Wang <wanghonglei@didichuxing.com>,
	Aaron Lu <aaron.lu@intel.com>, Chen Yu <yu.chen.surf@gmail.com>,
	linux-kernel@vger.kernel.org,
	kernel test robot <oliver.sang@intel.com>
Subject: Re: [RFC PATCH] sched/eevdf: Return leftmost entity in pick_eevdf()
 if no eligible entity is found
Message-ID: <20240415072251.GA12673@noisy.programming.kicks-ass.net>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409092104.GA2665@noisy.programming.kicks-ass.net>

On Tue, Apr 09, 2024 at 11:21:04AM +0200, Peter Zijlstra wrote:

> Is there any sane way to reproduce this, and how often does it happen?

This, how do you all make it go bang?

