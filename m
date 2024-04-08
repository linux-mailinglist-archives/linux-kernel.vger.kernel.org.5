Return-Path: <linux-kernel+bounces-135295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5966589BE8D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1469E2828F1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82F86A332;
	Mon,  8 Apr 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EXIXMMk0"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05486A323
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712577669; cv=none; b=h95T/3p6s2d/yNfEV3D9kn7ckC6TzQvyU68xw9wmSp0WXT2uqWw8i8kza4CxRBWLTDozCy7eWdIIvl1a7AQgV7Z1IG2nNKYarCr+a8qMMfrab/u/4ZVclmamOAfKXtU9/5G9samVWOml9866AhUY89jIHqKe18gcuDV+qGfK5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712577669; c=relaxed/simple;
	bh=qP5DQYTs1OxFpetY7uFY8x+mv/Alr/HA1yjleOP01Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4k8+PokbnN/CSxBrH15N1OPbWzopIScQy27uXFuEXO4towG5w9+8sGK05RWH/E5IwWRokMQdoDlUnweZgJigKy62NmePIHA4FF75ZZ0ycbdaBIEt4UvnjwrYDpAwhRvxaG0GZYhwAr+dO/JopvNw8TUoCJX7uHfxqW4gsLfftU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EXIXMMk0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qP5DQYTs1OxFpetY7uFY8x+mv/Alr/HA1yjleOP01Rc=; b=EXIXMMk0sPhMuU+AeunHAZfQIf
	aeXvxOk60PLRESooUGcSfFaVIJJAst7M8xi3WneggNFyfiHbQ9jjD92X40jnRx8VzDtxELttNcIel
	A+4BIItPc7KnqhoMb0+qZ7IsShTGCuP5Dal/0mdqKwMov/HPhurmZ4hlno2UHkN4eUF8LIdQe0/QS
	nARmVLzaYQEm3kLtLWZ+2OFuoVHoZVFSyooGlxqjBDjjEOKUEzrJzBLbIWwBLBE76y7LU/elB0d8d
	uMZWcixnqZQU3+J/VUNIf+4dkfmx1GHsu4kgcKusPUOTrVAu387XKGuJ42QB35br/h6FalHDroK1O
	GZ1KgWkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtng5-000000076v5-3RME;
	Mon, 08 Apr 2024 12:00:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 780BE30046F; Mon,  8 Apr 2024 14:00:45 +0200 (CEST)
Date: Mon, 8 Apr 2024 14:00:45 +0200
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
Message-ID: <20240408120045.GG21904@noisy.programming.kicks-ass.net>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <ZeF+uc/jMohokNRb@chenyu5-mobl2>
 <63102e0a-8a16-4b1d-b8f8-d9833079c924@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63102e0a-8a16-4b1d-b8f8-d9833079c924@bytedance.com>

On Fri, Mar 01, 2024 at 04:42:43PM +0800, Abel Wu wrote:

> After a second thought, this doesn't solve the insane huge vruntime
> itself. Since the immediate problem is that 'huge' number actually is
> a small one, is it possible to make vruntime s64 at definition?

In part that was never done because wrapping of signed types in C is UB
and UBSAN used to be buggy. But also, given how it all works, it mostly
doesn't matter.

