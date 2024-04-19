Return-Path: <linux-kernel+bounces-151744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4CB8AB349
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BEA21C21199
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD08131188;
	Fri, 19 Apr 2024 16:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VxeNt3aH"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B15313049E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543891; cv=none; b=a7vy6MYXeyT8Ni1NSozuUnItNSqw7IhOdPuUG884L2scguQrffr0UYVRqrdoGzEs2rqXPr4TUd06wPa8bAWP5/74mGdPvOX2GwfWaCMiO0aJtpwtZPj1V5uazn0h6vUp0ilpfyjhS/dDUUNWa9AMpfqYW/l8R6VansLhtKEK+f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543891; c=relaxed/simple;
	bh=MXSUTg8AAbXiv5XWWvlhI53mkeRPnCzdbes7s/84ff4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZiBaWGOHEATqNwYRuoRE88TNMF+xs5r6UVOSm4dDOW8NDkmA1BpJNosADjWu/wNQFjx3vbW55gkw80CxGqQEtkPcFXq4Y15YsO3GhabuOnRB6uIyhgoR4KqOEujd93j2+ADr3ZN0s+FnqtHII9TcCdAfQjgc8tDoi41FopY3mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VxeNt3aH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=c+bc2YaEMvUu+sQwXlHTLLHCVxXL532Ilhya9YUv2jY=; b=VxeNt3aHYm1RAi2j2tlX+s1h66
	4LigqpT28igYQWD8QeQZvtbssha4azUu7falSkMqp0sdaImIT53L2TRITp8MF+hGVtN3zFOdulsZx
	2FsppxlLne3StVaUdf157h4M+qMkgARiqxDDsEjw5kARbGmTosSyd9CTTxdQ1vwmT/TIEZhzT7G84
	LmdvQglNEXqnotFNrXL+re/Z4smxbsETXVqL62U6XEoU6EGcVh3WkV4ntDL1Rr86asz7yhr3Cc/GX
	0lHRW/9DdeE5lf1i0XekMBdRjfi3QooZbpu4s6v2uvHzVw3Dpg/zuXzrZxmnmt3H6RgJPhIptpYq4
	bI9h59fA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxr2L-0000000CVid-0Ag9;
	Fri, 19 Apr 2024 16:24:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B101530043E; Fri, 19 Apr 2024 18:24:28 +0200 (CEST)
Date: Fri, 19 Apr 2024 18:24:28 +0200
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
Message-ID: <20240419162428.GB23130@noisy.programming.kicks-ass.net>
References: <20240226082349.302363-1-yu.c.chen@intel.com>
 <758ebf4e-ee84-414b-99ec-182537bcc168@bytedance.com>
 <20240408115833.GF21904@noisy.programming.kicks-ass.net>
 <ZhPtCyRmPxa0DpMe@chenyu5-mobl2>
 <20240409092104.GA2665@noisy.programming.kicks-ass.net>
 <ZiAWTU5xb/JMn/Hs@chenyu5-mobl2>
 <CAB8ipk-fejQ41Jgk6z52+T6CP+impwbaOAfhA9vG_-FB9BeRyw@mail.gmail.com>
 <ZiEaKOQwiNEglYtS@chenyu5-mobl2>
 <20240419082440.GB6345@noisy.programming.kicks-ass.net>
 <ZiJBqRafMdBi+wCV@chenyu5-mobl2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiJBqRafMdBi+wCV@chenyu5-mobl2>

On Fri, Apr 19, 2024 at 06:04:25PM +0800, Chen Yu wrote:

> > Also, could you put a few words in on how often these clips are hit? I
> > suspect it's fairly rare (but crucial when it does).
> 
> Everytime it happens a subsequent NULL pointer exception usually happens.
> The trace data was posted here: 

That was not the question. Suppose I put a printk whenever the clamp()
actually changes the value, do I get a stormflood of output, or do I get
a sporadic blip.

