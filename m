Return-Path: <linux-kernel+bounces-34237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 448DC837619
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80FA81C24C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590D1FBE1;
	Mon, 22 Jan 2024 22:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qI9A/shm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866B15E94;
	Mon, 22 Jan 2024 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962693; cv=none; b=lnNoRUBbCLElkIgzuziuPv5MB2oJao4cq/Mn8ZnanHcM2EFMA/iYYN1TYwzs9jkFq6gQJO8DCCrwiiwUIL8oLZb6uwTTSkQAtzR4tWSBQ9zqYZ5OVp7tyRn3hCeYI46FSLETb3LWS+atPLlarVXdujFS5xrbhLubfxS4u3sQVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962693; c=relaxed/simple;
	bh=3JHtLyrtdIeR4lpdqLo4ZU4AipE0Puso/vddbxf5HZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hwuje5gWsMHygu5AJdaezDL4u/7u8ayTveIpHsb4Y1aPztG7YzgBYxKkcFuut9SyoDnFk4whK11StcvZi3UnJ+fSskscF6dUktz/xwVjzaFvG3IPaVGC9I4cjSRpyeDY4LZTW1QeCjiYn2oAl1kh0ZtDRHsglFPjv6Sr1mBpMP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qI9A/shm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A343BC433C7;
	Mon, 22 Jan 2024 22:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705962693;
	bh=3JHtLyrtdIeR4lpdqLo4ZU4AipE0Puso/vddbxf5HZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qI9A/shmvVcKK9J87UeI9xEBdcU3a2OlzH3Oa171BAtNE19qHkRAMUUEayiO632Zx
	 aH8yDOUkV64DHJTL8uqRLK/8ZVWO1B2NF0glxFNvQvbVFpi5IJWpwV56//WnwjwVa5
	 UnrB8I1Bidr6tBCbavofefh4qWZbQbEg5vLIdhktRevMgiHzmZn9mmwzndRIrCpT6J
	 YbrHJ42W2RpqMgNxKdIPUqTDRQNDX2Jfwq3Cdiavg/+OfeTnUD/2fEZcSzRbo7mnWd
	 py65TvhX2Khv1K21fmhi2ZPEGjBtUEOHUxi+emQ4hZ5mb5HDG8HW9jyQDQbMJujyoD
	 B5mxBKAZ2ihrA==
Date: Mon, 22 Jan 2024 23:31:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH] tick-sched: fix idle and iowait sleeptime accounting vs
 CPU hotplug
Message-ID: <Za7swp31JRzGJwzS@pavilion.home>
References: <20240115163555.1004144-1-hca@linux.ibm.com>
 <0928660b39aea2828a79a87fef57447e657d43b4.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0928660b39aea2828a79a87fef57447e657d43b4.camel@linux.intel.com>

Le Mon, Jan 22, 2024 at 10:19:30AM -0800, Tim Chen a écrit :
> On Mon, 2024-01-15 at 17:35 +0100, Heiko Carstens wrote:
> > 
> >  
> > +	idle_sleeptime = ts->idle_sleeptime;
> > +	iowait_sleeptime = ts->iowait_sleeptime;
> >  	memset(ts, 0, sizeof(*ts));
> > +	ts->idle_sleeptime = idle_sleeptime;
> > +	ts->iowait_sleeptime = iowait_sleeptime;
> >  }
> 
> Should idle_calls and idle_sleeps be preserved and
> restored too?  
> 
> Seems like if we preserve the
> idle_sleeptime, and wish to compute the average
> sleep time per sleep, we will need to know the value of
> idle_sleeps that's also preserved across CPU offline/online.

I guess those can be saved as well. Would you like to send the patch?

Thanks.

> 
> Tim

