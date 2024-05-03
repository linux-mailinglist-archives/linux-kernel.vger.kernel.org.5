Return-Path: <linux-kernel+bounces-168133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642318BB410
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646E51C23D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D03D15A4A7;
	Fri,  3 May 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuhBR78h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFA9158D6E;
	Fri,  3 May 2024 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714764596; cv=none; b=ldxY8BYhZM6s78uTvGgFc5ImpWgVQcv3qI818hWVTA0pCMIjF5EaGZMyMKBlOnLjjh1X6mFBejuvTIpUE+A5vqU/etLyLmHGfjHvDGeK95FcUXKE88LWMDQTHqlttWRcMSiO1aRZqOzBqz0rtsZIGn9jqHm45TOv93L7NmqnEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714764596; c=relaxed/simple;
	bh=m5MhwZYrQf56wlUh3xaqPGaPzrokLuXzfFsOkWQE3Do=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7g0YT7nQ4eGjZPmf8d2ol+LhNM0bhGLSdYLvHBH08LzVTXhl3elJ1f2MAMo66LkcQumenONoQII85drlfTTRTmnD4wDRMKKgof/EiPWTJELr9HMbGAlt2uqWtDOoNuFPy6ioJqiEywJrAYeP5q/tPtXjIYQo6TtuCsyOYQ2yP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuhBR78h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB83DC4AF14;
	Fri,  3 May 2024 19:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714764596;
	bh=m5MhwZYrQf56wlUh3xaqPGaPzrokLuXzfFsOkWQE3Do=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UuhBR78hPJyqGFp6vzkoJDmIZDhaza2rV4Hf7qKYFFLUYwtifnoMM1BGjNKs71tSG
	 L9gUVYfSzUS65LahDPjaF1FJGUJH9KM3SQOL8W9Zr61QeqwwmNKUERjO7h+oHpliNW
	 IaBS/LA7gX2wZaCUtsZw0g6Kpr++ZdZwYBsMNIZyfgZUV5OGpitEJiyWq6F/lu/K8P
	 8AhQaCCINk+BWGBwfsz1CMLxTr9Z3e1RhRBehnzXA5CH7+5nZpzrKS0VFeyusCPqdx
	 eYphMjVpmvAgewpYhgZmdS7LuE1XiC7TQtwtV34/VfT/8TiCeTmXoBZC//NiKv32v/
	 YbisTCPt+22SQ==
Date: Fri, 3 May 2024 12:29:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Praveen Kannoju <praveen.kannoju@oracle.com>
Cc: "jhs@mojatatu.com" <jhs@mojatatu.com>, "xiyou.wangcong@gmail.com"
 <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
 "davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Rajesh Sivaramasubramaniom
 <rajesh.sivaramasubramaniom@oracle.com>, Rama Nichanamatlu
 <rama.nichanamatlu@oracle.com>, Manjunath Patil
 <manjunath.b.patil@oracle.com>
Subject: Re: [PATCH RFC] net/sched: adjust device watchdog timer to detect
 stopped queue at right time
Message-ID: <20240503122954.58bee752@kernel.org>
In-Reply-To: <SA1PR10MB644567B49D44BA641CF63E828C1F2@SA1PR10MB6445.namprd10.prod.outlook.com>
References: <20240430140010.5005-1-praveen.kannoju@oracle.com>
	<20240501151251.2eccb4d0@kernel.org>
	<SA1PR10MB644567B49D44BA641CF63E828C1F2@SA1PR10MB6445.namprd10.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2024 14:28:13 +0000 Praveen Kannoju wrote:
> > >  				txq = netdev_get_tx_queue(dev, i);
> > >  				trans_start = READ_ONCE(txq->trans_start);
> > > -				if (netif_xmit_stopped(txq) &&
> > > -				    time_after(jiffies, (trans_start +
> > > -							 dev->watchdog_timeo))) {
> > > -					timedout_ms = jiffies_to_msecs(jiffies - trans_start);
> > > -					atomic_long_inc(&txq->trans_timeout);
> > > -					break;
> > > +				if (netif_xmit_stopped(txq)) {  
> > 
> > please use continue instead of adding another indentation level  
> 
> We need to take decision on whether to break out of loop or modify "oldest_start" only when
> Queue is stopped. Hence one more level of indentation is needed. Can you please elaborate
> on using "continue" in existing condition instead of adding a new indentation level.

If the queue is not stopped, continue. Split the condition into
multiple ifs.

> > > +								   dev->watchdog_timeo))) {
> > > +						timedout_ms = jiffies_to_msecs(current_jiffies -
> > > +										trans_start);
> > > +						atomic_long_inc(&txq->trans_timeout);
> > > +						break;
> > > +					}
> > > +					next_check = trans_start + dev->watchdog_timeo -
> > > +									current_jiffies;  
> > 
> > this will give us "next_check" for last queue. Let's instead find the oldest trans_start in the loop. Do:
> > 
> > 		unsigned long oldest_start = jiffies;
> > 
> > then in the loop:
> > 
> > 		oldest_start = min(...)

BTW, the min() I suggested here needs to be a if (time_after(...)),
we can't use bare min() to compare jiffies, because they may wrap.

