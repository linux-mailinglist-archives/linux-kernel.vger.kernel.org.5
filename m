Return-Path: <linux-kernel+bounces-14106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 666AA8217E8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 08:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBD88B2156D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 07:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC4820E0;
	Tue,  2 Jan 2024 07:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BOVCy3nJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D95920F9;
	Tue,  2 Jan 2024 07:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704179397; x=1735715397;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dlIRxW0Xk4qGNOKcqqw/6GoKOIDxzXJKtBnvvXlwhBE=;
  b=BOVCy3nJHatSezuNIyqXnP+y9rA4AsA5DNxoUrbG43pF4gHHBLKFTx3B
   dyb/Q2RzFMAcZcZmM2L6nzarc6pnzzD6KjFU+qqfCuEhCydc/sOv3ulOc
   tlmaqdPQSiINAwzWt06vBiOU1qSo0LDMVUp6oeOCHcfrvTOeOrGx02Riz
   fLgzekmdNCkosZuTFzrbgVKVAUOxI0WD8alf/pgcfjWRddv22DLBZZD9M
   ivF+XGFhGdHOumknMZYU3SqbH6tBUbsCwoMM4Gxo5LsWNWzA+zcqV6d2n
   cpXhErlo/IgOlPAIkiZEbmtopoM3uEbYglUvJDVh4BlqChz8xLebDSqTO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="376337968"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="376337968"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 23:09:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="729421414"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="729421414"
Received: from oshragax-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.35.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 23:09:53 -0800
Date: Tue, 2 Jan 2024 08:09:51 +0100
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
Message-ID: <ZZO2v0lQSZLxNV3c@linux.intel.com>
References: <CGME20231227084252epcas2p3b063f7852f81f82cd0a31afd7f404db4@epcas2p3.samsung.com>
 <5754861.DvuYhMxLoT@kreacher>
 <6019796.lOV4Wx5bFT@kreacher>
 <4874693.GXAFRqVoOG@kreacher>
 <ZY3auVvVzxwTmAX8@linux.intel.com>
 <CAJZ5v0gns5zeLEk39NGwjLy40wzHAHDWYBYapWwQWcJ9jrF-3Q@mail.gmail.com>
 <ZY44KH2wGIUyIZp6@linux.intel.com>
 <CAJZ5v0jWSH_+wC7P=bBV8uKNp1PBUjkE06Ec6HR1Zd5as8GQ2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jWSH_+wC7P=bBV8uKNp1PBUjkE06Ec6HR1Zd5as8GQ2g@mail.gmail.com>

On Fri, Dec 29, 2023 at 05:36:01PM +0100, Rafael J. Wysocki wrote:
> On Fri, Dec 29, 2023 at 3:54 PM Stanislaw Gruszka
> <stanislaw.gruszka@linux.intel.com> wrote:
> >
> > On Fri, Dec 29, 2023 at 02:37:36PM +0100, Rafael J. Wysocki wrote:
> > > > > +bool async_schedule_dev_nocall(async_func_t func, struct device *dev)
> > > > > +{
> > > > > +     struct async_entry *entry;
> > > > > +
> > > > > +     entry = kzalloc(sizeof(struct async_entry), GFP_KERNEL);
> > > >
> > > > Is GFP_KERNEL intended here ?
> > >
> > > Yes, it is.
> > >
> > > PM will be the only user of this, at least for now, and it all runs in
> > > process context.
> > >
> > > > I think it's not safe since will
> > > > be called from device_resume_noirq() .
> > >
> > > device_resume_noirq() runs in process context too.
> > >
> > > The name is somewhat confusing (sorry about that) and it means that
> > > hardirq handlers (for the majority of IRQs) don't run in that resume
> > > phase, but interrupts are enabled locally on all CPUs (this is
> > > required for wakeup handling, among other things).
> >
> > Then my concern would be: if among devices with disabled IRQs are
> > disk devices? Seems there are disk devices as well, and because
> > GFP_KERNEL can start reclaiming memory by doing disk IO (write
> > dirty pages for example), with disk driver interrupts disabled
> > reclaiming process can not finish.
> >
> > I do not see how such possible infinite waiting for disk IO
> > scenario is prevented here, did I miss something?
> 
> Well, it is not a concern, because the suspend code already prevents
> the mm subsystem from trying too hard to find free memory.  See the
> pm_restrict_gfp_mask() call in enter_state().

So that I missed :-) Thanks for explanations.

Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com> for the series.


