Return-Path: <linux-kernel+bounces-13126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D13C882000B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 15:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB8E1C21842
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 14:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A072911C9D;
	Fri, 29 Dec 2023 14:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LF1no2QX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A948111C8B;
	Fri, 29 Dec 2023 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703861658; x=1735397658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LmCz43UOG0d1OrqtwkVYhlzS+7VmCSgdz5lsHb1OANY=;
  b=LF1no2QXFOzULbsBO6urV7VfERdVXga3DYmCRUjzAKwSf8sC/Q/qp6aS
   CnfWe+G4hErLsMMZV28wAUv1d5fFKz0eDrcnWIUusF/kNdlGcDW1hQqlo
   fgiLASbNzm72ZBkpIpy5vJQPhEZayouyV+wfjO8JVAAzduiLvSb9qq0/j
   m5f3FBX7VfA8vMKS8ldJS5snyJBmw2ghm7D+z1tXzQbg0sx/Jd4kPaEyF
   j/wnN/j2dQGVHoxv1qu77DgQjY41g+qcSiitiHhcFyi8/J23kz7T9qcTy
   4OGN7wIl+PN9ixJlvi+QCWsOm+yY8krvMWHgYQAR0nydqNICAkLqh5toC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="376808414"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="376808414"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 06:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="771978949"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; 
   d="scan'208";a="771978949"
Received: from sgruszka-mobl.ger.corp.intel.com (HELO localhost) ([10.252.35.82])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 06:54:12 -0800
Date: Fri, 29 Dec 2023 04:08:24 +0100
From: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Greg KH <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org,
	Youngmin Nam <youngmin.nam@samsung.com>,
	linux-kernel@vger.kernel.org, d7271.choe@samsung.com,
	janghyuck.kim@samsung.com, hyesoo.yu@samsung.com,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1 2/3] async: Introduce async_schedule_dev_nocall()
Message-ID: <ZY44KH2wGIUyIZp6@linux.intel.com>
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher>
 <6019796.lOV4Wx5bFT@kreacher>
 <4874693.GXAFRqVoOG@kreacher>
 <ZY3auVvVzxwTmAX8@linux.intel.com>
 <CAJZ5v0gns5zeLEk39NGwjLy40wzHAHDWYBYapWwQWcJ9jrF-3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gns5zeLEk39NGwjLy40wzHAHDWYBYapWwQWcJ9jrF-3Q@mail.gmail.com>

On Fri, Dec 29, 2023 at 02:37:36PM +0100, Rafael J. Wysocki wrote:
> > > +bool async_schedule_dev_nocall(async_func_t func, struct device *dev)
> > > +{
> > > +     struct async_entry *entry;
> > > +
> > > +     entry = kzalloc(sizeof(struct async_entry), GFP_KERNEL);
> >
> > Is GFP_KERNEL intended here ?
> 
> Yes, it is.
> 
> PM will be the only user of this, at least for now, and it all runs in
> process context.
> 
> > I think it's not safe since will
> > be called from device_resume_noirq() .
> 
> device_resume_noirq() runs in process context too.
> 
> The name is somewhat confusing (sorry about that) and it means that
> hardirq handlers (for the majority of IRQs) don't run in that resume
> phase, but interrupts are enabled locally on all CPUs (this is
> required for wakeup handling, among other things).

Then my concern would be: if among devices with disabled IRQs are
disk devices? Seems there are disk devices as well, and because
GFP_KERNEL can start reclaiming memory by doing disk IO (write
dirty pages for example), with disk driver interrupts disabled
reclaiming process can not finish.

I do not see how such possible infinite waiting for disk IO
scenario is prevented here, did I miss something?

Regards
Stanislaw

